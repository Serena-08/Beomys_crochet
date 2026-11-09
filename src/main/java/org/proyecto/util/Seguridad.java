package org.proyecto.util;

import org.mindrot.jbcrypt.BCrypt;

public class Seguridad {

    //Convierte clase a Hash
    public static String hashear(String clave){
        return BCrypt.hashpw(clave, BCrypt.gensalt());
    }

    //Verifica si la clave ingresada es igual a la clave hasheada
    public static boolean coincide(String clave, String hash){
        if (clave == null || hash == null){
            return false;
        }

        try{
            return BCrypt.checkpw(clave, hash);
        } catch (IllegalArgumentException e){
            return false;
        }
    }

    //Devolvemos el hash de la clave ingresada
    public static String asegurarHash(String clave){
        if (clave != null && clave.startsWith("$2a$")){
            return clave;
        }
        return hashear(clave);
    }
}
