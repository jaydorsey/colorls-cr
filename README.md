# colorls-cr

A command line tool, written in Crystal for adding icons to ls output, similar to [colorls](https://github.com/athityakumar/colorls).

Example output:

![image](https://user-images.githubusercontent.com/191564/57423344-a1582700-71e1-11e9-9310-e8f041843384.png)

## Installation

- Install crystal
- Install a powerline font for your terminal
  - Download & install a release from [Nerd Fonts](http://nerdfonts.com/#downloads); **or**
  - Install a powerline font using homebrew (`brew cask install font-droid-sans-mono-for-powerline`)
- Install the termbox libraries
  - For macOS, try `brew install termbox`
  - For Linux or macOS, you can also try:
    - The [termbox](https://github.com/nsf/termbox) installation instructions
    - The [termbox-crystal](https://github.com/andrewsuzuki/termbox-crystal/blob/master/install-termbox.sh) installation script
- Clone this repo with `git clone https://github.com/jaydorsey/colorls-cr && cd colorls-cr`
- Run `shards install` to install application dependencies
- Build the binary with `crystal build src/colorls.cr --no-debug --release`

## Usage

Put the generated binary in your $PATH, and run `colorls`. You can setup an alias:

    alias ls="colorls --report"

Run `colorls -s` to generate a default configuration file. By default, the file is placed in
`~/.config/colorls-cr/config.yaml`

## Uninstallation

- Delete the binary
- Delete the config file `rm -rf ~/.config/colorls-cr/`

### Icons & colors

To customize icons & colors, add a `~/.config/colorls-cr/config.yaml` or
`~/.colorls-cr.yaml` file with your icon & color mappings. An example
yaml file is generated at `~/.config/colorls-cr/config.yaml` when you run
`colorls -s`

Available colors can be any string supported by [Colorize](https://crystal-lang.org/api/0.29.0/Colorize.html)

Icons can be any Unicode mapping for your font. Use the [nerdfonts cheatsheet](http://nerdfonts.com/#cheat-sheet)
to look up code points if you're using [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)

## Contributing

Contributions in the form of bug reports, pull requests, documentation updates, and feature requests are welcome.

Please open an issue for any of the above.
