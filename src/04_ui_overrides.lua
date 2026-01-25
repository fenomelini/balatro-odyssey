-- src/04_ui_overrides.lua
-- Sobrescreve a formatação de números do jogo para usar sufixos (K, M, B...)

if not G.E_MANAGER then
    -- If loaded very early
end

function create_UIBox_hand_tip(handname)
  if not G.GAME.hands[handname].example then return {n=G.UIT.R, config={align = "cm"},nodes = {}} end 
  local hand_example = G.GAME.hands[handname].example
  local is_discovered = G.GAME.hands[handname].visible

  local card_limit = #hand_example
  -- Fine-tune width to avoid excessive spacing (0.5 * G.CARD_W is enough for smaller cards)
  local cardarea = CardArea(
    2,2,
    (card_limit * 0.55) * G.CARD_W, 
    0.75*G.CARD_H, 
    {card_limit = card_limit, type = 'title', highlight_limit = 0})

  for k, v in ipairs(hand_example) do
      local card = Card(0,0, 0.5*G.CARD_W, 0.5*G.CARD_H, G.P_CARDS[v[1]], G.P_CENTERS.c_base)
      
      -- If the hand is a secret hand and NOT discovered, use the lock sprite
      if not is_discovered and handname:find('secret_hand') then
          if G.ASSET_ATLAS['odyssey_mystery'] then
              card.children.front.atlas = G.ASSET_ATLAS['odyssey_mystery']
              card.children.front:set_sprite_pos({x=0, y=0})
          end
      end

      -- If discovered, we use normal behavior. If not discovered, we force them to look "highlighted" (bigger)
      -- so the lock image is more visible and fills the space.
      local scale_mod = (is_discovered and v[2]) and 0.25 or (not is_discovered and 0.2) or -0.15
      
      if v[2] or not is_discovered then card:juice_up(0.3, 0.2) end
      if k == 1 then play_sound('paper1',0.95 + math.random()*0.1, 0.3) end
      ease_value(card.T, 'scale', scale_mod, nil, 'REAL', true, 0.2)
      cardarea:emplace(card)
  end

  return {n=G.UIT.R, config={align = "cm", colour = G.C.WHITE, r = 0.1}, nodes={
    {n=G.UIT.C, config={align = "cm"}, nodes={
      {n=G.UIT.O, config={object = cardarea}}
    }}
  }}
end

--------------------------------------------------------------------------------
-- 1. Number Formatting
--------------------------------------------------------------------------------

-- Salva a função original por segurança
local original_number_format = number_format

function number_format(number, reformat)
    if not number then return "0" end
    
    -- Garante que é um número
    local n = tonumber(number)
    if not n then return tostring(number) end

    -- Se for menor que 1000, retorna o número normal (arredondado)
    if math.abs(n) < 1000 then
        -- Permite decimais para números pequenos (importante para multiplicadores como 0.5)
        if n == math.floor(n) then
            return tostring(math.floor(n))
        else
            return string.format("%.1f", n):gsub("%.0$", "")
        end
    end

    -- Tabela de sufixos
    local suffixes = {
        "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc"
    }
    
    local suffix_index = 0
    local temp_number = n
    
    -- Divide por 1000 até ficar menor que 1000
    while math.abs(temp_number) >= 1000 and suffix_index < #suffixes do
        temp_number = temp_number / 1000
        suffix_index = suffix_index + 1
    end
    
    -- Se estourou a lista de sufixos (números absurdamente grandes), usa notação científica original
    if suffix_index > #suffixes then
        return original_number_format(number, reformat)
    end
    
    -- Formata com até 2 casas decimais
    local formatted = string.format("%.2f", temp_number)
    
    -- Remove zeros à direita desnecessários
    if formatted:sub(-3) == ".00" then
        formatted = formatted:sub(1, -4)
    elseif formatted:sub(-1) == "0" then
        formatted = formatted:sub(1, -2)
    end
    
    return formatted .. suffixes[suffix_index]
end

--------------------------------------------------------------------------------
-- 2. Card Cost Overrides
--------------------------------------------------------------------------------
-- Hook Card:set_cost to implement deck logic for free/double prices

