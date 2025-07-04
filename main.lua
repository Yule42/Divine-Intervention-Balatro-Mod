-- Tailsman Compat (fake)
to_big = to_big or function(x)
  return x
end

divine_intervention = SMODS.current_mod

SMODS.Sound({key = "jesus", path = "jesus.ogg",})

divine_intervention.seconds = 0

local updatehook = Game.update

function Game:update(dt)
    updatehook(self, dt)
    if G.GAME.current_round.hands_left and G.GAME.current_round.hands_left == 1 and G.GAME.current_round.discards_left < 2 and (to_big(G.GAME.chips)) < (to_big(G.GAME.blind.chips / 1.5)) then
        divine_intervention.seconds = divine_intervention.seconds - dt
        if divine_intervention.seconds <= 0 then
            divine_intervention.seconds = 2.5
            play_sound("divi_jesus")
            divine_intervention.jesuspng = load_image("jesus"..(math.random(4)-1)..".png")
        end
    end
end

local drawhook = love.draw
function love.draw()
    drawhook()
    function load_image(fn)
        local full_path = (divine_intervention.path 
        .. "customimages/" .. fn)
        local file_data = assert(NFS.newFileData(full_path))
        local tempimagedata = assert(love.image.newImageData(file_data))
        return (assert(love.graphics.newImage(tempimagedata)))
    end
    
    local _xscale = love.graphics.getWidth()/1920
    local _yscale = love.graphics.getHeight()/1080
    
    if G.GAME.current_round.hands_left and G.GAME.current_round.hands_left == 1 and G.GAME.current_round.discards_left < 2 and (to_big(G.GAME.chips)) < (to_big(G.GAME.blind.chips / 1.5)) then
        if divine_intervention.jesuspng == nil then divine_intervention.jesuspng = load_image("jesus0.png") end
        love.graphics.setColor(1, 1, 1, 0.2 + (divine_intervention.seconds / 3.25))
        love.graphics.draw(divine_intervention.jesuspng,0,0,0,_xscale,_yscale)
    end
end