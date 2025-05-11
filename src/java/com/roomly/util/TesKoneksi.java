package com.roomly.util;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author Lenovo
 */
public class TesKoneksi {
    public static void main(String[] args) {
        try {
            Connection conn = DatabaseUtil.getConnection();
            if (conn != null) {
                System.out.println("Koneksi ke database BERHASIL!");
                conn.close();
            }
        } catch (SQLException e) {
            System.out.println("Koneksi GAGAL: " + e.getMessage());
        }
    }
}
