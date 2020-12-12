package com.proyecto;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.proyecto.modelo.beans.Administrador;
import com.proyecto.modelo.beans.login;

/**
 * Servlet implementation class Servlet
 */
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String rutaJsp;
	private DataSource ds;
	private Connection con;  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Servlet() {
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
			 if(accion.equals("login")) {
				 getServletContext().getRequestDispatcher(rutaJsp+"login.jsp").forward(request,response);
			 }
			 else if (accion.equals("inicio")){
				 getServletContext().getRequestDispatcher(rutaJsp+"index.jsp").forward(request,response);
			 }
			 else if (accion.equals("logout")){
				 sesion.invalidate();
				 getServletContext().getRequestDispatcher(rutaJsp+"login.jsp").forward(request,response);
			 }
			/* else if (accion.equals("iniciarSeccion")){
				 getServletContext().getRequestDispatcher(rutaJsp+"postLogin.jsp").forward(request,response);
			 }*/
			
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
				
				if (accion !=null) {
					 if (accion.equals("iniciarSeccion")){
						 String usuario=request.getParameter("email");
						 String password=request.getParameter("password");
						 
						 login userlogin = new login(con);
						 if (userlogin.loginCheck(usuario, password)) {
						 Administrador uselogin = new login(con).getUserRol(usuario, password);
						 //Ambito Request
						 request.setAttribute("usuario",usuario);			 
						 request.setAttribute("password", password);
						 //Ambito Seccion
						 HttpSession sesion = request.getSession();
						 sesion.setAttribute("login",true);
						 
						 if(uselogin.getRolId()==1) {
							 sesion.setAttribute("rol","1");
							 getServletContext().getRequestDispatcher(rutaJsp+"Admin/Administrador.jsp").forward(request,response); 
						 }else if(uselogin.getRolId()==2) {
							 sesion.setAttribute("rol","2");
							 getServletContext().getRequestDispatcher(rutaJsp+"Admin/Administrador.jsp").forward(request,response);
						 }else if(uselogin.getRolId()==3) {
							 sesion.setAttribute("rol","3");
							 getServletContext().getRequestDispatcher(rutaJsp+"Admin/Administrador.jsp").forward(request,response);
						 }
					    }else {
					    	System.out.println("Usuario o Contraseña Incorrecta");
					    	PrintWriter out = response.getWriter();
					    	out.println("<br>");
					    	out.println("Usuario o Contraseña Incorrecta");
					    }
					 }
				}
				else {
					getServletContext().getRequestDispatcher(rutaJsp+"login.jsp").forward(request,response);
				}
	}

}
