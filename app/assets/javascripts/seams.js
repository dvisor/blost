(function( dvisor, $, undefined ) {
  dvisor.util.defineDeep(dvisor, ["blost", "data"], {});
}( window.dvisor = window.dvisor || {}, jQuery ));


(function( page, $, undefined ) {


  page.pageItem = function(options) {
    var that = {};
  
    var listView = typeof options.listView !== 'undefined' ? options.listView : undefined;
    var seamStitchId = typeof options.seamStitchId != 'undefined' ? options.seamStitchId : undefined;
    var offeredPageId = typeof options.offeredPageId !== 'undefined' ? options.offeredPageId : undefined;
    var passage = typeof options.passage !== 'undefined' ? options.passage : "";

    that.base = $("<div>").addClass("page-item").append(
      $("<div>").addClass("controls").append(
        $("<button>").attr("type", "button").addClass("btn btn-default turn-page-to-stitch").html("Stitch").click(function(event) {
          dvisor.blost.seam.ajax.addStitch(
            {
              seam_stitch_id: seamStitchId,
              offered_page_id: offeredPageId,
              position: "after"
            }
          );
        
          //alert("" + seamStitchId +  " " + pageId );
        })
      ).invisible()
    );

    that.base.append(
      $("<div>").addClass("passage").html(passage).click(function(event) {
        // var $pageItems = $("#seam-stitch-page-list li");
        var $pageItems = listView.find(".page-item");
        $pageItems.find(".passage").removeClass("active");
        $pageItems.find(".controls").invisible();

        $(event.target).addClass("active");
        $(event.target).parents("li").find(".controls").visible();
      })
    );

    return that;
  };

}( dvisor.blost.page = dvisor.blost.page || {}, jQuery ));


(function( branch, $, undefined ) {


  branch.branchItem = function(options) {
    var that = {};
  
    var listView = typeof options.listView !== 'undefined' ? options.listView : undefined;
    var seamStitchId = typeof options.seamStitchId != 'undefined' ? options.seamStitchId : undefined;
    var seamId = typeof options.seamId != 'undefined' ? options.seamId : undefined;
    var branchId = typeof options.branchId !== 'undefined' ? options.branchId : undefined;
    var passage = typeof options.passage !== 'undefined' ? options.passage : "";

    that.base = $("<div>").addClass("branch-item").append(
      $("<div>").addClass("controls").append(
        $("<a>").attr("href", "/seams/" + seamId).addClass("btn btn-default view-branch").html("View")
      ).invisible()
    );
    
    that.base.append(
      $("<div>").addClass("passage").html(passage).click(function(event) {
        // var $branchItems = $("#seam-stitch-branch-list li");
        var $branchItems = listView.find(".branch-item");
        $branchItems.find(".passage").removeClass("active");
        $branchItems.find(".controls").invisible();

        $(event.target).addClass("active");
        $(event.target).parents("li").find(".controls").visible();
      })
    );

    return that;
  };

}( dvisor.blost.branch = dvisor.blost.branch || {}, jQuery ));


