#╭─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
#│                                                 comes from  khaneliman                                                  │
#│ https://github.com/khaneliman/khanelivim/blob/374d4f1cebaa448b52c0b45f3f825da2e71b2bf3/packages/avante-nvim/package.nix │
#╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
{
  inputs,
  lib,
  nix-update-script,
  openssl,
  pkg-config,
  rustPlatform,
  stdenv,
  vimPlugins,
  vimUtils,
}:
let
  version = inputs.avante-nvim.shortRev;
  src = inputs.avante-nvim;

  avante-nvim-lib = rustPlatform.buildRustPackage {
    pname = "avante-nvim-lib";
    inherit version src;

    cargoHash = "sha256-AorBHq/qATpixAa4mrVwg48wYRiaThJKUXqGhxjPTug=";

    nativeBuildInputs = [
      pkg-config
    ];

    buildInputs = [
      openssl
    ];

    buildFeatures = [ "luajit" ];

    checkFlags = [
      # Disabled because they access the network.
      "--skip=test_hf"
      "--skip=test_public_url"
      "--skip=test_roundtrip"
      "--skip=test_fetch_md"
    ];
  };
in
vimUtils.buildVimPlugin {
  pname = "avante.nvim";
  inherit version src;

  dependencies = with vimPlugins; [
    # TODO(cleanup): dressing. Can I replace it with snacks?
    dressing-nvim
    nui-nvim
    nvim-treesitter
    plenary-nvim
  ];

  postInstall =
    let
      ext = stdenv.hostPlatform.extensions.sharedLibrary;
    in
    ''
      mkdir -p $out/build
      ln -s ${avante-nvim-lib}/lib/libavante_repo_map${ext} $out/build/avante_repo_map${ext}
      ln -s ${avante-nvim-lib}/lib/libavante_templates${ext} $out/build/avante_templates${ext}
      ln -s ${avante-nvim-lib}/lib/libavante_tokenizers${ext} $out/build/avante_tokenizers${ext}
    '';

  passthru = {
    updateScript = nix-update-script {
      attrPath = "vimPlugins.avante-nvim.avante-nvim-lib";
    };

    # needed for the update script
    inherit avante-nvim-lib;
  };

  nvimSkipModule = [
    # Requires setup with corresponding provider
    "avante.providers.azure"
    "avante.providers.copilot"
  ];

  meta = {
    description = "Neovim plugin designed to emulate the behaviour of the Cursor AI IDE";
    homepage = "https://github.com/yetone/avante.nvim";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [
      ttrei
      aarnphm
    ];
  };
}
