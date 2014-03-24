$(function () {
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
		})

	}


	// $.ajax({
 //    url: '//api.tumblr.com/v2/blog/' + blog + '/posts/text?notes_info=true&limit=3&filter=text&api_key=cA9agkd1WdAsFUFL5iq1Wnn0m4Dmcv5vf5otES3Ou08r2D3Ldu',
 //    type: 'GET',
 //    contentType: 'application/json',
 //    dataType: 'jsonp',
 //    jsonpCallback: 'jsonp',
 //    success: function (result) {
 //      $("#blog-loading").hide();
 //      for (i in result.response.posts) {
 //        // render post to the page
 //        var post = result.response.posts[i];
 //        $('#blog' + i + ' .blog-title').html(post.title);
 //        $('#blog' + i + ' .blog-title').attr('href', post.post_url);
 //        $('#blog' + i + ' .blog-text').html(post.body);
 //        $('#blog' + i + ' .readmore').attr('href', post.post_url);
 //        var tagHtml = '';
 //        for (j in post.tags) {
 //          if (j != 0) {
 //            tagHtml += ', ';
 //          }
 //          tagHtml += '<a href="http://' + blog + '/tagged/' + encodeURIComponent(post.tags[j]) + '">' + post.tags[j] + '</a>';
 //        }
 //        $('#blog' + i + ' .blog-tags').html(tagHtml);
 //        var d = new Date(post.timestamp * 1000);
 //        var date = months[d.getMonth()] + ' ' + d.getDate() + ', ' + d.getFullYear();
 //        $('#blog' + i + ' .blog-date').html(date);
 //        $('#blog' + i).show();
 //      }
 //      $(".blog-snippet").dotdotdot({
 //        watch: "window",
 //        after: "a.readmore"
 //      });
 //    },
 //    error: function (e) {
 //      $("#blog-loading .error").show();
 //    }
 //  });
});