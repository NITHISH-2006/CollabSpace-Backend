package com.collabspace.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public final class PropertyUtil {

    private static final Properties PROPERTIES = new Properties();

    static {
        try (InputStream input = PropertyUtil.class.getClassLoader()
                .getResourceAsStream("db.properties")) {
            if (input == null) {
                throw new IllegalStateException("db.properties not found on classpath");
            }
            PROPERTIES.load(input);
        } catch (IOException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    private PropertyUtil() {
    }

    public static String getPropertyString() {
        String host = PROPERTIES.getProperty("host");
        String port = PROPERTIES.getProperty("port");
        String database = PROPERTIES.getProperty("dbname");
        return "jdbc:mysql://" + host + ":" + port + "/" + database
                + "?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC";
    }

    public static String getUsername() {
        return PROPERTIES.getProperty("username");
    }

    public static String getPassword() {
        return PROPERTIES.getProperty("password");
    }
}
