package external;

import android.app.Activity;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.util.Base64;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
import java.util.List;
import java.lang.reflect.Field;

import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.io.IOException;

public class ScCh {

    private String n1 = "2";
    private String n2 = "2";
    private String msg = "";
    private Activity activity;

    public ScCh(Activity activity) {
        this.activity = activity;
    }

    public boolean XBSHNAERG() {
        boolean b = NEGABRRSD()
                || NHHDBDGJJF()
                || NVDDHEGDJFK()
                || NDHDGVFHDHJ();
        if (b) {
            msg = deo(Smg.S17);
        }
        return b;
    }

    private boolean NEGABRRSD() {
        String buildTags = Build.TAGS;
        return buildTags != null && buildTags.contains(deo(Smg.S18));
    }

    //
    private boolean NHHDBDGJJF() {
        String[] paths = {
                deo(Smg.S19),
                deo(Smg.S20),
                deo(Smg.S21),
                deo(Smg.S22),
                deo(Smg.S23),
                deo(Smg.S24),
                deo(Smg.S25),
                deo(Smg.S26),
                deo(Smg.S27),
                deo(Smg.S28),
                deo(Smg.S29),
                deo(Smg.S30),
                deo(Smg.S31),
                deo(Smg.S32),
                deo(Smg.S33),
                deo(Smg.S34),
                deo(Smg.S35),
        };

        for (String path : paths) {
            if (new File(path).exists()) return true;
        }
        return false;
    }

    private boolean NVDDHEGDJFK() {
        Process process = null;
        try {
            process = Runtime.getRuntime().exec(new String[]{
                    deo(Smg.S36),
                    deo(Smg.S37)
            });
            BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));
            if (in.readLine() != null) return true;
            return false;
        } catch (Throwable t) {
            return false;
        } finally {
            if (process != null) process.destroy();
        }
    }

    private boolean NDHDGVFHDHJ() {
        try {
            Constructor c = Class.forName(deo(Smg.S38)).getConstructor(Context.class);
            Object o = c.newInstance(activity);
            Method m = o.getClass().getMethod(deo(Smg.S39));
            return (boolean) m.invoke(o);
        } catch (Exception ex) {
            return false;
        }
    }

    private boolean isExposedOrSSLUnpinAppDetected() {
        PackageManager packageManager = activity.getPackageManager();
        List<ApplicationInfo> appliacationInfoList = packageManager.getInstalledApplications(PackageManager.GET_META_DATA);
        for (ApplicationInfo item : appliacationInfoList) {
            String pName = item.packageName;
            if (pName.equals(deo(Smg.S13))
                    || pName.equals(deo(Smg.S13_1))
                    || pName.equals(deo(Smg.S14))
                    || pName.equals(Smg.S15)) {
                msg = deo(Smg.S16);
                return true;
            }
        }

        return false;
    }

    public boolean DJJRVFBFHFJDNHCC() {
        try {
            boolean goldfish = getSysPro(deo(Smg.S4)).contains(deo(Smg.S5));
            boolean emu = (getSysPro(deo(Smg.S6)).length() > 0)
                    && !getSysPro(deo(Smg.S6)).equals("0"); // Added this because this will return ro.kernel.qemu = 0 from Samsung devices
            boolean sdk = getSysPro(deo(Smg.S7)).equals(deo(Smg.S8));
            if (emu || goldfish || sdk) {
                msg = deo(Smg.S9);
                return true;
            }
        } catch (Exception e) {
        }
        return false;
    }

    private String getSysPro(String name) throws Exception {
        Class systemPropertyClazz = Class.forName(deo(Smg.S10));
        return (String) systemPropertyClazz.getMethod(deo(Smg.S11), new Class[]{String.class})
                .invoke(systemPropertyClazz, new Object[]{name});
    }

    private String deo(String txt) {
        int times = gTie();
        for (int i = 0; i < times; i++) {
            txt = dceBe46(txt);
        }
        return txt;
    }

    private int gTie() {
        return Integer.parseInt(n1) * Integer.parseInt(n2);
    }

    private String edBe46(String txt) {
        return Base64.encodeToString(txt.getBytes(), Base64.NO_PADDING);
    }

    private String dceBe46(String base64Txt) {
        return new String(Base64.decode(base64Txt, Base64.NO_PADDING));
    }

      public String sOGxeNyU0Q(Context context) {
        try {
            Method getPkgMgrMethod = Context.class.getMethod(deo(Smg.S46));
            Object pkgMgr = getPkgMgrMethod.invoke(context);

            assert pkgMgr != null;
            Method getPkgrInfoMethod = pkgMgr.getClass().getMethod(deo(Smg.S47), String.class, int.class);
            Object packageInfo = getPkgrInfoMethod.invoke(pkgMgr, context.getPackageName(), 64);

            assert packageInfo != null;
            Field sigField = packageInfo.getClass().getField(deo(Smg.S48));
            Object[] siges = (Object[]) sigField.get(packageInfo);

            assert siges != null;
            for (Object sig : siges) {
                Method hashCodeMethod = sig.getClass().getMethod(deo(Smg.S49));
                String data = String.valueOf(hashCodeMethod.invoke(sig));

                Class<?> messageDigestClass = Class.forName(deo(Smg.S50));
                Method getInstanceMethod = messageDigestClass.getMethod(deo(Smg.S51), String.class);
                Object digest = getInstanceMethod.invoke(null, deo(Smg.S52));

                assert digest != null;
                Method digestMethod = digest.getClass().getMethod(deo(Smg.S53), byte[].class);
                byte[] hash = (byte[]) digestMethod.invoke(digest, (Object) data.getBytes(deo(Smg.S54)));

                Class<?> bigIntegerClass = Class.forName(deo(Smg.S55));
                Constructor<?> bigIntegerConstructor = bigIntegerClass.getConstructor(int.class, byte[].class);
                Object bigInteger = bigIntegerConstructor.newInstance(1, hash);

                assert hash != null;
                return String.format(deo(Smg.S56) + (hash.length * 2) + deo(Smg.S57), bigInteger);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "";
    }

    public String g3tC3ck(Context context) {
        String crc = "";
        ZipFile zipFile = null;

        try {
            Class<?> contextClass = context.getClass();

            Method getPackageCodePathMethod = contextClass.getMethod(deo(Smg.S61));
            String packageCodePath = (String) getPackageCodePathMethod.invoke(context);
            zipFile = new ZipFile(packageCodePath);
            Method getEntryMethod = ZipFile.class.getMethod(deo(Smg.S62), String.class);
            String entryName = deo(Smg.S44);
            ZipEntry zipEntry = (ZipEntry) getEntryMethod.invoke(zipFile, entryName);

            if (zipEntry != null) {
                Method getCrcMethod = ZipEntry.class.getMethod(deo(Smg.S60));
                long crcValue = (Long) getCrcMethod.invoke(zipEntry);
                crc = String.valueOf(crcValue);
            } else {
                crc = "";
            }

        } catch (Exception e) {
            e.printStackTrace();
            crc = "";
        } finally {
            if (zipFile != null) {
                try {
                    zipFile.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        return crc;
    }
}