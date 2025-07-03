INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:applications_view', 'Application View Feature', NULL, 'Manage views of applications from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:applications' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:applications_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:applications_edit', 'Application Edit Feature', NULL, 'Manage edits of applications from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:applications' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:applications_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:applications_view', 'Application View Feature', NULL, 'Manage views of applications in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:applications' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:applications_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:applications_edit', 'Application Edit Feature', NULL, 'Manage edits of applications in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:applications' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:applications_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:branding_view', 'Branding View Feature', NULL, 'Manage views of branding from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:branding' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:branding_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:branding_edit', 'Branding Edit Feature', NULL, 'Manage edits of branding from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:branding' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:branding_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:branding_view', 'Branding View Feature', NULL, 'Manage views of branding in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:branding' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:branding_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:branding_edit', 'Branding Edit Feature', NULL, 'Manage edits of branding in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:branding' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:branding_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:attributes_view', 'Attribute View Feature', NULL, 'Manage views of user attributes from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:attributes' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:attributes_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:attributes_edit', 'Attribute Edit Feature', NULL, 'Manage edits of user attributes from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:attributes' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:attributes_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:userstores_view', 'User views of Store View Feature', NULL, 'Manage user stores from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:userstores' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:userstores_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:userstores_edit', 'User Store Edit Feature', NULL, 'Manage edits of user stores from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:userstores' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:userstores_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:groups_view', 'Group View Feature', NULL, 'Manage views of groups from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:groups' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:groups_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:groups_edit', 'Group Edit Feature', NULL, 'Manage edits of groups from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:groups' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:groups_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:groups_view', 'Group View Feature', NULL, 'Manage views of groups in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:groups' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:groups_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:groups_edit', 'Group Edit Feature', NULL, 'Manage edits of groups in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:groups' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:groups_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:idps_view', 'Identity Provider View Feature', NULL, 'Manage views of identity providers from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:idps' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:idps_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:idps_edit', 'Identity Provider Edit Feature', NULL, 'Manage edits of identity providers from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:idps' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:idps_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:idps_view', 'Identity Provider View Feature', NULL, 'Manage views of identity providers in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:idps' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:idps_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:idps_edit', 'Identity Provider Edit Feature', NULL, 'Manage edits of identity providers in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:idps' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:idps_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:apiResources_view', 'API Resource View Feature', NULL, 'Manage views of api resources from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:apiResources' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:apiResources_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:apiResources_edit', 'API Resource Edit Feature', NULL, 'Manage edits of api resources from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:apiResources' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:apiResources_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:scopes:oidc_view', 'OIDC Scope View Feature', NULL, 'Manage views of OIDC scopes from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:scopes:oidc' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:scopes:oidc_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:scopes:oidc_edit', 'OIDC Scope Edit Feature', NULL, 'Manage edits of OIDC scopes from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:scopes:oidc' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:scopes:oidc_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:loginAndRegistration_view', 'Login And Registration View Feature', NULL, 'Manage views of login and regisgtration from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:loginAndRegistration' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:loginAndRegistration_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:loginAndRegistration_edit', 'Login And Registration Edit Feature', NULL, 'Manage edits of login and regisgtration from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:loginAndRegistration' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:loginAndRegistration_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:organizations_view', 'Organization View Feature', NULL, 'Manage views of organizations from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:organizations' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:organizations_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:organizations_edit', 'Organization Edit Feature', NULL, 'Manage edits of organizations from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:organizations' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:organizations_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:organizations_view', 'Organization View Feature', NULL, 'Manage views of organizations in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:organizations' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:organizations_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:organizations_edit', 'Organization Edit Feature', NULL, 'Manage edits of organizations in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:organizations' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:organizations_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:organizationDiscovery_view', 'Organization Discovery View Feature', NULL, 'Manage views of organization discovery from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:organizationDiscovery' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:organizationDiscovery_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:organizationDiscovery_edit', 'Organization Discovery Edit Feature', NULL, 'Manage edits of organization discovery from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:organizationDiscovery' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:organizationDiscovery_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:residentOutboundProvisioning_view', 'Resident Application Outbound Provisioning View Feature', NULL, 'Manage views of resident application outbound provisioning configuration from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:residentOutboundProvisioning' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:residentOutboundProvisioning_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:residentOutboundProvisioning_edit', 'Resident Application Outbound Provisioning Edit Feature', NULL, 'Manage edits of resident application outbound provisioning configuration from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:residentOutboundProvisioning' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:residentOutboundProvisioning_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:roles_view', 'Role View Feature', NULL, 'Manage views of roles from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:roles' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:roles_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:roles_edit', 'Role Edit Feature', NULL, 'Manage edits of roles from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:roles' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:roles_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:roles_view', 'Role View Feature', NULL, 'Manage views of roles in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:roles' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:roles_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:roles_edit', 'Role Edit Feature', NULL, 'Manage edits of roles in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:roles' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:roles_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:users_view', 'User View Feature', NULL, 'Manage views of users from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:users' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:users_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:users_edit', 'User Edit Feature', NULL, 'Manage edits of users from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:users' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:users_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:users_view', 'User View Feature', NULL, 'Manage views of users in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:users' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:users_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:users_edit', 'User Edit Feature', NULL, 'Manage edits of users in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:users' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:users_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:workflowApprovals_view', 'Workflow Approval View Feature', NULL, 'Manage views of workflow approvals from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:workflowApprovals' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:workflowApprovals_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:workflowApprovals_edit', 'Workflow Approval Edit Feature', NULL, 'Manage edits of workflow approvals from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:workflowApprovals' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:workflowApprovals_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:notificationChannels_view', 'Notification Channel View Feature', NULL, 'Manage views of notification channels from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:notificationChannels' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:notificationChannels_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:notificationChannels_edit', 'Notification Channel Edit Feature', NULL, 'Manage edits of notification channels from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:notificationChannels' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:notificationChannels_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:idvps_view', 'Identity Verification Provider View Feature', NULL, 'Manage views of identity verfication providers from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:idvps' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:idvps_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:idvps_edit', 'Identity Verification Provider Edit Feature', NULL, 'Manage edits of identity verfication providers from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:idvps' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:idvps_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:emailTemplates_view', 'Email Template View Feature', NULL, 'Manage views of email templates from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:emailTemplates' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:emailTemplates_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:emailTemplates_edit', 'Email Template Edit Feature', NULL, 'Manage edits of email templates from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:emailTemplates' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:emailTemplates_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:emailTemplates_view', 'Email Template View Feature', NULL, 'Manage views of email templates in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:emailTemplates' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:emailTemplates_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:emailTemplates_edit', 'Email Template Edit Feature', NULL, 'Manage edits of email templates in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:emailTemplates' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:emailTemplates_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:settings_view', 'Console Setting View Feature', NULL, 'Manage views of console setting from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:settings' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:settings_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:settings_edit', 'Console Setting Edit Feature', NULL, 'Manage edits of console setting from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:settings' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:settings_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:settings_view', 'Console Setting View Feature', NULL, 'Manage views of console setting in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:settings' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:settings_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:settings_edit', 'Console Setting Edit Feature', NULL, 'Manage edits of console setting in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:settings' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:settings_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:home_view', 'Getting Started View Feature', NULL, 'Manage views of home settings from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:home' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:home_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:home_edit', 'Getting Started Edit Feature', NULL, 'Manage edits of home settings from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:home' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:home_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:home_view', 'Getting Started View Feature', NULL, 'Manage views of home settings in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:home' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:home_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:org:home_edit', 'Getting Started Edit Feature', NULL, 'Manage edits of home settings in the organization from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:org:home' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:org:home_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:certificates_view', 'Certificate View Feature', NULL, 'Manage views of certificates from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:certificates' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:certificates_view');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'console:certificates_edit', 'Certificate Edit Feature', NULL, 'Manage edits of certificates from the Console'
FROM API_RESOURCE WHERE IDENTIFIER = 'console:certificates' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'console:certificates_edit');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'internal_user_association_create', 'Create User Associations', NULL, 'Create the associated local/federated accounts of a user in the organization (root)'
FROM API_RESOURCE
WHERE IDENTIFIER = '/api/users/v1/(.*)/(.*)associations' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'internal_user_association_create');

