# colorls-cr

A command line tool for adding icons to ls output, similar to [colorls](https://github.com/athityakumar/colorls).

This is my first tool written in Crystal, for fun.

## Installation

- Install crystal
- Install a powerline font for your terminal
- Clone the repo
- `shards install`
- `crystal build src/colorls.cr`

## Usage

Put the generated binary in your $PATH, and run `colorls`. You can setup an alias:

    alias ls="colorls --report"

Run `colorls -s` to generate a default configuration file.

### Icons & colors

To customize icons & colors, add a `~/.config/colorls-cr/config.yaml` or
`~/.colorls-cr.yaml` file with your icon & color mappings. An example
yaml file:

```yaml
---
colors:
  default: white
  directory: blue
  executable: green
  file: light_yellow
icons:
  default: "\uf15b"
  folder: "\uf07b"
  .git: "\uf1d3"
  .gitignore: "\uf1d3"
  Gemfile: "\ue21e"
  Gemfile.lock: "\ue21e"
  .rb: "\ue21e"
  yarn.lock: "\ue718"
  .yml: "\uf481"
  .yaml: "\uf481"
  .editorconfig: "\uf719"
  tags: "\uf02b"
  tags.lock: "\uf02b"
```

Available colors can be any string supported by [Colorize](https://crystal-lang.org/api/0.28.0/Colorize.html)

Icons can be any Unicode mapping for your font. Use the [nerdfonts cheatsheet](http://nerdfonts.com/#cheat-sheet) to
look up code points if you're using [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)

## TODO

- Additional flags/options
- Tests
- Setup/config.yaml generator

## Contributing

1. Fork it (<https://github.com/your-github-user/colorls/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
