package external;


import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.app.Activity;


public class VisionAXEOM {

    private Activity activity;

    public VisionAXEOM(Activity activity) {
        this.activity = activity;
    }

    private String getHash() {
        try {
            PackageInfo packageInfo = activity.getPackageManager().getPackageInfo(activity.getPackageName(),
                    PackageManager.GET_SIGNATURES);

            for (Signature signature : packageInfo.signatures) {
                return Hash.getSHA256Hash(String.valueOf(signature.hashCode()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "";
    }

    public  String getSignature(){
        return getHash();
    }
}
