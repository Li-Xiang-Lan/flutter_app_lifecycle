package com.lifecycle.flutter_app_lifecycle;

import android.app.Activity;
import android.app.Application;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** FlutterAppLifecyclePlugin */
public class FlutterAppLifecyclePlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private int pages=0;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_app_lifecycle");
    channel.setMethodCallHandler(this);
//    (flutterPluginBinding.getApplicationContext() as Application).registerActivityLifecycleCallbacks(this)
    ((Application) flutterPluginBinding.getApplicationContext()).registerActivityLifecycleCallbacks(new Application.ActivityLifecycleCallbacks() {
      @Override
      public void onActivityCreated(Activity activity, Bundle bundle) {
      }

      @Override
      public void onActivityStarted(Activity activity) {
        pages++;
        if(pages==1){
          Log.e("qwer","kk====app front");
          Map map=new HashMap<String,Boolean>();
          map.put("back",false);
          channel.invokeMethod("result", map);
        }
      }

      @Override
      public void onActivityResumed(Activity activity) {
      }

      @Override
      public void onActivityPaused(Activity activity) {
      }

      @Override
      public void onActivityStopped(Activity activity) {
        pages--;
        if(pages<=0){
          Map map=new HashMap<String,Boolean>();
          map.put("back",true);
          channel.invokeMethod("result", map);
        }
      }

      @Override
      public void onActivitySaveInstanceState(Activity activity, Bundle bundle) {

      }

      @Override
      public void onActivityDestroyed(Activity act) {
//        if (act == activity) {
//          ((Application) binding.getApplicationContext()).unregisterActivityLifecycleCallbacks(this);
//        }
      }
    });
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      channel.invokeMethod("result", null);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
