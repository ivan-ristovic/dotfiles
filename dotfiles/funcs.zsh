function palette() {
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

function beep() {
    beep_v > /dev/null 2>&1
}

function beep_v() {
    speaker-test -f 1000 --test sine -l 1 & sleep .2 && kill -9 $!
}
