# -*- mode: sh -*-
#
# Subroutines for dotfile modules
#
#
# Variables to set before sourcing this file:
#
#     module       set this to the module name
#     description  description of what this module is for
#
#
# Optional variables to set:
#
#     premodules   array of modules to install first
#
#
# Functions provided by this file:
#
#     mkdirs    Make some directories
#     mkslinks  Make some symbolic links to the module's directory
#
#
# Written by Andrew Pensinger
# SEE LICENSE

. $DOTFILE_DIR/util/base.zsh

# Set DOTFILE_MODULE_DIR
if [[ -z $DOTFILE_MODULE_DIR ]]; then
    export DOTFILE_MODULE_DIR=$PWD
fi


### MODULE HELPER FUNCTIONS ###

# Create directories
#
# Usage: mkdirs DIR ...
function mkdirs {
    while [[ $# -ne 0 ]]; do
        mkdir -p $1; shift
    done
}

# Create symbolic links to files in the module directory
#
# This function takes list of sources and destinations. The source path should
# be relative to the module's directory.
#
# Usage: mkslinks (SOURCE DESTINATION) ...
function mkslinks {
    local src
    local dest

    while [[ $# -ne 0 ]]; do
        src=$1; shift
        dest=$1; shift
        ln -s "$DOTFILE_MODULE_DIR/$src" "$dest"
    done
}


### EXECUTE THE MODULE ###

usage="usage: module (install | upgrade | remove)
       module (-h | --help)"

help="$module

Sub-Commands
    install  install this module
    upgrade  upgrade the currently installed version of this module
    remove   remove this module

Environment Variables
    DOTFILE_DIR         the directory containing the dotfile manager

    DOTFILE_MODULE_DIR  the path to this module; set to the current directory by
                        default

Exit Status
    0  OK
    1  Invalid number of arguments
    2  Invalid operation
    3  Module not found

$description"

# Validate number of arguments
if [[ $# -ne 1 ]]; then
    echo "$usage"
    exit 1
fi

# Validate sub-command
case $1 in
    -h|--help) echo "$usage\n\n$help"; exit 0;;
    install) ;;
    upgrade) ;;
    remove) ;;
    *) echo "$usage"; exit 2;;
esac

# Run command on pre-modules
if [[ ${#premodules} -gt 0 ]]; then
    local output
    local exitcode

    echo "Installing pre-modules for $module"
    for mod in $premodules; do
        echo $mod
        output=$(dotfile_exec $1 $mod)
        exitcode=$?
        if [[ $exitcode -ne 0 ]]; then
            echo "\nFailed to $1 $mod:"
            echo "$output"
            exit $exitcode
        fi
    done
fi

# Run the specified sub-command
$1
