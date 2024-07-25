resource "azurerm_linux_web_app" "webapp_service" {
  depends_on          = [azurerm_resource_group.rg, azurerm_service_plan.app_service_plan, azurerm_storage_account.rooted_storage, azurerm_application_insights.app_insights]
  provider            = azurerm.src
  name                = var.name
  location            = var.location
  resource_group_name = var.resourcegroupname
  service_plan_id     = azurerm_service_plan.app_service_plan.id


  site_config {
    always_on  = true
    ftps_state = "Disabled"

    dynamic "ip_restriction" {
      for_each = toset(var.restricted_ip_address_or_range)
      content {
        ip_address = ip_restriction.key
      }
    }

    dynamic "ip_restriction" {
      for_each = toset(var.restricted_subnet_id)
      content {
        virtual_network_subnet_id = ip_restriction.key
      }
    }

    ip_restriction_default_action = var.restricted_default_action

    dynamic "scm_ip_restriction" {
      for_each = toset(var.restricted_scm_ip_address_or_range)
      content {
        ip_address = scm_ip_restriction.key
      }
    }

    dynamic "scm_ip_restriction" {
      for_each = toset(var.restricted_scm_subnet_id)
      content {
        virtual_network_subnet_id = scm_ip_restriction.key
      }
    }

    scm_ip_restriction_default_action = var.restricted_scm_default_action

    application_stack {
      java_server         = "TOMCAT"
      java_server_version = "9.0"
      java_version        = "17"

    }
  }

  storage_account {
    name         = "rooted"
    account_name = azurerm_storage_account.rooted_storage.name
    access_key   = azurerm_storage_account.rooted_storage.primary_access_key
    share_name   = azurerm_storage_share.rooted_storage_fileshare.name
    type         = "AzureFiles"
    mount_path   = "/ROOT"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"                  = azurerm_application_insights.app_insights.instrumentation_key
    "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "1.0.0"
    "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT"       = ""
    "APPLICATIONINSIGHTS_CONNECTION_STRING"           = azurerm_application_insights.app_insights.connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~3"
    "DiagnosticServices_EXTENSION_VERSION"            = "~3"
    "InstrumentationEngine_EXTENSION_VERSION"         = "disabled"
    "SnapshotDebugger_EXTENSION_VERSION"              = "disabled"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode"           = "recommended"
    "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "disabled"
  }

  virtual_network_subnet_id = var.hosting_virtual_network_subnet_id

  sticky_settings {
    app_setting_names = [
      "APPINSIGHTS_INSTRUMENTATIONKEY",
      "APPLICATIONINSIGHTS_CONNECTION_STRING ",
      "APPINSIGHTS_PROFILERFEATURE_VERSION",
      "APPINSIGHTS_SNAPSHOTFEATURE_VERSION",
      "ApplicationInsightsAgent_EXTENSION_VERSION",
      "XDT_MicrosoftApplicationInsights_BaseExtensions",
      "DiagnosticServices_EXTENSION_VERSION",
      "InstrumentationEngine_EXTENSION_VERSION",
      "SnapshotDebugger_EXTENSION_VERSION",
      "XDT_MicrosoftApplicationInsights_Mode",
      "XDT_MicrosoftApplicationInsights_PreemptSdk",
      "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT",
      "XDT_MicrosoftApplicationInsightsJava",
      "XDT_MicrosoftApplicationInsights_NodeJS",
    ]
  }
  lifecycle {
    ignore_changes = [tags]
  }

}
