{
  config,
  pkgs,
  lib,
  ...
}:
let
  colors = import ../colorscheme/colors/${config.theme}.nix { };
in
{
  extraPlugins =
    with pkgs.vimPlugins;
    [
      blink-ripgrep-nvim
    ]
    ++ lib.optionals config.copilot [
      blink-cmp-copilot
    ];

  plugins = {
    cmp-emoji.enable = true;
    cmp-git.enable = true;
    cmp-spell.enable = true;
    cmp-calc.enable = true;
    cmp-treesitter.enable = true;
    blink-cmp = {
      enable = true;
      setupLspCapabilities = true;
      luaConfig.pre = # lua
        ''
          require('blink.compat').setup({debug = true, impersonate_nvim_cmp = true})
        '';

      settings = {
        keymap = {
          # https://cmp.saghen.dev/configuration/keymap.html#enter
          preset = "enter";
          # noop because interfierce when formatting lines.
          "<Tab>" = [ ];
          "<S-Tab>" = [ ];
        };
        signature = {
          enabled = true;
        };

        sources = {
          default =
            [
              "buffer"
              "calc"
              "emoji"
              "ripgrep"
              "git"
              "lsp"
              "path"
              "snippets"
              "spell"
              #"treesitter"
            ]
            ++ lib.optionals config.copilot [
              "copilot"
            ];
          providers = {
            emoji = {
              name = "emoji";
              module = "blink.compat.source";
            };
            copilot = lib.mkIf config.copilot {
              name = "copilot";
              module = "blink-cmp-copilot";
            };
            git = {
              name = "git";
              module = "blink.compat.source";
            };
            spell = {
              name = "spell";
              module = "blink.compat.source";
            };
            ripgrep = {
              name = "Ripgrep";
              module = "blink-ripgrep";
              score_offset = 1;
            };
            calc = {
              name = "calc";
              module = "blink.compat.source";
            };
          };
        };

        appearance = {
          use_nvim_cmp_as_default = false;
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
  highlight = with colors; {
    BlinkCmpMenu = {
      bg = base01;
      fg = base05;
    };
    BlinkCmpMenuSelection = {
      bg = base0C;
      fg = base00;
    };
    BlinkCmpDoc = {
      bg = base01;
      fg = base05;
    };
    BlinkCmpDocSeparator = {
      bg = base01;
      fg = base0C;
    };
    BlinkCmpDocBorder = {
      bg = base01;
      fg = base01;
    };
  };
}
