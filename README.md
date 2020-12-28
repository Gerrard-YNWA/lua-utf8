Name
====

lua-utf8, utf8 tool lib for lua.

Description
===========

This library implements several basic function for utf8 strings in pure lua.

* [Methods](#methods)
    * [validate](#validate)
    * [len](#len)
    * [reverse](#reverse)
    * [sub](#sub)

Methods
======

### validate
Check the given string is a valid utf8 string.

`syntax: valid, invalid_pos = utf8.validate(str)`

Args:
  str: string

Returns:
  (bool) whether the input string is a valid utf8 string.
  (number) position of the first invalid byte if given.

[Back to TOP](#name)

### len
Get the given string len of utf8.
`syntax len, invalid_pos = utf8.len(str)`

Args:
  str: string

Returns:
  (number) the length of valid utf8 string part.
  (number) position of the first invalid byte if given.

[Back to TOP](#name)

### reverse
Reverse the given valid utf8 string.
`syntax s = utf8.reverse(str)`

Args:
  str: string

Returns:
  (string) a reversed utf8 string of the given string.

[Back to TOP](#name)

### sub
Sub the given valid utf8 string with the given index.
`syntax s = utf8.sub(str, s, e)`

Args:
  str: string
  s: number, start index of utf8 character
  e: number, end index of utf8 character

Returns:
  (string) utf8 sub string

[Back to TOP](#name)
