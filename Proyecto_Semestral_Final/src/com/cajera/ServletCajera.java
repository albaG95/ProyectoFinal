package com.cajera;

import java.io.IOException;
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

import com.google.gson.Gson;
import com.proyecto.modelo.beans.Producto;
import com.proyecto.modelo.beans.caja;
import com.proyecto.modelo.beans.cliente;
import com.proyecto.modelo.beans.inventario;

/**
 * Servlet implementation class ServletCajera
 */
public class ServletCajera extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String rutaJsp;
	private DataSource ds;
	private Connection con; 
	private Gson gson = new Gson();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletCajera() {
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
		try {
			con = ds.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String accion = request.getParameter("accion");
		HttpSession sesion = request.getSession();
		if (accion !=null) {
			 if(accion.equals("createCliente")) {
				 getServletContext().getRequestDispatcher(rutaJsp+"/cajera/addClient/addClient.jsp").forward(request,response);
			 }
			 else if (accion.equals("updateCliente")){
				 ArrayList<cliente> lista = new caja(con).getClientes();
					
					if (lista.isEmpty()) {
						
					}else {
						System.out.println(lista.size());
						sesion.setAttribute("clientes",lista);
					}
				 getServletContext().getRequestDispatcher(rutaJsp+"/cajera/updateClient/UpdateClient.jsp").forward(request,response);
			 }else if (accion.equals("getClientesValues")){
				 
				 String codigo=request.getParameter("codigoCli");
				 boolean isNumber=isNumeric(codigo);
				 int code=0;
				 if(isNumber) {
					 code= Integer.parseInt(codigo);
				 }
					 
				 ArrayList<cliente> lista=  (ArrayList<cliente>) sesion.getAttribute("clientes");
				 cliente value = new cliente();
				
				 try {
					 if(!lista.isEmpty()) {
							
					 }else {
						 lista  = new caja(con).getClientes();
					 }
					 } catch (Exception e) {
						 lista  = new caja(con).getClientes();
				   			e.printStackTrace();
				   		}
				 for(cliente cli : lista) {
					 if(isNumber) {
						 if (cli.getId()==code) {
					        	value = cli;
					        	break;
					        }
					 }else {
						 if (cli.getCedula().equals(codigo)) {
					        	value = cli;
					        	break;
					        }else if (cli.getEmail().equals(codigo)){
					        	value = cli;
					        	break;
					        }
					 	} 
				    }
				 
				 String clientejson = this.gson.toJson(value);
				 System.out.println(clientejson);
				 response.setContentType("application/json");
				 response.setCharacterEncoding("UTF-8");
				 response.getWriter().write(clientejson);
			 }else if(accion.equals("CrearFactura")) {
				 ArrayList<cliente> lista = new caja(con).getClientes();
				 ArrayList<Producto> listaProd = new inventario(con).getproductos();
					if (lista.isEmpty()) {
						
					}else {
						
						request.setAttribute("clientesR", lista);
						sesion.setAttribute("clientes",lista);
					}
					
					
					if (listaProd.isEmpty()) {
						
					}else {
						System.out.println(listaProd.size());
						sesion.setAttribute("inventario",listaProd);
						request.setAttribute("productos", listaProd);
					}
					
				 getServletContext().getRequestDispatcher(rutaJsp+"/cajera/Facturar/CrearFactura.jsp").forward(request,response);
			 }
			
		}
		else {
			getServletContext().getRequestDispatcher(rutaJsp+"/Admin/Administrador.jsp").forward(request,response);
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
			 if (accion.equals("AddClient")){
				 String nombre=request.getParameter("nombre");
				 String apellido=request.getParameter("apellido");
				 String cedula=request.getParameter("cedula");
				 String celular=request.getParameter("celular");
				 String email=request.getParameter("email");
				 String direccion=request.getParameter("direccion");
				 
				 if(nombre==""|| apellido=="" || email=="" || cedula=="" || direccion=="") {
					 getServletContext().getRequestDispatcher(rutaJsp+"/cajera/addClient/addClient.jsp").forward(request,response);
				 }
				 caja obj = new caja(con);
					
				cliente cl = new cliente(nombre, apellido, cedula, email, celular, direccion);
					
					 
					 if(!obj.CheckClientName(email, cedula)) {
						 if(obj.crearCliente(cl)) {
							 request.setAttribute("addClientResponse","Cliente creado correctamente");
						 }
						 else {
							 request.setAttribute("addClientResponse","Error al crear el cliente");
						 }
					 }else {
						 request.setAttribute("addClientResponse","El cliente ya existe (cedula o email)");
					 }
					 getServletContext().getRequestDispatcher(rutaJsp+"/cajera/addClient/PostAddClient.jsp").forward(request,response);
			 }else  if (accion.equals("updateClientPost")) {
				 
				 String codigo=request.getParameter("id");
				 String nombre=request.getParameter("nombre");
				 String apellido=request.getParameter("apellido");
				 String cedula=request.getParameter("cedula");
				 String celular=request.getParameter("celular");
				 String email=request.getParameter("email");
				 String direccion=request.getParameter("direccion");
				 boolean isNumber=isNumeric(codigo);
				 int code=0;
				 if(isNumber) {
					 code= Integer.parseInt(codigo);
				 }
				 if(codigo!=""|| nombre==""|| apellido=="" || email=="" || cedula=="" || direccion=="") {
					 System.out.println(codigo);
					 //getServletContext().getRequestDispatcher(rutaJsp+"/cajera/updateClient/UpdateClient.jsp").forward(request,response);
				 }
				 caja obj = new caja(con);
				 cliente cli = new cliente(code,nombre, apellido, cedula, email, celular, direccion);
					
				 //if(!obj.CheckClientName(email, cedula)) {
					 if(obj.UpdateInventario(cli)) {
						 request.setAttribute("updateClientResponse","Cliente actualiZado correctamente");
					 }
					 else {
						 request.setAttribute("updateClientResponse","Error al actualiZar el cliente");
					 }
				 //}else {
					// request.setAttribute("updateClientResponse","La cedula o c ya existe (cedula o email)");
				// } 
					 ArrayList<cliente> lista  = new caja(con).getClientes();
					 
					 if (lista.isEmpty()) {
							
						}else {
							
							sesion.setAttribute("clientes",lista);
							request.setAttribute("tablaCliente",lista);
						}
					 getServletContext().getRequestDispatcher(rutaJsp+"/cajera/updateClient/respuestaUpdateClient.jsp").forward(request,response);
					
			 }
		}
		else {
			getServletContext().getRequestDispatcher(rutaJsp+"login.jsp").forward(request,response);
		}
	}
	public static boolean isNumeric(String strNum) {
	    if (strNum == null) {
	        return false;
	    }
	    try {
	        double d = Double.parseDouble(strNum);
	    } catch (NumberFormatException nfe) {
	        return false;
	    }
	    return true;
	}

}
