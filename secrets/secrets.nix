{config, ...}: {
  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    #age.keyFile = ./gitcrypt/keys.txt;
  };
}
