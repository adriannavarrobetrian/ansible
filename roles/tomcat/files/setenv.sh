# Allow encoded path delimiters and backslashes in URLs
CATALINA_OPTS="-Dorg.apache.tomcat.util.buf.UDecoder.ALLOW_ENCODED_SLASH=true $CATALINA_OPTS"
CATALINA_OPTS="-Dorg.apache.catalina.connector.CoyoteAdapter.ALLOW_BACKSLASH=true $CATALINA_OPTS"
