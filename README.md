# colorls-cr

A command line tool, written in Crystal for adding icons to ls output, similar to [colorls](https://github.com/athityakumar/colorls).

Example output:

![image](https://user-images.githubusercontent.com/191564/57423344-a1582700-71e1-11e9-9310-e8f041843384.png)

## Installation

- Install crystal
- Install a powerline font for your terminal
  - Download & install a release from [Nerd Fonts](http://nerdfonts.com/#downloads); **or**
  - Install a powerline font using homebrew (`brew cask install font-droid-sans-mono-for-powerline`)
- Clone the repo & `cd` into it
- `shards install`
- `crystal build src/colorls.cr --no-debug --release`

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

Available colors can be any string supported by [Colorize](https://crystal-lang.org/api/0.28.0/Colorize.html)

Icons can be any Unicode mapping for your font. Use the [nerdfonts cheatsheet](http://nerdfonts.com/#cheat-sheet)
to look up code points if you're using [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)

## Things to do

- [ ] Additional flags/options
- [ ] Tests
- [x] Setup/config.yaml generator

## Contributing

1. Fork it (<https://github.com/your-github-user/colorls/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
