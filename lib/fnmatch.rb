require 'fnmatch/fnmatch'

module FNMatch
  VERSION = '0.0.1'

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
end
