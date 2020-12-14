<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
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
<% int i=0; String color=""; %>
	<div class="contact1">
		<div class="container-contact1">
			<form style="width: 100%;">
				<span class="contact1-form-title">
					Inventario de productos
				</span>

				<div class="wrap-input1 validate-input" >
					<P class="input1"><% out.println(request.getAttribute("upProdResponse"));%>	</p>
					<span class="shadow-input1"></span>
				</div>
				<div class="row">
					<div class="col">
						<table class="table table-sm table-hover table-bordered table-responsive-lg">
							<thead>
								<tr>
									<th>Codigo</th>
									<th>Nombre</th>
									<th>Precio</th>
									<th>Cantidad inicial</th>
									<th>Cantidad Vendida</th>
									<th>Cantidad stock</th>
								</tr>
							</thead>
							<c:forEach items="${productos}" var="objeto">
							<%  if (i==0){ 
									color="table-success";
									i=1;
								}else {
									color="bg-primary text-white";
									i=0;
								}
							
							%>	
								<tr class="<%=color%>">
									<td><c:out value="${objeto.codigo}"/></td>
									<td><c:out value="${objeto.nombre}"/></td>
									<td><c:out value="${objeto.precio}"/></td>
									<td><c:out value="${objeto.existencia}"/></td>
									<td><c:out value="${objeto.vendidos}"/></td>
									<td><c:out value="${objeto.total}"/></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div class="container-contact1-form-btn">
					<button class="contact1-form-btn">
						<span>
							<a href="/Proyecto_Semestral_Final/ServletInventario?accion=updateProd">Regresar</a>
							<i class="fa fa-long-arrow-left" aria-hidden="true"></i>
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
</body>
</html>
