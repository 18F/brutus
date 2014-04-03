$(function () {
	// TODO: update to query on all .fetch-app
	var app_id = $('.fetch-app').data('appid');
	if (app_id) {
		$.ajax({
			url: '/app_details/'+app_id,
			type: 'GET',
			contentType: 'application/json',
			success: function (result) {
				$('.fetch-app').data('details',result);
				fields = result.fields;
				for (var i=0;i<fields.length;i++) {
					var field = fields[i];
					$('<div class="field"><span class="label">'+field['label']+'</span><span class="value">'+result.application[field['name']]+'</span><br clear="both" /></div>').insertBefore('.fetch-app');
				}
				$('.loading').hide();
			},
			error: function (e) {
				$('<p class="error">An error has occurred fetching the application details.</p>').insertAfter('.fetch-app');
				$('.loading').hide();
			}
		});
	}

	$('#sync').click(function (e) {
		var rand = Math.floor((Math.random()*100)+1);
		e.preventDefault();
		$.ajax({
			url: '/sync?no_cache='+rand,
			type: 'GET',
			contentType: 'application/json',
			success: function (result) {
				alert(result.responseText);
				// console.log(document.location);
				window.location.href = window.document.location+"?sync=success&no_cache="+rand;
			},
			error: function (exc) {
				// alert(exc.responseText);
				console.log(exc.responseText);
			}
		});
		return false;
	});
});