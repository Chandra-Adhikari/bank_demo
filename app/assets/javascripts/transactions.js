 $(document).ready(function(){
 	$('#data').datepicker({
        "setDate": new Date(),
        format: 'dd/mm/yyyy',
        "autoclose": true
    });


 	$("#new_transaction").validate({
	  onkeyup: function(element) {$(element).valid()},
	  onclick: false,
	    rules: {
	      "transaction[amount]": {
	        required: true,
	        minlength: 1,
	        digits: true,
	        maxlength: 5
	      }
	     
     },
      messages: {
      'transaction[amount]': {remote: 'Insufficient Balance', maxlength: "Transaction value should be less than 1000000" }
      },
      submitHandler: function(form) {
        form.submit();
      }
	});
});