{
  config,
  lib,
  pkgs,
  ...
}:
let
  colors = import ../colorscheme/colors/${config.theme}.nix { };
in
{
  extraPackages = with pkgs; [ fd ];

  plugins.snacks = {
    # https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-config
    settings = {
      picker = {
        actions.__raw = ''require("trouble.sources.snacks").actions'';
        matcher = {
          frecency = true;
        };
        win = {
          input = {
            keys.__raw = ''
              {
                ["<c-t>"] = {
                  "trouble_open",
                  mode = { "n", "i" },
                },
              }
            '';
          };
        };
        layouts = {
          # Big terminal window
          default.__raw = ''
            {
              reverse = true,
              layout = {
                box = "horizontal",
                backdrop = true,
                fullscreen = true,
                border = "none",
                {
                  box = "vertical",
                  {
                    win = "list",
                    title = " Results ",
                    title_pos = "center",
                    border = "rounded"
                  },
                  {
                    win = "input",
                    height = 1,
                    border = "rounded",
                    title = "{title} {live} {flags}",
                    title_pos = "center"
                  },
                },
                {
                  win = "preview",
                  title = "{preview:Preview}",
                  border = "rounded",
                  title_pos = "center",
                },
              },
            }
          '';
          # Small terminal window
          vertical.__raw = ''
            {
              layout = {
                backdrop = false,
                fullscreen = true,
                box = "vertical",
                border = "none",
                title = "{title} {live} {flags}",
                title_pos = "center",
                { win = "input", border = "top", height = 1 },
                { win = "list", border = "top" },
                { win = "preview", title = "{preview}", border = "top" },
              },
            }
          '';
        };
      };
    };
  };

  highlight =
    with colors;
    (lib.mkIf (config.plugins.snacks.enable && lib.hasAttr "picker" config.plugins.snacks.settings)) {
      SnacksPickerListBorder = {
        bg = base00;
        fg = base00;
      };
      SnacksPickerListTitle = {
        bg = base0D;
        fg = base01;
      };

      SnacksPickerPreview = {
        bg = base00;
      };
      SnacksPickerPreviewBorder = {
        bg = base00;
        fg = base00;
      };
      SnacksPickerPreviewTitle = {
        bg = base0E;
        fg = base00;
      };

      SnacksPickerInput = {
        bg = base00;
        fg = base05;
      };
      SnacksPickerSearch = {
        bg = base01;
        fg = base08;
      };
      SnacksPickerInputBorder = {
        bg = base00;
        fg = base01;
      };
      SnacksPickerInputTitle = {
        bg = base08;
        fg = base01;
      };

      # Window border.
      FloatBorder = {
        fg = base01;
        bg = base01;
      };

      # Active item.
      SnacksPickerListCursorLine = {
        bg = base01;
      };
    };

  keymaps =
    (lib.mkIf (config.plugins.snacks.enable && lib.hasAttr "picker" config.plugins.snacks.settings))
      (
        [
          {
            mode = "n";
            key = "<leader>fa";
            action = ''<cmd>lua Snacks.picker.autocmds()<cr>'';
            options = {
              desc = "Find autocmds";
            };
          }
          {
            mode = "n";
            key = "<leader>fd";
            action = ''<cmd>lua Snacks.picker.diagnostics_buffer()<cr>'';
            options = {
              desc = "Find buffer diagnostics";
            };
          }
          {
            mode = "n";
            key = "<leader>fD";
            action = ''<cmd>lua Snacks.picker.diagnostics()<cr>'';
            options = {
              desc = "Find workspace diagnostics";
            };
          }
          {
            mode = "n";
            key = "<leader>fh";
            action = ''<cmd>lua Snacks.picker.help()<cr>'';
            options = {
              desc = "Find help tags";
            };
          }
          # NOTE: prefer the UI but is lot slower
          {
            mode = "n";
            key = "<leader>fk";
            action = ''<cmd>lua Snacks.picker.keymaps()<cr>'';
            options = {
              desc = "Find keymaps";
            };
          }
          {
            mode = "n";
            key = "<leader>fp";
            action = ''<cmd>lua Snacks.picker.projects()<cr>'';
            options = {
              desc = "Find projects";
            };
          }
          # {
          #   mode = "n";
          #   key = "<leader>fr";
          #   action = ''<cmd>lua Snacks.picker.registers()<cr>'';
          #   options = {
          #     desc = "Find registers";
          #   };
          # }
          {
            mode = "n";
            key = "<leader>fs";
            action = ''<cmd>lua Snacks.picker.lsp_symbols()<cr>'';
            options = {
              desc = "Find lsp document symbols";
            };
          }
          {
            mode = "n";
            key = "<leader>fT";
            action = ''<cmd>lua Snacks.picker.colorschemes()<cr>'';
            options = {
              desc = "Find theme";
            };
          }
          {
            mode = "n";
            key = "<leader>fw";
            action = "<cmd>lua Snacks.picker.grep()<cr>";
            options = {
              desc = "Live grep";
            };
          }
          {
            mode = "n";
            key = "<leader>fO";
            action = ''<cmd>lua Snacks.picker.smart()<cr>'';
            options = {
              desc = "Find Smart (Frecency)";
            };
          }
          {
            mode = "n";
            key = "<leader>f?";
            action = ''<cmd>lua Snacks.picker.grep_buffers()<cr>'';
            options = {
              desc = "Fuzzy find in open buffers";
            };
          }
        ]
        ++ lib.optionals (!config.plugins.fzf-lua.enable) [
          {
            mode = "n";
            key = "<leader>f'";
            action = ''<cmd>lua Snacks.picker.marks()<cr>'';
            options = {
              desc = "Find marks";
            };
          }
          {
            mode = "n";
            key = "<leader>f/";
            action = ''<cmd>lua Snacks.picker.lines()<cr>'';
            options = {
              desc = "Fuzzy find in current buffer";
            };
          }
          {
            mode = "n";
            key = "<leader>fr";
            action = ''<cmd>lua Snacks.picker.resume()<cr>'';
            options = {
              desc = "Resume find";
            };
          }
          {
            mode = "n";
            key = "<leader>fb";
            action = ''<cmd>lua Snacks.picker.buffers()<cr>'';
            options = {
              desc = "Find buffers";
            };
          }
          {
            mode = "n";
            key = "<leader>ff";
            action = ''<cmd>lua Snacks.picker.files()<cr>'';
            options = {
              desc = "Find files";
            };
          }
          {
            mode = "n";
            key = "<leader><space>";
            action = ''<cmd>lua Snacks.picker.files()<cr>'';
            options = {
              desc = "Find files";
            };
          }
          {
            mode = "n";
            key = "<leader>fm";
            action = ''<cmd>lua Snacks.picker.man()<cr>'';
            options = {
              desc = "Find man pages";
            };
          }
          {
            mode = "n";
            key = "<leader>fo";
            action = ''<cmd>lua Snacks.picker.recent()<cr>'';
            options = {
              desc = "Find old files";
            };
          }
          {
            mode = "n";
            key = "<leader>fq";
            action = ''<cmd>lua Snacks.picker.qflist()<cr>'';
            options = {
              desc = "Find quickfix";
            };
          }
          {
            mode = "n";
            key = "<leader>ld";
            action = ''<cmd>lua Snacks.picker.lsp_definitions()<cr>'';
            options = {
              desc = "Goto Definition";
            };
          }
          {
            mode = "n";
            key = "<leader>li";
            action = ''<cmd>lua Snacks.picker.lsp_implementation()<cr>'';
            options = {
              desc = "Goto Implementation";
            };
          }
          {
            mode = "n";
            key = "<leader>lD";
            action = ''<cmd>lua Snacks.picker.lsp_references()<cr>'';
            options = {
              desc = "Find references";
            };
          }
          {
            mode = "n";
            key = "<leader>lt";
            action = ''<cmd>lua Snacks.picker.lsp_type_definitions()<cr>'';
            options = {
              desc = "Goto Type Definition";
            };
          }
          {
            mode = "n";
            key = "<leader>fS";
            action = ''<cmd>lua Snacks.picker.spell_suggest()<cr>'';
            options = {
              desc = "Find spelling suggestions";
            };
          }
          {
            mode = "n";
            key = "<leader>fH";
            action = ''<cmd>lua Snacks.picker.highlights()<cr>'';
            options = {
              desc = "Find highlights";
            };
          }
          {
            mode = "n";
            key = "<leader>gB";
            action = ''<cmd>lua Snacks.picker.git_branches()<cr>'';
            options = {
              desc = "Find git branches";
            };
          }
          {
            mode = "n";
            key = "<leader>gs";
            action = ''<cmd>lua Snacks.picker.git_status()<cr>'';
            options = {
              desc = "Find git status";
            };
          }
          {
            mode = "n";
            key = "<leader>gS";
            action = ''<cmd>lua Snacks.picker.git_stash()<cr>'';
            options = {
              desc = "Find git stashes";
            };
          }
        ]
      );
}
