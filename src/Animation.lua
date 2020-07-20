Animation = {}
Animation.__index = Animation

function Animation:new(quad, t)
    local this = {
        class = 'Animation',
        quad = quad,
        fps = t.fps,
        timer = 1 / t.fps,
        frame = 1,
        frames = t.frames,
        xoffset = 0,
        xoffsetMul = t.xoffsetMul,
        yoffset = t.yoffset,
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
        if self.frame >= self.frames then
            self.animationEnd = true
            return
        end
        self.xoffset = self.xoffsetMul * self.frame
        self.quad:setViewport(self.xoffset, self.yoffset, self.xoffsetMul, self.xoffsetMul)
    end
end

function Animation:hasFinished()
    return self.animationEnd
end