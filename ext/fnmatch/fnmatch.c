//
// This small extension wraps the fnmatch C library,
// to provide simple string matching.
//

#include <stdio.h>
#include <fnmatch.h>
#include <string.h>
#include "ruby.h"

// hack
# define FNM_IGNORE_CASE (1 << 4)


// ~~~~~~~~~~~~~~~~~~~~
// utility functions
// ~~~~~~~~~~~~~~~~~~~~

//
// return the type of a value as a cString
//
const char * rb_type_name(VALUE val)
{
  const char * type;

  switch( TYPE(val) ) {
    case T_OBJECT:
      type = "ordinary object";
      break;
    case T_CLASS:
      type = "class";
      break;
    case T_MODULE:	
      type = "module";
      break;
    case T_FLOAT:		
      type = "floating point number";
      break;
    case T_STRING:	
      type = "string";
      break;
    case T_REGEXP:
      type = "regular expression";
      break;
    case T_ARRAY:		
      type = "array";
      break;
    case T_HASH:		
      type = "associative array";
      break;
    case T_STRUCT:	
      type = "(Ruby) structure";
      break;
    case T_BIGNUM:	
      type = "multi precision integer";
      break;
    case T_FIXNUM:	
      type = "Fixnum";
      break;
    //case T_COMPLEX:       
    //  type = "complex number";
    //  break;
    //case T_RATIONAL:      
    //  type = "rational number";
    //  break;
    case T_FILE:		
      type = "IO";
      break;
    case T_TRUE:		
      type = "true";
      break;
    case T_FALSE:		
      type = "false";
      break;
    case T_DATA:		
      type = "data";
      break;
    case T_SYMBOL:        
      type = "symbol";
      break;
    default:
      type = "unknown";
      break;
  }
}
//
// check the datatype of the value and
// raise an error if it doesn't match
//
void check_type(VALUE val, VALUE type, const char * varname)
{
  const char * actual   = rb_type_name(val);
  const char * expected = rb_type_name(type);
  
  if ( TYPE(val) != type )
  {
    rb_raise(rb_eTypeError, "value provided for %s is invalid (got %s, expected %s)!", varname, actual, expected);
  }
}


// ~~~~~~~~~~~~~~~~~~~~
// Module functions
// ~~~~~~~~~~~~~~~~~~~~

// Match against a single pattern
// USE:
// >> require 'fnmatch'
// >> FNMatch.match('john', '*hn')
// => true
// >> FNMatch.match('johnny', 'hn')
// => false
// >> FNMatch.match('jim', '*hn')
// => false
//
static VALUE fnm_match(VALUE self, VALUE str, VALUE pat)
{
  // sanity
  check_type(str, T_STRING, "str");
  check_type(pat, T_STRING, "pat");

	// same for the string
	const char * string  = RSTRING_PTR( str );

  // convert ruby pattern string to c type
  const char * pattern = RSTRING_PTR( pat );

  // perform matching based on the preferred direction
	int	match = fnmatch( pattern, string, FNM_IGNORE_CASE );
	
  // fnmatch returns 0 if glob match was found
  if ( match == 0 ) {
    return Qtrue;
  }
  
  return Qfalse;
}

//
// Do the same as above, but assume the first argument
// is the glob pattern (reversed order of args):
// >> require 'fnmatch'
// >> FNMatch.match_r('*hn', 'john')
// => true
//
static VALUE fnm_match_r(VALUE self, VALUE pat, VALUE str)
{
  // sanity
  check_type(str, T_STRING, "str");
  check_type(pat, T_STRING, "pat");

	return fnm_match(self, str, pat);
}

//
// match a string against a list of patterns and return true
// if any match found
// USE:
// >> require 'fnmatch'
// >> FNMatch.match_any_pattern('john', ['*hn', '*bo*', 'am'])
// => true
// >> FNMatch.match_any_pattern('jack', ['*hn', '*bo*', 'am'])
// => false
//
static VALUE fnm_match_any_pattern(VALUE self, VALUE str, VALUE patterns)
{
  // sanity
  check_type(str, T_STRING, "str");
  check_type(patterns, T_ARRAY, "patterns");

  // here we assume 'patterns' is a ruby array, so we need to
  // decide how long it is and then get a pointer to the first
  // element and go through each cell to check for matches with
  // our original string 
  int p_len = RARRAY_LEN( patterns );

  // these are the loop counter and the match tracker
  int i;
	VALUE match = Qfalse,	pattern;

  // get a VALUE ptr to the first element
  VALUE * p_arr = RARRAY_PTR( patterns );

  // go through each element and try to match
  for ( i = 0 ; i < p_len ; ++i )
  {
		// the current pattern
    pattern = p_arr[i];
    
    // perform the actual matching
		match = fnm_match(self, str, pattern);

    // fnmatch returns 0 if glob match was found
    if ( match == Qtrue ) {
      return Qtrue;
    }
	}

  return Qfalse;
}

//
// same as above, but reversed:
// >> require 'fnmatch'
// >> FNMatch.match_any_string('*hn', ['john', 'bill', 'bob'])
// => true
// >> FNMatch.match_any_string('*hn', ['jake', 'jim', 'sam'])
// => false
//
static VALUE fnm_match_any_string(VALUE self, VALUE pattern, VALUE strings)
{
  // sanity
  check_type(pattern, T_STRING, "pattern");
  check_type(strings, T_ARRAY, "strings");

  int s_len = RARRAY_LEN( strings );

  // these are the loop counter and the match tracker
  int i;
	VALUE match = Qfalse,	string;

  // get a VALUE ptr to the first element
  VALUE * s_arr = RARRAY_PTR( strings );

  // go through each element and try to match
  for ( i = 0 ; i < s_len ; ++i )
  {
		// the current string
    string = s_arr[i];
    
    // perform the actual matching
		match = fnm_match(self, string, pattern);

    // fnmatch returns 0 if glob match was found
    if ( match == Qtrue ) {
      return Qtrue;
    }
	}

  return Qfalse;
}

// ~~~~~~~~~~~~~~~~~~~~
// Core ruby stuff
// ~~~~~~~~~~~~~~~~~~~~

VALUE mFNMatch;

// connect everything to actual Ruby
void Init_fnmatch()
{
  // create a ruby class instance
  mFNMatch = rb_define_module("FNMatch");

  // connect the instance methods to the module
  // (accepts the method name, pointer to C implementation
  // and the number of arguments
  rb_define_singleton_method(mFNMatch, "match"            , fnm_match            , 2);
  rb_define_singleton_method(mFNMatch, "match_r"          , fnm_match_r          , 2);
  rb_define_singleton_method(mFNMatch, "match_any_pattern", fnm_match_any_pattern, 2);
  rb_define_singleton_method(mFNMatch, "match_any_string" , fnm_match_any_string , 2);
}




