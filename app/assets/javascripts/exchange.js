var Exchange = {
  init : function(){
    var me=this;
    $('.btn').on('click', function(event){
       event.preventDefault();
       me.convert();
    });
  },

  convert: function(){
      $('.error').hide();
      $('input[name=amount]').removeClass('inputError');
      $('input[name=result]').val('');
      this.ajax_call($('select[name=original_currency]').val(), $('input[name=amount]').val(), $('select[name=destination_currency]').val());
  },

  ajax_call: function(original_currency, amount, destination_currency){
      $.ajax({
          url:  "/convert",
          data:{
              original_currency: original_currency,
              amount: amount,
              destination_currency: destination_currency,
          },
          dataType:"script"
      });
  }
};
