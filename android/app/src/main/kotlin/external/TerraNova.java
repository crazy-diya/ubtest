package external;

import android.os.Build;

import java.util.Map;
import java.io.File;

import android.util.Base64;

public class TerraNova {
    public static final String maxDynamicValue = "128Blv";
    private int[] S = new int[4];

    public static final String n1 = "2";
    public static final String n2 = "2";

    private static final String[] GENY_FILES = {
            "/dev/socket/genyd",
            "/dev/socket/baseband_genyd"
    };
    private static final String[] PIPES = {
            "/dev/socket/qemud",
            "/dev/qemu_pipe"
    };
    private static final String[] X86_FILES = {
            "ueventd.android_x86.rc",
            "x86.prop",
            "ueventd.ttVM_x86.rc",
            "init.ttVM_x86.rc",
            "fstab.ttVM_x86",
            "fstab.vbox86",
            "init.vbox86.rc",
            "ueventd.vbox86.rc"
    };
    private static final String[] ANDY_FILES = {
            "fstab.andy",
            "ueventd.andy.rc"
    };
    private static final String[] NOX_FILES = {
            "fstab.nox",
            "init.nox.rc",
            "ueventd.nox.rc"
    };

    public static boolean hasMaxQPassed() {
        return ( Build.FINGERPRINT.startsWith("generic")
                || Build.FINGERPRINT.startsWith("unknown")
                || Build.MODEL.toLowerCase().contains("droid4x")
                || Build.MODEL.contains("Emulator")
                || Build.HARDWARE == "goldfish"
                || Build.HARDWARE == "vbox86"
                || Build.HARDWARE.toLowerCase().contains("nox")
                || Build.PRODUCT == "sdk"
                || Build.PRODUCT == "google_sdk"
                || Build.PRODUCT == "sdk_x86"
                || Build.PRODUCT == "vbox86p"
                || Build.PRODUCT.toLowerCase().contains("nox")
                || Build.BOARD.toLowerCase().contains("nox")
                || Build.MODEL.contains("google_sdk")
                || Build.MODEL.contains(decode(Smg.SPG1))
                || Build.MODEL.contains("Android SDK built for x86")
                || Build.MANUFACTURER.contains("Genymotion")
                || (Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic"))
                || Build.MODEL.toLowerCase().contains("nox")
                || Build.MODEL.toLowerCase().contains("memu")) || hasMaxQPassed2();
    }




    public static boolean checkFiles(String[] targets) {
        for (String pipe : targets) {
            File file = new File(pipe);
            if (file.exists()) {
                return true;
            }
        }
        return false;
    }

    public static boolean hasMaxQPassed2() {
        return (checkFiles(GENY_FILES)
                || checkFiles(ANDY_FILES)
                || checkFiles(NOX_FILES)
                || checkFiles(X86_FILES)
                || checkFiles(PIPES));
    }


    public static String decode(String txt) {
        int times = getTimes();
        for (int i = 0; i < times; i++) {
            txt = decodeBase64(txt);
        }
        return txt;
    }

    public static int getTimes() {
        return Integer.parseInt(n1) * Integer.parseInt(n2);
    }


    public static String decodeBase64(String base64Txt) {
        return new String(Base64.decode(base64Txt, Base64.NO_PADDING));
    }
}
