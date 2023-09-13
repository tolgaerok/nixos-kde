{ pkgs, ... }: {

  # Cryptographic library that implements the SSL and TLS protocols:

  environment = {
    systemPackages = with pkgs; [

      # SSL and TLS protocols    
      #openssl             # Version: 3.0.10: bin debug dev doc man out
      #openssl_1_1         # Version: 1.1.1v: bin debug dev doc man out

    ];
  };
}
