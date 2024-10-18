#!/usr/bin/python3
import socket
import sys
import os



#############################################################
#                     VARIABLES                             #
#############################################################

# socket path
sockPath = os.environ['NEXTCLOUD_SOCKET_PATH']

# nextcloud client folder
dirPath = os.environ['NEXTCLOUD_DIR_PATH']

# logseq nextcloud folder
nextDir = os.environ['LOGSEQ_NEXTCLOUD_DIR']

# logseq local folder
localDir = os.environ['LOGSEQ_LOCAL_DIR']




#############################################################
#                     FUNCTIONS                             #
#############################################################

def isSynced(sockPath:str=sockPath, dirPath:str=dirPath) -> bool:
    try:
        # Create socket object
        nextSocket = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

        # Connect to socket
        nextSocket.connect(sockPath)
    except (ConnectionRefusedError, FileNotFoundError):
        return False

    # Send folder status command
    nextSocket.send((f'RETRIEVE_FOLDER_STATUS:{dirPath}\n').encode())

    # Get message
    message = nextSocket.recv(512).decode()

    for line in message.splitlines():
        if "OK" in line:
            return True
    else:
        return False

def isLogseqOpened() -> bool:
    if 0 == os.system('pgrep Logseq >/dev/null'):
        return True
    else:
        return False

def local_to_next(localDir:str=localDir, nextDir:str=nextDir, notify=False) -> None:
    os.system(f'rsync -av --delete-before "{localDir}/" "{nextDir}"')
    if notify:
        os.system('notify-send "Logseq nextcloud folder synced"')

def next_to_local(nextDir:str=nextDir, localDir:str=localDir, notify=False) -> None:
    os.system(f'rsync -av --delete-before "{nextDir}/" "{localDir}"')
    if notify:
        os.system('notify-send "Logseq local folder synced"')

def check_nextcloud() -> None: 
    if not isSynced():
        os.system('notify-send -u critical "Local logseq folder got synced to the nextcloud folder, but nextcloud is currently turned off. It is recommended that you turn it back on"')



#############################################################
#                       SCRIPT                              #
#############################################################

# Check if Logseq is opened
if isLogseqOpened():
    os.system('notify-send -u critical "Logseq is already opened, this should not have happened. You are on your own now :)"')
    sys.exit()


# Sync nextcloud folder to local folder if nextcloud status is synced
if isSynced():
    next_to_local(notify=True)
else:
    os.system('notify-send "You need to sync your notes first"')
    sys.exit()


# Open logseq
os.system('exec /usr/bin/flatpak run --branch=stable --arch=x86_64 com.logseq.Logseq --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-features=WaylandWindowDecorations')


# Check if local ramdisk folder exists, if not create it --->
# Check if another user is currently accessing logseq cloud folder


while isLogseqOpened():
    i+=1
    if i == 90:
        local_to_next()
        check_nextcloud()
        i=0
    time.sleep(2)

local_to_next(notify=True)
check_nextcloud()
