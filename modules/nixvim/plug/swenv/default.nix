{
  pkgs,
  config,
  lib,
  ...
}:
let
  pname = "swenv.nvim";
in
{
  # TODO(python-venv)
  config.extraPlugins = lib.mkIf (builtins.elem "python-venv" config.experemental) [
    (pkgs.vimUtils.buildVimPlugin {
      inherit pname;
      version = "0.0.1";
      dependencies = with pkgs.vimPlugins; [
        plenary-nvim
        # For vim.ui.select implementation.
        snacks-nvim
      ];
      src = pkgs.fetchFromGitHub {
        owner = "AckslD";
        repo = pname;
        rev = "main";
        hash = "sha256-XFsF2b6e+jNz5IDChuS5ZhDNpoU7jyVczihgBGq8ZXU=";
      };
    })
  ];
}
