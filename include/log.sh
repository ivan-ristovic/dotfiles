#!/bin/bash

SHLIB_FMT_PROMPT=">"
SHLIB_FMT_C_R='\033[0;31m'
SHLIB_FMT_C_G='\033[0;32m'
SHLIB_FMT_C_Y='\033[0;33m'
SHLIB_FMT_C_B='\033[0;34m'
SHLIB_FMT_S_B='\033[1m'
SHLIB_FMT_CLR='\033[0m'

function log::exec ()
{
    log::msg "executing: $*"
    "$@"
}

function log::suc ()
{
    log::log "suc" "$SHLIB_FMT_C_G" "$*"
}

function log::msg ()
{
    log::log "inf" "$SHLIB_FMT_C_B" "$*"
}

function log::wrn ()
{
    log::log "WRN" "$SHLIB_FMT_C_Y" "$*"
}

function log::err ()
{
    log::log "ERR" "$SHLIB_FMT_C_R" "$*"
}

function log::log ()
{
    local level="$1"
    local color="$2"
    shift 2
    if [ -z "$SHLIB_FMT_TIME" ]; then
        echo -e "${color}${SHLIB_FMT_PROMPT} $level: ${SHLIB_FMT_CLR}$*"
    else
        echo -en "${SHLIB_FMT_S_B}[$(date +%T)]${color}${SHLIB_FMT_PROMPT} $level: ${SHLIB_FMT_CLR}"
        echo -e "$@"
    fi
}

function log::stacktrace () 
{
    local frame=0 line func source n=0
    while caller "$frame"; do
        ((frame++))
    done | while read -r line func source; do
        ((n++ == 0)) && {
            log::log "trace" "red_i"
        }
        printf '%4s at %s\n' " " "$func ($source:$line)"
    done
}
