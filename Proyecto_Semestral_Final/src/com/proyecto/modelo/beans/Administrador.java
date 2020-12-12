package com.proyecto.modelo.beans;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;

import com.ejemplo.modelo.beans.Administrador;
import com.ejemplo.modelo.beans.ArrayList;

public class Administrador {
	private Connection con;
	public Connection getCon() {
		return con;
	}
	public void setCon(Connection con) {
		this.con = con;
	}
	private int id;
	private String nombre;
	private String email;
	private String fecha;
	private String estados;
	private int rolId;
	private String password;
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Administrador() {
		
	}
	public Administrador(int id, String nombre, String email, String fecha, String estados, int rolId) {
		super();
		this.id = id;
		this.nombre = nombre;
		this.email = email;
		this.fecha = fecha;
		this.estados = estados;
		this.rolId = rolId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public String getEstados() {
		return estados;
	}

	public void setEstados(String estados) {
		this.estados = estados;
	}

	public int getRolId() {
		return rolId;
	}

	public void setRolId(int rolId) {
		this.rolId = rolId;
	}
	
	public boolean crearUsuario(){
		int cta=0;
		try {
			PreparedStatement st = con.prepareCall("{call sp_insertar_usuarios(?,?,?,?)}");
			st.setString(1, this.getNombre());
			st.setString(2, this.getEmail());
			st.setString(3, this.getPassword());
			st.setLong(4, this.getRolId());
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
public boolean CheckUserName() {
		
		String sql="Select count(*) as dato from usuarios where email=? ";
		int cta=0;
		
		try {
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, this.getEmail());
			
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
public ArrayList<Administrador> consultarusuarios(){
	
	ArrayList<Administrador> lista = new ArrayList<Administrador>();
	try {
		PreparedStatement st = con.prepareCall("{call usuarios(?)}");
		st.setString(1, "A");
		ResultSet rs=st.executeQuery();
		while (rs.next()) {
			Administrador objeto = new Administrador(
					rs.getInt("id"),
					rs.getString("nombre"),
					rs.getString("email"),
					rs.getString("fecha"),
					rs.getString("estados")
					);
			lista.add(objeto);
		}
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		System.out.println("Error en el procedimiento");
	}
	
	return lista;
	
}
public Administrador getusuario(){
	

	Administrador resp = new Administrador(); 
	String sql="select id, nombre, email, password, estado, rolId FROM usuarios where email =?";
	try {
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, this.getEmail());
		 
		ResultSet rs=st.executeQuery();
		
		while (rs.next()) {
			System.out.println(rs.getInt("rolId"));
			resp.setNombre(rs.getString("nombre"));
			resp.setId(	rs.getInt("id"));
			resp.setEmail(rs.getString("email"));
			resp.setPassword(rs.getString("password"));		
			resp.setEstados(rs.getString("estado"));	
			resp.setRolId(rs.getInt("rolId"));		
		}
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	return resp;
	
}
public boolean actualiarUsuario(){
	int cta=0;
	String sql = "UPDATE `usuarios`" + 
			"SET" + 
			"`nombre`=?," + 
			"`email`=?," + 
			"`rolId`=?," + 
			"`estado`=?" + 
			"WHERE id=?";
	try {
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, this.getNombre());
		st.setString(2, this.getEmail());
		st.setLong(3, this.getRolId());
		st.setString(4, this.getEstados());
		st.setLong(5, this.getId());
	    cta=st.executeUpdate();
		st.close();
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
