package com.cajera;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

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

import com.proyecto.modelo.beans.caja;
import com.proyecto.modelo.beans.cliente;

/**
 * Servlet implementation class ServletCajera
 */
public class ServletCajera extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String rutaJsp;
	private DataSource ds;
	private Connection con; 
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
		String accion = request.getParameter("accion");
		 HttpSession sesion = request.getSession();
		if (accion !=null) {
			 if(accion.equals("createCliente")) {
				 getServletContext().getRequestDispatcher(rutaJsp+"/cajera/addClient/addClient.jsp").forward(request,response);
			 }
			 else if (accion.equals("updateCliente")){
				 getServletContext().getRequestDispatcher(rutaJsp+"/cajera/updateClient/UpdateClient.jsp").forward(request,response);
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
			 }
		}
	}

}
