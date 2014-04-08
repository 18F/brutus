$(function () {
	// TODO: update to query on all .fetch-app
	var app_id = $('.fetch-app').data('appid');
	if (app_id) {
		$.ajax({
			url: '/admin/app_details/'+app_id,
			type: 'GET',
			contentType: 'application/json',
			success: function (result) {
				$('.fetch-app').data('details',result);
				var _$details = $('<div id="details-'+app_id+'"><h4>General Information</h4></div>')
				console.log(result);
				var fields = result.fields;
				for (var i=0;i<fields.length;i++) {
					var field = fields[i];
					if (field)
						_$details.append('<div class="field"><span class="label">'+field+'</span><span class="value">'+result.application[field]+'</span><br clear="both" /></div>')
				}
				_$details.append('<br /><br /><h4>Projects</h4>');
				var projects = result.projects;
				for (var i=0;i<projects.length;i++) {
					var project = projects[i];
					for (var project_name in project) {
						_$details.append('<div class="field"><span class="label">'+project_name+'</span><span class="value">'+project[project_name]+'</span><br clear="both" /></div>')	
					}
				}
				$('.loading').hide();
				$(_$details).insertBefore('.fetch-app');
				$(_$details).linkify();
			},
			error: function (e) {
				$('<p class="error">An error has occurred fetching the application details.</p>').insertAfter('.fetch-app');
				console.log(e);
				$('.loading').hide();
			}
		});
	}

	$('#sync').click(function (e) {
		var rand = Math.floor((Math.random()*1000)+1);
		e.preventDefault();
		$.ajax({
			url: '/admin/sync?no_cache='+rand,
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