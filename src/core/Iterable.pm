my class Iterable { # declared in BOOTSTRAP
    # class Iterable is Any {

    method elems()    { self.list.elems }
    method item($self:) { $self }

    method fmt($format = '%s', $separator = ' ') {
        self.list.fmt($format, $separator)
    }

    method Int()      { self.elems }
    method Num()      { self.elems.Num }
    multi method Numeric(Iterable:D:)  { self.elems }
    multi method Str(Iterable:D:)      { self.list.Str }
}

# vim: ft=perl6 expandtab sw=4
