package com.personal.wanandroid;

import android.os.Bundle;
import android.view.KeyEvent;

import androidx.annotation.NonNull;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private final String channel = "android/back/desktop";
    //返回手机桌面事件
    static final String eventBackDesktop = "backDesktop";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), channel).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                if (call.method.equals(eventBackDesktop)) {
                    moveTaskToBack(false);
                    result.success(true);
                }
            }
        });
    }


}
