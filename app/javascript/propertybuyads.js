
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

$(document).on('turbolinks:load', function() {
  $(document).on ("click",'[data-behavior=showfixed]',function() {
        console.log(this.value + " " + this.id);
        var rewardPro = document.getElementById("div_rewardPro")
        var rewardInt = document.getElementById("div_rewardInd")
        var rewardProPercent = document.getElementById("div_rewardProPercent")
        var rewardIntPercent = document.getElementById("div_rewardIndPercent")

        if (this.value)
        {
          rewardPro.style.display = "block"
          rewardInt.style.display = "block"
          rewardProPercent.style.display = "none"
          rewardIntPercent.style.display = "none"
        }
      }
  );  
});


$(document).on('turbolinks:load', function() {
  $(document).on ("click",'[data-behavior=showpercent]',function() {
        console.log(this.value + " " + this.id);
        var rewardPro = document.getElementById("div_rewardPro")
        var rewardInt = document.getElementById("div_rewardInd")
        var rewardProPercent = document.getElementById("div_rewardProPercent")
        var rewardIntPercent = document.getElementById("div_rewardIndPercent")

        if (this.value)
        {
          rewardPro.style.display = "none"
          rewardInt.style.display = "none"
          rewardProPercent.style.display = "block"
          rewardIntPercent.style.display = "block"
        }
      }
  );  
});


// $(document).on('turbolinks:load', function() {
//   document.getElementById('propertybuyad_classifiedad_attributes_fixedreward_true').addEventListener("change", e=>{
//     e.preventDefault();
//     console.log("la fonciton est appelée");
//     return true;
//   });
  
// });


  