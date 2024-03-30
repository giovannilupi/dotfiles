# dotfiles

This repository contains a collection of configuration files crafted for my macOS setup. The setup is designed to enhance my experience for development and daily use, striking a harmonious balance between aesthetics and efficiency. The productivity aspects of this setup, pertaining to programs, binaries, and programming workflows, can be easily adapted for use in Linux with minor adjustments.

This configuration is quite elaborate and makes heavy use of external programs and binaries. Despite its complexity, the configuration remains relatively lean in terms of disk space and memory / CPU overhead.

To provide coherency in visual appeal, I am using the [gruvbox](https://github.com/morhetz/gruvbox) dark theme with a moderate level of transparency across most applications.

## Gallery

![screenshot](screenshots/screenshot1.png)
![screenshot](screenshots/screenshot2.png)
![screenshot](screenshots/screenshot3.png)
![screenshot](screenshots/screenshot4.png)

## Dependencies

Here are some of the programs and binaries that I use in this setup.

### Recommended Programs

[`Visual Studio Code`](https://code.visualstudio.com/): main code editor

[`Sublime Text`](https://www.sublimetext.com/): alternative code editor and note taking

[`iTerm2`](https://iterm2.com/): terminal emulator

[`Raycast`](https://www.raycast.com/): replacement launcher for Spotlight

[`SpaceId`](https://github.com/dshnkao/SpaceId): space indicator for macOS menu bar

[`Via`](https://github.com/the-via): keyboard configuration

[`Mos`](https://github.com/Caldis/Mos): smooth scrolling for external mouse

[`Firefox`](https://www.mozilla.org/en-US/firefox/new/): browser

[`Adobe Photoshop`](https://www.adobe.com/products/photoshop.html): image editing

[`Adobe InDesign`](https://www.adobe.com/products/indesign.html): page layout design

[`Spotify`](https://github.com/dshnkao/SpaceId): music player (patched with [`SpotX-Bash`](https://github.com/SpotX-Official/SpotX-Bash))

[`KeePassX`](https://www.keepassx.org/): password manager

[`OmniDiskSweeper`](https://www.omnigroup.com/more): free disk space

### Recommended Binaries

[`yabai`](https://github.com/koekeishiya/yabai): tiling window manager

[`skhd`](https://github.com/koekeishiya/skhd): hotkeys for yabai

[`eza`](https://github.com/eza-community/eza): replacement for `ls`

[`bat`](https://github.com/sharkdp/bat): replacement for `cat`

[`bat-extras`](https://github.com/eth-p/bat-extras): scripts to integrate `bat` with other tools

[`fzf`](https://github.com/junegunn/fzf): command-line fuzzy finder

[`ripgrep`](https://github.com/BurntSushi/ripgrep): replacement for `grep`

[`fd`](https://github.com/sharkdp/fd): replacement for `find`

[`lf`](https://github.com/gokcehan/lf): terminal file manager

[`delta`](https://github.com/dandavison/delta): pager for git/diff

[`forgit`](https://github.com/wfxr/forgit): integrate `git` with `fzf`

[`tgpt`](https://github.com/aandrew-me/tgpt): AI chatbot in the terminal

[`bottom`](https://github.com/ClementTsang/bottom): graphical process/system monitor for the terminal

[`chafa`](https://github.com/hpjansson/chafa): display images in terminal

[`fastfetch`](https://github.com/fastfetch-cli/fastfetch): fetch and display system information

[`cowsay`](https://formulae.brew.sh/formula/cowsay): cow ASCII art with messages

[`fortune`](https://formulae.brew.sh/formula/fortune): fortune-cookie generator

[`ani-cli`](https://github.com/pystardust/ani-cli): browse and watch anime from terminal

[`gruvbox-factory`](https://github.com/paulopacitti/gruvbox-factory): manufacture a gruvbox themed wallpaper

[`xz`](https://formulae.brew.sh/formula/xz): data compression

[`unrar`](https://formulae.brew.sh/cask/rar): data compression

[`7z`](https://formulae.brew.sh/formula/p7zip): data compression

[`ffmpegthumbnailer`](https://formulae.brew.sh/formula/ffmpegthumbnailer): thumbnails for video files

[`pdftoppm`](https://formulae.brew.sh/formula/poppler): PDF rendering library

[`docx2txt.pl`](https://formulae.brew.sh/formula/docx2txt): convert docx documents to text documents

[`gnumeric`](https://formulae.brew.sh/formula/gnumeric): GNOME Spreadsheet Application

## Instructions

Here are some configuration instructions.

### Shell

I use zsh as my preferred shell. 
\
I use [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) as a framework for managing configurations and plugins.
\
As theme, I use [Powerlevel10k](https://github.com/romkatv/powerlevel10k).
\
I am using three custom plugins, which are not included by default on `Oh My Zsh`:

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions): fish shell-like autosuggestions
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting): fish shell-like syntax highlighting
- [dirbrowse](https://github.com/giovannilupi/dirbrowse): fast browsing through the directory stack

The rest of the configuration can be found in the `.zshrc` file.

