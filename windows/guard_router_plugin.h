#ifndef FLUTTER_PLUGIN_GUARD_ROUTER_PLUGIN_H_
#define FLUTTER_PLUGIN_GUARD_ROUTER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace guard_router {

class GuardRouterPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  GuardRouterPlugin();

  virtual ~GuardRouterPlugin();

  // Disallow copy and assign.
  GuardRouterPlugin(const GuardRouterPlugin&) = delete;
  GuardRouterPlugin& operator=(const GuardRouterPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace guard_router

#endif  // FLUTTER_PLUGIN_GUARD_ROUTER_PLUGIN_H_
