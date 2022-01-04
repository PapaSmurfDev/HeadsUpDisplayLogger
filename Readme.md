# HeadsUpDisplayLogger made by PapaNicSmurf

A bunch of personal CC:Tweaked + Plethora scripts tested on SwitchCraft

## How to install this on computercraft

Note: This assumes the repo is cloned on the root of your computer, please change your paths accordingly.

### 1. Install Github Repo Downloader

this will add the github program and it's rom to the computer

```sh
pastebin run p8PJVxC4
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
Add the following:
- local DisplayLogger = required("displayLogger")
- DisplayLogger.transmitChannel = <Any Acceptable Modem Channel>
- DisplayLogger.logFile = <Any Log file name you want>
Print it anywhere with:
- DisplayLogger.log(<Log Information>)


#### Required Modules to start:
* Overlay Glasses
