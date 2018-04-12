$TTL 1800       ;
@               IN      SOA     ns1.test.gplshops.com. domains.test.gplshops.com. (
                        2016062900 ; serial
                        10800 ; refresh
                        3600 ; retry
                        1209600 ; expire
                        1800 ; minimum
                        )

                IN      NS      ns1.test.gplshops.com.
                IN      NS      ns2.test.gplshops.com.

                IN      MX      5       mail-1.venda-sbs.com.
                IN      MX      5       mail-2.venda-sbs.com.

ns1		IN	A	52.208.42.71
ns2		IN	A	52.19.57.131

api		IN	A	52.19.197.204

paytest		IN	A	52.208.201.229

www.paytest	IN	A	52.208.201.229
