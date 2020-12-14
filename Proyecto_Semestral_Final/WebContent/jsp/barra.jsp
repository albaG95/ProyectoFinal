<nav class="navbar navbar-expand-sm bg-dark navbar-dark custom_navBar">
  <!-- Brand/logo -->
  <a class="navbar-brand" href="#">EGPH</a>
  
  <!-- Links -->
  <ul class="navbar-nav">
	<%
	if(session.getAttribute("rol")=="1") {
	%>
	 <li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
	        Administrar Usuarios
	      </a>
	      <div class="dropdown-menu">
	        <a class="dropdown-item" href="<%=request.getContextPath()%>/AdminUsers?accion=createUser">Crear Usuarios</a>
	        <a class="dropdown-item" href="<%=request.getContextPath()%>/AdminUsers?accion=updateUser">Actualizar Usuario</a>
	      </div>
	    </li>
	<%
	} if(session.getAttribute("rol")=="1" || session.getAttribute("rol")=="2") {
	%>
	 <li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
	        Cajera
	      </a>
	      <div class="dropdown-menu">
	        <a class="dropdown-item" href="<%=request.getContextPath()%>/ServletCajera?accion=CrearFactura">Facturar</a>
	        <a class="dropdown-item" href="<%=request.getContextPath()%>/ServletCajera?accion=createCliente">Crear Cliente</a>
	        <a class="dropdown-item" href="<%=request.getContextPath()%>/ServletCajera?accion=updateCliente">Actualizar Cliente</a>
	      </div>
	    </li>
	<%
	} if(session.getAttribute("rol")=="1" || session.getAttribute("rol")=="3") {
	%>
	 <li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
	        Inventario
	      </a>
	      <div class="dropdown-menu">
	        <a class="dropdown-item" href="<%=request.getContextPath()%>/ServletInventario?accion=registroProd">Crear Producto</a>
	        <a class="dropdown-item" href="<%=request.getContextPath()%>/ServletInventario?accion=updateProd">Actualizar Inventario</a>
	      </div>
	    </li>
	<%
	}
	%>
     <li class="nav-item dropdown-menu-right">
      <a href="<%=request.getContextPath()%>/?accion=logout" class="nav-link">Cerrar Sección</a>
    </li>
  </ul>
</nav>