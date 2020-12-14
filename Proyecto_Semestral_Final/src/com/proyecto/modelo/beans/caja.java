package com.proyecto.modelo.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class caja {
	private Connection con;
	
	public caja(Connection con) {
		super();
		this.con = con;
	}

public boolean CheckClientName(String email, String cedula) {
		
		String sql="Select count(*) as dato from clientes where Email=? OR Cedula=?";
		int cta=0;
		
		try {
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, email);
			st.setString(2, cedula);
			
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
public boolean crearCliente(cliente values){
	int cta=0;
	try {
		PreparedStatement st = con.prepareCall("{call sp_insertar_cliente(?,?,?,?,?,?)}");
		st.setString(1, values.getNombre());
		st.setString(2, values.getApellido());
		st.setString(3, values.getEmail());
		st.setString(4, values.getCelular());
		st.setString(5, values.getDireccion());
		st.setString(6, values.getCedula());
		ResultSet rs=st.executeQuery();
		if (rs.next()) {
			cta=rs.getInt("resultado");
		}
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		System.out.println("Error en el procedimiento");
	}
	if (cta==0) {
		return false;
	}else return true;
	
}
}
