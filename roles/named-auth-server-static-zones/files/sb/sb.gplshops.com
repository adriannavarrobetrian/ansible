$TTL 1800       ;
@               IN      SOA     ns1.sb.gplshops.com. domains.sb.gplshops.com. (
                        2016062900 ; serial
                        10800 ; refresh
                        3600 ; retry
                        1209600 ; expire
                        1800 ; minimum
                        )

                IN      NS      ns1.sb.gplshops.com.
                IN      NS      ns2.sb.gplshops.com.

                IN      MX      5       mail-1.venda-sbs.com.
                IN      MX      5       mail-2.venda-sbs.com.

ns1		IN	A	52.213.8.210
ns2		IN	A	52.50.239.250
