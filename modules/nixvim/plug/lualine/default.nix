{ config, ... }:
let
  colors = import ../colorscheme/colors/${config.theme}.nix { };
in
{
  plugins.lualine = {
    enable = true;
    lazyLoad.settings.event = "BufEnter";
    settings = {
      options = {
        component_separators = "";
        section_separators = {
          left = "";
          right = "";
        };
        theme = {
          normal = {
            a = {
              bg = "#nil";
            };
            b = {
              bg = "nil";
            };
            c = {
              bg = "nil";
            };
            z = {
              bg = "nil";
            };
            y = {
              bg = "nil";
            };
          };
        };
        globalstatus = true;
        disabled_filetypes = {
          statusline = [
            "dashboard"
            "alpha"
            "starter"
            "snacks_dashboard"
          ];
        };
      };
      inactive_sections = {
        lualine_x = [
          "filename"
        ];
      };
      sections = {
        lualine_a = [
          {
            __unkeyed = "mode";
            fmt = "string.lower";
            color = {
              fg = colors.base04;
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
          {
            __unkeyed = "branch";
            icon.__unkeyed = "";
            color = {
              fg = colors.base04;
            };
            separator.left = "";
            separator.right = "";
          }
          {
            __unkeyed = {
              __raw = ''
                function()
                    local msg = ""
                    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then
                        return msg
                    end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end
              '';
            };
            icon.__unkeyed = "";
            color = {
              fg = colors.base0B;
            };
          }
        ];
        lualine_b = [
          {
            __unkeyed = "diff";
            separator.left = "";
            separator.right = "";
          }
        ];
        lualine_c = [
          {
            __unkeyed = "filename";
            # 0 = just filename, 1 = relative path, 2 = absolute path
            path = 1;
            # Displays file status (readonly, modified)
            file_status = true;
            # Shortens the path to leave 40 spaces for other components
            shorting_target = 40;
          }
        ];
        lualine_x = [ "" ];
        lualine_y = [ "" ];
        lualine_z = [
          {
            __unkeyed = "diagnostic";
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
              hint = "󰝶 ";
            };
            color = {
              fg = colors.base08;
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
          {
            __unkeyed = "location";
            color = {
              fg = colors.base0D;
            };
            separator.left = "";
            separator.right = "";
          }
          {
            __unkeyed = {
              __raw = ''
                function()
                  local chars = setmetatable({
                    " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ",
                    " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ",
                  }, { __index = function() return " " end })
                  local line_ratio = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
                  local position = math.floor(line_ratio * 100)

                  local icon = chars[math.floor(line_ratio * #chars)] .. position
                  if position <= 5 then
                    icon = " TOP"
                  elseif position >= 95 then
                    icon = " BOT"
                  end
                  return icon
                end
              '';
            };
            color = {
              fg = colors.base0C;
            };
            padding = 0;
            separator.left = "";
            separator.right = "";
          }
        ];
      };
    };
  };
}
