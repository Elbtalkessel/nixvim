{ lib, config, ... }:
let
  enable = config.copilot && config.plugins.cmp.enable;
in
{
  plugins.copilot-cmp = lib.mkIf enable {
    enable = true;
  };

  plugins.copilot-lua = lib.mkIf enable {
    enable = true;
    settings = {
      suggestion = {
        enabled = false;
      };
      panel = {
        enabled = false;
      };
    };
  };

  extraConfigLua = lib.mkIf enable ''
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  '';
}
