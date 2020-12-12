package com.admin;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.proyecto.modelo.beans.Administrador;
import com.proyecto.modelo.beans.login;
import com.proyecto.modelo.beans.user;

/**
 * Servlet implementation class AdminUsers
 */
public class AdminUsers extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String rutaJsp;
	private DataSource ds;
	private Connection con; 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminUsers() {
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
			 if(accion.equals("createUser")) {
				 getServletContext().getRequestDispatcher(rutaJsp+"/Admin/Add/CreateUser.jsp").forward(request,response);
			 }
			 else if (accion.equals("updateUser")){
				 getServletContext().getRequestDispatcher(rutaJsp+"/Admin/UpdateUser/UpdateUser.jsp").forward(request,response);
			 }
			 /* else if (accion.equals("logout")){
				 sesion.invalidate();
				 getServletContext().getRequestDispatcher(rutaJsp+"login.jsp").forward(request,response);
			 }
			else if (accion.equals("iniciarSeccion")){
				 getServletContext().getRequestDispatcher(rutaJsp+"postLogin.jsp").forward(request,response);
			 }*/
			
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
			 if (accion.equals("userAdd")){
				 
				 String nombre=request.getParameter("name");
				 String email=request.getParameter("email");
				 String password=request.getParameter("password");
				 String rolId= request.getParameter("rolId");
				 if(nombre=="" || email=="" || password=="" || rolId==null) {
					 getServletContext().getRequestDispatcher(rutaJsp+"/Admin/Add/CreateUser.jsp").forward(request,response);
				 }
				 int rolValue =0;
				 //System.out.println(rolId);
				if(rolId!="" && rolId!=null) {
					rolValue= Integer.parseInt(rolId);
				}
				 Administrador user = new Administrador();
				 user.setNombre(nombre);
				 user.setEmail(email);
				 user.setPassword(password);
				 user.setRolId(rolValue);
				 user.setCon(con);
				 
				 if(!user.CheckUserName()) {
					 if(user.crearUsuario()) {
						 request.setAttribute("addUserResponse","Usuario creado correctamente");
					 }
					 else {
						 request.setAttribute("addUserResponse","Error al crear el usuario");
					 }
				 }else {
					 request.setAttribute("addUserResponse","El usuario ya existe");
				 }
				 getServletContext().getRequestDispatcher(rutaJsp+"/Admin/UpdateUser/PostAddUser.jsp").forward(request,response);
			 }else if(accion.equals("userUpdate")) {
				 String email=request.getParameter("email");
				 Administrador user = new Administrador();
				 Administrador resp = new Administrador();
				 user.setCon(con);
				 user.setEmail(email);
				 resp = user.getusuario();
				// System.out.println(email);
				 if(resp.getId()>0) {
					 request.setAttribute("nombre",resp.getNombre());
					 request.setAttribute("id",resp.getId());
					 request.setAttribute("email",resp.getEmail());
					 //request.setAttribute("password",resp.getPassword());
					 request.setAttribute("estado",resp.getEstados());
					 request.setAttribute("rolId",resp.getRolId());
					 getServletContext().getRequestDispatcher(rutaJsp+"/Admin/UpdateUser/postGetUsuario.jsp").forward(request,response);
				 }else {
					 request.setAttribute("error","Usuario no encontrado");
					 getServletContext().getRequestDispatcher(rutaJsp+"/Admin/UpdateUser/UpdateUser.jsp").forward(request,response);
				 }
			 }else if(accion.equals("userUpdatePost")) {
				 String nombre=request.getParameter("name");
				 String email=request.getParameter("email");
				 String id =request.getParameter("id");
				 String rolId= request.getParameter("rolId");
				 String estado= request.getParameter("estado");
				 Administrador user = new Administrador();
				
				 if(id!="" && id!=null) {
					 user.setId(Integer.parseInt(id));;
					}
				 user.setNombre(nombre);
				 user.setEmail(email);
				 user.setEstados(estado);
				 if(rolId!="" && rolId!=null) {
					 user.setRolId(Integer.parseInt(rolId));;
					}
				 user.setCon(con);
				 if(user.actualiarUsuario()) {
					 request.setAttribute("good","Usuario fue actualiado");
					 getServletContext().getRequestDispatcher(rutaJsp+"/Admin/UpdateUser/UpdateUser.jsp").forward(request,response);
				 }else{
					 request.setAttribute("nombre",user.getNombre());
					 request.setAttribute("id",user.getId());
					 request.setAttribute("email",user.getEmail());
					 //request.setAttribute("password",resp.getPassword());
					 request.setAttribute("estado",user.getEstados());
					 request.setAttribute("rolId",user.getRolId());
					 request.setAttribute("error","Usuario no fue actualiado");
					 getServletContext().getRequestDispatcher(rutaJsp+"/Admin/UpdateUser/postGetUsuario.jsp").forward(request,response);
				 }
			 }
		}
		else {
			getServletContext().getRequestDispatcher(rutaJsp+"login.jsp").forward(request,response);
		}
	}

}
