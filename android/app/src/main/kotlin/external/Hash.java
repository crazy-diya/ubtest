package external;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;


public class Hash {
    public static String bin2hex(byte[] data) {
        return String.format("%0" + (data.length * 2) + 'x', new BigInteger(1, data));
    }

    public static String getSHA256Hash(String data) {
        String result = null;
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(data.getBytes(StandardCharsets.UTF_8));
            return bin2hex(hash); // make it printable
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return result;
    }
}