
import $ from 'jquery';

$(document).on('turbolinks:load', function() {
  $('a#data-form-prepend').on(
    'click',
      function() {
          console.log("la fonciton est appelée")
          var obj = $($(this).attr("data-form-prepend"));
          var newid = new Date().getSeconds();
          newid = newid + 100;
          obj.find("input, select, textarea").each(function() {
            $(this).attr("name", function() {
              return $(this)
                .attr("name")
                .replace("new_record", newid);
            });
          });
          obj.insertBefore(this);
          return false;
      }
  );
});


  