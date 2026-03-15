#!/usr/bin/env python3
"""
update_changelog_summary.py

Reads CHANGELOG.md and automatically updates the summary table
between <!-- CHANGELOG_SUMMARY_START --> and <!-- CHANGELOG_SUMMARY_END -->
markers in README.md and README_BR.md.

Triggered by GitHub Actions on every push that touches CHANGELOG.md.
"""

import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent.parent
CHANGELOG = REPO_ROOT / "CHANGELOG.md"

READMES = {
    "en": REPO_ROOT / "README.md",
    "pt": REPO_ROOT / "README_BR.md",
}

MARKER_START = "<!-- CHANGELOG_SUMMARY_START -->"
MARKER_END = "<!-- CHANGELOG_SUMMARY_END -->"

MAX_VERSIONS = 8
MAX_HIGHLIGHTS = 3
MAX_HIGHLIGHT_LEN = 70


def parse_changelog(text: str) -> list[dict]:
    """Parse CHANGELOG.md into a list of version dicts."""
    versions = []

    # Split into blocks at each version header line
    blocks = re.split(r"\n(?=## )", text)

    for block in blocks:
        # Match headers like: ## [0.1.8-alpha] - 2026-03-13
        # or: ## 0.1.8-alpha - 2026-03-13
        m = re.match(
            r"## \[?([^\]\s]+)\]?\s*[-\u2013]\s*(\d{4}-\d{2}-\d{2})", block
        )
        if not m:
            continue

        version = m.group(1)
        date = m.group(2)

        # Collect all bullet points from this block
        bullets = re.findall(r"^[-*]\s+(.+)$", block, re.MULTILINE)
        highlights = bullets[:MAX_HIGHLIGHTS]

        def shorten(s: str) -> str:
            return s[:MAX_HIGHLIGHT_LEN] + "..." if len(s) > MAX_HIGHLIGHT_LEN else s

        highlight_str = "; ".join(shorten(h) for h in highlights)
        if not highlight_str:
            highlight_str = "See full changelog"

        versions.append(
            {
                "version": version,
                "date": date,
                "highlights": highlight_str,
            }
        )

        if len(versions) >= MAX_VERSIONS:
            break

    return versions


def date_to_pt(date_str: str) -> str:
    """Convert YYYY-MM-DD to DD/MM/YYYY."""
    parts = date_str.split("-")
    if len(parts) == 3:
        return f"{parts[2]}/{parts[1]}/{parts[0]}"
    return date_str


def anchor(version: str) -> str:
    """Generate a GitHub Markdown anchor from a version string."""
    return version.replace(".", "").replace("-", "")


def build_table_en(versions: list[dict]) -> str:
    lines = ["| Version | Date | Highlights |", "|---|---|---|"]
    for v in versions:
        lines.append(
            f"| [{v['version']}](CHANGELOG.md#{anchor(v['version'])}) "
            f"| {v['date']} | {v['highlights']} |"
        )
    lines.append("")
    lines.append("→ [Full Changelog](CHANGELOG.md)")
    return "\n".join(lines)


def build_table_pt(versions: list[dict]) -> str:
    lines = ["| Versão | Data | Destaques |", "|---|---|---|"]
    for v in versions:
        lines.append(
            f"| [{v['version']}](CHANGELOG.md#{anchor(v['version'])}) "
            f"| {date_to_pt(v['date'])} | {v['highlights']} |"
        )
    lines.append("")
    lines.append("→ [Changelog Completo](CHANGELOG.md)")
    return "\n".join(lines)


def update_readme(path: Path, new_table: str) -> bool:
    """Replace the content between markers in the given file."""
    if not path.exists():
        print(f"ERROR: {path} not found", file=sys.stderr)
        return False

    text = path.read_text(encoding="utf-8")

    if MARKER_START not in text or MARKER_END not in text:
        print(f"WARNING: markers not found in {path.name}", file=sys.stderr)
        return False

    start_idx = text.index(MARKER_START) + len(MARKER_START)
    end_idx = text.index(MARKER_END)

    new_text = text[:start_idx] + "\n" + new_table + "\n" + text[end_idx:]

    if new_text == text:
        print(f"  {path.name}: no changes")
        return False

    path.write_text(new_text, encoding="utf-8")
    print(f"  {path.name}: updated")
    return True


def main() -> None:
    if not CHANGELOG.exists():
        print(f"ERROR: {CHANGELOG} not found", file=sys.stderr)
        sys.exit(1)

    changelog_text = CHANGELOG.read_text(encoding="utf-8")
    versions = parse_changelog(changelog_text)

    if not versions:
        print("WARNING: no versions found in CHANGELOG.md", file=sys.stderr)
        sys.exit(0)

    print(f"Found {len(versions)} version(s), updating summaries...")

    update_readme(READMES["en"], build_table_en(versions))
    update_readme(READMES["pt"], build_table_pt(versions))

    print("Done.")


if __name__ == "__main__":
    main()
