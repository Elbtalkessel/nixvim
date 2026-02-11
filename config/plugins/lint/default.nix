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
        lua = [ "luacheck" ];
        markdown = [ "markdownlint" ];
        nix = [
          "deadnix"
          "nix"
          # TODO(pipe): use https://github.com/molybdenumsoftware/statix for pipe support.
          #"statix"
        ];
        sh = [ "shellcheck" ];
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
        luacheck = {
          cmd = lib.getExe pkgs.luaPackages.luacheck;
        };
        markdownlint = {
          cmd = lib.getExe pkgs.markdownlint-cli;
          args = [
            "--disabel=MD013"
          ];
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
        # TODO(pipe): Use https://github.com/molybdenumsoftware/statix for pipe support.
        #statix = {
        #  cmd = lib.getExe pkgs.statix;
        #};
        yamllint = {
          cmd = lib.getExe pkgs.yamllint;
        };
      };
    };
  };
}
