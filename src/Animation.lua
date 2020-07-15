Animation = {}
Animation.__index = Animation

function Animation:new(quad, fps, numFrames, yoffset)
    local this = {
        class = 'Animation',
        quad = quad,
        fps = fps,
        timer = 1 / fps,
        frame = 1,
        numFrames = numFrames,
        xoffset = 0,
        yoffset = yoffset,
        animationEnd = false
    }

    setmetatable(this, self)
    return this
end

function Animation:update(dt)
    if self.shotEnd then return end

    self.timer = self.timer - dt
    if self.timer <= 0 then
        self.timer = 1 / self.fps
        self.frame = self.frame + 1
        if self.frame >= self.numFrames then
            self.animationEnd = true
            return
        end
        self.xoffset = 32 * self.frame
        self.quad:setViewport(self.xoffset, self.yoffset, 32, 32)
    end
end

function Animation:hasFinished()
    return self.animationEnd
end