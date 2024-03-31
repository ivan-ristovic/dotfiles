#!/bin/bash

SHLIB_FMT_PROMPT=">"
SHLIB_FMT_C_R='\033[0;31m'
SHLIB_FMT_C_G='\033[0;32m'
SHLIB_FMT_C_B='\033[0;34m'
SHLIB_FMT_C_Y='\033[0;36m'
SHLIB_FMT_S_B='\033[1m'
SHLIB_FMT_CLR='\033[0m'

function log::suc ()
{
    if [ -z "$SHLIB_FMT_TIME" ]; then
        echo -e "${SHLIB_FMT_C_G}${SHLIB_FMT_PROMPT} suc: ${SHLIB_FMT_CLR}$@"
    else
        log::_tprint "suc" $SHLIB_FMT_C_G $*
    fi
}

function log::msg ()
{
    if [ -z "$SHLIB_FMT_TIME" ]; then
        echo -e "${SHLIB_FMT_C_Y}${SHLIB_FMT_PROMPT} inf: ${SHLIB_FMT_CLR}$@"
    else
        log::_tprint "msg" $SHLIB_FMT_C_Y $*
    fi
}

function log::wrn ()
{
    if [ -z "$SHLIB_FMT_TIME" ]; then
        echo -e "${SHLIB_FMT_C_R}${SHLIB_FMT_PROMPT} WRN: ${SHLIB_FMT_CLR}$@"
    else
        log::_tprint "WRN" $SHLIB_FMT_C_R $*
    fi
}

function log::err ()
{
    if [ -z "$SHLIB_FMT_TIME" ]; then
        echo -e "${SHLIB_FMT_C_R}${SHLIB_FMT_PROMPT} err: ${SHLIB_FMT_CLR}$@"
    else
        log::_tprint "err" $SHLIB_FMT_C_R $*
    fi
}

function log::_tprint ()
{
    echo -en "$SHLIB_FMT_S_B[$(date +%T)]$2$SHLIB_FMT_PROMPT $1: $SHLIB_FMT_CLR"
    shift 2
    echo -e "$@"
}

