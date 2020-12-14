package com.proyecto.modelo.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.google.gson.Gson;

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
public ArrayList<cliente>  getClientes(){
	
	ArrayList<cliente>  lista = new ArrayList<cliente>(); 
	String sql="SELECT Id, Nombre, Apellido, Email, Celular, Direccion, Cedula FROM clientes";
	try {
		PreparedStatement st = con.prepareStatement(sql);
		ResultSet rs=st.executeQuery();
		while (rs.next()) {
			cliente objeto = new cliente(rs.getInt("Id"),rs.getString("nombre"),
					rs.getString("Apellido"), rs.getString("Cedula"),rs.getString("Email"),rs.getString("Celular"),rs.getString("Direccion"));
			lista.add(objeto);
		}
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		System.out.println("Error en la consulta");
	}
	System.out.println("TEST "+lista.size());
	return lista;
	
}
public boolean  UpdateInventario(cliente cli){
	int cta=0;
	try {
		 Gson gson = new Gson();
		String productojson =  gson.toJson(cli);
		 System.out.println(productojson);
		PreparedStatement st = con.prepareCall("{call sp_actualiZar_cliente(?,?,?,?,?,?,?)}");
		st.setInt(1, cli.getId());
		st.setString(2, cli.getNombre());
		st.setString(3, cli.getApellido());
		st.setString(4, cli.getEmail());
		st.setString(5, cli.getCedula());
		st.setString(6, cli.getDireccion());
		st.setString(7, cli.getCedula());
		
		ResultSet rs=st.executeQuery();
		if (rs.next()) {
			cta=rs.getInt("resultado");
		}	
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		System.out.println("Error en la consulta");
	}
	if (cta==0) {
		return false;	
	}else return true;			
}
}
