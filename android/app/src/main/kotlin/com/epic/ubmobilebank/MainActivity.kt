package com.epic.ubmobilebank

import android.annotation.SuppressLint
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.util.Log
import android.view.MotionEvent
import android.view.MotionEvent.FLAG_WINDOW_IS_OBSCURED
import android.view.MotionEvent.FLAG_WINDOW_IS_PARTIALLY_OBSCURED
import android.view.View
import android.view.WindowManager
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import external.*
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import justpay.JustPayCalls
import justpay.LankaQRScanner


class MainActivity : FlutterFragmentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        disableAndroidTapJacking()
    }
    
    private val CHANNEL = "ubgo_method_channel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {
                "8b08d02" -> {
                    result.success(ScCh(this@MainActivity).DJJRVFBFHFJDNHCC())
                }
                "33b2f052" -> {
                    result.success(ScCh(this@MainActivity).XBSHNAERG())
                }
                "842d1d79" -> {
                    result.success(ScCh(this@MainActivity).sOGxeNyU0Q(applicationContext))
                }
                "ba6c17af" -> {
                    result.success(Luca.getSilicaNucleicAcidExtractionPHValue(applicationContext))
                }
                "b1e4fead" -> {
                    result.success(AelonFlux.isStaticFluxReleased(applicationContext))
                }
                "c231def8" -> {

                    result.success(TerraNova.hasMaxQPassed())
                }
                "180c2247" -> {
                    result.success(BioWPN.checkAvailability(applicationContext))
                }
                "ceb45240" -> {
                    directToUsbDebugging()
                }
                "917ca3f0" -> {
                    disableScreenShot()
                }
                "2b34675e" -> {
                    val justPay = JustPayCalls.getInstance(applicationContext)
                    val deviceId = justPay.deviceID
                    if (deviceId == null)
                        result.error(
                            JustPayCalls.ERR_DID,
                            JustPayCalls.ERR_DID,
                            JustPayCalls.ERR_DID
                        )
                    else
                        result.success(deviceId)
                }
                "9a479f83" -> {
                    val justPay = JustPayCalls.getInstance(applicationContext)
                    result.success(justPay.isIdentityExist)
                }
                "78fd1637" -> {
                    val justPay = JustPayCalls.getInstance(applicationContext)
                    result.success(justPay.revoke())
                }
                "80dcbec1" -> {
                    val challenge = call.argument<String>("challenge")
                    val justPay = JustPayCalls.getInstance(applicationContext)
                    justPay.createIdentity(challenge) { payPayload -> result.success(payPayload) }
                }
                "cc658593" -> {
                    val terms = call.argument<String>("terms")
                    val justPay = JustPayCalls.getInstance(applicationContext)
                    justPay.signMessage(terms) { payPayload -> result.success(payPayload) }
                }
                "e681eecb" -> {
                    result.success(ScCh(this@MainActivity).g3tC3ck(applicationContext))
                }
                "2ef6f68d" -> {
                    var scanResult = call.argument<String>("qrString") as String

                    val lankaQr = LankaQRScanner.getLankaQRData(scanResult)
                    if (lankaQr == LankaQRScanner.LQRErrorCode)
                        result.error(
                            LankaQRScanner.LQRErrorCode,
                            LankaQRScanner.InvalidLQR,
                            LankaQRScanner.InvalidLQR
                        )
                    else
                        result.success(lankaQr)

                }
            }
        }
    }

    private fun directToUsbDebugging() {
        val intent = Intent(Settings.ACTION_APPLICATION_DEVELOPMENT_SETTINGS)
        startActivity(intent)
    }

    private fun disableAndroidTapJacking() {
       try{
           var view: View? = findViewById<View?>(android.R.id.content)
           if (view == null) {
               view = window.decorView.findViewById<View>(android.R.id.content)
           }
           view!!.rootView.filterTouchesWhenObscured = true

           //Android SDK 31 higher
           if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {

               window.setHideOverlayWindows(true)
           }
       }catch (e : Exception){
           e.printStackTrace()
       }
   }

    override fun dispatchTouchEvent(event: MotionEvent): Boolean {
        val flags = event.flags
        val badTouch = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            ((flags and FLAG_WINDOW_IS_PARTIALLY_OBSCURED) != 0
                    || (flags and FLAG_WINDOW_IS_OBSCURED) != 0)
        } else {
            super.dispatchTouchEvent(event)
        }

        return if (badTouch) {
            false
        } else {
            super.dispatchTouchEvent(event)
        }
    }

    private fun disableScreenShot() {
        window.setFlags(
            WindowManager.LayoutParams.FLAG_SECURE,
            WindowManager.LayoutParams.FLAG_SECURE
        )
    }
}
