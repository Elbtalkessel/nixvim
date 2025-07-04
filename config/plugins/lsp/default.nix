_: {
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
        sqls = {
          enable = true;
          filetypes = [ "sql" ];
          rootMarkers = [ ".sqlsrc.yaml" ];
          cmd = [
            "sqls"
            "-config"
            "$DEVENV_ROOT/.sqlsrc.yaml"
          ];
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
