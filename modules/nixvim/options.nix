{ lib, ... }:
{
  options = {
    theme = lib.mkOption {
      default = lib.mkDefault "darkside";
      type = lib.types.enum [
        "aquarium"
        "decay"
        "edge-dark"
        "everblush"
        "everforest"
        "far"
        "gruvbox"
        "jellybeans"
        "material"
        "material-darker"
        "mountain"
        "ocean"
        "oxocarbon"
        "paradise"
        "radium"
        "test"
        "tokyonight"
        "yoru"
        "darkside"
      ];
    };
    bufferline-style = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "If enabled bufferline will use custom style, by default it tries to match current theme automatically.";
    };
    spelllang = lib.mkOption {
      default = null;
      type = lib.types.nullOr lib.types.str;
      description = "Disabled by default. To enable use valid attribute of nvim's spelllang, i.e. 'en,uk'.";
    };
    spellcheck = lib.mkOption {
      default = [ ];
      type = lib.type.listOf lib.types.str;
      description = "List of file patterns to enable spellcheck for. Without setting the `spellanag` option, this one does nothing.";
    };
    lspFmt = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Enables LSP formatting, prefer using conform plugin, as the LSP one doesn't honor local formatting preferences.";
    };
    thisisfine = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Enables this is fine dog on dashboard.";
    };
    copilot = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Enable copilot code completion.";
    };
  };
}
