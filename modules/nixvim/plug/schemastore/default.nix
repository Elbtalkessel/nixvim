{ config, ... }:
{
  plugins.schemastore = {
    inherit (config.plugins.lsp.servers.yamlls) enable;
    yaml.enable = config.plugins.lsp.servers.yamlls.enable;
    json.enable = false;
  };
}
