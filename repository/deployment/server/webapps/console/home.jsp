<!--
~    Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
~
~    This software is the property of WSO2 Inc. and its suppliers, if any.
~    Dissemination of any information or reproduction of any material contained
~    herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
~    You may not alter or remove any copyright or other notice from copies of this content."
-->

<%@ page import="org.wso2.carbon.base.ServerConfiguration" %>
<%@ page import="static org.wso2.carbon.identity.core.util.IdentityCoreConstants.PROXY_CONTEXT_PATH" %>
<%@ page import="static org.wso2.carbon.identity.core.util.IdentityUtil.getServerURL" %>
<%@ page import="static org.wso2.carbon.utils.multitenancy.MultitenantConstants.TENANT_AWARE_URL_PREFIX"%>
<%@ page import="static org.wso2.carbon.utils.multitenancy.MultitenantConstants.SUPER_TENANT_DOMAIN_NAME"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="static org.wso2.carbon.identity.application.authentication.framework.util.FrameworkUtils.isOrganizationManagementEnabled"%>
<%@ page import="static org.wso2.carbon.identity.application.authentication.framework.util.FrameworkUtils.isAdaptiveAuthenticationAvailable"%>

<% String is_cookiepro_enabled = System.getenv("is_cookiepro_enabled"); %>
<% String initialScriptType = (Boolean.TRUE.toString()).equals(is_cookiepro_enabled) ? "text/plain" : "text/javascript"; %>
<% String cookiepro_domain_script_id = System.getenv("cookiepro_domain_script_id"); %>

<jsp:scriptlet>
    session.setAttribute("authCode",request.getParameter("code"));
    session.setAttribute("sessionState", request.getParameter("session_state"));
    if(request.getParameter("state") != null) {session.setAttribute("state", request.getParameter("state"));}
</jsp:scriptlet>

