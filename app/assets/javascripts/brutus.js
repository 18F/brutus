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
			// contentType: 'application/json',
			success: function (result) {
				alert(result.responseText);
				// console.log(document.location);
				window.location.href = window.document.location+"?sync=success&no_cache="+rand;
			},
			error: function (exc) {
				alert(exc.responseText);
				// console.log(exc.responseText);
			}
		});
		return false;
	});

	// sliders
	$( ".score-slider" ).slider({
    value: 0,
    min: 1,
    max: 6,
    step: 1,

    slide: function ( event, ui ) {
    	$(this).find('.cpc').each( function () {
    		$(this).val( ui.value );
    	});
    	$(this).find('.score-num').each( function () {
    		$(this).html( ui.value );
    	});
    	var _desc = $(this).parent().find('.desc-sel')
    	$(this).find('.cpa-desc-'+ui.value).each( function () {
    		var desc = $(this).val();
    		_desc.html(desc);
    	});
    	updateScore();
    },

    start: function( event, ui ) {
    	var _desc = $(this).parent().find('.desc-sel')
    	$(this).find('.cpa-desc-'+ui.value).each( function () {
    		var desc = $(this).val();
    		_desc.html(desc);
    	});
    }

  });

  var updateScore = function () {
  	var _score = 0;
  	var $_remarks_field = $('#review_remarks');
  	var _remarks = []
		$('.cpc').each(function () {
			_score = _score + parseInt($(this).val());
		});
		$('.score-slider').each( function () {
			var _score = $(this).find('.cpc').val();
			var _desc = $(this).find('.cpa-desc-'+_score).val();
			var _name = $(this).find('.cpc-name').val();
			_remarks.push(_name + " - " + _desc);
		});
		_score = _score * 4;
		$('.score').val(_score);
		$('.score-text').html(_score);
		$_remarks_field.val('');
		for (var i = 0;i<=_remarks.length;i++) {
			$_remarks_field.val($_remarks_field.val() + _remarks[i] + '\r\n\r\n');
		}
  }

  $('#review_follow_up').click(function () {
  	if ($(this).is(':checked')) {
  		$('.score').data('score',$(this).val());
  		$('.score').val(0);
  		$('.score-text').html('<span style="color: green;">FLAGGED</span>');
  		// $('.score-slider').hide();
  	} else {
  		updateScore();
  		// $('.score-slider').show();
  	}
  	

  });

  updateScore();
});



