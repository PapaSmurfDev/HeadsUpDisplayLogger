TextCanvas = {}

local modules = peripheral.find("neuralInterface")
if not modules.hasModule("plethora:glasses") then 
  error("The overlay glasses are missing", 0) 
end

local canvas = modules.canvas()

canvas.clear()

local screenWidth, screenHeight = canvas.getSize()

local headsupWidth, headsupHeight, headsupBg =
 screenWidth/4, screenHeight/2, 0x000000AA

local headsUp_xStartPos = screenWidth - headsupWidth

local textHeight = 10

local scrollDist = 0

local displayGroup = canvas.addGroup({0,0})

TextCanvas.isPause = false

displayGroup.addRectangle(headsUp_xStartPos,
0, headsupWidth, headsupHeight+textHeight, headsupBg)

local textGroup = displayGroup.addGroup({headsUp_xStartPos+5,
0})
local text = textGroup.addText({0, 0}, "")

local isPauseText = displayGroup.addText({headsUp_xStartPos+5,
 headsupHeight}, "")

local textGroup_yPos = 0
local currentTextBox_yLimit = headsupHeight - textHeight
local textBoxData = {}

local textObjGroup = {}

local function checkText_YPosColor(i)
  local yData = textBoxData[i]["y"]
  if yData > currentTextBox_yLimit then
    textObjGroup[i].setColour(0xFFFFFF00)
  elseif yData >= 0 and yData <= currentTextBox_yLimit then
    textObjGroup[i].setColour(0xFFFFFFFF)
  end
end

local function resetScroll()
  if scrollDist ~= 0 then
    textGroup_yPos = 0
    textGroup.setPosition(headsUp_xStartPos+5, textGroup_yPos)
    for i, v in ipairs(textBoxData) do
      v["y"] = v["y"] - scrollDist*textHeight
      checkText_YPosColor(i)
    end
    scrollDist = 0
  end
end

function TextCanvas.toggleIsPause()
  TextCanvas.isPause = not TextCanvas.isPause
  if TextCanvas.isPause then
    isPauseText.setText("Pause")
  else
    isPauseText.setText("")
  end
end

function TextCanvas.addLine(str)
  resetScroll()
  for i, v in ipairs(textBoxData) do
    v["y"] = v["y"] - textHeight
    textObjGroup[i].setPosition(0, v["y"])
    checkText_YPosColor(i)
  end
  local textData = {
    -- ["str"] = "",
    ["x"] = 0,
    ["y"] = headsupHeight - textHeight,
    ["color"] = 0XFFFFFFFF
  }
  local text = textGroup.addText({
    textData.x, textData.y}, str)
  -- text.setScale(1)
  table.insert(textObjGroup, text)
  table.insert(textBoxData, textData)
end

function TextCanvas.scroll(direction)
  textGroup_yPos = textGroup_yPos + direction*textHeight
  textGroup.setPosition(headsUp_xStartPos+5, textGroup_yPos)
  scrollDist = scrollDist + direction
  for i, v in ipairs(textBoxData) do
    v["y"] = v["y"] + direction*textHeight
    checkText_YPosColor(i)
  end
end

return TextCanvas