(function( seam, $, undefined ) {



  // -- Add stitch into seam.
  // seam.addStitch = function(data) {
  //   $("#new-seam-stitch-text").val('');
  //   if( data && data.message ) {
  //     $("#new-seam-stitch").before($("<div>").addClass("seam-stitch").html(data.message));
  //   }
  // };

  // -- Add stitch into seam.
  // seam.offerPage = function(data) {

  // };






  // -- Add branch from seam.
  // seam.addBranch = function(data) {
  //   // $("#new-seam-stitch-text").val('');
  //   // if( data && data.message ) {
  //   //   $("#new-seam-stitch").before($("<div>").addClass("seam-stitch").html(data.message));
  //   // }
  //   alert(data);
  // };

  // seam.updateSeamStitchData = function(data) {
  //   console.log("updateSeamStitchData")
  //   if( data.length ) {
  //     dvisor.util.defineDeep(dvisor.blost.data, ["seamStitches"], {});
  //     dvisor.blost.data.seamStitch = data[0];
  //     $.each(data, function(index, seamStitch) {
  //       dvisor.blost.data.seamStitches[seamStitch.id] = seamStitch;
  //     });
  //   }
  // };

  seam.display = function() {
    var that = {};

    that.show = function() {
      var that = {};

      that.$pageAllTab = $('#seam-stitch-page-tabs a[href="#seam-stitch-page-list-container"]');
      that.$pageNewTab = $('#seam-stitch-page-tabs a[href="#seam-stitch-new-page-container"]');
      that.$newPageText = $('#new-page-text');

      that.$branchAllTab = $('#seam-stitch-branch-tabs a[href="#seam-stitch-branch-list-container"]');
      that.$branchNewTab = $('#seam-stitch-branch-tabs a[href="#seam-stitch-new-branch-container"]');
      that.$startBranchText = $('#new-branch-text');

      that.update = function() {
        var seamStitch = dvisor.blost.data.seam_stitch.data[dvisor.blost.data.seam_stitch.active_ids[0]];

        $("#seam-stitch-text").html(seamStitch.passage);

        var branchList = $("#seam-stitch-branch-list");
        branchList.empty();
        $("#seam-stitch-branch-tab").html("Branches (" + seamStitch.branches.total + ")");
        $.each(seamStitch.branches.data, function(index, branch) {
          var listItem = $("<li>").append(dvisor.blost.branch.branchItem({listView: branchList, seamId: branch.seam_id, seamStitchId: seamStitch.id, branchId: branch.id, passage : branch.passage}).base);//.click(function(event){alert("item");});
            branchList.append(listItem);
          });

        var pageList = $("#seam-stitch-page-list");
        pageList.empty();
        $("#seam-stitch-page-tab").text("Pages (" + seamStitch.offered_pages.total + ")");
        $.each(seamStitch.offered_pages.data, function(index, offeredPage) {
          // -- Build page item with click function.
          var listItem = $("<li>").append(dvisor.blost.page.pageItem({listView:pageList, seamStitchId : seamStitch.id, offeredPageId : offeredPage.id, passage : offeredPage.passage}).base);//.click(function(event){alert("item");});
          pageList.append(listItem);
        });
      };

      return that;
    }();

    return that;
  }();


  // seam.updateSeamStitchDisplay = function() {
  //   var seamStitch = dvisor.blost.data.seam_stitch.data[dvisor.blost.data.seam_stitch.active_ids[0]];
  //   var branchList = $("#seam-stitch-branch-list");

  //   $("#seam-stitch-text").html(seamStitch.passage);
  //   branchList.empty();
  //   $("#seam-stitch-branch-tab").html("Branches (" + seamStitch.branches.total + ")");
  //   $.each(seamStitch.branches.data, function(index, seamStitch) {
  //       var branchItem = $("<li>").append($("<div>").addClass("branch-list-item").html(seamStitch.passage));
  //       branchList.append(branchItem);
  //     });

  //   var pageList = $("#seam-stitch-page-list");
  //   pageList.empty();
  //   $("#seam-stitch-page-tab").text("Pages (" + seamStitch.offered_pages.total + ")");
  //   $.each(seamStitch.offered_pages.data, function(index, offeredPage) {
  //     // -- Build page item with click function.
  //     var listItem = $("<li>").append(dvisor.blost.page.pageItem({listView:pageList, seamStitchId : seamStitch.id, offeredPageId : offeredPage.id, passage : offeredPage.passage}).base);//.click(function(event){alert("item");});
  //     pageList.append(listItem);
  //   });
  // };

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
      seam_id : dvisor.blost.data.seam.active_ids[0]
    };

    // -- Build request data.
    data = $.extend({}, defaultData, data);

    // -- Send through AJAX.
    ajax.sendJSON({
      url: '/seams/' + data.seam_id + '/add_stitch/',
      data: data,
      success: function(data) {
        // dvisor.blost.seam.addStitch(data);
        $.extend(true, dvisor.blost.data, data);
        dvisor.blost.seam.display.show.update();
      }
    });
  };

  ajax.offerPage = function(data) {
    data = dvisor.util.resolve(data, {});

    var defaultData = {
      seam_stitch_id : dvisor.blost.data.seamStitch.active_ids[0]
    };

    // -- Build request data.
    data = $.extend({}, defaultData, data);

    // -- Send through AJAX.
    ajax.sendJSON({
      url: '/seam_stitches/' + data.seam_stitch_id + '/offer_page/',
      data: data,
      success: function(data) {
        $.extend(true, dvisor.blost.data, data);
        dvisor.blost.seam.display.show.update();
        dvisor.blost.seam.display.show.$pageAllTab.tab('show');
        dvisor.blost.seam.display.show.$newPageText.val('');
      }
    });
  };

  ajax.addBranch = function(data) {
    data = dvisor.util.resolve(data, {});

    var defaultData = {
      seam_id : dvisor.blost.data.seam.active_ids[0],
      seam_stitch_id : dvisor.blost.data.seam_stitch.active_ids[0]
    };

    // -- Build request data.
    data = $.extend({}, defaultData, data);

    // -- Send through AJAX.
    ajax.sendJSON({
      url: '/seams/' + data.seam_id + '/add_branch/',
      data: data,
      success: function(data) {
        // dvisor.blost.seam.addBranch(data);
        $.extend(true, dvisor.blost.data, data);
        dvisor.blost.seam.display.show.update();
        dvisor.blost.seam.display.show.$branchAllTab.tab('show');
        dvisor.blost.seam.display.show.$startBranchText.val('');
      }
    });
  };

  ajax.getSeamStitch = function(data) {
    data = dvisor.util.resolve(data, {});

    var defaultData = {
      seam_stitch_id : dvisor.blost.data.seamStitch.active_ids[0],
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
        $.extend(true, dvisor.blost.data, data);
        dvisor.blost.seam.display.show.update();
      }
    });
  }

}( dvisor.blost.seam.ajax = dvisor.blost.seam.ajax || {}, jQuery ));


