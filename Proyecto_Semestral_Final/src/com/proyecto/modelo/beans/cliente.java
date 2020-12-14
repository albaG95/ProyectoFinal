package com.proyecto.modelo.beans;

public class cliente {
 private int Id;
 public int getId() {
	return Id;
}

public void setId(int id) {
	Id = id;
}
private String Nombre;
 private String Apellido;
 private String Cedula;
 private String Email;
 private String Celular;
 private String Direccion;
 public cliente() {
	 super();
 }
 public cliente(String nombre, String apellido, String cedula, String email, String celular, String direccion) {
	super();
	Nombre = nombre;
	Apellido = apellido;
	Cedula = cedula;
	Email = email;
	Celular = celular;
	Direccion = direccion;
}
 public cliente(int id, String nombre, String apellido, String cedula, String email, String celular, String direccion) {
	super();
	Id= id;
	Nombre = nombre;
	Apellido = apellido;
	Cedula = cedula;
	Email = email;
	Celular = celular;
	Direccion = direccion;
}

public String getNombre() {
	return Nombre;
}
public void setNombre(String nombre) {
	Nombre = nombre;
}
public String getApellido() {
	return Apellido;
}
public void setApellido(String apellido) {
	Apellido = apellido;
}
public String getCedula() {
	return Cedula;
}
public void setCedula(String cedula) {
	Cedula = cedula;
}
public String getEmail() {
	return Email;
}
public void setEmail(String email) {
	Email = email;
}
public String getCelular() {
	return Celular;
}
public void setCelular(String celular) {
	Celular = celular;
}
public String getDireccion() {
	return Direccion;
}
public void setDireccion(String direccion) {
	Direccion = direccion;
}
 
}
