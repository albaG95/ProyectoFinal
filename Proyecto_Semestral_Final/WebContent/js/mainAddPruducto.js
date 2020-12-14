
(function ($) {
    "use strict";

    
    /*==================================================================
    [ Validate ]*/
    var name = $('.validate-input input[name="name"]');
    var codigo = $('.validate-input input[name="codigo"]');
    var precio = $('.validate-input input[name="precio"]');
    //var roles = $('.validate-input textarea[name="rolId"]');
    $('.validate-form').on('submit',function(){
        var check = true;

        if($(name).val().trim() == ''){
            showValidate(name);
            check=false;
        }

        if($(codigo).val().trim() == ''){
            showValidate(codigo);
            check=false;
        }

		if($(precio).val().trim() == ''){
            showValidate(precio);
            check=false;
        }
        return check;
    });


    $('.validate-form .input1').each(function(){
        $(this).focus(function(){
           hideValidate(this);
       });
    });

    function showValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).addClass('alert-validate');
    }

    function hideValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).removeClass('alert-validate');
    }
    
    

})(jQuery);