lua-utf8
========
[![Actions Status](https://github.com/Gerrard-YNWA/lua-utf8/actions/workflows/ci.yml/badge.svg)](https://github.com/Gerrard-YNWA/lua-utf8/actions)
[![codecov](https://codecov.io/gh/Gerrard-YNWA/lua-utf8/branch/master/graph/badge.svg)](https://codecov.io/gh/Gerrard-YNWA/lua-utf8)
[![License](https://img.shields.io/badge/License-MIT-brightgreen.svg)](LICENSE)


Name
====

lua-utf8, simple, lightweight utf8 lib in pure lua.

Description
===========

This library implements several basic function for utf8 strings in pure lua with no dependency.

* [Methods](#methods)
    * [validate](#validate)
    * [len](#len)
    * [reverse](#reverse)
    * [sub](#sub)

Methods
======

### validate
Validate whether the given string is a valid utf8 string.

`syntax: valid, invalid_pos = utf8.validate(str)`

Args:

  * `str`: string

Returns:

  * `valid` (bool) whether the input string is a valid utf8 string.

  * `invalid_pos` (number) position of the first invalid byte in the given string.

[Back to TOP](#name)

### len
Get the given string len of utf8.

`syntax len, invalid_pos = utf8.len(str)`

Args:

  * `str`: string

Returns:

  * `len` (number) the length of valid utf8 string part.

  * `invalid_pos` (number) position of the first invalid byte in the given string.

[Back to TOP](#name)

### reverse
Reverse a given valid utf8 string.

`syntax s = utf8.reverse(str)`

Args:

  * `str`: string

Returns:

  * `s` (string) a reversed utf8 string of the given string.

[Back to TOP](#name)

### sub
Sub the given valid utf8 string with the given index.

`syntax s = utf8.sub(str, s, e)`

Args:

  * str: string

  * s: number, start index of utf8 character

  * e: number, end index of utf8 character

Returns:

  * `s` (string) utf8 sub string

[Back to TOP](#name)
