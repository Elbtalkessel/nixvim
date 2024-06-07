{
  plugins.gitlinker = {
    enable = true;
    callbacks = {
      "github.com" = "get_github_type_url";
      "gitea.42cc.co" = "get_github_type_url";
    };
  };
}
