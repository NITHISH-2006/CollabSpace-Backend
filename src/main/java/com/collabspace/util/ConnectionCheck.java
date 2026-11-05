package com.collabspace.util;

import java.sql.Connection;

public final class ConnectionCheck {

    public static void main(String[] args) throws Exception {
        Connection connection = DBConnection.getConnection();
        System.out.println("Connected to: " + connection.getCatalog());
        DBConnection.closeConnection();
    }
}
