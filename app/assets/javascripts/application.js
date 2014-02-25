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
//= require_tree .
$(function() {
  $('tr.row-entry, tr.row-caption, .popular-entry').click(function(e) {
    e.preventDefault();
    window.location.href = '/entry/' + $(this).attr("value")
  });
});

// Log the up vote and update the vote count asynchronously.
var upVote = function(countVote) {
  var id = $(countVote).closest('.caption-container').attr('value');
  var upVoteCount = parseInt(countVote.next('.count').text().replace("+",""));
  $.ajax({
    url: '/caption/' + id + '/up-vote', 
    type: 'PUT',
    success: function(response) {
      if (response.success) {
        upVoteCount = '+' + (upVoteCount + 1);
        countVote.next('.count').html(upVoteCount);
        countVote.css('background-color', 'yellow').animate({backgroundColor: '#90EE90'}, 1000);
      }
      else {
        $('.errors').html(response.errors).show();
      }
    }
  });
};

// Log the down vote and update the vote count asynchronously.
var downVote = function(countVote) {
  var id = countVote.closest('.caption-container').attr('value');
  var downVoteCount = parseInt(countVote.next('.count').text().replace("-",""));
  $.ajax({
    url: '/caption/' + id + '/down-vote', 
    type: 'PUT',
    success: function(response) {
      if (response.success) {
        downVoteCount = '-' + (downVoteCount + 1)
        countVote.next('.count').html(downVoteCount)
        countVote.css('background-color', 'orange').animate({backgroundColor: '#FFA07A'}, 1000);
      }
      else {
        $('.errors').html(response.errors).show();
      }
    }
  });
};

// Click handler to prevent same caption from being voted on twice (at least until page is refreshed).
var oneVote = function() {
  $('.vote').on('click', '.votable', function(e) {
    e.preventDefault();
    $('.errors').hide();
    $(this).closest('.vote').find('.votable').removeClass('votable');
    var countVote = $(this);
    if (countVote.parent('.up-vote').length > 0) {
      upVote(countVote);
    }
    else {
      downVote(countVote);
    }
  });
};

$(function() {
  oneVote();
});



// Load function works, but loads via POST, should load via GET
// $(function() {
//   $('select').change(function(event) {
//     $('#captions-here').load(
//       '/caption/sort',
//       {type: $(event.target).val(),
//         entry_id: $('#label_entry_id').val()}
//     );
//   });
// });

$(function() {
  $('select').change(function(event) {
    // Use GET to correctly load request.
    $.get(
      '/caption/sort',
      {type: $(event.target).val(),
        entry_id: $('#label_entry_id').val()},
      function(response) {
        $('#captions-here').html(response);
        oneVote();
      }
    );
  });
});

$(function() {
  $('#show-entry-container .list-group-item.show-captions').toggle();
  $('a.list-group-item.show-captions').click(function(event) {
    $('.list-group-item.show-captions').toggle();
  })
})

$(function() {
  $('#new-caption-container .list-group-item.show-caption-form').toggle();
  $('a.list-group-item.show-caption-form').click(function(event) {
    $('.list-group-item.show-caption-form').toggle();
  })
})