<!DOCTYPE HTML>
<html>
    <head>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
        <meta name="referrer" content="no-referrer" />

        <link href="/console/libs/themes/wso2is/theme.b2b7735a.min.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="/console/libs/themes/wso2is/assets/images/branding/favicon.ico" />

        <% if ((Boolean.TRUE.toString()).equals(is_cookiepro_enabled)) { %>
             <!-- CookiePro Cookies Consent Notice start for asgardeo.io -->
            <script src="https://cookie-cdn.cookiepro.com/scripttemplates/otSDKStub.js"  type="text/javascript" charset="UTF-8" data-domain-script="<%= cookiepro_domain_script_id %>" ></script>
            <script type="text/javascript">
                function OptanonWrapper() {
                    // Get initial OnetrustActiveGroups ids
                    if (typeof OptanonWrapperCount == "undefined") {
                        otGetInitialGroups();
                    }

                    // Delete cookies
                    otDeleteCookie(otInitialConsentedGroups);

                    // Assign OnetrustActiveGroups to custom variable
                    function otGetInitialGroups() {
                        OptanonWrapperCount = "";
                        otInitialConsentedGroups =  OnetrustActiveGroups;
                    }

                    function otDeleteCookie(iniOptGrpIdsListStr) {
                        try {
                            var otDomainGrps = JSON.parse(JSON.stringify(Optanon.GetDomainData().Groups));
                            // publish custom event to announce the cookie consent change
                            const cookiePrefChangeEvent = new CustomEvent("cookie-pref-change", { pref: OnetrustActiveGroups });
                            window.dispatchEvent(cookiePrefChangeEvent)
                            // return consent revoked group id list
                            var otRevokedGrpIds = otGetInactiveId(iniOptGrpIdsListStr, OnetrustActiveGroups);

                            if(otRevokedGrpIds.length != 0 && otDomainGrps.length != 0){
                                for(var i=0; i < otDomainGrps.length; i++){
                                    // Check if CustomGroupId matches
                                    if(otDomainGrps[i]["CustomGroupId"] != "" && otRevokedGrpIds.includes(otDomainGrps[i]["CustomGroupId"])){
                                        for(var j=0; j < otDomainGrps[i]['Cookies'].length; j++){
                                            console.info("Deleting cookie ",otDomainGrps[i]['Cookies'][j]['Name'])
                                            // Delete cookie
                                            eraseCookie(otDomainGrps[i]["Cookies"][j]["Name"]);
                                        }
                                    }

                                    // Check if Hostid matches
                                    if(otDomainGrps[i]["Hosts"].length != 0){
                                        for(var j = 0; j < otDomainGrps[i]["Hosts"].length; j++){
                                            // Check if HostId presents in the deleted list and cookie array is not blank
                                            if(otRevokedGrpIds.includes(otDomainGrps[i]["Hosts"][j]["HostId"]) && otDomainGrps[i]['Hosts'][j]['Cookies'].length !=0){
                                                for(var k=0; k < otDomainGrps[i]["Hosts"][j]["Cookies"].length; k++){
                                                    // Delete cookie
                                                    eraseCookie(otDomainGrps[i]["Hosts"][j]["Cookies"][k]["Name"]);
                                                }
                                            }
                                        }
                                    }

                                }
                            }
                            otGetInitialGroups(); //Reassign new group ids
                        } catch (err) {
                            console.error(err)
                        }
                    }

                    // Get inactive ids
                    function otGetInactiveId(prevGroupIdListStr, otActiveGrp) {
                        prevGroupIdList = prevGroupIdListStr.split(",");
                        prevGroupIdList = prevGroupIdList.filter(Boolean);

                        // After action OnetrustActiveGroups
                        otActiveGrp = otActiveGrp.split(",");
                        otActiveGrp = otActiveGrp.filter(Boolean);

                        var result = [];
                        for (var i = 0; i < prevGroupIdList.length; i++){
                            if (otActiveGrp.indexOf(prevGroupIdList[i]) <= -1){
                                result.push(prevGroupIdList[i]);
                            }
                        }
                        return result;
                    }

                    // Delete cookie
                    function eraseCookie(name) {
                        // Delete root path cookies
                        domainName = window.location.hostname;
                        document.cookie = name+"=; Max-Age=-99999999; Path=/;Domain="+ domainName;
                        document.cookie = name+"=; Max-Age=-99999999; Path=/;";

                        // Delete LSO incase LSO being used, cna be commented out.
                        localStorage.removeItem(name);

                        // Check for the current path of the page
                        pathArray = window.location.pathname.split('/');
                        // Loop through path hierarchy and delete potential cookies at each path.
                        for (var i = 0; i < pathArray.length; i++){
                            if (pathArray[i]){
                                // Build the path string from the Path Array e.g /site/login
                                var currentPath = pathArray.slice(0,i+1).join('/');
                                document.cookie = name+"=; Max-Age=-99999999; Path=' + currentPath + ';Domain="+ domainName;
                                document.cookie = name+"=; Max-Age=-99999999; Path=' + currentPath + ';";
                                // Maybe path has a trailing slash!
                                document.cookie = name+"=; Max-Age=-99999999; Path=' + currentPath + '/;Domain="+ domainName;
                                document.cookie = name+"=; Max-Age=-99999999; Path=' + currentPath + '/;";

                            }
                        }
                    }
                }
            </script>
        <% } %>
        <script>
            var contextPathGlobal = "/console/";
            var serverOriginGlobal = "<%=getServerURL("", true, true)%>";
            var proxyContextPathGlobal = "<%=ServerConfiguration.getInstance().getFirstProperty(PROXY_CONTEXT_PATH)%>";
            var superTenantGlobal = "<%=SUPER_TENANT_DOMAIN_NAME%>";
            var tenantPrefixGlobal = "<%=TENANT_AWARE_URL_PREFIX%>";
            var isAdaptiveAuthenticationAvailable = JSON.parse("<%= isAdaptiveAuthenticationAvailable() %>");
            var isOrganizationManagementEnabled = "<%= isOrganizationManagementEnabled() %>" === "true";
        </script>

        <script>
            var userAccessedPath = sessionStorage.getItem("userAccessedPath");
            var isSilentSignInDisabled = userAccessedPath.includes("disable_silent_sign_in") ||
                                            window.location.href.includes("disable_silent_sign_in");
            var isInviteUserFlow = userAccessedPath.includes("invite_user");
            var isApplicationsPath = userAccessedPath.includes("develop/applications") ||
                                        window.location.href.includes("develop/applications");

            if(isInviteUserFlow) {
                window.location = window.location.origin;
            }
        </script>

        <!-- Start of custom stylesheets -->
        <link rel="stylesheet" type="text/css" href="/console/extensions/stylesheet.css"/>
        <!-- End of custom stylesheets -->

        <!-- Start of custom scripts added to the head -->
        <script type="text/javascript" src="/console/extensions/head-script.js"></script>
        <!-- End of custom scripts added to the head -->
    <script defer src="/console/static/js/runtime.26b4eb09.js?99edb6eff05433c7"></script><script defer src="/console/static/js/vendor.691a15a3.js?99edb6eff05433c7"></script><script defer src="/console/static/js/0.6f1123ea.js?99edb6eff05433c7"></script><script defer src="/console/static/js/1.89bdb6de.js?99edb6eff05433c7"></script><script defer src="/console/static/js/certificate.2e0d06fe.js?99edb6eff05433c7"></script><script defer src="/console/static/js/codemirror.730fc89e.js?99edb6eff05433c7"></script><script defer src="/console/static/js/main.703cf559.js?99edb6eff05433c7"></script></head>
    <body>
        <noscript>
            You need to enable JavaScript to run this app.
        </noscript>
        <div id="root"></div>

        <!-- Start of custom scripts added to the body -->
        <script type="text/javascript" src="/console/extensions/body-script.js"></script>
        <!-- End of custom scripts added to the body -->
    </body>
</html>
