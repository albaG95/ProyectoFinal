package com.proyecto.modelo.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



public class Producto {
	private String Codigo;
	private String Nombre;
	private int Existencia;
	private int Vendidos;
	private int Total; 
	private double precio;
	
	public double getPrecio() {
		return precio;
	}
	public void setPrecio(double precio) {
		this.precio = precio;
	}
	public int getTotal() {
		return Total;
	}
	public void setTotal(int total) {
		Total = total;
	}
	public int getVendidos() {
		return Vendidos;
	}
	public void setVendidos(int vendidos) {
		Vendidos = vendidos;
	}
	private Connection con;
	public Connection getCon() {
		return con;
	}
	public void setCon(Connection con) {
		this.con = con;
	}
	public String getCodigo() {
		return Codigo;
	}
	public void setCodigo(String codigo) {
		Codigo = codigo;
	}
	public String getNombre() {
		return Nombre;
	}
	public void setNombre(String nombre) {
		Nombre = nombre;
	}
	public int getExistencia() {
		return Existencia;
	}
	public void setExistencia(int existencia) {
		Existencia = existencia;
	}
	
public boolean CheckCodigoProducto() {
		
		String sql="Select count(*) as dato from productos where codigo=?";
		int cta=0;
		
		try {
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, this.getCodigo());
			
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
public boolean crearProducto(){
	int cta=0;
	try {
		PreparedStatement st = con.prepareCall("{call sp_insertar_producto(?,?,?)}");
		st.setString(1, this.getNombre());
		st.setString(2, this.getCodigo());
		st.setDouble(3, this.getPrecio());
		
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
