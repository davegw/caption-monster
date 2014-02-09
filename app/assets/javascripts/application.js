// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(function() {
  $('tr').click(function(e) {
    e.preventDefault();
    window.location.href = '/entry/' + $(this).attr("value")
  });
});

$(function() {
  $('.up-vote .arrow').click(function(e) {
    e.preventDefault();
    var id = $(this).closest('.caption').attr('value');
    var upVote = $(this)
    var upVoteCount = parseInt(upVote.next('.count').text().replace("+",""));
    $.ajax({
      url: '/caption/' + id + '/up-vote', 
      type: 'PUT',
      success: function() {
        upVoteCount = '+' + (upVoteCount + 1)
        upVote.next('.count').html(upVoteCount)
        upVote.css('background-color', 'yellow').animate({backgroundColor: '#F7F6C3'}, 1000);
      }
    });
  });
});

$(function() {
  $('.down-vote .arrow').click(function(e) {
    e.preventDefault();
    var id = $(this).closest('.caption').attr('value');
    var downVote = $(this)
    var downVoteCount = parseInt(downVote.next('.count').text().replace("-",""));
    $.ajax({
      url: '/caption/' + id + '/down-vote', 
      type: 'PUT',
      success: function() {
        downVoteCount = '-' + (downVoteCount + 1)
        downVote.next('.count').html(downVoteCount)
        downVote.css('background-color', 'red').animate({backgroundColor: '#FFA07A'}, 1000);
      }
    });
  });
});
