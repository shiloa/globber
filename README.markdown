# fnmatch

Perform string matching with glob syntax.

## DESCRIPTION:

This gem provides a simple wrapper around the the `fnmatch` GNU C library. The `fnmatch` lib provides simple tools to find so called "glob" syntax matches on strings. 

## FEATURES/PROBLEMS:

* Currently supports only case insensitive search. Future flags will be added to support all native options of the C lib.

## TODO:

1. Add strict type checking, argument validation and errors where applicable.
2. Add bit flag integration to fully the fnmatch C lib.
3. Extend the capabilites to add search/find capabilities given a pattern and an array of strings, etc.

## REQUIREMENTS:

* A working gcc compiler.
* Ruby header files (ruby.h). Should be available if using RVM or by installing some form of `ruby-dev` package on your linux / mac distro. Try google.

## INSTALL:

At the moment, you'll have to do this manually (until this is a gem)

Someday, perhaps this:
```ruby
  gem install fnmatch
```

## USE:
```ruby
require 'fnmatch'

# match a single string with a glob pattern
FNMatch.fnmatch('john', '*hn') # => true
FNMatch.fnmatch('john', 'hn')  # => false

# this goes the other way too
FNMatch.fnmatch_r('*hn', 'john') # => true

# match a single string with a list of patterns
FNMatch.fnmatch_any_pat('john', ['*hn', 'boe', 'pi*p']) # => true
FNMatch.fnmatch_any_pat('john', ['hn', 'boe',  'pi*p']) # => false

# you could also do this with a single pattern and a list of strings
FNMatch.fnmatch_any_str('*hn', ['john', 'sam', 'jeeves']) # => true
FNMatch.fnmatch_any_str('*hn', ['amy', 'sue',  'sally'])  # => false

```

## LICENSE:

(The MIT License)

Copyright (c) 2011 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
