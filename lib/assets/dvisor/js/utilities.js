(function( dvisor, $, undefined ) {
}( window.dvisor = window.dvisor || {}, jQuery ));

(function( util, $, undefined ) {

  util.resolve = function(arg, def) {
    return typeof arg === 'undefined' ? def : arg;
  }

  // -------------------------------------------------------------------------
  /** isObject TAKEN FROM YAHOO YUI VERSION 2.7.0b - build/yahoo/yahoo.js
   ** Replaces YAHOO.lang.isFunction() with Object.isFunction() from
        prototype.js
   * Determines whether or not the provided object is of type object
        or function
   * @method isObject
   * @param {any} o The object being testing
   * @return {boolean} the result
   */
  // -------------------------------------------------------------------------
  util.isObject = function(o) {
    return (o && (typeof o === 'object' || Object.isFunction(o))) || false;
  };
  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  /** Taken from http://www.inventpartners.com/content/javascript_is_int
      with slight modifcations
   */
  // -------------------------------------------------------------------------
  util.isInt = function(value) {
    if( (parseFloat(value) === parseInt(value)) && !isNaN(parseInt(value)) ) {
      return true;
    } else {
      return false;
    }
  };
  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.isNonWhiteSpaceString = function(s) {
    return Object.isString(s) && !s.match(/^\s*$/);
  };
  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.isStringOtherThanWhiteSpace = function(s) {
    return this.isNonWhiteSpaceString(s);
  };
  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.transferXMLAttributesToElement = function(sourceXMLNode, targetElement, attributes) {
    for( var attribIndex = 0; attribIndex < attributes.length; ++attribIndex ) {
    
      var sourceAttribute = attributes[attribIndex];
      var sourceAttributeValue = sourceXMLNode.getAttribute(sourceAttribute);
      if( util.isDefinedAndNotNull(sourceAttributeValue) ) {
        targetElement.writeAttribute(sourceAttribute, sourceAttributeValue);
      }        
    }
    return targetElement;
  };
  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.extendDeep = function( originalVariable, unknownVariable, overwrite ) {
    var currentIndex, property, unknownVariableKeys;

    if( Object.isUndefined(unknownVariable) ) {

    } else if( unknownVariable === null ) {
      return null;
    } else {

      if( Object.isHash(unknownVariable) ||
          Object.isArray(unknownVariable) ||
          Object.isNumber(unknownVariable) ||
          Object.isString(unknownVariable) ||
          Object.isElement(unknownVariable) ||
          Object.isFunction(unknownVariable) ) {

        return unknownVariable;
      } else {
        if( util.isDefinedAndNotNull(originalVariable) &&
            !Object.isArray(originalVariable) &&
            typeof originalVariable === "object" &&
            originalVariable !== unknownVariable ) {

            for( property in unknownVariable ) {
              if( Object.isUndefined(originalVariable[property]) ) {
                originalVariable[property] = unknownVariable[property];
              } else {
                if( overwrite ) {
                  originalVariable[property] = util.extendDeep(
                    originalVariable[property],
                    unknownVariable[property],
                    overwrite);
                } else {
                  util.extendDeep(originalVariable[property],
                    unknownVariable[property],
                    overwrite);
                }
              }
            }
          } else {
            return unknownVariable;
          }
        }
      }
    return originalVariable;
  };

  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.mergeDeep = function( originalVariable, unknownVariable ) {
    var currentIndex, property, unknownVariableKeys;

    if( Object.isUndefined(unknownVariable) ) {

    } else if( unknownVariable === null ) {
      return null;
    } else {

      if( Object.isNumber(unknownVariable) ||
          Object.isString(unknownVariable) ||
          Object.isElement(unknownVariable) ||
          Object.isFunction(unknownVariable) ) {

        return unknownVariable;
      } else if( Object.isArray(unknownVariable) ) {
        if( Object.isArray(originalVariable) &&
            originalVariable !== unknownVariable ) {

          for( currentIndex = 0; currentIndex < unknownVariable.length; ++currentIndex ) {          
            if( !Object.isUndefined(unknownVariable[currentIndex]) ) {
              if( Object.isUndefined( originalVariable[currentIndex]) ) {
                originalVariable[currentIndex] = unknownVariable[currentIndex];
              } else {
                originalVariable[currentIndex] = util.mergeDeep(
                  originalVariable[currentIndex],
                  unknownVariable[currentIndex]);
              }
            }
          } 
        } else {
          return unknownVariable;
        }
      } else if( Object.isHash(unknownVariable) ) {
        if( Object.isHash(originalVariable) &&
            originalVariable !== unknownVariable ) {

          unknownVariableKeys = unknownVariable.keys();
          for( currentIndex = 0; currentIndex < unknownVariableKeys.length; ++currentIndex ) {
            if( Object.isUndefined(originalVariable.get(unknownVariableKeys[currentIndex])) ) {
              originalVariable.set(unknownVariableKeys[currentIndex], unknownVariable.get(
                unknownVariableKeys[currentIndex]));
            } else {
              originalVariable.set(unknownVariableKeys[currentIndex],
                util.mergeDeep(originalVariable.get(unknownVariableKeys[currentIndex]),
                  unknownVariable.get(unknownVariableKeys[currentIndex])));
            }
          }
        } else {
          return unknownVariable;
        }
      } else {
        if( util.isDefinedAndNotNull(originalVariable) &&
            !Object.isArray(originalVariable) &&
            typeof originalVariable === "object" &&
            originalVariable !== unknownVariable ) {

          for( property in unknownVariable ) {
            if( Object.isUndefined(originalVariable[property]) ) {
              originalVariable[property] = unknownVariable[property];
            } else {
              originalVariable[property] = util.mergeDeep(originalVariable[property],
                unknownVariable[property]);
            }
          }
        } else {
          return unknownVariable;
        }
      }
    }
  
    return originalVariable;

  };

  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.cloneDeep = function( unknownVariable ) {
    var processedVariable, currentIndex, property, unknownVariableKeys;

    if( Object.isNumber(unknownVariable) ||
        Object.isString(unknownVariable) ||
        Object.isElement(unknownVariable) ||
        Object.isFunction(unknownVariable) ||
        Object.isUndefined(unknownVariable) ||
        unknownVariable === null ) {

      processedVariable = unknownVariable;
    } else if( Object.isArray(unknownVariable) ) {
      processedVariable = [];
      for( currentIndex = 0;
          currentIndex < unknownVariable.length;
          ++currentIndex ) {

        processedVariable[currentIndex] =
        util.cloneDeep(unknownVariable[currentIndex]);
      } 
    }
    else if( Object.isHash(unknownVariable) ) {
      processedVariable = $H();
      unknownVariableKeys = unknownVariable.keys();
      for( currentIndex = 0;
        currentIndex < unknownVariableKeys.length;
        ++currentIndex ) {
      
        processedVariable.set(
          unknownVariableKeys[currentIndex],
          util.cloneDeep(
            unknownVariable.get(unknownVariableKeys[currentIndex])));
      } 
    } else {
      processedVariable = {};
      for( property in unknownVariable ) {
        processedVariable[property] = util.cloneDeep(unknownVariable[property]);
      }
    }

    return processedVariable;

  };


  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.defineDeep = function(targetObj, propertyList, value) {
    var currentObj = targetObj;
    var lastKeyIndex = propertyList.length - 1;
    for( var propertyIndex = 0;
         propertyIndex < lastKeyIndex;
         ++propertyIndex ) {

      var currentProperty = propertyList[propertyIndex];
      if( !util.isObject(currentObj[currentProperty]) ) {
        currentObj[currentProperty] = {};
      }
    
      currentObj = currentObj[currentProperty];
    }
    currentObj[propertyList[lastKeyIndex]] = value;
    return currentObj;
  };

  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.isDefinedAndNotNull = function(obj) {
    return !Object.isUndefined(obj) && obj !== null;
  };


  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.isDefinedDeepAndNotNull = function(originalObject, properties) {
    definedDeepResult = util.definedDeep(originalObject, properties);
    if( definedDeepResult['fullyDefined'] &&
        util.isDefinedAndNotNull(definedDeepResult['lastDefinedValue']) ) {

      return true;
    } else {
      return false;
    }
  };

  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.definedDeep = function(originalObject, properties) {

    var propertyArray;
    var propertyArrayLen;
    var propertyIndex;
    var finalPropertyDefined;
    var currentBaseObject;
    var lastDefinedProperty;

    if( util.isDefinedAndNotNull(originalObject) ) {
    
      if( Object.isString(properties) ) {
        //properties = properties.replace(/^\s*\.*/,'');
        //properties = properties.replace(/\.*\s*$/,'');
        //properties = properties.split('.');
        propertyArray =
          properties.replace(/^\s*\.*/,'').replace(/^\.*\s*$/,'').split('.');
      } else if( Object.isArray(properties) ) {
        propertyArray = properties;
      } else {
        return { 
          fullyDefined : false,
          lastDefinedValue : originalObject,
          lastDefinedProperty : null,
          lastDefinedPropertyIndex : -1
        };
      }

      propertyArrayLen = propertyArray.length;
      if( propertyArrayLen === 0 ) {
        return { 
          fullyDefined : false,
          lastDefinedValue : originalObject,
          lastDefinedProperty : null,
          lastDefinedPropertyIndex : -1
        };
      }

      finalPropertyDefined = true;
      currentBaseObject = originalObject;
      propertyIndex = 0;
      while( propertyIndex < propertyArrayLen && finalPropertyDefined) {

        if( Object.isUndefined(
              currentBaseObject[propertyArray[propertyIndex]]) ) {
          finalPropertyDefined = false;
        } else {
          currentBaseObject =
            currentBaseObject[propertyArray[propertyIndex]];
          ++propertyIndex;
        }
      }

      propertyIndex -= 1;
      lastDefinedProperty = propertyIndex < 0 ?
        null : propertyArray[propertyIndex];

      return { 
        fullyDefined : finalPropertyDefined,
        lastDefinedValue : currentBaseObject,
        lastDefinedProperty : lastDefinedProperty,
        lastDefinedPropertyIndex : propertyIndex
      };

    }

    return { 
      fullyDefined : false,
      lastDefinedValue : null,
      lastDefinedProperty : null,
      lastDefinedPropertyIndex : -1
    };
  };


  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.newSelectElement = function(argObj) {
    var that = {};
    var sCIndex;

    that.selectElementProperties = argObj.selectElementProperties || null;
    that.selectOptions = argObj.selectOptions || null;

    if( that.selectOptions && that.selectOptions.length > 0 ) {
      that.selectElement = new Element('select', that.selectElementProperties);
      for( sCIndex = 0; sCIndex < that.selectOptions.length; ++sCIndex ) {
        currentSelOpt = that.selectOptions[sCIndex];
        that.selectElement.appendChild(
          new Element('option',
            { value : currentSelOpt}
            ).update(currentSelOpt)
          );
      }
    
    }

    return that.selectElement;
  };

  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.getChildrenByTagName = function(parent, targetTagName) {
      
    var validChildren = [];

    targetTagName = targetTagName || null;
    parent = parent || null;
    if( targetTagName === null || parent === null ) {
        return validChildren;
    }
    var children = parent.childNodes || [];
    
    for( var childIndex = 0;
        childIndex < children.length;
        ++childIndex ) {
        
      var child = children[childIndex];
      var tagName = child.tagName || null;

      if( tagName === targetTagName ) {
        validChildren.push(child);   
      }
    }

    return validChildren;

  };
  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.replaceChildrenOfParentElement = function(parentElement, newChildrenElementArray) {
    var newChiElementIndex;

    while( parentElement.hasChildNodes() ) {
      parentElement.removeChild(parentElement.firstChild);
    }

    if( Object.isArray(newChildrenElementArray) ) {
      for( newChiElementIndex = 0;
           newChiElementIndex < newChildrenElementArray.length;
           ++newChiElementIndex ) {

        Object.isElement(newChildrenElementArray[newChiElementIndex]) &&
          parentElement.appendChild(newChildrenElementArray[newChiElementIndex]);
      }
    }
  };

  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.objectMaskUpdate = function(dest_obj, src_obj, mask_keys, extendEnabled) {
    if( dest_obj && src_obj ) {
      var dest_keys = Object.keys(dest_obj);
      //var dest_clone_obj = dest_obj.clone();
      var src_keys = Object.keys(src_obj);
      var src_clone_obj = Object.clone(src_obj);
      var restricted = util.isDefinedAndNotNull(extendEnabled) ?
        extendEnabled : false;

      var temp_array, mask_key_index, current_mask_key, src_key_index;
      var current_src_key;

      if( !Object.isArray(mask_keys) ) {
        mask_keys = dest_keys;
      } else if( !extendEnabled ) {
        temp_array = [];
        for( mask_key_index = 0;
            mask_key_index < mask_keys.length;
            ++mask_key_index ) {

          current_mask_key = mask_keys[mask_key_index];
          if( dest_keys.indexOf(current_mask_key) > -1 ) {
            temp_array.push(current_mask_key);
          }
        }
        mask_keys = temp_array;
      }

      for( src_key_index = 0;
          src_key_index < src_keys.length;
          ++src_key_index ) {

        current_src_key = src_keys[src_key_index];
        if( mask_keys.indexOf(current_src_key) < 0 ) {
          delete src_clone_obj[current_src_key];
        }
      }

      return Object.extend(dest_obj, src_clone_obj);
    } else {
      return null;
    }

  };

  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.hashMaskUpdate = function(dest_hash, src_hash, mask_keys) {
    var dest_keys = dest_hash.keys();
    //var dest_clone_hash = dest_hash.clone();
    var src_keys = src_hash.keys();
    var src_clone_hash = src_hash.clone();

    var temp_array, mask_key_index, current_mask_key, src_key_index;
    var current_src_key;

    if( typeof mask_keys == "undefined" ) {
      mask_keys = dest_keys;
    } else {
      temp_array = new Array();
      for( mask_key_index = 0;
          mask_key_index < mask_keys.length;
          ++mask_key_index ) {

        current_mask_key = mask_keys[mask_key_index];
        if( dest_keys.indexOf(current_mask_key) > -1 ) {
          temp_array.push(current_mask_key);
        }
      }
    
      mask_keys = temp_array;
    }

    for( src_key_index = 0;
        src_key_index < src_keys.length;
        ++src_key_index ) {

      current_src_key = src_keys[src_key_index];
      if( mask_keys.indexOf(current_src_key) < 0 ) {
        src_clone_hash.unset(current_src_key);
      }
    }

    return dest_hash.merge(src_clone_hash);
  };


  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.standardNumeric = function(a, b) {
    return a - b;
  };


  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.isEmail = function(str) {
    // are regular expressions supported?
    var supported = 0;
    var tempStr, tempReg, r1, r2;


    if (window.RegExp) {
      tempStr = "a";
      tempReg = new RegExp(tempStr);
      if (tempReg.test(tempStr)) supported = 1;
    }

    if (!supported) 
      return (str.indexOf(".") > 2) && (str.indexOf("@") > 0);

    r1 = new RegExp("(@.*@)|(\\.\\.)|(@\\.)|(^\\.)");
    r2 = new RegExp("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\." +
      "([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$");

    return (!r1.test(str) && r2.test(str));
  };


  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.getDateToday = function() {
    //displaying the current date
    //dayName = new Array ("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
    var monName = new Array("January", "February", "March", "April", "May",
      "June", "July", "August", "September",
      "October", "November", "December");
    var now = new Date;
    var now_date = monName[now.getMonth()] + " " + now.getDate() + ", " +
      now.getFullYear();

    return now_date;
  };

  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.removeChildFromParent = function(target_child, target_parent) {
    if( target_child ) {
      target_parent.removeChild(target_child);
    }
  };

  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.numberRange = function(start, stop, step) {
    if( arguments.length === 1 && start ) {
      stop = start;
      start = 0;
    }


    if( arguments.length < 3 ) {
      if( start <= stop ) {
        step = 1;
      } else {
        step = -1;
      }
    } else if( step === 0 ) {
      return [];
    }


    var arr = [];
    if( step > 0 ) {
      for( var i=start; i < stop; i += step ) {
        arr.push(i);
      }
    } else {
      for( var i=start; i > stop; i += step ) {
        arr.push(i);
      }
    }

    return arr;
  };

  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.loopRange = function(lower, upper, initial, step) {
    var sequenceList = [];
    var sequenceCountLimit = initial + upper - lower;
    for( var sequenceIndex = initial;
        sequenceIndex <= sequenceCountLimit;
        ++sequenceIndex ) {

      if( sequenceIndex <= upper ) {
        sequenceList.push(sequenceIndex);
      } else {
        sequenceList.push(sequenceIndex-upper-1);
      }
    }

    return sequenceList;

  };
  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  util.escapeXML = function(target) {
    return target.replace(/&/g,'&amp;').replace(/</g,'&lt;').
      replace(/>/g,'&gt;').replace(/\"/g,'&quot;').
      replace(/\'/g,'&apos;');
  };

  // -------------------------------------------------------------------------

}( window.dvisor.util = window.dvisor.util || {}, jQuery ));