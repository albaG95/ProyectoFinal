<%@page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>REGISTRO PRODUCTO</title>
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

			<form class="contact1-form validate-form" method="post" action="/Proyecto_Semestral_Final/ServletInventario?accion=ProdutAdd" >
				<span class="contact1-form-title">
					Datos del nuevo producto
				</span>

				<div class="wrap-input1 validate-input" data-validate = "El codigo del producto es requerido">
					<input class="input1" type="text" name="codigo" id="codigo" placeholder="Codigo de producto">
					<span class="shadow-input1"></span>
				</div>
				<div class="wrap-input1 validate-input" data-validate = "El nombre del producto es requerido">
					<input class="input1" type="text" name="name" id="name" placeholder="Nombre de producto">
					<span class="shadow-input1"></span>
				</div>
				<div class="wrap-input1 validate-input" data-validate = "El precio del producto es requerido">
					<input class="input1" type="text" name="precio" id="precio" placeholder="Precio unitario">
					<span class="shadow-input1"></span>
				</div>
				<%if(request.getAttribute("error")!=null){%>
				<div class="wrap-input1 validate-input" >
					<P class="input1"><% out.println(request.getAttribute("error"));%>	</p>
					<span class="shadow-input1"></span>
				</div>
		      <%}%>
				<div class="container-contact1-form-btn">
					<button  class="contact1-form-btn">
						<span>
							Crear Producto
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
	<script src="<%=request.getContextPath()%>/js/mainAddProducto.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	$('#precio').blur(function (e) {
	    this.value = parseFloat((this.value.replace(/(?!-)[^0-9.]/g, "")), 10)
	        .toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,")
	        .toString();
	    if (this.value === 'NaN') {
	        this.value = '';
	    }
	});
});
</script>
</body>
</html>
