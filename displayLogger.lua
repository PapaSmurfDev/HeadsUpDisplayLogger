#HeadsUpDisplayLogger/displayLogger

local modem = peripheral.find("modem")
local modules
local canvas
local TextCanvas
if modem == nil then
  wireless = false
  error("Can't open modem")
else
  wireless = true
end

DisplayLogger = {}

DisplayLogger.transmitChannel = -1
DisplayLogger.logFile = ""
-- This is for the Neural Interface
DisplayLogger.isReceiver = false
DisplayLogger.signature = ""
isReceiver = false

function DisplayLogger.initiate(isReceiver, channel, 
	logFile, signature)
	DisplayLogger.signature = signature
	DisplayLogger.isReceiver = isReceiver
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
	DisplayLogger.transmitChannel = channel
	DisplayLogger.logFile = logFile
	return modem.open(transmitChannel)
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
	if not canvas then
		TextCanvas.addLine(msg)
	else
		print("canvas not found")
	end
end

function DisplayLogger.listenDevice()
	local running = true
	while running do
		local event, key_side, held_ch, rch, msg, dist = os.pullEvent()
		if event == "key" then
			if key_side == keys.x then
				running = false
			end
		elseif event == "modem_message" then
			if msg["signature"] == DisplayLogger.signature and msg["channel"] == DisplayLogger.transmitChannel then
				addLine(msg["obj"]["msg"])
			end
		end
	end
end

return DisplayLogger