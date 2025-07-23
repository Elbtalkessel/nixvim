{
  pkgs,
  lib,
  ...
}:
let
  copilot = false;
in
{
  extraPlugins =
    with pkgs.vimPlugins;
    [
      blink-ripgrep-nvim
    ]
    ++ (
      if copilot then
        [
          blink-cmp-copilot
        ]
      else
        [ ]
    );

  extraPackages = with pkgs; [
    gh
  ];

  plugins = {
    blink-cmp-copilot.enable = copilot;
    blink-cmp-dictionary.enable = true;
    blink-cmp-spell.enable = true;
    blink-copilot.enable = copilot;
    blink-cmp-git.enable = true;
    blink-emoji.enable = true;
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
          default = [
            "buffer"
            "lsp"
            "path"
            "snippets"
            # Community
            "dictionary"
            "emoji"
            "git"
            "spell"
            "ripgrep"
          ] ++ (if copilot then [ "copilot" ] else [ ]);
          providers = {
            ripgrep = {
              name = "Ripgrep";
              module = "blink-ripgrep";
              score_offset = 300;
            };
            dictionary = {
              name = "Dict";
              module = "blink-cmp-dictionary";
              min_keyword_length = 100;
            };
            emoji = {
              name = "Emoji";
              module = "blink-emoji";
              score_offset = 0;
            };
            copilot = lib.mkIf copilot {
              name = "copilot";
              module = "blink-copilot";
              async = true;
              score_offset = 200;
            };
            lsp.score_offset = 400;
            spell = {
              name = "Spell";
              module = "blink-cmp-spell";
              score_offset = 0;
            };
            git = {
              module = "blink-cmp-git";
              name = "git";
              score_offset = 0;
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
