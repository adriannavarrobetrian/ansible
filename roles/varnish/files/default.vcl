vcl 4.0;

import directors;
import std;

backend web01 {
    .host = "search.powa.locayta.com";
    .port = "80";
}

sub vcl_init {
    new bar = directors.round_robin();
    bar.add_backend(web01);
}

acl purge {
    "localhost";
    "127.0.0.1";
    "::1";
}

sub vcl_recv {
 
    # Allow purging
    if (req.method == "PURGE") {
       if (!client.ip ~ purge) { # purge is the ACL defined at the begining
       # Not from an allowed IP? Then die with an error.
       return (synth(405, "This IP is not allowed to send PURGE requests."));
    }
    # If you got this stage (and didn't error out above), purge the cached result
       return (purge);
    }

    # Only deal with "normal" types

    if (req.method != "GET" &&
        req.method != "HEAD" &&
        req.method != "PUT" &&
        req.method != "POST" &&
        req.method != "TRACE" &&
        req.method != "OPTIONS" &&
        req.method != "PATCH" &&
        req.method != "DELETE") {
        return (pipe);
    }

    # Bypass for all requests that are not GET or HEAD

    if (req.method != "GET" && req.method != "HEAD") {
        return (pipe);
    }

    # Don't cache the fake product used during publishing - GP-1607

    if (req.url ~ "(.*)/records\?filter=id%3Aqawsedrftg$"){
        set req.http.host = "search.powa.locayta.com";
        return (pass);
    }

    # Remove items and hosts we don't want to cache

    if (req.url !~ "(.+)_1615_(.*)"  && # ELX UK
        req.url !~ "(.+)_1673_(.*)"  && # AEG DE
        req.url !~ "(.+)_1689_(.*)"  && # ELX SE
        req.url !~ "(.+)_1665_(.*)"  && # ELX FR
        req.url !~ "(.+)_1684_(.*)"  && # ELX IT
        req.url !~ "(.+)_1616_(.*)"  && # AEG UK
        req.url !~ "(.+)_1676_(.*)"  && # ELX DE
        req.url !~ "(.+)_1983_(.*)"  && # ELX PL
        req.url !~ "(.+)_1667_(.*)"  && # ELX CH FR
        req.url !~ "(.+)_2358_(.*)"  && # ELX SE - Elastic Search Site Copy
        req.url !~ "(.+)_1618_(.*)") {  # ZAN UK

          set req.http.host = "search.powa.locayta.com";
 	  return (pass);
    }

    set req.backend_hint = bar.backend();
    set req.http.host = "search.powa.locayta.com";
    return (hash);

}

sub vcl_backend_response {

    # Don't cache 500 or 404 responses
    if (beresp.status == 500 || beresp.status == 502 || beresp.status == 503 || beresp.status == 504 || beresp.status == 404) {
        return (abandon);
    }

    # Don't cache the fake product used during publishing - GP-1607

    if (bereq.url ~ "(.+)/records\?filter=id%3Aqawsedrftg$"){
          unset beresp.http.Cache-Control;
          return (deliver);
    }

    if (bereq.url !~ "(.+)_1615_(.*)"  && # ELX UK
        bereq.url !~ "(.+)_1673_(.*)"  && # AEG DE
        bereq.url !~ "(.+)_1689_(.*)"  && # ELX SE
        bereq.url !~ "(.+)_1665_(.*)"  && # ELX FR
        bereq.url !~ "(.+)_1684_(.*)"  && # ELX IT
        bereq.url !~ "(.+)_1616_(.*)"  && # AEG UK
        bereq.url !~ "(.+)_1676_(.*)"  && # ELX DE
        bereq.url !~ "(.+)_1983_(.*)"  && # ELX PL
        bereq.url !~ "(.+)_1667_(.*)"  && # ELX CH FR
        bereq.url !~ "(.+)_2358_(.*)"  && # ELX SE - Elastic Search Site Copy
	bereq.url !~ "(.+)_1618_(.*)") {  # ZAN UK

	  unset beresp.http.Cache-Control;
	  return (deliver);
    }

    set beresp.ttl = 43200s;
    set beresp.http.Cache-Control = "max-age=43200";

    return (deliver);
}

sub vcl_deliver {
    unset resp.http.Via; 
    unset resp.http.X-Varnish;   
}
