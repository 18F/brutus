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
					var _field = fields[i];
					console.log(_field);
					// console.log(_field[1])
					var _value = result.application[Object.keys(_field)[0]]|| '';
					var _label = _field[Object.keys(_field)[0]];
					console.log(_value);
					if (_field)
						_$details.append('<div class="field"><span class="label">'+_label+'</span><span class="value">'+_value+'</span><br clear="both" /></div>')
				}
				_$details.append('<br /><br /><h4>Projects</h4>');
				var projects = result.projects;
				for (var i=0;i<projects.length;i++) {
					var _project = projects[i];
					for (var _project_name in _project) {
						var _project_justification = _project[_project_name] || '';
						_$details.append('<div class="field"><span class="label">'+_project_name+'</span><span class="value">'+_project_justification+'</span><br clear="both" /></div>')	
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
    min: 0,
    max: 5,
    step: 1,

    slide: function ( event, ui ) {
    	var _score = ui.value;
    	$(this).find('.cpc').each( function () {
    		$(this).val( _score );
    	});
    	$(this).find('.score-num').each( function () {
    		$(this).html( _score );
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


  // DASHBOARD
  $( '.ajax_flagged_apps' ).each(function () {
  	var _url = '/admin/fetch_flagged_apps/'
  	var _tag_list = $(this).data('tag_list');
  	var _$div = $(this);
  		_url = _url + "?tag_list=" + _tag_list;
  	$.ajax({
			url: _url,
			type: 'GET',
			contentType: 'application/json',
			async: true,
			success: function (result) {
				_$div.html(result);
				_$div.removeClass('loading');
				if (result.length == 0) {
					_$div.html('<span class="blank_slate">Nothing flagged for follow-up at this time.</span>');
				} else {
					_$div.html('<ul></ul>');
					_$list = _$div.find('ul');
					for (var _i = 0; _i < result.length; _i++) {
						var _tags = result[_i]['tag_list'];
						var _tag_list = "";
						for (var _t = 0; _t < _tags.length; _t++) {
							_tag_list += "<span class='tag'>" + _tags[_t] + "</span>";
						}
						_$list.append("<li><a href='/admin/applications/" + result[_i]['id'] + "/'>" + result[_i]['name'] + "</a>" + _tag_list + "</li>");
					}
				}
				colorizeTags();
			},
			error: function (exc) {
				_$div.html(result);
				_$div.removeClass('loading');
			}
		});
  });

  // unreviewed/recent apps
  $( '.ajax_recent_apps' ).each(function () {
  	var _url = '/admin/fetch_recent_apps/'
  	var _tag_list = $(this).data('tag_list');
  	var _$div = $(this);
  		_url = _url + "?tag_list=" + _tag_list;
  	$.ajax({
			url: _url,
			type: 'GET',
			contentType: 'application/json',
			async: true,
			success: function (result) {
				_$div.removeClass('loading');
				if (result.length == 0) {
					_$div.html('<span class="blank_slate">Nothing to review at this time.</span>');
				} else {
					_$div.html('<ul></ul>');
					_$list = _$div.find('ul');
					for (var _i = 0; _i < result.length; _i++) {
						var _tags = result[_i]['tag_list'];
						var _tag_list = "";
						for (var _t = 0; _t < _tags.length; _t++) {
							_tag_list += "<span class='tag'>" + _tags[_t] + "</span>";
						}
						_$list.append("<li><a href='/admin/applications/" + result[_i]['id'] + "/'>" + result[_i]['name'] + "</a>" + _tag_list + "</li>");
					}
				}
				colorizeTags();
			},
			error: function (exc) {
				_$div.html(exc);
				_$div.removeClass('loading');
			}
		});
  });

  // recent reviews
  $( '.ajax_recent_reviews' ).each(function () {
  	var _url = '/admin/fetch_recent_reviews/'
  	var _tag_list = $(this).data('tag_list');
  	var _$div = $(this);
  		_url = _url + "?tag_list=" + _tag_list;
  	$.ajax({
			url: _url,
			type: 'GET',
			contentType: 'application/json',
			async: true,
			success: function (result) {
				_$div.removeClass('loading');
				if (result.length == 0) {
					_$div.html('<span class="blank_slate">No recent reviews at this time.</span>');
				} else {
					_$div.html('<ul></ul>');
					_$list = _$div.find('ul');
					for (var _i = 0; _i < result.length; _i++) {
						_$list.append("<li>" + result[_i]['reviewer']['name'] + " reviewed <a href='/admin/applications/" + result[_i]['application_id'] + "/reviews/" + result[_i]['id'] + "'>" + result[_i]['applicant']['name'] + "</a></li>");
					}
				}
			},
			error: function (exc) {
				_$div.html(exc);
				_$div.removeClass('loading');
			}
		});
  });

  // colorizing tags
  var colorizeTags = function () {
  	$('.tag').each(function () {
	  	var _tag = $(this).html();
	  	var _$elm = $(this);
	  	_$elm.addClass(_tag);
	  });
  }
  colorizeTags();
});



