{
  sops,
  config,
  ...
}: {
  sops.secrets."programs/nextcloud/adminpass" = {
    owner = "nextcloud";
  };

  services.nextcloud = {
    settings = let
      prot = "https"; # or https
      host = "127.0.0.1";
      dir = "/nextcloud";
    in {
      overwriteprotocol = prot;
      overwritehost = host;
      overwritewebroot = dir;
      overwrite.cli.url = "${prot}://${host}${dir}/";
      htaccess.RewriteBase = dir;
    };
    enable = true;
    hostName = "localhost";
    settings.trusted_domains = [
      "jacob-china.tail264a8.ts.net"
    ];
    config.adminpassFile = config.sops.secrets."programs/nextcloud/adminpass".path;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "nextcloud-27.1.11"
  ];

  services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
    forceSSL = true;
    sslCertificate = /mypool/documents/Tailscale-Certs/jacob-china.tail264a8.ts.net.crt;
    sslCertificateKey = /mypool/documents/Tailscale-Certs/jacob-china.tail264a8.ts.net.key;
  };
}
