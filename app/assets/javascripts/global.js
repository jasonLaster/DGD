
var groups = [{label: "AISES", value: "AISES", id: 980190982}, {label: "AIRES", value: "AIRES", id: 980190981}];

// AUTOCOMPLETE
$(function() {
	$( "#header input" ).autocomplete({
		source: groups,
		select: function(event, ui) {
     $.get(
        "/group/" + ui.item.id,
        function(data){}
      );
		}
	});
});