local mon = peripheral.find("monitor")
local me = peripheral.find("meBridge")

local monX, monY = mon.getSize()

os.loadAPI("ae2/api/progressbar")

local progress = progressbar.new()

function clear(xMin,xMax, yMin, yMax)
    mon.setBackgroundColor(colors.black)
    for xPos = xMin, xMax, 1 do
        for yPos = yMin, yMax, 1 do
            mon.setCursorPos(xPos, yPos)
            mon.write(" ")
        end
    end
end

function prepare()
    mon.setBackgroundColor(colors.black)
    mon.clear()
    if monX < 38 or monY < 25 then
        error("Monitor is too small, we need a size of 39x and 26y minimum.")
    end

    drawBox(2, monX - 1, 2, monY - 1, "Storage", colors.white, colors.green)

    progress.setup(mon, 3, 5, monY - 4, 2, colors.lightGray, colors.green)
end

function drawBox(xMin, xMax, yMin, yMax, title, bcolor, tcolor)
    mon.setBackgroundColor(bcolor)
    for xPos = xMin, xMax, 1 do
        mon.setCursorPos(xPos, yMin)
        mon.write(" ")
    end
    for yPos = yMin, yMax, 1 do
        mon.setCursorPos(xMin, yPos)
        mon.write(" ")
        mon.setCursorPos(xMax, yPos)
        mon.write(" ")

    end
    for xPos = xMin, xMax, 1 do
        mon.setCursorPos(xPos, yMax)
        mon.write(" ")
    end
    mon.setCursorPos(xMin+2, yMin)
    mon.setBackgroundColor(colors.black)
    mon.setTextColor(tcolor)
    mon.write(" ")
    mon.write(title)
    mon.write(" ")
    mon.setTextColor(colors.white)
end

function update()
    mon.setCursorPos(3, 3)
    mon.setTextColor(colors.black)
    mon.write(string.rep(" ", monX - 6))

    mon.setTextColor(colors.white)
    mon.write("Available Storage: " .. me.getAvailableItemStorage() .. " Bytes")

    mon.setCursorPos(3, 3)
    mon.setTextColor(colors.black)
    mon.write(string.rep(" ", monX - 6))

    mon.setTextColor(colors.white)
    mon.write("Totals Cells: " .. me.listDrives())

    progress.update(math.floor((me.getUsedItemStorage() / me.getTotalItemStorage()) * 100))
end

prepare()

while true do
    update()
    sleep(1)
end