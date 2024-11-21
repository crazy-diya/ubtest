package justpay;

import android.content.Context;

import com.google.gson.Gson;
import com.lankapay.justpay.LPTrustedSDK;
import com.lankapay.justpay.callbacks.CreateIdentityCallback;
import com.lankapay.justpay.callbacks.SignMessageCallback;

//
// Created by gayan_g on 12/24/2019.
// Copyright (c) 2019 epiclanka. All rights reserved.

public class JustPayCalls {
    private static LPTrustedSDK lcTrustedSDK;
    private static JustPayCalls justPayCalls;
    public static String ERR_DID = "ERR_DID";
    public static String ERR_SUCCESS_CREATE_IDENTITY = "ERR_SUCCESS_CREATE_IDENTITY";

    private JustPayCalls(Context context) {
        lcTrustedSDK = LPTrustedSDK.getInstance(context);
    }

    public static synchronized JustPayCalls getInstance(Context context) {
        if (lcTrustedSDK == null) {
            justPayCalls = new JustPayCalls(context);
        }

        return justPayCalls;
    }

    public String getDeviceID() {
        return lcTrustedSDK.getDeviceID();
    }

    public boolean isIdentityExist() {
        return lcTrustedSDK.isIdentityExist();
    }

    public void revoke(){
        if(lcTrustedSDK.isIdentityExist())
            lcTrustedSDK.clearIdentity();
    }

    public void createIdentity(String challenge, JustPayEvents.IdentityCallback identityCallback) {
        lcTrustedSDK.createIdentity(challenge, new CreateIdentityCallback() {
            @Override
            public void onSuccess() {
                JustPayPayload payPayload = new JustPayPayload();
                payPayload.setSuccess(true);
                identityCallback.onIdentityInvoked(new Gson().toJson(payPayload));
            }

            @Override
            public void onFailed(int i, String s) {
                JustPayPayload payPayload = new JustPayPayload();
                payPayload.setSuccess(false);
                payPayload.setCode(i);
                identityCallback.onIdentityInvoked(new Gson().toJson(payPayload));
            }
        });
    }

    public void signMessage(String message, JustPayEvents.SigningCallback signingCallback) {
        lcTrustedSDK.signMessage(message, new SignMessageCallback() {
            @Override
            public void onSuccess(String signedMessage, String status) {
                JustPayPayload payPayload = new JustPayPayload();
                payPayload.setSuccess(true);
                payPayload.setData(signedMessage);
                signingCallback.onSignTermsInvoked(new Gson().toJson(payPayload));
            }

            @Override
            public void onFailed(int i, String s) {
                JustPayPayload payPayload = new JustPayPayload();
                payPayload.setSuccess(false);
                payPayload.setData(s);
                payPayload.setCode(i);
                signingCallback.onSignTermsInvoked(new Gson().toJson(payPayload));
            }
        });
    }

    public interface JustPayEvents {
        interface IdentityCallback {
            void onIdentityInvoked(String payPayload);
        }

        interface SigningCallback {
            void onSignTermsInvoked(String payPayload);
        }
    }
}
