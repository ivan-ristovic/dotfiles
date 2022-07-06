function palette() {
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

function beep() {
    beep_v > /dev/null 2>&1
}

function beep_v() {
    speaker-test -f 1000 --test sine -l 1 & sleep .2 && kill -9 $!
}

function mp3gain_all() {
   fd -g \*.mp3 -X mp3gain -g $@ 
}

function flac2mp3() {
    fd -t f -e flac -x ffmpeg -i "{}" -qscale:a 0 "{.}.mp3"
}

function trim() {
    sed 's/^ *//; s/ *$//; /^$/d' $@
}

function until-err() {
    "$@"
    while [ $? -eq 0 ]; do
        "$@"
    done
}

function until-suc() {
    "$@"
    while [ $? -ne 0 ]; do
        "$@"
    done
}


# http://djm.me/ask
function ask()
{
    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read REPLY </dev/tty
        sleep 1

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY="$default"
        fi

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

