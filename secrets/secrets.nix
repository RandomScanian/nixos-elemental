{config, ...}: {
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    #age.keyFile = ./secrets/gitcrypt/keys.txt;
  };
}