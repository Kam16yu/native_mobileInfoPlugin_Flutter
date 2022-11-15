package com.kam16yu.mobile_info

import android.os.Build
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** MobileInfoPlugin */
class MobileInfoPlugin : FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mobile_info")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {

    val specifications: MutableMap<String, String> = mutableMapOf()

    if (call.method == "getSpecifications") {
      // Get information about smartphone to map
      specifications["Platform"] = "Android ${Build.VERSION.RELEASE}"
      specifications["SDK"] = Build.VERSION.SDK_INT.toString()
      specifications["Device"] = Build.DEVICE
      specifications["Model"] = Build.MODEL
      specifications["Product"] = Build.PRODUCT
      specifications["CODENAME"] = Build.VERSION.CODENAME
      specifications["Security patch"] = Build.VERSION.SECURITY_PATCH
      specifications["Board"] = Build.BOARD
      specifications["BOOTLOADER"] = Build.BOOTLOADER
      specifications["DISPLAY"] = Build.DISPLAY
      specifications["FINGERPRINT"] = Build.FINGERPRINT
      specifications["HARDWARE"] = Build.HARDWARE
      specifications["HOST"] = Build.HOST
      specifications["ID"] = Build.ID
      specifications["MANUFACTURER"] = Build.MANUFACTURER
      specifications["USER"] = Build.USER
      specifications["RadioVersion"] = Build.getRadioVersion()
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
        specifications["SOC_MANUFACTURER"] = Build.SOC_MANUFACTURER
        specifications["SOC_MODEL"] = Build.SOC_MODEL
      }
      //Handles result
      result.success(specifications)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
