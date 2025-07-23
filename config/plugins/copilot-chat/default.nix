{ config, lib, ... }:
{
  plugins.copilot-chat = lib.mkIf config.plugins.blink-copilot.enable {
    enable = true;
  };
  plugins.render-markdown = lib.mkIf config.plugins.blink-copilot.enable {
    enable = true;
    lazyLoad.settings = {
      ft = [
        "copilot-chat"
      ];
    };
    settings = {
      file_types = [
        "copilot-chat"
      ];
    };
  };
}
