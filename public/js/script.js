$(function(){

	var show_movies = function(){
		$.get("/search_movie",function(res){
			var respuesta = JSON.parse(res);
			console.log(res);
			$.each(respuesta, function(key,value){
			var newp = $('<p><input type="checkbox" name="' + key + '" />' + value + '</p>');
			$('#cont').append(newp);
			});
		})
	};

	var add_elements = function(){
		var valor= $("#task").val();
		$.post("/send", {key: valor} , function(){
			$('#cont').append($('<p><input type="checkbox" />' + valor + '</p>'));
		});
	};

	var removeChecked = function(evt){
		alert(evt);
	};

	$("#add").click(add_elements);

	$("input[type=checkbox]").on( "click", removeChecked);

	show_movies();
});