var ready = function() {
  // dvisor.blost.data.seam = $("#seam-data").data();
  // dvisor.blost.data.seamStitch = $("#seam-stitch-data").data();

  $.extend(true, dvisor.blost.data, $("#data").data());
  dvisor.blost.data.seam_stitch = dvisor.blost.data.seamStitch;
  dvisor.blost.seam.display.show.update();

  var initSeams = function() {
    // dvisor.blost.seam.ajax.getSeamStitch()
  };

  var initPages = function() {
    $("#offer-new-page").click(function(event) {
      dvisor.blost.seam.ajax.offerPage(
        {
          passage: $("#new-page-text").val()
        });
    });
    // $("#seam-stitch-page-list").on('mousewheel', function(event) {
    //   // cross-browser wheel delta
    //   var e = window.event || e; // old IE support
    //   var delta = Math.max(-1, Math.min(1, (e.wheelDelta || -e.detail)));
    //   this.scrollLeft -= (delta * 50);
    //   event.preventDefault();
    // });
  };

  var initBranches = function() {
    $("#start-new-branch").click(function(event) {
      dvisor.blost.seam.ajax.addBranch(
        {
          passage: $("#new-branch-text").val()
        });
    });
  };


  var changeLayout = function(layoutName) {
    switch (layoutName) {
      case "pages":
        $("#seam-stitch-tier4").children().hide();
        $("#seam-stitch-page-container").show();
        break;
      case "branches":
        $("#seam-stitch-tier4").children().hide();
        $("#seam-stitch-branch-container").show();
        break;  
    }
  };

  var init = function() {
    // changeLayout("pages");
    initSeams();
    initPages();
    initBranches();
    $("#promote-page-to-stitch-button").prop("disabled", true);
  };

  init();





  $("#pages-button").click(function(event) {
    changeLayout("pages");
  });

  $("#branches-button").click(function(event) {
    changeLayout("branches");
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

    // -- Set click for next seam stitch button to retrieve via ajax.
    $("#next-seam-stitch").click(function(event) {
      dvisor.blost.seam.ajax.getSeamStitch({
        next : 2
      })
    });

    // -- Set click for prev seam stitch button to retrieve via ajax.
    $("#prev-seam-stitch").click(function(event) {
      dvisor.blost.seam.ajax.getSeamStitch({
        next : -2
      })
    });




};

$(ready);
// $(document).on('page:load', ready);
