
$(document).ready(function () {

        $(".expandable-content2b").hide();
        $(".expandable-content12b").hide();
        $(".expandable-heading-trigger").click(function () {
            $(this).next(".expandable-content12b").slideToggle(500);
            $(".expandable-content2b").hide();
            $(".expandable-heading-trigger").hide();
        });
        $(".expandable-heading2-trigger").click(function () {
            $(this).next(".expandable-content2b").slideToggle(500);
            $(".expandable-heading-trigger").show();
            $(".expandable-content12b").hide();
        });
	/*
        $('.jRating').jRating();
        $('.jRating').jRating({
            step: false,
            length: 5, 
            type: 'small' 
        });
        */
        $('#myCarousel').carousel({
        interval: 8000
        })
        $('#featured').carousel({
            interval: 4000
        })
        $('#differentview').carousel({
            interval: 2000
        })
	/*
        $(function () {
            $('#gallery a').lightBox();
        });
        */
        function codeAddress(address) {
        geocoder.geocode({ 'address': address }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                if ("undefined" == typeof (map)) {
                    var myOptions = {
                        zoom: 13,
                        center: results[0].geometry.location,
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    }
                    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
                }

                var marker = new google.maps.Marker({
                    map: map,
                    position: results[0].geometry.location
                });
                map.setCenter(marker.getPosition());

            } else {
                alert("Geocode was not successful for the following reason: " + status);
            }
        });
    }

    var map;
    var geocoder;
    /*
    $(document).ready(function () {
        geocoder = new google.maps.Geocoder();
        var x = document.getElementById('address');
        codeAddress(x.innerHTML);
    });
    
    */
    
    	  
    $('.categories').bind('mouseenter', function() 
    {
	    $('.categoriesNameBackground',this).hide();
	    $('.categoriesNameBackground2',this).show();
	    
    });

    $('.categories').bind('mouseleave', function() {
	    $('.categoriesNameBackground',this).show();
	    $('.categoriesNameBackground2',this).hide();
    });
			
});