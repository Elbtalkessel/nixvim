{ lib, ... }:
{
  options = {
    copilot = lib.mkOption {
      default = { };
      type = lib.types.submodule {
        options = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable copilot and copilot chat plugins.";
          };
        };
      };
    };
  };

  config = {
    copilot.enable = false;
  };
}
