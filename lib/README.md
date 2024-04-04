# Shell scripting library

Contains useful scripting functions. Functions are grouped into modules based on functionality. Function name format:
```sh
module::function
```

Include individual modules or entire lib:
```sh
. include std  # std module
. include os   # os module
. include lib  # entire lib
```

## (Some) examples

All functions that print values can have their output saved in a variable instead of printing it:
```bash
foo=$(str::len "abc")    # foo will be set to "3"
```

### ANSI formatting
```sh
. include ansi

ansi::fg::blue  ; echo "blue text" ; ansi::fg::reset
ansi::fmt::bold ; echo "bold text" ; ansi::fmt::bold_off

ansi::ansi --bold --italic --red --bg-blue
echo "foo bar"
ansi::reset
```

### Strings
```bash
. include str

str::len "abc"         # prints 3
str::is_alpha "a2"     # returns 1 (false)
str::is_alpha "ab"     # returns 0 (true)
str::strip_r "c" "acc" # prints a 
```

### Paths
```bash
. include os

os::path "/foo//bar/./w"  # prints /foo/bar/w
os::path::ext "foo.txt"   # prints txt
```

### Math
```sh
. include math

math::eval "$PI" 2   # prints 3.14
math::eval "$PI/2" 
    | math::sin 
    | math::int      # prints 1

if math::cond "$PI/2 > 1.05"; then
    # ...
fi
```

