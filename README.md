Dotfiles
========

This repository contains configuration files for the tools I use. The
configurations are organized into modules, which can be installed, uninstalled,
and updated through automated scripts.


Dependencies
------------

- zsh


Installation
------------

    git clone https://github.com/apnsngr/dotfiles.git $HOME/.d
    cd $HOME/.d
    ./dotfiles install


Important Modules
-----------------

- homefs
- zsh


To Do
-----

### Basics

- [ ] DOTFILE_PATH
- [x] mkdirs
- [ ] rmdirs
- [x] mkslinks
- [ ] rmslinks
- [ ] Test pre-module failure
- [ ] OS directories in modules

### Documentation

- [x] Add ``dotfile`` script instructions
- [ ] Add documentation about module layout
- [ ] Add documentation about creating modules
- [ ] Add local configuration instructions

### OS Modules

- [x] macOS (OS X)
- [ ] Ubuntu
- [ ] OpenBSD

### General Tools

- [x] Home directory Unix hierarchy (homefs)
- [x] zsh
- [x] tmux
- [x] Vim (sane defaults, no plugins)
- [ ] Vim (colorscheme and gundo)
- [ ] Spacemacs
  - [x] Local Spacemacs configuration
  - [ ] OS Spacemacs configuration
- [ ] Plan9Port

### macOS Specific

### X Windows

- [ ] Lemonbar

### Ubuntu Specific

- [ ] Unity
  - [ ] Random background script (set up cronjob too)


License
-------

BSD unless otherwise stated. See LICENSE.
