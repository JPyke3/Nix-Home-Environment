{inputs, ...}: let
  serverIP = "100.73.94.58";
in {
  virtualisation.oci-containers.containers.pihole = {
    image = "pihole/pihole:latest";
    ports = [
      "53:53/tcp"
      "53:53/udp"
      "3080:80"
      "30443:443"
    ];
    volumes = [
      "/home/jacobpyke/pihole-config/pihole:/etc/pihole/"
      "/home/jacobpyke/pihole-config/dnsmasq.d:/etc/dnsmasq.d/"
    ];
    environment = {
      ServerIP = serverIP;
      INTERFACE = "tailscale0";
    };
    extraOptions = [
      "--cap-add=NET_ADMIN"
      "--dns=127.0.0.1"
      "--dns=1.1.1.1"
    ];
  };

  # Configure the host to use Pi-hole as its DNS server
  networking.nameservers = ["127.0.0.1"];
  networking.dhcpcd.extraConfig = "nohook resolv.conf";
}