if Card then
    local old_set_cost = Card.set_cost
    Card.set_cost = function(self)
        -- Call original first to compute base cost
        if old_set_cost then old_set_cost(self) end
        
        -- Safe check for G variables
        if not (G and G.GAME and G.GAME.modifiers) then return end

        if G.GAME.selected_back and G.GAME.selected_back.effect.center.key == 'odyssey_tech' then
            -- Check if we are in shop (Booster or Jokers or Vouchers)
            if self.area == G.shop_jokers or self.area == G.shop_booster or self.area == G.shop_vouchers then
                 self.cost = self.cost * 2
                 -- Recompute sell cost
                 self.sell_cost = math.max(1, math.floor(self.cost/2))
                 -- Fix label
                 self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
            end
        end

        local set = self.ability.set
        local name = self.ability.name

        -- Free Arcana (73)
        if G.GAME.modifiers.odyssey_free_arcana and set == 'Booster' and name and name:find('Arcane') then
             self.cost = 0
        end
        -- Free Celestial (74)
        if G.GAME.modifiers.odyssey_free_planet and set == 'Booster' and name and name:find('Celestial') then
             self.cost = 0
        end
        -- Free Spectral (75)
        if G.GAME.modifiers.odyssey_free_spectral and set == 'Booster' and name and name:find('Spectral') then
             self.cost = 0
        end
        -- Free Standard (76)
        if G.GAME.modifiers.odyssey_free_standard and set == 'Booster' and name and name:find('Standard') then
             self.cost = 0
        end
        -- Free Buffoon (77)
        if G.GAME.modifiers.odyssey_free_buffoon and set == 'Booster' and name and name:find('Buffoon') then
             self.cost = 0
        end
    end
end

------------------------------------------------------------------------
-- UI Override for Deck Selection Pagination
------------------------------------------------------------------------

-- Helper to apply the fix to a UI definition table (REORGANIZE PIPS TO ROWS OF 10)
local function apply_pip_fix(t)
    local function find_and_fix_pips(node, depth)
        if not node or type(node) ~= 'table' then return false end
        if depth > 40 then return false end
        
        -- Check if this node has many children (likely the pips container)
        if node.nodes and #node.nodes > 15 then
            -- Double check: Are the children UI nodes with B type (Button/Pip)?
            local all_pips = true
            for _, child in ipairs(node.nodes) do
                if type(child) ~= 'table' or child.n ~= G.UIT.B then
                    all_pips = false
                    break
                end
            end

            if all_pips then
                -- node.nodes is the array of pips. We empty it to hide them.
                node.nodes = {}
                return true -- Stop searching
            end
        end
        
        -- Recurse into children
        if node.nodes then
            for _, child in ipairs(node.nodes) do
                if find_and_fix_pips(child, depth + 1) then
                    return true
                end
            end
        end
        
        return false
    end

    find_and_fix_pips(t, 0)
end

-- Hook 1: G.UIDEF.run_setup_option
if G and G.UIDEF then
    local old_run_setup_option = G.UIDEF.run_setup_option
    G.UIDEF.run_setup_option = function(type)
        local t = old_run_setup_option(type)
        if type == 'Back' then
            apply_pip_fix(t)
        end
        return t
    end
end

-- Hook 2: create_option_cycle (Global)
if create_option_cycle then
    local old_create_option_cycle = create_option_cycle
    create_option_cycle = function(args)
        -- Filter Vanilla Decks if this is the Deck Selection cycle
        if args and args.options then
            local vanilla_keys = {
                ["b_red"] = true, ["b_blue"] = true, ["b_yellow"] = true, ["b_green"] = true, ["b_black"] = true,
                ["b_magic"] = true, ["b_nebula"] = true, ["b_ghost"] = true, ["b_abandoned"] = true, ["b_checkered"] = true,
                ["b_zodiac"] = true, ["b_painted"] = true, ["b_anaglyph"] = true, ["b_plasma"] = true, ["b_erratic"] = true
            }
            
            -- Check if this is a deck cycle
            local is_deck_cycle = false
            local first_opt = args.options[1]
            
            -- Heuristic: Check first option
            if type(first_opt) == 'table' then
                if first_opt.key and (vanilla_keys[first_opt.key] or string.find(first_opt.key, "^b_odyssey")) then
                    is_deck_cycle = true
                elseif first_opt.set == 'Back' then
                    is_deck_cycle = true
                end
            elseif type(first_opt) == 'string' then
                -- If it's a string, check if it matches a known deck name
                if first_opt == "Red Deck" or first_opt == "Baralho Vermelho" then
                    is_deck_cycle = true
                end
            end
            
            if is_deck_cycle then
                local new_options = {}
                for _, opt in ipairs(args.options) do
                    local is_odyssey = false
                    
                    -- STRICT FILTER: Only allow Odyssey decks
                    if type(opt) == 'table' then
                        if opt.key and (string.find(opt.key, "odyssey") or string.find(opt.key, "b_odyssey")) then
                            is_odyssey = true
                        end
                    end
                    
                    if is_odyssey then
                        table.insert(new_options, opt)
                    end
                end
                
                -- Only replace if we found at least one Odyssey deck
                if #new_options > 0 then
                    args.options = new_options
                end
            end
        end
        
        local t = old_create_option_cycle(args)
        
        -- Check if this is a large cycle (likely decks)
        if args and args.options and #args.options > 20 then
            apply_pip_fix(t)
        end
        
        return t
    end
end

sendDebugMessage("Balatro Odyssey: UI Overrides Loaded (Number Formatting + Deck Pagination)")
