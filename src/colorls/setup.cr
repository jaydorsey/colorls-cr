module Colorls
  module Setup
    def self.call
      config_path = File.expand_path("~/.config/colorls-cr")
      config_file = File.expand_path("~/.config/colorls-cr/config.yaml")

      Dir.mkdir_p(config_path)

      puts "Generating default configuration files & folders"
      puts
      if File.exists?(config_file)
        puts "  Config file already exists at #{config_file.to_s}".colorize(:yellow)
      else
        puts "  Generating config file at #{config_file.to_s}".colorize(:green)
        File.write(config_file, "---
# Available colors from https://crystal-lang.org/api/0.27.2/Colorize.html
# default
# black
# red
# green
# yellow
# blue
# magenta
# cyan
# light_gray
# dark_gray
# light_red
# light_green
# light_yellow
# light_blue
# light_magenta
# light_cyan
# white
colors:
  default: white
  directory: blue
  executable: green
  file: light_yellow
# Look up unicode mappings at http://nerdfonts.com/#cheat-sheet
icons:
  default: \"\\uf15b\"
  folder: \"\\uf07b\"
  .c: \"\\ue61e\"
  .clj: \"\\ue768\"
  .conf: \"\\ue615\"
  .cpp: \"\\ue61d\"
  .css: \"\\ue749\"
  .db: \"\\uf1c0\"
  .doc: \"\\uf1c2\"
  .docx: \"\\uf1c2\"
  Dockerfile: \"\\uf308\"
  docker-compose.yml: \"\\uf308\"
  .docker: \"\\uf308\"
  .env: \"\\uf462\"
  .ex: \"\\ue62d\"
  .font: \"\\uf031\"
  .git: \"\\uf1d3\"
  .gitignore: \"\\uf1d3\"
  .go: \"\\ue626\"
  gruntfile.js: \"\\ue74c\"
  .html: \"\\uf13b\"
  .java: \"\\ue204\"
  .js: \"\\ue74e\"
  .json: \"\\ue60b\"
  .log: \"\\uf18d\"
  .md: \"\\uf48a\"
  .markdown: \"\\uf48a\"
  .pdf: \"\\uf1c1\"
  .ppt: \"\\uf1c4\"
  .pptm: \"\\uf1c4\"
  .pptx: \"\\uf1c4\"
  .psd: \"\\ue7b8\"
  .py: \"\\ue606\"
  Gemfile: \"\\ue21e\"
  Gemfile.lock: \"\\ue21e\"
  .rb: \"\\ue21e\"
  .rubydoc: \"\\ue73b\"
  .sass: \"\\ue603\"
  .scss: \"\\ue603\"
  .sqlite3: \"\\ue7c4\"
  .ts: \"\\ue628\"
  .txt: \"\\uf15c\"
  .vim: \"\\ue62b\"
  .xls: \"\\uf1c3\"
  .xlsx: \"\\uf1c3\"
  .xml: \"\\ue619\"
  yarn.lock: \"\\ue718\"
  .yml: \"\\uf481\"
  .yaml: \"\\uf481\"
  .zip: \"\\uf410\"
  LICENSE: \"\\uf719\"
  .editorconfig: \"\\uf719\"
  tags: \"\\uf02b\"
  tags.lock: \"\\uf02b\"")
      end
    end
  end
end
