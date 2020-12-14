<!DOCTYPE html>
<html lang="en">
<head>
	<title>Add Client</title>
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

			<form class="contact1-form validate-form" method="post" action="/Proyecto_Semestral_Final/ServletCajera?accion=AddClient" >
				<span class="contact1-form-title">
					Datos del nuevo cliente
				</span>

				<div class="wrap-input1 validate-input" data-validate = "El campo es requerido">
					<input class="input1" type="text" name="nombre" id="nombre" placeholder="Nombre completo">
					<span class="shadow-input1"></span>
				</div>
				<div class="wrap-input1 validate-input" data-validate = "El campo es requerido">
					<input class="input1" type="text" name="apellido" id="apellido" placeholder="Apellido">
					<span class="shadow-input1"></span>
				</div>
				<div class="wrap-input1 validate-input" data-validate = "El campo es requerido">
					<input class="input1" type="text" name="cedula" id="cedula" placeholder="cedula">
					<span class="shadow-input1"></span>
				</div>
				<div class="wrap-input1 validate-input" data-validate = "El campo es requerido">
					<input class="input1" type="text" name="celular" id="celular" placeholder="celular">
					<span class="shadow-input1"></span>
				</div>
				
				<div class="wrap-input1 validate-input" data-validate = "El campo es requerido: ejemplo@abc.com">
					<input class="input1" type="text" name="email" id="email" placeholder="Correo Electrónico">
					<span class="shadow-input1"></span>
				</div>

				<div class="wrap-input1 validate-input" data-validate = "El campo es requerido">
					<textarea class="input1" name="direccion" placeholder="direccion"></textarea>
					<span class="shadow-input1"></span>
				</div>

				<div class="container-contact1-form-btn">
					<button  class="contact1-form-btn">
						<span>
							Crear cliente
							<i class="fa fa-long-arrow-right" aria-hidden="true"></i>
						</span>
					</button>
					
				</div>
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
	<script src="<%=request.getContextPath()%>/js/validateAddClient.js"></script>

</body>
</html>
