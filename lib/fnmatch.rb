require 'fnmatch/fnmatch'

=begin rdoc
== About
This gem provides a very basic wrapper around the fnmatch C-lib available on most 'nix installs. 

== Motivation
When you need to do some basic matching and regular expressions are too to expensive for performance (for me, this was done while processing thousands of DB rows). If you need something beyond the basic glob syntax (you know, like you use in the shell), then this is not for you.

== NOTE
<b>Module flags are still BUGGY</b> - so matching works for case _INSENSITIVE_ matching <b>only</b>.

== INSTALL
Through rubygems - 
    gem install fnmatch

== API
All function calls are currently called as module singleton methods.

== FNMatch.match(string, pattern, [optional-flags])
Match against a single pattern

Arguments:
  string  - the string to check for matches.
  pattern - the glob pattern to match against.
  flags   - optional module flags to include in the processing. 

USE:
    >> require 'fnmatch'
    >> FNMatch.match('john', '*hn')
    => true
    >> FNMatch.match('johnny', 'hn')
    => false
    >> FNMatch.match('jim', '*hn')
    => false

== FNMatch.match_r(pattern, string, [optional-flags])
Do the same as above, but assume the first argument
is the glob pattern (reversed order of args):

Arguments:
  pattern - the glob pattern to match against.
  string  - the string to check for matches.
  flags   - optional module flags to include in the processing. 

USE:
    >> require 'fnmatch'
    >> FNMatch.match_r('*hn', 'john')
    => true


== FNMatch.match_any_pattern(string, patterns, [optional-flags])
match a string against a list of patterns and return true if <b>any</b> match was found.

Arguments:
  string   - the string to check for matches.
  patterns - an array of glob pattern to match against.
  flags    - optional module flags to include in the processing. 

USE:
    >> require 'fnmatch'
    >> FNMatch.match_any_pattern('john', ['*hn', '*bo*', 'am'])
    => true
    >> FNMatch.match_any_pattern('jack', ['*hn', '*bo*', 'am'])
    => false


== FNMatch.match_any_string(pattern, strings, [optional-flags])
same as above, but reversed (one pattern, many strings):
  
Arguments:
  pattern - the glob pattern to match against.
  strings - an array of strings to check for matches.
  flags   - optional module flags to include in the processing. 

USE:
    >> require 'fnmatch'
    >> FNMatch.match_any_string('*hn', ['john', 'bill', 'bob'])
    => true
    >> FNMatch.match_any_string('*hn', ['jake', 'jim', 'sam'])
    => false
=end

module FNMatch
  VERSION = '0.1.0'

  #****************************************
  # fnmatch flags
  #****************************************
  
  # If this flag is set, match a slash in string only with 
  # a slash in pattern and not by an asterisk (*) or a question 
  # mark (?) metacharacter, nor by a bracket expression ([])
  # containing a slash. 
  FNM_PATHNAME = ( 1 << 0 )

  # If this flag is set, treat backslash as an ordinary character,
  # instead of an escape character. 
  FNM_NOESCAPE = ( 1 << 1 )

  # If this flag is set, a leading period in string has to be
  # matched exactly by a period in pattern. A period is considered
  # to be leading if it is the first character in string, 
  # or if both FNM_PATHNAME is set and the period immediately 
  # follows a slash. 
  FNM_PERIOD   = ( 1 << 2 )

  # If this flag (a GNU extension) is set, the pattern is 
  # matched case-insensitively. 
  FNM_IGNORE_CASE = ( 1 << 4 )

  # def match(string, pattern, *flags)
  # end
end
