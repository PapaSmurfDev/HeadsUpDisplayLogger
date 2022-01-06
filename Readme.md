# HeadsUpDisplayLogger made by PapaNicSmurf

A bunch of personal CC:Tweaked + Plethora scripts tested on SwitchCraft

## How to install this on computercraft

Note: This assumes the repo is cloned on the root of your computer, please change your paths accordingly.

### 1. Install Github Repo Downloader

this will add the github program and it's rom to the computer

```sh
pastebin run MqMXLCdf
```

I also have the habit to alias github as git as such:

```sh
alias git github
```

### 2. Clone the repository

```sh
git clone PapaSmurfDev/HeadsUpDisplayLogger

```

This will clone the whole repo into a HeadsUpDisplayLogger directory.

### 3. Update the repo

While being in the repository directory, use the pull script to update it

```sh
pull
```

## The various scripts

### pull -- updater

This script is an updater, it auto clones the repo onto itself using the github script aforementioned.

### Basic Usage

isReceiver: true - Represents the Neural interface receiving signal
isReceiver: false - Represents the machine logging
signature: Is basically your password to prevent people from invading your channel
logFile: WIP

Add the following:
#### For the Neural Interface with overlay glasses:

>local DisplayLogger = require("HeadsUpDisplayLogger/displayLogger")
>
>local initiateTbl = {
>
>  ["signature"] = "12345",
>  
>  ["isReceiver"] = true,
>  
>  ["channel"] = 1000,
>  
>  ["logFile"] = "testLog.txt"
>  
>}
>
>DisplayLogger.initiate(initiateTbl)

#### For the machine you want to log and send the information:

>local DisplayLogger = require("HeadsUpDisplayLogger/displayLogger")
>
>local initiateTbl = {
>
>  ["signature"] = "12345",
>  
>  ["isReceiver"] = false,
>  
>  ["channel"] = 1000,
>  
>  ["logFile"] = "testLog.txt"
>  
>}
>
>DisplayLogger.initiate(initiateTbl)

#### Wherever you need to send data to your glasses
>DisplayLogger.sendData("Insert your own info here")

 #### You can control your glasses log with:
 - Up Arrow: Scroll up
 - Down Arror: Scroll down
 - P: Pause the incoming data, do not worry about future data sent, when you unpaused, they will appear
  
#### Required Modules to start:
* Overlay Glasses
* Keyboard
