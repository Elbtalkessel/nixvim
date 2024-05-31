{pkgs, ...}: {
  extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname = "plenary.nvim";
      version = "0.1.4";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-lua";
        repo = "plenary.nvim";
        rev = "50012918b2fc8357b87cff2a7f7f0446e47da174";
        hash = "sha256-zR44d9MowLG1lIbvrRaFTpO/HXKKrO6lbtZfvvTdx+o=";
      };
    })
    (buildVimPlugin {
      pname = "cmp_ai";
      version = "0.0.1";
      src = pkgs.fetchFromGitHub {
        owner = "tzachar";
        repo = "cmp-ai";
        rev = "b6c3fb81910fd0cef539c90db626f84581c06d26";
        hash = "sha256-1IGqxVOneRt20SiXOYu4aErg1UxjMaH1NTuuTyuGXLQ=";
      };
    })
  ];
  extraConfigLua = ''
    local cmp_ai = require('cmp_ai.config')
    cmp_ai:setup({
      max_lines = 100,
      provider = 'Ollama',
      provider_options = {
        model = 'codestral',
      },
      notify = true,
      notify_callback = function(msg)
        vim.notify(msg)
      end,
      run_on_every_keystroke = true,
    })
  '';
}
