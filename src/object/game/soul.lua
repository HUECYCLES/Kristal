local Soul, super = Class(Object)

function Soul:init(x, y)
    super:init(self, x, y)

    self:setOrigin(0.5, 0.5)

    self.color = {1, 0, 0, 1}

    self.sprite = Sprite("player/heart_dodge")
    self.sprite.color = self.color
    self:addChild(self.sprite)

    self.original_x = x
    self.original_y = y
    self.target_x = x
    self.target_y = y
    self.timer = 0
    self.transitioning = false
    self.speed = 4
    self.alpha = 0
end

function Soul:moveTo(x, y)
    self.transitioning = true
    self.target_x = x
    self.target_y = y
    self.timer = 0
end

function Soul:update(dt)
    if self.transitioning then
        if self.timer >= 7 then
            self.transitioning = false
            self.timer = 0
            self.x = self.target_x
            self.y = self.target_y
        else
            self.x = Utils.lerp(self.original_x, self.target_x, self.timer / 7)
            self.y = Utils.lerp(self.original_y, self.target_y, self.timer / 7)
            self.alpha = Utils.lerp(0, self.color[4], self.timer / 3)
            self.sprite:setColor(self.color[1], self.color[2], self.color[3], self.alpha)
            self.timer = self.timer + (1 * DTMULT)
            return
        end
    end


    local speed = self.speed

    -- Do speed calculations here if required.

    if Input.cancel() then speed = speed / 2 end -- Focus mode.

    -- Keyboard input:
    if love.keyboard.isDown("left")  then self.x = self.x - (speed * DTMULT) end
    if love.keyboard.isDown("right") then self.x = self.x + (speed * DTMULT) end
    if love.keyboard.isDown("up")    then self.y = self.y - (speed * DTMULT) end
    if love.keyboard.isDown("down")  then self.y = self.y + (speed * DTMULT) end

    self:updateChildren(dt)
end

return Soul