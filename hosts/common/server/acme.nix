{ config, ... }:
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "alex+letsencrypt@confusedserver.de";
    certs."mytbu.de" = {
      dnsProvider = "cloudflare";
      domain = "mytbu.de";
      extraDomainNames = [ "*.mytbu.de" ];
      dnsPropagationCheck = true;
      credentialFiles = {
        "CLOUDFLARE_DNS_API_TOKEN_FILE" = config.sops.secrets."cloudflare_dns_secret".path;
      };
    };
  };

  sops.secrets.cloudflare_dns_secret = { };

  environment.persistence."/persist".directories = [ "/var/lib/acme" ];
}
