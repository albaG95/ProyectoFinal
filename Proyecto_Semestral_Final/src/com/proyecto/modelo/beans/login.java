package com.proyecto.modelo.beans;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.ejemplo.modelo.beans.Administrador;

import java.math.BigInteger; 
import java.security.MessageDigest; 
import java.security.NoSuchAlgorithmException; 


public class login {
	private Connection con;
	
	public login(Connection con) {
		this.con = con;
	}
	
	public boolean loginCheck(String email, String password) {
		
		String sql="Select count(*) as dato from usuarios where email=? and password=? and estado='A'";
		int cta=0;
		
		try {
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, email);
			st.setString(2, getMd5(password));
			
			ResultSet rs=st.executeQuery();
			
			if (rs.next()) {
				cta=rs.getInt("dato");
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		
		if (cta==0) {
			return false;
		}else return true;	
	}
	
	public Administrador getUserRol(String email, String password) {
		String sql="select	id, nombre, email, DATE_FORMAT( fecha_creacion , '%d-%m-%Y %r' ) as fecha ," + 
				"(case estado  when 'A' then 'Activo' when 'I' then 'Inactivo' end) as estados, rolId from usuarios where email=? and password=?";
		Administrador rol = new Administrador(); 
		
		try {
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, email);
			st.setString(2, getMd5(password));
			
			ResultSet rs=st.executeQuery();
			
			while (rs.next()) {
				rol = new Administrador(
						rs.getInt("id"),
						rs.getString("nombre"),
						rs.getString("email"),
						rs.getString("fecha"),
						rs.getString("estados"),
						rs.getInt("rolId")
						);
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rol;	
	}
	
	
	public static String getMd5(String input) 
	{ 
	    try { 
	
	        // Static getInstance method is called with hashing MD5 
	        MessageDigest md = MessageDigest.getInstance("MD5"); 
	
	        // digest() method is called to calculate message digest 
	        //  of an input digest() return array of byte 
	        byte[] messageDigest = md.digest(input.getBytes()); 
	
	        // Convert byte array into signum representation 
	        BigInteger no = new BigInteger(1, messageDigest); 
	
	        // Convert message digest into hex value 
	        String hashtext = no.toString(16); 
	        while (hashtext.length() < 32) { 
	            hashtext = "0" + hashtext; 
	        } 
	        return hashtext; 
	    }  
	
	    // For specifying wrong message digest algorithms 
	    catch (NoSuchAlgorithmException e) { 
	        throw new RuntimeException(e); 
	    } 
	} 
}
