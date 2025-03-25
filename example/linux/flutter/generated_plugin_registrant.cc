//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <guard_router/guard_router_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) guard_router_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "GuardRouterPlugin");
  guard_router_plugin_register_with_registrar(guard_router_registrar);
}
