{
  pkgs,
  config,
  ...
}:
let
  pname = "venv-selector.nvim";
in
{
  config = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        inherit pname;
        version = "0.0.1";
        dependencies = with pkgs.vimPlugins; [
          plenary-nvim
        ];
        # https://nixos.org/manual/nixpkgs/unstable/#testing-neovim-plugins-neovim-require-check
        nvimSkipModule = [
          # 5108: Error executing lua ...nv-selector.nvim-0.0.1/lua/venv-selector/cached_venv.lua:0: attempt to index field 'cache' (a nil value)
          # stack traceback:
          # ...nv-selector.nvim-0.0.1/lua/venv-selector/cached_venv.lua: in function <...nv-selector.nvim-0.0.1/lua/venv-selector/cached_venv.lua:0>
          # [C]: in function 'require'
          # [string ":lua"]:1: in main chunk
          "venv-selector.cached_venv"
        ];
        # vim.ui.select support, switch repo back to `linux-cultist` when done and branch to `regexp`.
        # https://github.com/linux-cultist/venv-selector.nvim/pull/188
        src = pkgs.fetchFromGitHub {
          owner = "stefanboca";
          repo = pname;
          rev = "sb/push-rlpxsqmllxtz";
          hash = "sha256-bfuZVJ7NnveU+jFA+HAb/buAOmMAHNg5tKfYNtBAy6Q=";
        };
      })
    ];
    extraConfigLua = ''
      require("venv-selector").setup()
    '';
    keymaps = [
      {
        mode = "n";
        key = "<leader>v";
        action = "<cmd>VenvSelect<cr>";
      }
    ];
  };
}
