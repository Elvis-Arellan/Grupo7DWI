package util;

import java.security.MessageDigest;

public class PasswordUtil {

    private PasswordUtil() {
    }

    public static String hashear(String clave) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(clave.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("Error al hashear contraseña", e);
        }
    }

    public static boolean verificar(String claveIngresada, String hashGuardado) {
        return hashear(claveIngresada).equals(hashGuardado);
    }
}
