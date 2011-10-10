# globber

Perform string matching with glob syntax. 

## DESCRIPTION:

This gem provides a simple wrapper around the the `fnmatch` GNU C library. The `fnmatch` lib provides simple tools to find so called "glob" syntax matches on strings. 

<div style="display: block; color: red;">
  This code is still <b>VERY</b> immature, so don't use in production unless you have nothing to lose.
</div>

## FEATURES/PROBLEMS:

* Currently supports only case insensitive search. Hopefully, module flags will be added soon to support all native options of the C lib.

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

```sh
$ gem install globber
```

Until then, do it the old fashion way:

```sh
$ git clone https://github.com/shiloa/globber
$ cd globber
$ rake compile
```

## Loading:
Promise this will get easier when I find some time.

```ruby
# path to globber.so file (don't include the '.so' part)
require 'path/to/globber/lib/globber/globber'

# go crazy.
```

## USE:
```ruby
require 'globber'

# match a single string with a glob pattern
Globber.match('john', '*hn') # => true
Globber.match('john', 'hn')  # => false

# match a single string with a list of patterns
Globber.match_any_pattern('john', ['*hn', 'boe', 'pi*p']) # => true
Globber.match_any_pattern('john', ['hn', 'boe',  'pi*p']) # => false

# you could also do this with a single pattern and a list of strings
Globber.match_any_string('*hn', ['john', 'sam', 'jeeves']) # => true
Globber.match_any_string('*hn', ['amy', 'sue',  'sally'])  # => false
```

## DEV:
Feel free to fork, knife or spoon this repo any way you see fit (keep it G-rated, though). Don't judge me based on the code, I'm generally a nice guy.

## LICENSE:

(The MIT License)

Copyright (c) 2011 

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
