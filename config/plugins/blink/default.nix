{ pkgs, lib, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    blink-ripgrep-nvim
  ];

  plugins = rec {
    blink-cmp-dictionary.enable = true;
    blink-cmp-spell.enable = false;
    blink-cmp-git.enable = false;
    blink-emoji.enable = false;
    blink-ripgrep.enable = true;
    blink-cmp = {
      enable = true;
      setupLspCapabilities = true;

      settings = {
        keymap = {
          preset = "super-tab";
        };
        signature = {
          enabled = true;
        };

        sources = {
          default = (
            [
              "buffer"
              "lsp"
              "path"
              "snippets"
            ]
            # Community
            ++ lib.lists.optionals blink-cmp-dictionary.enable [ "dictionary" ]
            ++ lib.lists.optionals blink-ripgrep.enable [ "ripgrep" ]
            ++ lib.lists.optionals blink-cmp-spell.enable [ "spell" ]
            ++ lib.lists.optionals blink-cmp-git.enable [ "git" ]
            ++ lib.lists.optionals blink-emoji.enable [ "emoji" ]
          );
          providers = {
            lsp = {
              score_offset = 900;
            };
            dictionary = lib.mkIf blink-cmp-dictionary.enable {
              name = "Dict";
              module = "blink-cmp-dictionary";
              min_keyword_length = 800;
            };
            spell = lib.mkIf blink-cmp-spell.enable {
              name = "Spell";
              module = "blink-cmp-spell";
              score_offset = 700;
            };
            ripgrep = lib.mkIf blink-ripgrep.enable {
              name = "Ripgrep";
              module = "blink-ripgrep";
              score_offset = 600;
              opts = {
                backend = {
                  use = "gitgrep-or-ripgrep";
                };
              };
            };
            emoji = lib.mkIf blink-emoji.enable {
              name = "Emoji";
              module = "blink-emoji";
              score_offset = 500;
            };
            git = lib.mkIf blink-cmp-git.enable {
              module = "blink-cmp-git";
              name = "git";
              score_offset = 400;
              opts = {
                commit = { };
                git_centers = {
                  git_hub = { };
                };
              };
            };
          };
        };

        appearance = {
          nerd_font_variant = "mono";
          kind_icons = {
            Text = "󰉿";
            Method = "";
            Function = "󰊕";
            Constructor = "󰒓";

            Field = "󰜢";
            Variable = "󰆦";
            Property = "󰖷";

            Class = "󱡠";
            Interface = "󱡠";
            Struct = "󱡠";
            Module = "󰅩";

            Unit = "󰪚";
            Value = "󰦨";
            Enum = "󰦨";
            EnumMember = "󰦨";

            Keyword = "󰻾";
            Constant = "󰏿";

            Snippet = "󱄽";
            Color = "󰏘";
            File = "󰈔";
            Reference = "󰬲";
            Folder = "󰉋";
            Event = "󱐋";
            Operator = "󰪚";
            TypeParameter = "󰬛";
            Error = "󰏭";
            Warning = "󰏯";
            Information = "󰏮";
            Hint = "󰏭";

            Emoji = "🤶";
          };
        };
        completion = {
          menu = {
            border = "none";
            draw = {
              gap = 1;
              treesitter = [ "lsp" ];
              columns = [
                {
                  __unkeyed-1 = "label";
                }
                {
                  __unkeyed-1 = "kind_icon";
                  __unkeyed-2 = "kind";
                  gap = 1;
                }
                { __unkeyed-1 = "source_name"; }
              ];
            };
          };
          trigger = {
            show_in_snippet = false;
          };
          documentation = {
            auto_show = true;
            window = {
              border = "single";
            };
          };
          accept = {
            auto_brackets = {
              enabled = false;
            };
          };
        };
      };
    };
  };
}
