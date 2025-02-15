{ config, lib, ... }:
{
  config.autoCmd =
    [
      # Vertically center document when entering insert mode
      {
        event = "InsertEnter";
        command = "norm zz";
      }

      # Open help in a vertical split
      {
        event = "FileType";
        pattern = "help";
        command = "wincmd L";
      }

      # TODO(cleanup): telescope
      # Close Telescope prompt in insert mode by clicking escape
      {
        event = [ "FileType" ];
        pattern = "TelescopePrompt";
        command = "inoremap <buffer><silent> <ESC> <ESC>:close!<CR>";
      }
      {
        event = [ "FileType" ];
        pattern = "snacks_picker_input";
        command = "inoremap <buffer><silent> <ESC> <ESC>:close!<CR>";
      }

      # Highlight yank text
      {
        event = "TextYankPost";
        pattern = "*";
        command = "lua vim.highlight.on_yank{timeout=500}";
      }
      # Enter git buffer in insert mode
      {
        event = "FileType";
        pattern = [
          "gitcommit"
          "gitrebase"
        ];
        command = "startinsert | 1";
      }
    ]
    ++ lib.optionals (config.spelllang != null) [
      # Enable spellcheck for some filetypes
      {
        event = "FileType";
        pattern = config.spellcheck;
        command = "setlocal spell spelllang=${config.spelllang}";
      }
    ];
}
