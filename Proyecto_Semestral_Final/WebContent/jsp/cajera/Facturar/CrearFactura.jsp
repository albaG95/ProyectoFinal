<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
 <%@page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>FACTURAR PRODUCTO</title>
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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/vendor/toastr/toastr.min.css">
<style>
    form{
        margin: 20px 0;
    }
    form input, button{
        padding: 5px;
    }
    table{
        width: 100%;
        margin-bottom: 20px;
		border-collapse: collapse;
    }
    table, th, td{
        border: 1px solid #cdcdcd;
    }
    table th, table td{
        padding: 10px;
        text-align: left;
    }
</style>

</head>
<body>

<%@include file="../../barra.jsp" %>
<% int i=0; String color=""; %>
	<div class="contact1">
		<div class="container-contact1">
	
			<form style="width: 100%;">
				<span class="contact1-form-title">
					Creación de factura
				</span>

				
				<div class="row">
					<div class="col">
						 <form>
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
				    <label for="formGroupExampleInput">Cantidad en unidades</label>
					<input class="input1" type="text" name="cantidad" id="cantidad" placeholder="cantidad" >
					<span class="shadow-input1"></span>
				</div>
    	<input type="button" class="contact1-form-btn" id="agregar" value="Agregar">
    </form>
    <table>
        <thead>
            <tr>
                <th>#</th>
                <th>Codigo</th>
                <th>Descripción</th>
                <th>cantidad</th>
                <th>Precio por unidad</th>
                <th>valor</th>
                <th>Eliminar</th>
            </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
					</div>
				</div>
				<div class="container-contact1-form-btn">
				<a class="contact1-form-btn" href="/Proyecto_Semestral_Final/ServletInventario?accion=updateProd">Regresar
					<span>
						<i class="fa fa-long-arrow-left" aria-hidden="true"></i>
					</span>
				</a>
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
	<script src="<%=request.getContextPath()%>/vendor/toastr/toastr.min.js"></script>
	<script >
		$('.js-tilt').tilt({
			scale: 1.1
		})
	</script>
	<script>
    $(document).ready(function(){
        $("#agregar").click(function(){
            var codigo = $("#codigoProducto").val();
            var cantidad = $("#cantidad").val();
          
            var Nombre;
        	var Existencia;
    		var valor;
    		var Total;
    		var precio;
    		if(codigo!=""){ $.get('ServletInventario', {
            	accion:'getProductoValues',
                codigoProd : codigo
		        }, function(responseText) {
		        	Nombre =responseText.Nombre;
		        	Total =responseText.Total;
		            precio =responseText.precio;
		            valor = cantidad*precio;
		            console.log(Total);
		    		console.log(cantidad);
		    		if(Total>=cantidad){
		    			var markup = "<tr><td><input type='checkbox' name='record'></td><td>" + codigo + "</td><td>"+Nombre+"</td><td>" + cantidad +"</td><td>"+precio+"</td><td>"+valor+ "</td><td><a class='btn btn-xs delete-record' data-id='0'><i class='fa fa-trash-o' aria-hidden='true'></i></a></td></tr> ";
		                $("table tbody").append(markup);
		    		}else{
		    			toastr.info('No hay stock suficiente para esta cantidad: '+cantidad)
		    		}
		        });
    		}
    		
            
        });
        
        jQuery(document).delegate('a.delete-record', 'click', function(e) {
             e.preventDefault();    
             
             var didConfirm = confirm("Esta seguro de eliminar esta fila?");
             if (didConfirm == true) {
              
              $(this).parents("tr").remove();
            
            return true;
          } else {
            return false;
          }
        });
    });    
</script>
<!--===============================================================================================-->
</body>
</html>
