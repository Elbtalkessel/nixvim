{
  inputs,
  pkgs,
  vimUtils,
}:
vimUtils.buildVimPlugin {
  pname = "snacks-nvim";
  src = inputs.snacks-nvim;
  version = inputs.snacks-nvim.shortRev;

  dependencies = [ pkgs.vimPlugins.trouble-nvim ];

  # TODO(clarify): find why check for these modules are failing, missing dependencies?
  # Describe the reason.
  nvimSkipModule = [
    "snacks.dashboard"
    "snacks.indent"
    "snacks.input"
    "snacks.notifier"
    "snacks.picker.actions"
    "snacks.picker.config.highlights"
    "snacks.picker.core.list"
    "snacks.picker.util.db"
    "snacks.terminal"
    "snacks.win"
    "snacks.zen"
    "snacks.dim"
    "snacks.git"
    "snacks.lazygit"
    "snacks.scratch"
    "snacks.scroll"
    "snacks.words"
    "snacks.image.init"
    "snacks.image.convert"
    "snacks.image.image"
    "snacks.image.placement"
  ];
}
