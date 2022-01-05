#HeadsUpDisplayLogger/displayLogger

local modem = peripheral.find("modem")
local modules
local canvas
local TextCanvas
if modem == nil then
  error("Can't open modem")
end

DisplayLogger = {}

DisplayLogger.transmitChannel = -1
DisplayLogger.logFile = ""
-- This is for the Neural Interface
DisplayLogger.isReceiver = false
DisplayLogger.signature = ""

function DisplayLogger.initiate(intiatiateTbl)
	DisplayLogger.signature = intiatiateTbl["signature"]
	DisplayLogger.isReceiver = intiatiateTbl["isReceiver"]
	print("Receiver:",DisplayLogger.isReceiver)
	if DisplayLogger.isReceiver then
		TextCanvas = require('HeadsUpDisplayLogger/TextCanvas')
	end
	if DisplayLogger.isReceiver then
		modules = peripheral.find("neuralInterface")
		if not modules then 
			error("Must have a neural interface", 0) 
		end
		if not modules.hasModule("plethora:glasses") then 
			error("The overlay glasses are missing", 0) 
		end
		canvas = modules.canvas()
	end
	DisplayLogger.transmitChannel = intiatiateTbl["channel"]
	DisplayLogger.logFile = intiatiateTbl["logFile"]
	return modem.open(DisplayLogger.transmitChannel)
end

function DisplayLogger.sendData(msg)
	local data = {
		["channel"] = DisplayLogger.transmitChannel,
		["signature"] = DisplayLogger.signature,
		["obj"] = {
			["msg"] = msg
		}
	}
	modem.transmit(DisplayLogger.transmitChannel, 
		DisplayLogger.transmitChannel, data)
end

function addLine(msg)
	if canvas then
		TextCanvas.addLine(msg)
	else
		print("canvas not found")
	end
end

local cachedReceivedLines = {}

function DisplayLogger.clearCanvas()
	canvas.clear()
end

function DisplayLogger.listenDevice(event, key_side, msg)
		if event == "key" then
			if key_side == keys.up then
		    TextCanvas.scroll(-1)
	  	elseif key_side == keys.down then
	    	TextCanvas.scroll(1)
			elseif key_side == keys.p then
				TextCanvas.toggleIsPause()
			end
		elseif event == "modem_message" then
			if msg["signature"] == DisplayLogger.signature and msg["channel"] == DisplayLogger.transmitChannel then
				if not TextCanvas.isPause then
					if #cachedReceivedLines > 0 then
						for i,v in ipairs(cachedReceivedLines) do
							addLine(v)
						end
						cachedReceivedLines = {}
					end
					addLine(msg["obj"]["msg"])
				else
					table.insert(cachedReceivedLines, msg["obj"]["msg"])
				end
			end
		end
end

return DisplayLogger