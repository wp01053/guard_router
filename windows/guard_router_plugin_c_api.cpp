#include "include/guard_router/guard_router_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "guard_router_plugin.h"

void GuardRouterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  guard_router::GuardRouterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
