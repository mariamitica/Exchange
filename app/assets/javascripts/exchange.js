var Exchange = {
  init : function(){
    var me=this;
    $('.btn').on('click', function(event){
       event.preventDefault();
       me.convert();
    });
  },

  convert: function(){
    $.ajax({
      url:  "/convert",
      data:{
          original_currency: $('select[name=original_currency]').val(),
          amount: $('input[name=amount]').val(),
          destination_currency:  $('select[name=destination_currency]').val()
      },
      dataType:"script"
      });
  }
};
