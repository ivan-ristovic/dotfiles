#!/bin/bash

PI='3.141592653589793'
TAU='6.283185307179586'
E='2.718281828459045'

export SHLIB_MATH_SCALE=8

function math::int ()
{ 
    eval "$(math::__args_or_input "$@")"
    echo "${1%.*}"
}

function math::frac ()
{
    eval "$(math::__args_or_input "$@")"
    if [[ "$1" =~ \. ]]; then
        echo ".${1#*.}"
    fi
}

function math::compute () 
{
    eval "$(math::__args_or_input "$@")"
    (math::__bc_functions 
     echo "scale=${2:-$SHLIB_MATH_SCALE} ; "
     echo "$1"
    ) | bc -lq 2>/dev/null
}

function math::cond ()
{
    eval "$(math::__args_or_input "$@")"
    local cond=0 scale=${2:-$SHLIB_MATH_SCALE}
    if (( $# > 0 )); then
        cond="$(math::compute "$1" "$scale")"
        if [[ -z "$cond" ]]; then cond=0; fi
        if [[ "$cond" != 0  && "$cond" != 1 ]]; then cond=0; fi
    fi
    local stat=$((cond == 0))
    return $stat
}

function math::eval () 
{
    eval "$(math::__args_or_input "$@")"
    local exc=0 res=0 scale="${2:-$SHLIB_MATH_SCALE}"
    if (( $# > 0 )) ; then
        res=$(math::compute "$1" "$scale")
        exc=$?
        if [[ $exc -eq 0 && -z "$res" ]]; then exc=1; fi
    fi
    echo "$res"
    return $exc
}

function math::sin    () { eval "$(math::__args_or_input "$@")" ; math::eval "s($1)"           "${2:-$SHLIB_MATH_SCALE}" ; }
function math::cos    () { eval "$(math::__args_or_input "$@")" ; math::eval "c($1)"           "${2:-$SHLIB_MATH_SCALE}" ; }
function math::tan    () { eval "$(math::__args_or_input "$@")" ; math::eval "(s($1)/c($1))"   "${2:-$SHLIB_MATH_SCALE}" ; }
function math::cotan  () { eval "$(math::__args_or_input "$@")" ; math::eval "(c($1)/s($1))"   "${2:-$SHLIB_MATH_SCALE}" ; }
function math::sec    () { eval "$(math::__args_or_input "$@")" ; math::eval "(1/c($1))"       "${2:-$SHLIB_MATH_SCALE}" ; }
function math::cosec  () { eval "$(math::__args_or_input "$@")" ; math::eval "(1/s($1))"       "${2:-$SHLIB_MATH_SCALE}" ; }
function math::csc    () { eval "$(math::__args_or_input "$@")" ; math::cosec "$@" ; }
function math::asin   () { eval "$(math::__args_or_input "$@")" ; math::eval "asin($1)"        "${2:-$SHLIB_MATH_SCALE}" ; }
function math::acos   () { eval "$(math::__args_or_input "$@")" ; math::eval "acos($1)"        "${2:-$SHLIB_MATH_SCALE}" ; }
function math::atan   () { eval "$(math::__args_or_input "$@")" ; math::eval "atan($1)"        "${2:-$SHLIB_MATH_SCALE}" ; }
function math::arccot () { eval "$(math::__args_or_input "$@")" ; math::eval "(($PI/2)-a($1))" "${2:-$SHLIB_MATH_SCALE}" ; }
function math::arcsin () { eval "$(math::__args_or_input "$@")" ; math::asin "$@" ; }
function math::arccos () { eval "$(math::__args_or_input "$@")" ; math::acos "$@" ; }
function math::arctan () { eval "$(math::__args_or_input "$@")" ; math::atag "$@" ; }
function math::ln     () { eval "$(math::__args_or_input "$@")" ; math::eval "l($1)"           "${2:-$SHLIB_MATH_SCALE}" ; }
function math::log10  () { eval "$(math::__args_or_input "$@")" ; math::eval "l($1)/l(10.0)"   "${2:-$SHLIB_MATH_SCALE}" ; }
function math::log    () { eval "$(math::__args_or_input "$@")" ; math::log10 "$@" ; }
function math::exp    () { eval "$(math::__args_or_input "$@")" ; math::eval "e($1)"           "${2:-$SHLIB_MATH_SCALE}" ; }
function math::pow    () { eval "$(math::__args_or_input "$@")" ; math::eval "$1^$2"           "${2:-$SHLIB_MATH_SCALE}" ; }
function math::deg    () { eval "$(math::__args_or_input "$@")" ; math::eval "deg($1)"         "${2:-$SHLIB_MATH_SCALE}" ; }
function math::ndeg   () { eval "$(math::__args_or_input "$@")" ; math::eval "ndeg($1)"        "${2:-$SHLIB_MATH_SCALE}" ; }
function math::rad    () { eval "$(math::__args_or_input "$@")" ; math::eval "rad($1)"         "${2:-$SHLIB_MATH_SCALE}" ; }
function math::abs    () { eval "$(math::__args_or_input "$@")" ; math::eval "abs($1)" ; }
function math::hypot  () { eval "$(math::__args_or_input "$@")" ; math::eval "sqrt(($1)^2 + ($2)^2)" "${3:-$SHLIB_MATH_SCALE}" ; }
function math::round  () { eval "$(math::__args_or_input "$@")" ; math::eval "round($1, ${2:-(scale($1)-1)})" "${2:-$SHLIB_MATH_SCALE}" ; }

function math::__bc_functions ()
{
    cat <<'EOF'
    define pi()       { auto r,s ; s=scale; scale=10 ; r=4*a(1);         scale=s ; return(r) ; }
    define int(x)     { auto r,s ; s=scale; scale=0  ; r=((x - x%1)/1) ; scale=s ; return(r) ; }
    define frac(x)    { auto r,s ; s=scale; scale=0  ; r=(x%1) ;         scale=s ; return(r) ; }
    define sin(x)     { return(s(x))                     ; }
    define cos(x)     { return(c(x))                     ; }
    define tan(x)     { return(s(x)/c(x))                ; }
    define asin(x)    { return(2*a(x/(1+sqrt(1-(x^2))))) ; }
    define acos(x)    { return(2*a(sqrt(1-(x^2))/(1+x))) ; }
    define atan(x)    { return(a(x))                     ; }
    define logn(x)    { return(l(x))                     ; }
    define log(x)     { return(l(x)/l(10.0))             ; }
    define log10(x)   { return(log(x))                   ; }
    define exp(x)     { return(e(x))                     ; }
    define pow(x,y)   { return(x^y)                      ; }
    define rad(x)     { return(x*pi()/180)               ; }
    define deg(x)     { return(x*180/pi())               ; }
    define ndeg(x)    { return((360 + deg(x))%360)       ; }
    define round(x,s) { auto r,o
                      o=scale(x) ; scale=s+1
                      r = x + 5*10^(-(s+1))
                      scale=s
                      return(r/1) ; }
    define abs(x)     { if ( x<0 ) return(-x) else return(x) ; }
EOF
}

function math::__args_or_input () 
{
    if (( $# == 0 )) ; then
        local -a args
        local func="${FUNCNAME[1]}"
        while (( ${#args[*]} == 0 )); do
            read -rp "$func? " -a args
        done
        echo "set - '${args[0]}' ${args[1]}"
    else
        echo "set - '$1' $2"
    fi
}
