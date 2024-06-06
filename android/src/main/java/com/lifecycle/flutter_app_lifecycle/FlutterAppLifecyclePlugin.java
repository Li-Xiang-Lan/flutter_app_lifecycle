package com.lifecycle.flutter_app_lifecycle;

import android.app.Activity;
import android.app.Application;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;

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
        Log.e("qwer","onActivityCreated");
      }

      @Override
      public void onActivityStarted(Activity activity) {
        pages++;
        Log.e("qwer","onActivityStarted"+pages);
        if(pages==1){
          Log.e("qwer","kk====app front");
        }
      }

      @Override
      public void onActivityResumed(Activity activity) {
        Log.e("qwer","onActivityResumed");
      }

      @Override
      public void onActivityPaused(Activity activity) {
        Log.e("qwer","onActivityPaused");
      }

      @Override
      public void onActivityStopped(Activity activity) {
        pages--;
        Log.e("qwer","onActivityStopped"+pages);
        if(pages<=0){
          Log.e("qwer","kk====app back");
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
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
