{
  lib,
  pkgs,
  ...
}:
{
  plugins = {
    lint = {
      enable = true;

      lazyLoad.settings.event = "DeferredUIEnter";

      lintersByFt = {
        bash = [ "shellcheck" ];
        fish = [ "fish" ];
        go = [ "golangcilint" ];
        json = [ "jsonlint" ];
        lua = [ "luacheck" ];
        markdown = [ "markdownlint" ];
        nix = [
          "deadnix"
          "nix"
          "statix"
        ];
        sh = [ "shellcheck" ];
        terraform = [ "tflint" ];
        yaml = [ "yamllint" ];
      };

      linters = {
        checkmake = {
          cmd = lib.getExe pkgs.checkmake;
        };
        deadnix = {
          cmd = lib.getExe pkgs.deadnix;
        };
        fish = {
          cmd = lib.getExe pkgs.fish;
        };
        golangcilint = {
          cmd = lib.getExe pkgs.golangci-lint;
          # Took from https://github.com/mfussenegger/nvim-lint/blob/master/lua/lint/linters/golangcilint.lua
          # Without it golangci-lint is called without arguments.
          args = [
            "run"
            "--output.json.path=stdout"
            # Overwrite values possibly set in .golangci.yml
            "--output.text.path="
            "--output.tab.path="
            "--output.html.path="
            "--output.checkstyle.path="
            "--output.code-climate.path="
            "--output.junit-xml.path="
            "--output.teamcity.path="
            "--output.sarif.path="
            "--issues-exit-code=0"
            "--show-stats=false"
            # Get absolute path of the linted file
            "--path-mode=abs"
          ];
        };
        jsonlint = {
          cmd = lib.getExe pkgs.nodePackages.jsonlint;
        };
        luacheck = {
          cmd = lib.getExe pkgs.luaPackages.luacheck;
        };
        markdownlint = {
          cmd = lib.getExe pkgs.markdownlint-cli;
        };
        pylint = {
          cmd = lib.getExe pkgs.pylint;
        };
        shellcheck = {
          cmd = lib.getExe pkgs.shellcheck;
        };
        sqlfluff = {
          cmd = lib.getExe pkgs.sqlfluff;
        };
        statix = {
          cmd = lib.getExe pkgs.statix;
        };
        terraform = {
          cmd = lib.getExe pkgs.tflint;
        };
        yamllint = {
          cmd = lib.getExe pkgs.yamllint;
        };
      };
    };
  };
}
