<%@page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Contact V1</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/formulario.css" type="text/css"/>
<!--===============================================================================================-->
	<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/vendor/animate/animate.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/util.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/froms.css">
<!--===============================================================================================-->
</head>
<body>

<%@include file="../../barra.jsp" %>

	<div class="contact1">
		<div class="container-contact1">

			<div class="contact1-pic js-tilt" data-tilt>
				<img src="images/img-03.png" alt="IMG">
			</div>

			<form class="contact1-form validate-form" method="post" action="/Proyecto_Final_AGarrido/AdminUsers?accion=userUpdatePost" >
				<span class="contact1-form-title">
					Datos del usuario
				</span>
				<div class="wrap-input1 validate-input" data-validate = "El id es requerido">
				    <label for="formGroupExampleInput">Id Usuario</label>
					<input class="input1" type="text" name="id" id="id" placeholder="ID" value="<%=request.getAttribute("id")%>">
					<span class="shadow-input1"></span>
				</div>
				<div class="wrap-input1 validate-input" data-validate = "El nombre es requerido">
					<label for="formGroupExampleInput">Nombre Usuario</label>
					<input class="input1" type="text" name="name" id="name" placeholder="Nombre completo" value="<%=request.getAttribute("nombre")%>">
					<span class="shadow-input1"></span>
				</div>

				<div class="wrap-input1 validate-input" data-validate = "El correo es requerido: ejemplo@abc.com">
					<label for="formGroupExampleInput">Correo Usuario</label>
					<input class="input1" type="text" name="email" id="email" placeholder="Correo Electrónico" value="<%=request.getAttribute("email")%>">
					<span class="shadow-input1"></span>
				</div>

				<!--<div class="wrap-input1 validate-input" data-validate = "La contraseña es requerida">
					<label for="formGroupExampleInput">Contraseña Usuario</label>
					<input class="input1" type="text" name="password" id="password" placeholder="Contraseña" value="<%=request.getAttribute("password")%>">
					<span class="shadow-input1"></span>
				</div>-->

				<div class="wrap-input1 validate-input" data-validate = "Tipo de usuario requerido">
					<!--  <textarea class="input1" name="rolId" placeholder="Message"></textarea>
					<span class="shadow-input1"></span>-->
					<label for="formGroupExampleInput">Rol de Usuario</label>
					<select class="input1" style="
						    height: 50px;
						    border-radius: 25px;
						    padding: 0 30px;
						" id="rolId" name="rolId" value="<%=request.getAttribute("rolId")%>">
					    <option value="" disabled selected>Select your option</option>
					    <option value="1"<%if((request.getAttribute("rolId") != null) && request.getAttribute("rolId").equals(1)){ %> selected <%} %>>Administrador</option>
					     <option value="2"<%if((request.getAttribute("rolId") != null) && request.getAttribute("rolId").equals(2)){ %> selected <%} %>>Cajera</option>
					      <option value="3"<%if((request.getAttribute("rolId") != null) && request.getAttribute("rolId").equals(3)){ %> selected <%} %>>Inventario</option>
					</select>
					<span class="shadow-input1"></span>
				</div>
				<div class="wrap-input1 validate-input" data-validate = "Tipo de usuario requerido">
					<label for="formGroupExampleInput">Estado del Usuario</label>
					<select class="input1" style="
						    height: 50px;
						    border-radius: 25px;
						    padding: 0 30px;
						" id="estado" name="estado" value="<%=request.getAttribute("estado")%>">
					    <option value="" disabled selected>Seleccione una opcion</option>
					    <option value="A"<%if((request.getAttribute("estado") != null) && request.getAttribute("estado").equals("A")){ %> selected <%} %>>Activo</option>
					     <option value="B"<%if((request.getAttribute("estado") != null) && request.getAttribute("estado").equals("B")){ %> selected <%} %>>Inactivo</option>
					</select>
					<span class="shadow-input1"></span>
				</div>
				<div class="container-contact1-form-btn">
					<button  class="contact1-form-btn">
						<span>
							Actualizar Usuario
							<i class="fa fa-long-arrow-right" aria-hidden="true"></i>
						</span>
					</button>
					
				</div>
				<%if(request.getAttribute("error")!=null){%>
				<div class="wrap-input1 validate-input" >
					<P class="input1"><% out.println(request.getAttribute("error"));%>	</p>
					<span class="shadow-input1"></span>
				</div>
		      <%}%>
			</form>
			
		</div>
	</div>




<!--===============================================================================================-->
	<script src="<%=request.getContextPath()%>/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="<%=request.getContextPath()%>/vendor/bootstrap/js/popper.js"></script>
	<script src="<%=request.getContextPath()%>/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="<%=request.getContextPath()%>/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="<%=request.getContextPath()%>/vendor/tilt/tilt.jquery.min.js"></script>
	<script >
		$('.js-tilt').tilt({
			scale: 1.1
		})
	</script>
<!--===============================================================================================-->
	<script src="<%=request.getContextPath()%>/js/validateUpdatePost.js"></script>

</body>
</html>
