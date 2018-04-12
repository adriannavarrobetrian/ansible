import com.ifountain.opsgenie.client.http.OpsGenieHttpClient
import com.ifountain.opsgenie.client.util.ClientConfiguration
import com.ifountain.opsgenie.client.util.JsonUtils
import org.apache.http.HttpHeaders
import org.apache.http.auth.UsernamePasswordCredentials
import org.apache.http.impl.auth.BasicScheme

LOG_PREFIX = "[${action}]:";
logger.warn("${LOG_PREFIX} Will execute action for alertId ${alert.alertId}");

CONF_PREFIX = "jira.";
HTTP_CLIENT = createHttpClient();

JIRA_ISSUE_KEY_PREFIX = 'jiraIssueKey:'
jiraIssuePath = "${_conf("basepath")}/issue"
try {
    if (action == "Create") {
        createJiraIssue()
    } else if (action == "AddNote") {
        addCommentToJiraIssue()
    } else if (action == "Acknowledge") {
        startJiraIssueProgress()
    } else if (action == "Close" || action == "Delete") {
        closeJiraIssue()
    }
}
finally {
    HTTP_CLIENT.close()
}

def postToJira(Map postParams, String path, int expectedCode){
    def url = "${_conf("protocol")}://${_conf("host")}:${_conf("port")}${path}"
    logger.debug("${LOG_PREFIX} Posting to Jira. Url ${url} params:${postParams}")

    def postMethod = ((OpsGenieHttpClient) HTTP_CLIENT).preparePostMethod(url,JsonUtils.toJson(postParams),[:],[:])
    postMethod.addHeader(HttpHeaders.CONTENT_TYPE,"application/json")
    def creds = new UsernamePasswordCredentials(_conf("username",true), _conf("password", true))
    postMethod.addHeader(BasicScheme.authenticate(creds,"US-ASCII",false))

    def response = ((OpsGenieHttpClient) HTTP_CLIENT).executeHttpMethod(postMethod)
    if(response.statusCode == expectedCode){
        logger.info("${LOG_PREFIX} Successfully executed at Jira.");
        if(response.getContent() != null){
            logger.debug("${LOG_PREFIX} Jira response: ${response.getContentAsString()}")
        }else{
            logger.debug("${LOG_PREFIX} No content found on Jira response.")
        }
    }else{
        if(response.getContent() != null) {
            logger.warn("${LOG_PREFIX} Could not execute at Jira. Response:${response.getContentAsString()}")
        }else{
            logger.warn("${LOG_PREFIX} Could not execute at Jira. No content found on response")
        }
    }
    return response
}

def createJiraIssue() {
    def jiraProjectKey = determineJiraProjectKey()
    logger.info("${LOG_PREFIX} creating issue to project: ${jiraProjectKey}")
    def reqParams = [
            fields: [
                    project: [key: jiraProjectKey],
                    summary: alert.message,
                    description: "OpsGenie Alert: " + alert.message + ". Reported by " + alert.source,
                    issuetype: [name: 'Bug'] // Make sure your JIRA project configuration(s) supports this Issue Type.
            ]
    ]
    def expectedCode = 201
    def response = postToJira(reqParams, "${jiraIssuePath}", 201)
    if (response.statusCode == expectedCode){
        logger.info("${LOG_PREFIX} adding issue key as tag to alert")
        def content = JsonUtils.parse(response.getContentAsString())
        def resp = opsgenie.addTags([id: alert.alertId, tags: ["${JIRA_ISSUE_KEY_PREFIX}${content.key}"]])
        if (resp.success) {
            logger.warn("Successfully added tags to alert");
        } else {
            logger.warn("Could not add tags to alert");
        }
    }
}

def determineJiraProjectKey(){
    List<String> tags = alert.tags
    def projectKeysFromConfig = determineAlertTagToProjectKeyMappings()
    def jiraProjectKey
    projectKeysFromConfig.each {
        if (tags.contains(it.key)){
            logger.debug("${LOG_PREFIX} determined jira project key from alert tags. Project Key: ${it.value}")
            jiraProjectKey = it.value
        }
    }

    if(jiraProjectKey == null){
        def defaultKey = _conf("default.project.key")
        logger.debug("${LOG_PREFIX} could not determine jira project key from alert tags, will use default key from configuration: ${defaultKey}")
        return defaultKey
    }

    return jiraProjectKey
}

def determineAlertTagToProjectKeyMappings(){
    def projectKeysMappingsFromConfig =  conf.findAll{ it.key.contains("${CONF_PREFIX}project")}
    def projectKeyMappingsWithoutPrefix = [:]
    projectKeysMappingsFromConfig.each {
        def matcher = it.key =~ "${CONF_PREFIX}project.(.+)"
        projectKeyMappingsWithoutPrefix[matcher[0][1]] = it.value
    }
    logger.debug("${LOG_PREFIX} alert tag to project key mappings: ${projectKeyMappingsWithoutPrefix}")
    return projectKeyMappingsWithoutPrefix
}


def addCommentToJiraIssue() {
    logger.info("${LOG_PREFIX} adding comment to issue")
    def params = [body: alert.note]
    postToJiraWithExistingIssue(params, "/comment", 201)
}

def startJiraIssueProgress() {
    transitionJiraIssue("61", "starting issue progress")
}

def closeJiraIssue() {
    transitionJiraIssue("111", "closing issue")
}

def transitionJiraIssue(String transIdStr, String logMessage){
    logger.info("${LOG_PREFIX} ${logMessage}")
    def params = [transition: [id: transIdStr]]
    postToJiraWithExistingIssue(params, "/transitions", 204)
}

def postToJiraWithExistingIssue(Map postParams,String reqPathSuffix, int expectedResponseCode){
    def jiraIssueKey = extractJiraIssueKeyFromAlertTag()
    if(jiraIssueKey == null){
        logger.warn("${LOG_PREFIX} Cannot determine associated JIRA issue. Alert data lacks JIRA issue key tag.")
    }else{
        def url = "${jiraIssuePath}/${jiraIssueKey}${reqPathSuffix}"
        postToJira(postParams, url, expectedResponseCode)
    }
}

def extractJiraIssueKeyFromAlertTag(){
    def tags = alert.tags
    for(String tag: tags){
        if(tag.startsWith(JIRA_ISSUE_KEY_PREFIX)){
            return tag.substring(JIRA_ISSUE_KEY_PREFIX.size())
        }
    }
    return null
}

def _conf(confKey, boolean isMandatory = true) {
    def confVal = conf[CONF_PREFIX + confKey]
    logger.debug("confVal ${CONF_PREFIX + confKey} from file is ${confVal}");
    if (isMandatory && confVal == null) {
        def errorMessage = "${LOG_PREFIX} Skipping action, Mandatory Conf item ${CONF_PREFIX + confKey} is missing. Check your marid conf file.";
        logger.warn(errorMessage);
        throw new Exception(errorMessage);
    }
    return confVal
}

def createHttpClient() {
    def timeout = _conf("request.timeout", false);
    if (timeout == null) {
        timeout = 30000;
    } else {
        timeout = timeout.toInteger();
    }
    ClientConfiguration clientConfiguration = new ClientConfiguration().setSocketTimeout(timeout)
    return new OpsGenieHttpClient(clientConfiguration)
}
