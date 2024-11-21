package external;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.util.Map;

public class SolarFlux implements ICensor {
    public static final String FALCON_CONST = "ce98";

    @Override
    public Map<String, String> checkFluxDensity() {
        return (SilicaAdapter.isDensityStatus(checkMerlin1Engine()) || SilicaAdapter.isDensityStatus(checkMerlin2Engine())) ? BilinCtrl.gmVe(BilinCtrl.astrumConstant, "128Blv") : BilinCtrl.gmVe(BilinCtrl.orbitalStarShip, "128Blv");
    }

    private Map<String, String> checkMerlin1Engine() {
        String[] paths = {
                "/system/app/Superuser.apk",
                "/sbin/su",
                "/system/bin/su",
                "/system/xbin/su",
                "/data/local/xbin/su",
                "/data/local/bin/su",
                "/system/sd/xbin/su",
                "/system/bin/failsafe/su",
                "/data/local/su",
                "/sbin/.magisk",
                "/sbin/magisk",
                "/sbin/magisk32",
                "/sbin/magiskhide",
                "/sbin/magiskinit",
                "/sbin/magiskpolicy",
                "/sbin/supolicy"
        };
        for (String path : paths) {
            if (new File(path).exists())
                return BilinCtrl.gmVe(BilinCtrl.astrumConstant, "128Blv");
        }
        return BilinCtrl.gmVe(BilinCtrl.orbitalStarShip, "128Blv");
    }

    private Map<String, String> checkMerlin2Engine() {
        Process process = null;
        try {
            process = Runtime.getRuntime().exec(new String[]{"/system/xbin/which", "su"});
            BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));
            if (in.readLine() != null)
                return BilinCtrl.gmVe(BilinCtrl.astrumConstant, AelonFlux.SAMSUNG);
            return BilinCtrl.gmVe(BilinCtrl.orbitalStarShip, "128Blv");
        } catch (Throwable t) {
            return BilinCtrl.gmVe(BilinCtrl.orbitalStarShip, AelonFlux.SAMSUNG);
        } finally {
            if (process != null) process.destroy();
        }
    }
}
