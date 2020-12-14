package com.proyecto.modelo.beans;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.google.gson.Gson;

import java.sql.Connection;


public class inventario {
	private Connection con;

	public inventario(Connection con) {
		this.con = con;
	}
	
	public ArrayList<Producto>  getproductos(){
		
		ArrayList<Producto>  lista = new ArrayList<Producto>(); 
		String sql="SELECT B.Codigo,B.Nombre, IFNULL(A.Existencia, 0 ) AS Existencia ,IFNULL(A.Vendidos, 0 ) AS Vendidos ,IFNULL(A.Total, 0 ) As Total , B.Precio_Unitario FROM inventario A RIGHT JOIN productos B ON A.CodigoProducto=B.Codigo";
		try {
			PreparedStatement st = con.prepareStatement(sql);
			ResultSet rs=st.executeQuery();
			while (rs.next()) {
				Producto objeto = new Producto();
				objeto.setCodigo(rs.getString("Codigo"));
				objeto.setNombre(rs.getString("nombre"));	
				objeto.setExistencia(rs.getInt("Existencia"));
				objeto.setVendidos(rs.getInt("Vendidos"));	
				objeto.setTotal(rs.getInt("Total"));
				objeto.setPrecio(rs.getDouble("Precio_Unitario"));
				lista.add(objeto);
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Error en la consulta");
		}
		
		return lista;
		
	}
	public boolean  UpdateInventario(Producto prod){
		int cta=0;
		try {
			 Gson gson = new Gson();
			String productojson =  gson.toJson(prod);
			 System.out.println(productojson);
			PreparedStatement st = con.prepareCall("{call sp_Actualizar_Inventario(?,?,?,?,?)}");
			st.setString(1, prod.getNombre());
			st.setString(2, prod.getCodigo());
			st.setDouble(3, prod.getPrecio());
			st.setInt(4, prod.getExistencia());
			st.setInt(5, prod.getVendidos());
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
