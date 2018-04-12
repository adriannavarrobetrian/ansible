$TTL 1800       ;
@               IN      SOA     ns1.venda-sbs.com. domains.venda-sbs.com. (
                        2009012101 ; serial
                        10800 ; refresh
                        3600 ; retry
                        1209600 ; expire
                        1800 ; minimum
                        )

                IN      NS      ns3.venda-sbs.com.
                IN      NS      ns4.venda-sbs.com.

                IN      MX      5       mail-1.venda-sbs.com.
                IN      MX      5       mail-2.venda-sbs.com.

                IN      A       52.19.197.204
*               IN      A       52.19.197.204
