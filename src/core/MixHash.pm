my class MixHash does Mixy {

    method Mix (:$view) {
        if $view {
            my $mix := nqp::create(Mix);
            $mix.BUILD( :elems(%!elems) );
            $mix;
        }
        else {
            Mix.new-from-pairs(%!elems.values);
        }
    }
    method MixHash { self }
    method Bag     { Bag.new-from-pairs(%!elems.values) }
    method BagHash { BagHash.new-from-pairs(%!elems.values) }

    multi method AT-KEY(MixHash:D: \k) {
        Proxy.new(
          FETCH => {
              my \v := %!elems.AT-KEY(k.WHICH);
              nqp::istype(v,Pair) ?? v.value !! 0;
          },
          STORE => -> $, $value is copy {
              if $value != 0 {
                  (%!elems.AT-KEY(k.WHICH) //= ((k) => 0)).value = $value;
              }
              else {
                  %!elems.DELETE-KEY(k.WHICH);
              }
              $value;
          }
        );
    }
}

# vim: ft=perl6 expandtab sw=4
