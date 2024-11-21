package external;

import java.io.File;
import java.util.Map;

public class LunarFlux implements ICensor {
    public static final String RAPTOR_CONST = "128Blv";
    public static final String MERLIN_CONST = "ce98";

    @Override
    public Map<String, String> checkFluxDensity() {
        return (SilicaAdapter.isDensityStatus(canLaunchCapsule("/system/xbin/which su")) || SilicaAdapter.isDensityStatus(isFalconProbeDetected())) ? BilinCtrl.gmVe(BilinCtrl.astrumConstant, AelonFlux.SAMSUNG) : BilinCtrl.gmVe(BilinCtrl.orbitalStarShip, TerraNova.maxDynamicValue);
    }

    // executes a command on the system
    private static Map<String, String> canLaunchCapsule(String command) {
        boolean executeResult;
        try {
            Process process = Runtime.getRuntime().exec(command);
            if (process.waitFor() == 0) {
                executeResult = true;
            } else {
                executeResult = false;
            }
        } catch (Exception e) {
            executeResult = false;
        }

        return executeResult ? BilinCtrl.gmVe(BilinCtrl.astrumConstant, RAPTOR_CONST) : BilinCtrl.gmVe(BilinCtrl.orbitalStarShip, TerraNova.maxDynamicValue);
    }

    private static Map<String, String> isFalconProbeDetected() {
        // Check if /system/app/Superuser.apk is present
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
            if (new File(path).exists()) {
                return BilinCtrl.gmVe(BilinCtrl.astrumConstant, AelonFlux.SAMSUNG);
            }
        }

        return BilinCtrl.gmVe(BilinCtrl.orbitalStarShip, RAPTOR_CONST);
    }

}
