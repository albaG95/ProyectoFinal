package com.inventario;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.proyecto.modelo.beans.Producto;
import com.proyecto.modelo.beans.inventario;
import com.google.gson.Gson; 

/**
 * Servlet implementation class ServletInventario
 */

public class ServletInventario extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String rutaJsp;
	private DataSource ds;
	private Connection con;    
	private Gson gson = new Gson();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletInventario() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    @Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
		rutaJsp=config.getInitParameter("rutaJsp");
		System.out.println(rutaJsp);
		try {
			InitialContext initContext =new InitialContext();
			Context env=(Context)initContext.lookup("java:comp/env");
			ds=(DataSource) env.lookup("jdbc/DB1LS221");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			con = ds.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String accion = request.getParameter("accion");
		 HttpSession sesion = request.getSession();
		if (accion !=null) {
			 if(accion.equals("registroProd")) {
				 getServletContext().getRequestDispatcher(rutaJsp+"/inventario/Registro/RegistroProducto.jsp").forward(request,response);
			 }			 
			else if (accion.equals("updateProd")){
				ArrayList<Producto> lista = new inventario(con).getproductos();
				
				if (lista.isEmpty()) {
					
				}else {
					System.out.println(lista.size());
					sesion.setAttribute("inventario",lista);
					request.setAttribute("productos", lista);
				}
				
				getServletContext().getRequestDispatcher(rutaJsp+"/inventario/UpdateProd/UpdateProd.jsp").forward(request,response);
			 }else if (accion.equals("getProductoValues")) {
				 String codigo=request.getParameter("codigoProd");
				 ArrayList<Producto> lista=  (ArrayList<Producto>) sesion.getAttribute("inventario");
				 Producto value = new Producto();
				 if(lista.size()>0) {
				
				 }else {
					 lista = new inventario(con).getproductos();
				 }
				 
				 for(Producto producto : lista) {
				        if (producto.getCodigo().equals(codigo)) {
				        	value = producto;
				        }
				    }
				 
				 String productojson = this.gson.toJson(value);
				 System.out.println(productojson);
				 response.setContentType("application/json");
				 response.setCharacterEncoding("UTF-8");
				 response.getWriter().write(productojson);
			 }
			
		}
		else {
			getServletContext().getRequestDispatcher(rutaJsp+"login.jsp").forward(request,response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String accion = request.getParameter("accion");
		try {
			con = ds.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 HttpSession sesion = request.getSession();
		if (accion !=null) {
			 if (accion.equals("ProdutAdd")){
				 
				 String nombre=request.getParameter("name");
				 String codigo=request.getParameter("codigo");
				 String precio=request.getParameter("precio");
				 
				 if(nombre=="" || codigo=="" || precio=="") {
					 request.setAttribute("error","Campos en blando no permitidos");
					 getServletContext().getRequestDispatcher(rutaJsp+"/inventario/Registro/RegistroProducto.jsp").forward(request,response);
				 }

				 Producto producto = new Producto();
				 producto.setNombre(nombre);
				 producto.setCodigo(codigo);
				 producto.setPrecio(Double.parseDouble(precio));
				 producto.setCon(con);
				 
				 if(!producto.CheckCodigoProducto()) {
					 if(producto.crearProducto()) {
						 request.setAttribute("addProdResponse","Producto creado correctamente");
					 }
					 else {
						 request.setAttribute("addProdResponse","Error al crear el producto");
					 }
				 }else {
					 request.setAttribute("addProdResponse","El Codigo de producto ya existe");
				 }
				 getServletContext().getRequestDispatcher(rutaJsp+"/inventario/Registro/RespuestaProducto.jsp").forward(request,response);
			 }else if(accion.equals("UpdateProd")) {
;
				 String nombre=request.getParameter("nombre");
				 String codigo=request.getParameter("codigo");
				 String existencia=request.getParameter("existencia");
				 String Vendidos=request.getParameter("Vendidos");
				 String stock=request.getParameter("stock");
				 String precio=request.getParameter("precio");
				 
				 if(nombre=="" || codigo=="" || precio=="" || existencia=="" || Vendidos=="") {
					 request.setAttribute("error","Campos en blando no permitidos");
					 getServletContext().getRequestDispatcher(rutaJsp+"/inventario/UpdateProd/UpdateProd.jsp").forward(request,response);
				 }
				 Producto producto = new Producto();
				 producto.setNombre(nombre);
				 producto.setCodigo(codigo);
				 producto.setPrecio(Double.parseDouble(precio));
				 producto.setExistencia(Integer.parseInt(existencia) );
				 producto.setVendidos(Integer.parseInt(Vendidos));
				 
				 boolean resp = new inventario(con).UpdateInventario(producto);
				 
				 if(resp) {
					 request.setAttribute("upProdResponse","Inventario actualizado correctamente");
				 }else {
					 request.setAttribute("upProdResponse","Error al actualizar el inventario");
				 }
				 
				 ArrayList<Producto> lista = new inventario(con).getproductos();
					
					if (lista.isEmpty()) {
						
					}else {
						
						sesion.setAttribute("inventario",lista);
						request.setAttribute("productos", lista);
					}

				 getServletContext().getRequestDispatcher(rutaJsp+"/inventario/UpdateProd/RespuestaUpdateProd.jsp").forward(request,response);
			   } 
		}
		else {
			getServletContext().getRequestDispatcher(rutaJsp+"login.jsp").forward(request,response);
		}
	}

}
