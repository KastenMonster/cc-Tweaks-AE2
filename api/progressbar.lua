
local function drawLine(mon, x, y, length, height, color)
    for yPos = y, y + height - 1 do
        mon.setBackgroundColor(color)
        mon.setCursorPos(x, yPos)
        mon.write(string.rep(" ", length))
    end
end

local function clear(mon, x, y, length, height)
    drawLine(mon, x, y, length, height, colors.black)
end

function new()
    local self = {}

    self.setup = function (mon, x, y, length, height, color_bar, color_prog)
        self.mon = mon
        self.x = x
        self.y = y
        self.length = length
        self.height = height
        self.color_bar = color_bar
        self.color_prog = color_prog

        drawLine(self.mon, self.x, self.y, self.length, self.height, self.color_bar)
    end

    self.update = function (value)
        drawLine(self.mon, self.x, self.y, self.length, self.height, self.color_bar)
        drawLine(self.mon, self.x, self.y, math.floor(value / 100) * self.length, self.height, self.color_prog)
    end

    self.remove = function ()
        clear(self.mon, self.x, self.y, self.length, self.height)
    end

    return self
end