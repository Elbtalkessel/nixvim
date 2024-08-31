{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname = "grapple.nvim";
      version = "1.0";
      src = pkgs.fetchFromGitHub {
        owner = "cbochs";
        repo = "grapple.nvim";
        rev = "7aedc261b05a6c030397c4bc26416efbe746ebf1";
        hash = "sha256-apWKHEhXjFdS8xnSX0PoiOMzR+RVuYHFLV9sUl/HhTE=";
      };
    })
  ];

  extraConfigLua = ''
    require('grapple').setup({
      scope = "git_branch",
    })
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>j";
      action = "+j";
      options = {desc = "+jump";};
    }

    {
      mode = "n";
      key = "<leader>jt";
      action = "<CMD>Grapple toggle<CR>";
      options = {desc = "Tag a file";};
    }

    {
      mode = "n";
      key = "<leader>jm";
      action = "<CMD>Grapple toggle_tags<CR>";
      options = {desc = "Toggle tag menu";};
    }

    {
      mode = "n";
      key = "<leader>jl";
      action = "<CMD>Grapple cycle_tags next<CR>";
      options = {desc = "Go to next tag";};
    }

    {
      mode = "n";
      key = "<leader>jh";
      action = "<CMD>Grapple cycle_tags prev<CR>";
      options = {desc = "Go to previous tag";};
    }

    {
      mode = "n";
      key = "<leader>j1";
      action = "<CMD>Grapple select index=1<CR>";
      options = {desc = "Go to tag 1";};
    }

    {
      mode = "n";
      key = "<leader>j2";
      action = "<CMD>Grapple select index=2<CR>";
      options = {desc = "Go to tag 2";};
    }

    {
      mode = "n";
      key = "<leader>j3";
      action = "<CMD>Grapple select index=3<CR>";
      options = {desc = "Go to tag 3";};
    }

    {
      mode = "n";
      key = "<leader>j4";
      action = "<CMD>Grapple select index=4<CR>";
      options = {desc = "Go to tag 4";};
    }
  ];
}