UPDATE API_RESOURCE SET TYPE = 'ORGANIZATION' WHERE IDENTIFIER = '/o/api/server/v(.*)/email/template-types';

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'internal_org_email_mgt_create', 'Create Email Template', NULL, 'Create new email template and types in the organization'
FROM API_RESOURCE WHERE IDENTIFIER = '/o/api/server/v(.*)/email/template-types' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'internal_org_email_mgt_create');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'internal_org_email_mgt_delete', 'Delete Email Template', NULL, 'Delete email templates and types in the organization'
FROM API_RESOURCE WHERE IDENTIFIER = '/o/api/server/v(.*)/email/template-types' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'internal_org_email_mgt_delete');

-- Organization application management related scope creation
INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'internal_org_application_mgt_create', 'Create Application', NULL, 'Create applications in the organization'
FROM API_RESOURCE
WHERE IDENTIFIER = '/o/api/server/v1/applications' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'internal_org_application_mgt_create');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'internal_org_application_mgt_delete', 'Delete Application', NULL, 'Delete applications in the organization'
FROM API_RESOURCE
WHERE IDENTIFIER = '/o/api/server/v1/applications' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'internal_org_application_mgt_delete');

-- Organization role management related scope creation
INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'internal_org_role_mgt_create', 'Create Role', NULL, 'Create new roles in the organization'
FROM API_RESOURCE
WHERE IDENTIFIER = '/o/scim2/Roles' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'internal_org_role_mgt_create');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'internal_org_role_mgt_delete', 'Delete Role', NULL, 'Delete roles in the organization'
FROM API_RESOURCE
WHERE IDENTIFIER = '/o/scim2/Roles' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'internal_org_role_mgt_delete');

