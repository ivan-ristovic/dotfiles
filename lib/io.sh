#!/bin/bash

source "$SHLIB_ROOT/assert.sh"

function io::is_dir ()
{
    test::all -d "$@"
}

function io::is_dev ()
{
    test::all -b "$@"
}

function io::is_file ()
{
    test::all -f "$@"
}

function io::readline() 
{
    # Reads symbols from stdin or a file descriptor, until it faced a delimiter
    # or the EOF. The delimiter can be defined. It also doesn't matter if
    # a string ends with a specified  delimiter (by default it's '\n') or not.
    # That's why it's much safer to be used in a while loop to read a stream
    # which may not have a defined delimiter at the end of the last string.
    #
    # usage:
    #    str_readline [--delim char] [--fd num] [--] var
    #
    # parameters:
    #    --delim    A delimiter of a string (default is '\n')
    #    --fd       A file descriptor to read from (default is 0)
    #    var        A variable for storing a result
    #
    # examples:
    #   # the result should contain all 3 strings and first 2 start with spaces
    #   printf '  Hi!\n    How are you?\nBye' | \
    #       while str_readline str; do echo "${str}"; done
    #
    #   # reads strings which end with \0 symbol instead of \n
    #   cat /proc/self/environ | \
    #       while str_readline --delim '' str; do echo "[${str}]"; done
    #
    #   # reads from a file descriptor
    #   { mkfifo /tmp/my.pipe;
    #     exec {mypipe}<>/tmp/my.pipe;
    #     cat /etc/passwd > /tmp/my.pipe;
    #     while str_readline --fd ${mypipe} str; do echo "${str}"; done;
    #     exec {mypipe}<&-;
    #     rm -f /tmp/my.pipe; }

    declare -n _var
    declare _arg=""
    declare -i _fd="0"
    declare _delim=$'\n'

    # parse param string
    while [[ "$@" ]]; do
        case "$1" in
            --)
                shift
                break
                ;;
            --*)
                _arg="${1#--}"
                case "${_arg}" in
                    delim)
                        shift
                        _delim="$1"
                        ;;
                    fd)
                        shift
                        _fd="$1"
                        ;;
                    *)  ;;
                esac
                shift
                ;;
            *)
                _var="$1"
                break
                ;;
        esac
    done

    if ! IFS= read -d "${_delim}" -u ${_fd} -r _var; then
        [[ "${_var}" ]]
    fi
}

function io::readlines () 
{
    # Reads strings from the stdin until it faced the EOF and save
    # them in an array. It also behaves correctly if there is no a delimiter
    # at the end of the last string.
    #
    # usage:
    #    str_readlines [--delim char] [--fd num] [--] arr
    #
    # parameters:
    #    --delim    A delimiter of a string (default is $'\n')
    #    --fd       A file descriptor to read from (default is 0)
    #    arr        An array variable for storing the result
    #
    # examples:
    #   # reads strings which end with '\0' symbol instead of '\n'
    #   str_readlines --delim $'\0' myenv < /proc/self/environ && \
    #       echo "${myenv[0]}"

    declare -n _arr
    declare _str="" _arg=""
    declare -i _fd="0"
    declare _delim=$'\n'

    # parse param string
    while [[ "$*" ]]; do
        case "$1" in
            --)
                shift
                break
                ;;
            --*)
                _arg="${1#--}"
                case "${_arg}" in
                    delim)
                        shift
                        _delim="$1"
                        ;;
                    fd)
                        shift
                        _fd="$1"
                        ;;
                    *)  ;;
                esac
                shift
                ;;
            *)
                _arr="$1"
                break
                ;;
        esac
    done

    while io::readline --delim "${_delim}" --fd ${_fd} _str; do
        _arr+=("${_str}")
    done
}

