require "colorize"
require "yaml"

module Colorls
  module Styler
    # I have to map these, because we can't dynamically create a Symbol and a Symbol is required by Colorizer
    COLORS = {
      "default"       => :default,
      "black"         => :black,
      "red"           => :red,
      "green"         => :green,
      "yellow"        => :yellow,
      "blue"          => :blue,
      "magenta"       => :magenta,
      "cyan"          => :cyan,
      "light_gray"    => :light_gray,
      "dark_gray"     => :dark_gray,
      "light_red"     => :light_red,
      "light_green"   => :light_green,
      "light_yellow"  => :light_yellow,
      "light_blue"    => :light_blue,
      "light_magenta" => :light_magenta,
      "light_cyan"    => :light_cyan,
      "white"         => :white,
    }

    # Maybe do these as file types later
    def self.config
      @@config ||= YAML.parse(config_file)
    end

    # Look for a configuration file:
    # - In the current directory (for overrides)
    # - In the preferred configuration location
    # - In the root of the users ~ directory
    def self.config_file
      @@config_file ||=
        if File.exists?(File.expand_path("./colorls-cr.yml"))
          File.read(File.expand_path("./.colorls-cr.yml"))
        elsif File.exists?(File.expand_path("~/.config/colorls-cr/config.yaml"))
          File.read(File.expand_path("~/.config/colorls-cr/config.yaml"))
        elsif File.exists?(File.expand_path("~/.colorls-cr.yml"))
          File.read(File.expand_path("~/.colorls-cr.yml"))
        else
          "---
  colors:
    default: white
    directory: blue
    executable: green
    file: light_yellow
    symlink: light_cyan
  icons:
    default: \"\uf15b\"
    folder: \"\uf07b\""
        end
    end

    def self.filename(file : NamedTuple) : Colorize::Object
      file[:filename].colorize(color(file))
    end

    def self.long_filename(file : NamedTuple) : Colorize::Object
      file[:long_filename].colorize(color(file))
    end

    def self.icon(file : NamedTuple) : Colorize::Object
      icon = if file[:type] == :directory
               config["icons"]["folder"]
             else
               config["icons"][file[:filename]]? ||
                 config["icons"][file[:extension]]? ||
                 config["icons"]["default"]
             end.to_s

      icon.colorize(color(file))
    end

    # Output colors are based on the file type and are limited to the colors supported by
    # [Colorize](https://crystal-lang.org/api/0.28.0/Colorize.html)
    def self.color(file : NamedTuple) : Symbol
      color_key = file[:type].to_s

      color = config["colors"][color_key]? || config["colors"]["default"]?

      COLORS[color]? || :white
    end
  end
end