-- Organization user store management related scope creation
INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'internal_org_userstore_create', 'Create Userstore', NULL, 'Add new secondary userstores to the organization'
FROM API_RESOURCE
WHERE IDENTIFIER = '/o/api/server/v1/userstore' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'internal_org_userstore_create');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'internal_org_userstore_delete', 'Delete Userstore', NULL, 'Delete secondary userstores in the organization'
FROM API_RESOURCE
WHERE IDENTIFIER = '/o/api/server/v1/userstore' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'internal_org_userstore_delete');

INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'internal_org_userstore_update', 'Update Userstore', NULL, 'Update the configurations of secondary userstores in the organization'
FROM API_RESOURCE
WHERE IDENTIFIER = '/o/api/server/v1/userstore' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'internal_org_userstore_update');

-- Organization claim management related scope creation
INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'internal_org_claim_meta_update', 'Update Claim', NULL, 'Update claims in the organization'
FROM API_RESOURCE
WHERE IDENTIFIER = '/o/api/server/v1/claim-dialects' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'internal_org_claim_meta_update');

-- Organization discovery configuration management related scope creation
INSERT INTO SCOPE (ID, API_ID, NAME, DISPLAY_NAME, TENANT_ID, DESCRIPTION)
SELECT LOWER(NEWID()), ID, 'internal_organization_config_update', 'Update Organization Configs', NULL, 'Update discovery configurations of the organization (root)'
FROM API_RESOURCE
WHERE IDENTIFIER = '/api/server/v1/organization-configs/discovery' AND NOT EXISTS (SELECT 1 FROM SCOPE WHERE NAME = 'internal_organization_config_update');
