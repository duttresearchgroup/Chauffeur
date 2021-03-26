# Password is read from this file. Don't change this line
export R_PASS="-f passwd"

# Chimera
export R_USER=deep
export R_PORT=-p22
export R_HOST=chimera.ics.uci.edu
export R_SRC_ROOT=/home/deep/workspace/miself

# Drive PX2
# export R_USER=nvidia
# export R_PORT=-p22222
# export R_HOST=203.246.112.155
# export R_SRC_ROOT=/home/nvidia/deep/miself

# export R_USER=leming
# export R_PORT=-p22
# export R_HOST=hydra.ics.uci.edu
# export R_SRC_ROOT=/home/leming/deep/miself

# Uncomment for verbose remote commands
export R_VERBOSE=-v

######################################################
# Runs a remote shell command
######################################################

function R_SHELL(){
    if [ -n "$1" ]; then
        sshpass $R_VERBOSE $R_PASS ssh $R_PORT -o StrictHostKeyChecking=no $R_USER@$R_HOST $@
        if [ ! $? -eq 0 ]; then
            echo "Check /etc/ssh/sshd_config in client machine and set X11Forwarding=yes and X11UseLocalhost=no"
        fi
    fi
}
export -f R_SHELL

######################################################
# Waits until the remote device is ready
######################################################

function R_WAIT(){
    __SSHSLEEP="R_SHELL sleep 0.1"
    while ! $__SSHSLEEP
    do
       echo "Waiting for device"
       sleep 2
    done
}
export -f R_WAIT


######################################################
# Copies a file form the remote device
######################################################

function R_PULL(){
    __SRC=$1
    __DEST=$2
    if [ -n "$__DEST" ]; then
        sshpass $R_VERBOSE $R_PASS scp $R_PORT -o StrictHostKeyChecking=no $R_USER@$R_HOST:$__SRC $__DEST
    else
        sshpass $R_VERBOSE $R_PASS scp $R_PORT -o StrictHostKeyChecking=no $R_USER@$R_HOST:$__SRC .
    fi
    
}
export -f R_PULL


######################################################
# Synchs a remote directory with a local directory
# Data in the remote directory may be OVERWRITTEN
######################################################

function R_SYNCH(){
    __SRC=$1
    __DEST=$2
    if [ -e "$__SRC" ]; then
        sshpass $R_VERBOSE $R_PASS rsync --progress -avze "ssh $R_PORT -o StrictHostKeyChecking=no" $__SRC/ $R_USER@$R_HOST:$R_SRC_ROOT/$__DEST/
    else
        echo $__SRC does not exist
        exit
    fi
}
export -f R_SYNCH


######################################################
# Synchs a local directory with a remote directory
# Data in the local directory may be OVERWRITTEN
######################################################

function R_SYNCH_LOCAL(){
    __SRC=$1
    __DEST=$2
    sshpass $R_VERBOSE $R_PASS rsync --progress -avze "ssh $R_PORT -o StrictHostKeyChecking=no" $R_USER@$R_HOST:$R_SRC_ROOT/$__SRC/ $__DEST/
}
export -f R_SYNCH_LOCAL