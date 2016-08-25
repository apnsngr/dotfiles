# -*- mode: sh -*-
# Sets basic environment and provides basic functions for dotfile scripts and
# modules.
#
#
# Environment Variables:
#
#     DOTFILE_DIR   Required. Set to the directory that contains the dotfile
#                   manager code (Conventionally ~/.d)
#
#     DOTFILE_OS    The OS name to use for OS specific dotfile installation. If
#                   this is not set, it will automatically be determined.
#
#     DOTFILE_PATH  Colon separated directories to search for modules in. These
#                   directories will be searched before directories in
#                   DOTFILE_DIR
#
#
# Functions:
#
#     dotfile_exec  Run a command on the specified module. Returns the exit
#                   status of the module command. Returns 3 if the module is not
#                   found.
#
#
# Written by Andrew Pensinger
# SEE LICENSE

# Set DOTFILE_OS
if [[ -z $DOTFILE_OS ]]; then
    local kernel=$(uname -s)
    case $kernel in
        Darwin)
            export DOTFILE_OS="macos" ;;
        Linux)
            local distro=$(lsb_release -si)
            case $distro in
                Ubuntu) export DOTFILE_OS="ubuntu" ;;
                RedHatEnterpriseWorkstation) export DOTFILE_OS="redhat" ;;
                *) echo "Unsupported Linux distribution: $distro" >&2 ;;
            esac
            ;;
        *)
          echo "Could not determine OS" >&2 ;;
    esac
fi

# Set module search path
# TODO Include directories in DOTFILE_PATH
search_path=($DOTFILE_DIR/private
             $DOTFILE_DIR/os
             $DOTFILE_DIR/modules)

# Function to execute a command on a module
# Usage: dotfile_exec <command> <module>
# Return:
#     3  Module not found
#     Exit status of <command>
function dotfile_exec {
    local dmd=$DOTFILE_MODULE_DIR
    for s in $search_path; do
        for m in $s/*(N); do
            if [[ -d $m && $(basename $m) == $2 ]]; then
                export DOTFILE_MODULE_DIR=$m
                $m/module $1
                return $?
            fi
        done
    done
    export DOTFILE_MODULE_DIR=$dmd
    echo "Module not found: $2" >&2
    return 3
}
