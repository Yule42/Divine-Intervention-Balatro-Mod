-- Tailsman Compat (fake)
to_big = to_big or function(x)
  return x
end

this_mod = SMODS.current_mod

SMODS.Sound({key = "jesus", path = "jesus.ogg",})

this_mod.seconds = 0

local updatehook = Game.update

function Game:update(dt)
    updatehook(self, dt)
    if G.GAME.current_round.hands_left and G.GAME.current_round.hands_left == 1 and G.GAME.current_round.discards_left < 2 and (to_big(G.GAME.chips)) < (to_big(G.GAME.blind.chips / 1.5)) then
        this_mod.seconds = this_mod.seconds - dt
        if this_mod.seconds <= 0 then
            this_mod.seconds = 2.5
            play_sound("divi_jesus")
            this_mod.jesuspng = load_image("jesus"..(math.random(4)-1)..".png")
        end
    end
end

local drawhook = love.draw
function love.draw()
    drawhook()
    function load_image(fn)
        local full_path = (this_mod.path 
        .. "customimages/" .. fn)
        local file_data = assert(NFS.newFileData(full_path))
        local tempimagedata = assert(love.image.newImageData(file_data))
        return (assert(love.graphics.newImage(tempimagedata)))
    end
    
    local _xscale = love.graphics.getWidth()/1920
    local _yscale = love.graphics.getHeight()/1080
    
    if G.GAME.current_round.hands_left and G.GAME.current_round.hands_left == 1 and G.GAME.current_round.discards_left < 2 and (to_big(G.GAME.chips)) < (to_big(G.GAME.blind.chips / 1.5)) then
        if this_mod.jesuspng == nil then this_mod.jesuspng = load_image("jesus0.png") end
        love.graphics.setColor(1, 1, 1, 0.2 + (this_mod.seconds / 3.25))
        love.graphics.draw(this_mod.jesuspng,0,0,0,_xscale,_yscale)
    end
end