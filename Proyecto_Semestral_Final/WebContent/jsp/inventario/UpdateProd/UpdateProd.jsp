<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>ACTUALIZAR PRODUCTO</title>
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

			<form class="contact1-form validate-form" method="post" action="/Proyecto_Semestral_Final/ServletInventario?accion=UpdateProd" >
				<span class="contact1-form-title">
					Lista de Productos
				</span>
                <div class="wrap-input1 validate-input" data-validate = "Tipo de usuario requerido">
					<label for="formGroupExampleInput">Seleccione el producto</label>
					<select class="input1" style="
						    height: 50px;
						    border-radius: 25px;
						    padding: 0 30px;
						" id="codigoProducto" name="codigoProducto" >
					    <option value="" disabled selected>Seleccione una opcion</option>	   
					    <c:forEach items="${productos}" var="prod">
				        <option value="${prod.codigo}">${prod.nombre}</option>
				    </c:forEach>
					</select>
					<span class="shadow-input1"></span>
				</div>
				<div class="wrap-input1 validate-input" data-validate = "Campo requerido">
				    <label for="formGroupExampleInput">Código Producto</label>
					<input class="input1" type="text" name="codigo" id="codigo" placeholder="codigo" >
					<span class="shadow-input1"></span>
				</div>
				
				<div class="wrap-input1 validate-input" data-validate = "Campo requerido">
				    <label for="formGroupExampleInput">Nombre Producto</label>
					<input class="input1" type="text" name="nombre" id="nombre" placeholder="nombre" >
					<span class="shadow-input1"></span>
				</div>
				
				<div class="wrap-input1 validate-input" data-validate = "Campo requerido">
				    <label for="formGroupExampleInput">Cantidad inicial</label>
					<input class="input1" type="text" name="existencia" id="existencia" placeholder="cantidad inicial" >
					<span class="shadow-input1"></span>
				</div>
				
				<div class="wrap-input1 validate-input" data-validate = "Campo requerido">
				    <label for="formGroupExampleInput">Cantidad Vendida</label>
					<input class="input1" type="text" name="Vendidos" id="Vendidos" placeholder="vendidos" >
					<span class="shadow-input1"></span>
				</div>
				
				<div class="wrap-input1 validate-input" data-validate = "Campo requerido">
				    <label for="formGroupExampleInput">Cantidad stock</label>
					<input class="input1" type="text" name="stock" id="stock" placeholder="stock" >
					<span class="shadow-input1"></span>
				</div>
				<div class="wrap-input1 validate-input" data-validate = "Campo requerido">
				    <label for="formGroupExampleInput">Precio unitario</label>
					<input class="input1" type="text" name="precio" id="precio" placeholder="precio" >
					<span class="shadow-input1"></span>
				</div>
				<div class="container-contact1-form-btn">
					<button  class="contact1-form-btn">
						<span>
							Actualizar Producto
							<i class="fa fa-long-arrow-right" aria-hidden="true"></i>
						</span>
					</button>
					
				</div>
				<%if(request.getAttribute("error")!=null){%>
				<div class="wrap-input1 validate-input" >
					<P class="input1"><% out.println(request.getAttribute("error"));%>	</p>
					<span class="shadow-input1"></span>
				</div>
		      <%} if(request.getAttribute("good")!=null){%>
				<div class="wrap-input1 validate-input" >
					<P class="input1"><% out.println(request.getAttribute("good"));%>	</p>
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
	<script src="<%=request.getContextPath()%>/js/validateUpdate.js"></script>
    <script type="text/javascript">
    $("#codigoProducto").change(function () {
        var selectedValue = $(this).val();
        
        $.get('ServletInventario', {
        	accion:'getProductoValues',
            codigoProd : selectedValue
    }, function(responseText) {
    	console.log(responseText);
    	$('#codigo').val(responseText.Codigo);
    	$('#nombre').val(responseText.Nombre);
    	$('#existencia').val(responseText.Existencia);
    	$('#Vendidos').val(responseText.Vendidos);
    	$('#stock').val(responseText.Total);
    	$('#precio').val(responseText.precio);
    });
    });
    </script>
</body>
</html>
