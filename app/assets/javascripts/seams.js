(function( dvisor, $, undefined ) {
  dvisor.util.defineDeep(dvisor, ["blost", "data"], {});
}( window.dvisor = window.dvisor || {}, jQuery ));

(function( seam, $, undefined ) {



  // -- Add stitch into seam.
  seam.addStitch = function(data) {
    $("#new-seam-stitch-text").val('');
    if( data && data.message ) {
      $("#new-seam-stitch").before($("<div>").addClass("seam-stitch").html(data.message));
    }
  };

  // -- Add branch from seam.
  seam.addBranch = function(data) {
    // $("#new-seam-stitch-text").val('');
    // if( data && data.message ) {
    //   $("#new-seam-stitch").before($("<div>").addClass("seam-stitch").html(data.message));
    // }
    alert(data);
  };

  seam.updateSeamStitchData = function(data) {
    console.log("updateSeamStitchData")
    if( data.length ) {
      dvisor.blost.data.seamStitch = data[0];
    }
  };

  seam.updateSeamStitchDisplay = function() {
    $("#seam-stitch-text").html(dvisor.blost.data.seamStitch.passage);
    var branchList = $("#seam-stitch-branch-list");
    branchList.empty();
    $.each(dvisor.blost.data.seamStitch.branches, function(index, seamStitch) {
        var branchItem = $("<li>").append($("<div>").addClass("branch-list-item").html(seamStitch.passage));
        branchList.append(branchItem);
      });
  };

}( dvisor.blost.seam = dvisor.blost.seam || {}, jQuery ));

(function( ajax, $, undefined ) {

  ajax.sendJSON = function(options) {
    options = dvisor.util.resolve(options, {});

    // -- Convert data to JSON and send through AJAX.
    $.ajax($.extend({
      type: 'POST',
      //contentType: 'application/json; charset=utf-8',
      //data: JSON.stringify(data),
      dataType: 'json',
    }, options));
  };

  ajax.addStitch = function(data) {
    data = dvisor.util.resolve(data, {});

    var defaultData = {
      seam_id : dvisor.blost.data.seam.id
    };

    // -- Build request data.
    data = $.extend({}, defaultData, data);

    // -- Send through AJAX.
    ajax.sendJSON({
      url: '/seams/' + data.seam_id + '/add_stitch/',
      data: data,
      success: function(data) {
        dvisor.blost.seam.addStitch(data);
      }
    });
  };

  ajax.addBranch = function(data) {
    data = dvisor.util.resolve(data, {});

    var defaultData = {
      seam_id : dvisor.blost.data.seam.id
    };

    // -- Build request data.
    data = $.extend({}, defaultData, data);

    // -- Send through AJAX.
    ajax.sendJSON({
      url: '/seams/' + data.seam_id + '/add_branch/',
      data: data,
      success: function(data) {
        dvisor.blost.seam.addBranch(data);
      }
    });
  };

  ajax.getSeamStitch = function(data) {
    data = dvisor.util.resolve(data, {});

    var defaultData = {
      seam_stitch_id : dvisor.blost.data.seamStitch.id,
      next : 1
    };

    // -- Build request data.
    data = $.extend({}, defaultData, data);

    // -- Send through AJAX.
    ajax.sendJSON({
      type : 'GET',
      url: '/seam_stitches/' + data.seam_stitch_id,
      data: data,
      success: function(data) {
        dvisor.blost.seam.updateSeamStitchData(data);
        dvisor.blost.seam.updateSeamStitchDisplay();
      }
    });
  }

}( dvisor.blost.seam.ajax = dvisor.blost.seam.ajax || {}, jQuery ));


$(function() {
  dvisor.blost.data.seam = $("#seam-data").data();
  dvisor.blost.data.seamStitch = $("#seam-stitch-data").data();


  $("#seam-stitch-page-container").hide();

  $("#pages-button").click(function(event) {
    $("#seam-stitch-tier4").children().hide();
    $("#seam-stitch-page-container").show();
  });

  $("#branches-button").click(function(event) {
    $("#seam-stitch-tier4").children().hide();
    $("#seam-stitch-branch-container").show();
  });


  $("#add-stitch-button").click(function(event) {
    alert("no functionality");
  });

  // -- Track keypress for textarea.
  $("#new-seam-stitch-text").keypress(function(event) {
    if( event.which == 13 ) {
      // -- Enter key pressed.

      dvisor.blost.seam.ajax.addStitch({
        passage: event.target.value});

    }
  });

  $("[id^=branch-seam-stitch-]").filter(function() {
    var matchedId = this.id.match(/branch-seam-stitch-(\d+)-button/);
    dvisor.util.defineDeep(this, ['dvisor', 'blost', 'seamStitch', 'id'], matchedId.pop());
    return this.id.match(/branch-seam-stitch-\d+-button/);
    
    }).click(function(event) {


      // $("[id^=seam-stitch-]").filter(function() {
      //     return this.id.match(/seam-stitch-\d+-right-container/);
      //   }).empty();
      $("[id^=seam-stitch-]").filter(function() {
          return this.id.match(/seam-stitch-\d+-branch-list/);
        }).show();

      var seamStitchId = event.target.dvisor.blost.seamStitch.id;
      $("#seam-stitch-" + seamStitchId + "-branch-container").toggle();


    });

  $("[id^=banch-seam-stitch-]").filter(function() {
    var matchedId = this.id.match(/branch-seam-stitch-(\d+)-button/);
    dvisor.util.defineDeep(this, ['dvisor', 'blost', 'seamStitch', 'id'], matchedId.pop());
    return this.id.match(/branch-seam-stitch-\d+-button/);
    
    }).click(function(event) {
      $(".seam-stitch-branch-text").remove();

      // alert(event.target.dvisor.blost.seamStitch.id);
      // $("#seam-stitch-" + seamStitchId + "-right-container").html("branch on " + seamStitchId);

      branchTextJQ = $("<textarea>").addClass("seam-stitch-branch-text").appendTo($("#seam-stitch-" + seamStitchId + "-right-container"));
      dvisor.util.defineDeep(branchTextJQ[0], ['dvisor', 'blost', 'seamStitch', 'id'], seamStitchId);

      branchTextJQ.keypress(function(event) {
        if( event.which == 13 ) {
          // -- Enter key pressed.

          dvisor.blost.seam.ajax.addBranch({
            seam_stitch_id : event.target.dvisor.blost.seamStitch.id,
            passage: event.target.value});
        }
      });
    });

    $("#next-seam-stitch").click(function(event) {
      dvisor.blost.seam.ajax.getSeamStitch({
        next : 2
      })
    });

    $("#prev-seam-stitch").click(function(event) {
      dvisor.blost.seam.ajax.getSeamStitch({
        next : -2
      })
    });

});