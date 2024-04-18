{ config, ... }:
with config.lib.stylix.colors.withHashtag;
''
  "ui.background" = { bg = "base00" }
  "ui.virtual.whitespace" = "base03"
  "ui.menu" = { fg = "base05", bg = "base01" }
  "ui.menu.selected" = { fg = "base01", bg = "base04" }
  "ui.linenr" = { fg = "base03", bg = "base01" }
  "ui.popup" = { bg = "base01" }
  "ui.window" = { bg = "base01" }
  "ui.linenr.selected" = { fg = "base04", bg = "base01", modifiers = ["bold"] }
  "ui.selection" = { bg = "base02" }
  "comment" = { fg = "base03", modifiers = ["italic"] }
  "ui.statusline" = { fg = "base04", bg = "base01" }
  "ui.cursor" = { fg = "base04", modifiers = ["reversed"] }
  "ui.cursor.primary" = { fg = "base05", modifiers = ["reversed"] }
  "ui.text" = "base05"
  "operator" = "base05"
  "ui.text.focus" = "base05"
  "variable" = "base08"
  "constant.numeric" = "base09"
  "constant" = "base09"
  "attribute" = "base09"
  "type" = "base0A"
  "ui.cursor.match" = { fg = "base0A", modifiers = ["underlined"] }
  "string"  = "base0B"
  "variable.other.member" = "base0B"
  "constant.character.escape" = "base0C"
  "function" = "base0D"
  "constructor" = "base0D"
  "special" = "base0D"
  "keyword" = "base0E"
  "label" = "base0E"
  "namespace" = "base0E"
  "ui.help" = { fg = "base06", bg = "base01" }

  "markup.heading" = "base0D"
  "markup.list" = "base08"
  "markup.bold" = { fg = "base0A", modifiers = ["bold"] }
  "markup.italic" = { fg = "base0E", modifiers = ["italic"] }
  "markup.strikethrough" = { modifiers = ["crossed_out"] }
  "markup.link.url" = { fg = "base09", modifiers = ["underlined"] }
  "markup.link.text" = "base08"
  "markup.quote" = "base0C"
  "markup.raw" = "base0B"

  "diff.plus" = "base0B"
  "diff.delta" = "base09"
  "diff.minus" = "base08"

  "diagnostic" = { modifiers = ["underlined"] }
  "ui.gutter" = { bg = "base01" }
  "info" = "base0D"
  "hint" = "base03"
  "debug" = "base03"
  "warning" = "base09"
  "error" = "base08"

  "ui.bufferline" = { fg = "base04", bg = "base00" }
  "ui.bufferline.active" = { fg = "base06", bg = "base01" }

  [palette]
  base00 = "${base00}" # Default Background
  base01 = "${base01}" # Lighter Background (Used for status bars, line number and folding marks)
  base02 = "${base02}" # Selection Background
  base03 = "${base03}" # Comments, Invisibles, Line Highlighting
  base04 = "${base04}" # Dark Foreground (Used for status bars)
  base05 = "${base05}" # Default Foreground, Caret, Delimiters, Operators
  base06 = "${base06}" # Light Foreground (Not often used)
  base07 = "${base07}" # Light Background (Not often used)
  base08 = "${base08}" # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
  base09 = "${base09}" # Integers, Boolean, Constants, XML Attributes, Markup Link Url
  base0A = "${base0A}" # Classes, Markup Bold, Search Text Background
  base0B = "${base0B}" # Strings, Inherited Class, Markup Code, Diff Inserted
  base0C = "${base0C}" # Support, Regular Expressions, Escape Characters, Markup Quotes
  base0D = "${base0D}" # Functions, Methods, Attribute IDs, Headings
  base0E = "${base0E}" # Keywords, Storage, Selector, Markup Italic, Diff Changed
  base0F = "${base0F}" # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
''