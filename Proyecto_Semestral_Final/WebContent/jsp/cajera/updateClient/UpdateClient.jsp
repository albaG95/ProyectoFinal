<%@page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Update Client</title>
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

			<form class="contact1-form validate-form" method="post" action="/Proyecto_Semestral_Final/ServletCajera?accion=updateClientPost" >
				<span class="contact1-form-title">
					Escriba el numero de cliente, cedula o email
				</span>
				<div class="wrap-input1 input-group mb-5" data-validate = "Para buscar, no puede estar en blanco">
				  <input type="text" class="input1" id="busqueda" name="busqueda" placeholder="Valor de busqueda" 
				  style="
				    height: 50px;
				    padding: 0 30px;
				    border-top-left-radius: 25px;
				    border-bottom-left-radius: 25PX;
				    BORDER-BOTTOM-RIGHT-RADIUS: 0PX;
    				BORDER-TOP-RIGHT-RADIUS: 0PX;
				">
				  <div class="input-group-append">
				    <button class="btn btn-outline-secondary" id="busquedab" style="
					    height: 50px;
					    BORDER-BOTTOM-RIGHT-RADIUS: 25PX;
					    BORDER-TOP-RIGHT-RADIUS: 25PX;
					    background: #57b846;
					    font-family: Montserrat-Bold;
					    font-size: 15px;
					    line-height: 1.5;
					    color: #fff;
					" type="button">Buscar</button>
				  </div>
				  <span class="shadow-input1"></span>
				</div>
				<div class="wrap-input1 validate-input" data-validate = "El campo es requerido">
				 <label for="formGroupExampleInput">Numero de Cliente</label>
					<input class="input1" type="text" name="id" id="id" placeholder="numero cliente">
					<span class="shadow-input1"></span>
				</div>
				<div class="wrap-input1 validate-input" data-validate = "El campo es requerido">
				 <label for="formGroupExampleInput">Nombre</label>
					<input class="input1" type="text" name="nombre" id="nombre" placeholder="Nombre completo">
					<span class="shadow-input1"></span>
				</div>
				<div class="wrap-input1 validate-input" data-validate = "El campo es requerido">
				 <label for="formGroupExampleInput">Apellido</label>
					<input class="input1" type="text" name="apellido" id="apellido" placeholder="Apellido">
					<span class="shadow-input1"></span>
				</div>
				<div class="wrap-input1 validate-input" data-validate = "El campo es requerido">
				 <label for="formGroupExampleInput">Cedula</label>
					<input class="input1" type="text" name="cedula" id="cedula" placeholder="cedula">
					<span class="shadow-input1"></span>
				</div>
				<div class="wrap-input1 validate-input" data-validate = "El campo es requerido">
				 <label for="formGroupExampleInput">Telefono Celular</label>
					<input class="input1" type="text" name="celular" id="celular" placeholder="celular">
					<span class="shadow-input1"></span>
				</div>
				
				<div class="wrap-input1 validate-input" data-validate = "El campo es requerido: ejemplo@abc.com">
				 <label for="formGroupExampleInput">Correo Electronico</label>
					<input class="input1" type="text" name="email" id="email" placeholder="Correo Electrónico">
					<span class="shadow-input1"></span>
				</div>

				<div class="wrap-input1 validate-input" data-validate = "El campo es requerido">
				 <label for="formGroupExampleInput">Direccion</label>
					<textarea class="input1" id="direccion" name="direccion" placeholder="direccion"></textarea>
					<span class="shadow-input1"></span>
				</div>

				<div class="container-contact1-form-btn">
					<button  class="contact1-form-btn">
						<span>
							Actualizar cliente
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
<script type="text/javascript">
$(document).ready(function () {
	  $('#busquedab').click(function () {
	        var selectedValue = $("#busqueda").val();
	        if(selectedValue!=""){
	        	$.get('ServletCajera', {
		        	accion:'getClientesValues',
		            codigoCli : selectedValue
		    }, function(responseText) {
		    	console.log(responseText);
		    	$('#id').val(responseText.Id);
		    	$('#nombre').val(responseText.Nombre);
		    	$('#apellido').val(responseText.Apellido);
		    	$('#cedula').val(responseText.Cedula);
		    	$('#email').val(responseText.Email);
		    	$('#celular').val(responseText.Celular);
		    	$('#direccion').text(responseText.Direccion);
		    });
	        }else{
	        	if(validate2($("#busqueda")) == false){
	                showValidate2($("#busqueda"));
	                check=false;
	            }
	        }
	        });
	    
	  
	  $('#busqueda').each(function(){
	        $(this).focus(function(){
	           hideValidate2(this);
	        });
	    });
});
function validate2 (input) {
   if($(input).val().trim() == ''){
       return false;
   }
}

function showValidate2(input) {
    var thisAlert = $(input).parent();
    $(thisAlert).addClass('alert-validate');
}

function hideValidate2(input) {
    var thisAlert = $(input).parent();

    $(thisAlert).removeClass('alert-validate');
}
</script>
</body>
</html>
