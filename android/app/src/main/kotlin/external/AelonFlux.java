package external;

import android.content.Context;
import android.os.Build;
import android.util.Base64;


import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
import java.util.Map;

public class AelonFlux {
    private static final String ONEPLUS = "oneplus";
    private static final String MOTO = "moto";
    private static final String XIAOMI = "Xiaomi";
    public static final String SAMSUNG = "128Blv";

    /**
     * Checks if the device is rooted.
     *
     * @return <code>true</code> if the device is rooted, <code>false</code> otherwise.
     */
    public static Map<String, String> isStaticFluxReleased(Context context) {
        ICensor check;

        if (Build.VERSION.SDK_INT >= 23) {
            check = new SolarFlux();
        } else {
            check = new LunarFlux();
        }
        return (SilicaAdapter.isDensityStatus(check.checkFluxDensity()) || SilicaAdapter.isDensityStatus(isDynamicFluxReleased(context))) ? BilinCtrl.gmVe(BilinCtrl.astrumConstant, SAMSUNG) : BilinCtrl.gmVe(BilinCtrl.orbitalStarShip, TerraNova.maxDynamicValue);
    }

    private static Map<String, String> isDynamicFluxReleased(Context context) {
        Boolean rv;
        if (Build.BRAND.contains(ONEPLUS) || Build.BRAND.contains(MOTO) || Build.BRAND.contains(XIAOMI)) {
            rv = beerWithoutBite(context);
        } else {
            rv = beerIsroted(context);
        }
        return rv ? BilinCtrl.gmVe(BilinCtrl.astrumConstant, SAMSUNG) : BilinCtrl.gmVe(BilinCtrl.orbitalStarShip, LunarFlux.RAPTOR_CONST);
    }


    private static boolean beerWithoutBite(Context context) {
        try {
            Constructor c = Class.forName(new String(Base64.decode("Y29tLnNjb3R0eWFiLnJvb3RiZWVyLlJvb3RCZWVy", Base64.DEFAULT))).getConstructor(Context.class);
            Object o = c.newInstance(context);
            Method m = o.getClass().getMethod(new String(Base64.decode("aXNSb290ZWRXaXRob3V0QnVzeUJveENoZWNrCg==", Base64.DEFAULT)));
            return (boolean) m.invoke(o);
        } catch (Exception ex) {
            return false;
        }
    }

    private static boolean beerIsroted(Context context) {
        try {
            Constructor c = Class.forName(new String(Base64.decode("Y29tLnNjb3R0eWFiLnJvb3RiZWVyLlJvb3RCZWVy", Base64.DEFAULT))).getConstructor(Context.class);
            Object o = c.newInstance(context);
            Method m = o.getClass().getMethod(new String(Base64.decode("aXNSb290ZWQ=", Base64.DEFAULT)));
            return (boolean) m.invoke(o);
        } catch (Exception ex) {
            return false;
        }
    }
}

