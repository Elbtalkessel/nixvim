{ pkgs, lib, ... }:
{
  plugins = {
    lsp-format = {
      enable = true;
    };
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        html = {
          enable = true;
        };
        lua_ls = {
          enable = true;
        };
        nixd = {
          enable = true;
        };
        markdown_oxide = {
          enable = true;
        };
        yamlls = {
          enable = true;
        };
        pyright = {
          enable = true;
        };
        ts_ls = {
          enable = true;
        };
        volar = {
          enable = true;
        };
        gopls = {
          enable = true;
        };
        crystalline = {
          enable = true;
        };
        sqls = {
          enable = true;
          filetypes = [ "sql" ];
          rootMarkers = [ ".sqlsrc.yaml" ];
          # SQLS formatter removes all whitespaces.
          # https://github.com/sqls-server/sqls/issues/149
          # https://github.com/sqls-server/sqls/issues/153
          onAttach.function = ''
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          '';
          cmd = [
            (builtins.toString (
              pkgs.writeShellScript "sqls-wrapper.bash" ''
                #!${lib.getExe pkgs.bash}

                # sqls.nvim does not support per project configuration
                # (or I'm unaware of such).
                # This script searches for a nearest configuration starting
                # from a directory where lsp was attached.

                conf=".sqlsrc.yaml"
                dir="''$(pwd)"
                path=""

                while [[ "''$dir" != "/" ]]; do
                  path_="''$dir/''$conf"
                  if [[ -e "''$path_" ]]; then
                    path="''$path_"
                    break
                  fi
                  dir="''$(dirname "''$dir")"
                done

                ${lib.getExe pkgs.sqls} -config "''$path" "''$@"
              ''
            ))
          ];
          package = pkgs.sqls;
        };
      };
      keymaps = {
        silent = true;
        lspBuf = {
          gd = {
            action = "definition";
            desc = "Goto Definition";
          };
          gr = {
            action = "references";
            desc = "Goto References";
          };
          gD = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          gI = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          gT = {
            action = "type_definition";
            desc = "Type Definition";
          };
          "<leader>cr" = {
            action = "rename";
            desc = "Rename";
          };
        };
      };
    };
  };
}
