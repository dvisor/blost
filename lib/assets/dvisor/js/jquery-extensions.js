(function ( $ ) {

  // ----------------------------------------------------------------------------
  // Provided by James Padolsey under Unlicense.
  // http://james.padolsey.com/javascript/regex-selector-for-jquery/
  // Adds regex to jQuery selector.
  $.expr[':'].regex = function(elem, index, match) {
      var matchParams = match[3].split(','),
          validLabels = /^(data|css):/,
          attr = {
              method: matchParams[0].match(validLabels) ? 
                          matchParams[0].split(':')[0] : 'attr',
              property: matchParams.shift().replace(validLabels,'')
          },
          regexFlags = 'ig',
          regex = new RegExp(matchParams.join('').replace(/^\s+|\s+$/g,''), regexFlags);
      return regex.test(jQuery(elem)[attr.method](attr.property));
  };
  // ----------------------------------------------------------------------------


  $.fn.visible = function() {
    return this.each(function() {
      $(this).css('visibility', 'visible');
    });
  };

  $.fn.invisible = function() {
    return this.each(function() {
      $(this).css('visibility', 'hidden');
    });
  };

  $.fn.visibilityToggle = function() {
    return this.each(function() {
      $(this).css('visibility', function(i, visibility) {
        return (visibility == 'visible') ? 'hidden' : 'visible';
      });
    });
  };

}( jQuery ));