
   $(document).ready(function(){
      
         $('#name').click(function(){
           $('#name').addClass("active-link");
           $('#priority').removeClass('active-link');
         });
         $('#priority').click(function(){
           $('#priority').addClass("active-link");
           $('#name').removeClass('active-link');
         });
         $('.dropdown-toggle').dropdown()
         $("#new_user").validate(); 
         $("#new_course").validate();
         $('#login_btn').popover({ 
          html : true,
          content: function() {
            return $("#login_form").html();
          }
          
      });
   });

   function showOnly(link)
   {
   // <hr> <div class="VenueMenuRow" id="VIrow" onclick="showOnly('VIContents','VIrow'); return false;">Venue Information</div>
     link = "#"+link;
     $('.Menue').children().each(function () {
         $(this).removeClass('active-link'); // current element
       });
     $(link).addClass("active-link");
    
   }