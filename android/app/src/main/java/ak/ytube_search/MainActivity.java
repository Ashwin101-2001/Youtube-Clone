package ak.ytube_search;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.speech.RecognizerIntent;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.Date;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "ysearch";
    private static final int SPEECH_REQUEST_CODE = 0;
    private String speech="no";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        Log.d("tag4","ab");
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {

                    if (call.method.equals("voice search")) {
                        displaySpeechRecognizer();
                        Date d=new Date();
                        Log.d("time1",d.toString());

                    }




                });
    }

    private void displaySpeechRecognizer() {
        Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
// This starts the activity and populates the intent with the speech text.
        startActivityForResult(intent, SPEECH_REQUEST_CODE);
    }

    // This callback is invoked when the Speech Recognizer returns.
// This is where you process the intent and extract the speech text from the intent.
    @Override
    protected void onActivityResult(int requestCode, int resultCode,
                                    Intent data) {
        if (requestCode == SPEECH_REQUEST_CODE && resultCode == RESULT_OK) {
            List<String> results = data.getStringArrayListExtra(
                    RecognizerIntent.EXTRA_RESULTS);
            String spokenText = results.get(0);
            SharedPreferences sharedpreferences = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE);
            SharedPreferences.Editor editor = sharedpreferences.edit();
            editor.putString("flutter."+"speech",spokenText);
            editor.commit();
            editor.putBoolean("flutter."+"justVoiced",true);
            editor.commit();



            // Do something with spokenText.
            Date d=new Date();
            Log.d("time2",d.toString()+spokenText+sharedpreferences.getString("flutter."+"speech",null));
            speech=spokenText;
              PackageManager packageManager = getPackageManager();
            Intent intent = packageManager.getLaunchIntentForPackage(getPackageName());
            ComponentName componentName = intent.getComponent();
            Intent mainIntent = Intent.makeRestartActivityTask(componentName);
            startActivity(mainIntent);
            Runtime.getRuntime().exit(0);


        }
        super.onActivityResult(requestCode, resultCode, data);
    }




}
