{ pkgs
, lib
, ...
}:
let
  repo = {
    owner = "linux-cultist";
    repo = "venv-selector.nvim";
    # regexp branch
    rev = "f202a8375919dd643d9d186fbc8dbe14dcb2e5a9";
    hash = "sha256-2+Xi7zUv2VcRjSs7lWvJP73nJ48vWBNw7KMIKpMMwcY=";
  };
in
{
  extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname = "venv-selector.nvim";
      version = "0.0.1";
      src = pkgs.fetchFromGitHub repo;
      meta = {
        description = "Automatically activate and switch between python venvs.";
        homepage = "https://github.com/linux-cultist/venv-selector.nvim";
        license = lib.licenses.mit;
      };
    })
  ];
  extraConfigLua = ''
    require("venv-selector").setup {
      settings = {
        options = {
          debug = true,
          notify_user_on_venv_activate = true,
          fd_binary_name = "find";
        },
        search = {
          code = {
            command = 'find ~/code -path "*venv/bin/python" -type l 2>/dev/null'
          },
        },
      },
    }
  '';
  keymaps = [
    {
      mode = "n";
      key = "<leader>v";
      action = "<cmd>VenvSelect<cr>";
    }
  ];
}
