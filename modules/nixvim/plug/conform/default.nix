{ pkgs, config, ... }:
let
  mkFmt =
    fmt: ftype:
    builtins.listToAttrs (
      map (t: {
        name = t;
        value = fmt;
      }) ftype
    );
in
{
  extraPackages = with pkgs; [ shfmt ];
  plugins.conform-nvim = {
    enable = true;

    lazyLoad.settings = {
      cmd = [
        "ConformInfo"
      ];
      event = [ "BufWrite" ];
    };

    settings = {
      format_on_save = {
        lspFallback = config.lspFmt;
        timeoutMs = 500;
      };
      notify_on_error = true;

      formatters_by_ft =
        {
          liquidsoap = [ "liquidsoap-prettier" ];
          python = [ "black" ];
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          yaml = [
            "yamllint"
            "yamlfmt"
          ];
        }
        // mkFmt [ "shfmt" ] [ "bash" "sh" ]
        //
          mkFmt
            {
              __unkeyed-1 = "prettierd";
              __unkeyed-2 = "prettier";
              stop_after_first = true;
            }
            [
              "html"
              "css"
              "javascript"
              "javascriptreact"
              "typescript"
              "typescriptreact"
              "markdown"
            ];
    };
  };
}
