#!/usr/bin/env bash
#
# ANSI code generator
#
# © Copyright 2015 Tyler Akins, modified for more intuitive naming convention
# Licensed under the MIT license with an additional non-advertising clause
# See http://github.com/fidian/ansi

ANSI_ESC=$'\033'
ANSI_CSI="${ANSI_ESC}["
ANSI_OSC="${ANSI_ESC}]"
ANSI_ST="${ANSI_ESC}\\"
ANSI_REPORT=""


#### MISC ####

ansi::bell() {
    printf "%s" $'\007'
}

ansi::repeat() {
    printf '%s%sb' "$ANSI_CSI" "${1-}"
}

ansi::reset() {
    ansi::fmt::reset
    ansi::font::reset
    ansi::erase::display 2
    ansi::cur::pos "1;1"
    ansi::cur::show
}

#### CURSOR ####

ansi::cur::restore() {
    printf '%su' "$ANSI_CSI"
}

ansi::cur::pos() {
    local position="${1-}"
    printf '%s%sH' "$ANSI_CSI" "${position/,/;}"
}

ansi::cur::pos::save() {
    printf '%ss' "$ANSI_CSI"
}

ansi::cur::fw() {
    printf '%s%sC' "$ANSI_CSI" "${1-}"
}

ansi::cur::fw_tab() {
    printf '%s%sI' "$ANSI_CSI" "${1-}"
}

ansi::cur::bw() {
    printf '%s%sD' "$ANSI_CSI" "${1-}"
}

ansi::cur::bw_tab() {
    printf '%s%sZ' "$ANSI_CSI" "${1-}"
}

ansi::cur::dn() {
    printf '%s%sB' "$ANSI_CSI" "${1-}"
}

ansi::cur::up() {
    printf '%s%sA' "$ANSI_CSI" "${1-}"
}

ansi::cur::blink() {
    printf '%s5m' "$ANSI_CSI"
}

ansi::cur::blink_rapid() {
    printf '%s6m' "$ANSI_CSI"
}

ansi::cur::blink_off() {
    printf '%s25m' "$ANSI_CSI"
}

ansi::cur::col() {
    printf '%s%sG' "$ANSI_CSI" "${1-}"
}

ansi::cur::col_rel() {
    printf '%s%sa' "$ANSI_CSI" "${1-}"
}

ansi::cur::hide() {
    printf '%s?25l' "$ANSI_CSI"
}

ansi::cur::show() {
    printf '%s?25h' "$ANSI_CSI"
}

ansi::cur::lf() {
    printf '%s%sd' "$ANSI_CSI" "${1-}"
}

ansi::cur::lf_rel() {
    printf '%s%se' "$ANSI_CSI" "${1-}"
}

ansi::cur::nl() {
    printf '%s%sE' "$ANSI_CSI" "${1-}"
}

ansi::cur::prev_line() {
    printf '%s%sF' "$ANSI_CSI" "${1-}"
}

ansi::scr::down() {
    printf '%s%sT' "$ANSI_CSI" "${1-}"
}

ansi::scr::up() {
    printf '%s%sS' "$ANSI_CSI" "${1-}"
}

ansi::ins::chars() {
    printf '%s%s@' "$ANSI_CSI" "${1-}"
}

ansi::ins::lines() {
    printf '%s%sL' "$ANSI_CSI" "${1-}"
}

ansi::del::chars() {
    printf '%s%sP' "$ANSI_CSI" "${1-}"
}

ansi::del::lines() {
    printf '%s%sM' "$ANSI_CSI" "${1-}"
}

ansi::erase::display() {
    printf '%s%sJ' "$ANSI_CSI" "${1-}"
}

ansi::erase::chars() {
    printf '%s%sX' "$ANSI_CSI" "${1-}"
}

ansi::erase::lines() {
    printf '%s%sK' "$ANSI_CSI" "${1-}"
}

#### FORMAT ####

ansi::fmt::reset() {
    printf '%s0m' "$ANSI_CSI"
}

ansi::fmt::bold() {
    printf '%s1m' "$ANSI_CSI"
}

ansi::fmt::bold_off() {
    printf '%s22m' "$ANSI_CSI"
}

ansi::fmt::italic() {
    printf '%s3m' "$ANSI_CSI"
}

ansi::fmt::italic_off() {
    printf '%s23m' "$ANSI_CSI"
}

ansi::fmt::underline() {
    printf '%s4m' "$ANSI_CSI"
}

ansi::fmt::underline2() {
    printf '%s21m' "$ANSI_CSI"
}

ansi::fmt::strike() {
    printf '%s9m' "$ANSI_CSI"
}

ansi::fmt::strike_off() {
    printf '%s29m' "$ANSI_CSI"
}

ansi::fmt::underline_off() {
    printf '%s24m' "$ANSI_CSI"
}

ansi::fmt::faint() {
    printf '%s2m' "$ANSI_CSI"
}

ansi::fmt::reverse() {
    printf '%s7m' "$ANSI_CSI"
}

ansi::fmt::reverse_off() {
    printf '%s27m' "$ANSI_CSI"
}

ansi::fmt::invisible() {
    printf '%s8m' "$ANSI_CSI"
}

ansi::fmt::visible() {
    printf '%s28m' "$ANSI_CSI"
}

ansi::fmt::icon() {
    printf '%s1;%s%s' "$ANSI_OSC" "${1-}" "$ANSI_ST"
}

ansi::fmt::title() {
    printf '%s2;%s%s' "$ANSI_OSC" "${1-}" "$ANSI_ST"
}

#### FONTS ####

ansi::font() {
    printf '%s1%sm' "$ANSI_CSI" "${1-0}"
}

ansi::font::reset() {
    printf '%s10m' "$ANSI_CSI"
}

#### COLORS ####

ansi::fg::reset() {
    printf '%s39m' "$ANSI_CSI"
}

ansi::fg() {
    printf '%s38;5;%sm' "$ANSI_CSI" "$1"
}

ansi::fg::rgb() {
    printf '%s38;2;%s;%s;%sm' "$ANSI_CSI" "$1" "$2" "$3"
}

ansi::fg::black() {
    printf '%s30m' "$ANSI_CSI"
}

ansi::fg::black_i() {
    printf '%s90m' "$ANSI_CSI"
}

ansi::fg::blue() {
    printf '%s34m' "$ANSI_CSI"
}

ansi::fg::blue_i() {
    printf '%s94m' "$ANSI_CSI"
}

ansi::fg::cyan() {
    printf '%s36m' "$ANSI_CSI"
}

ansi::fg::cyan_i() {
    printf '%s96m' "$ANSI_CSI"
}

ansi::fg::green() {
    printf '%s32m' "$ANSI_CSI"
}

ansi::fg::green_i() {
    printf '%s92m' "$ANSI_CSI"
}

ansi::fg::magenta() {
    printf '%s35m' "$ANSI_CSI"
}

ansi::fg::magenta_i() {
    printf '%s95m' "$ANSI_CSI"
}

ansi::fg::red() {
    printf '%s31m' "$ANSI_CSI"
}

ansi::fg::red_i() {
    printf '%s91m' "$ANSI_CSI"
}

ansi::fg::white() {
    printf '%s37m' "$ANSI_CSI"
}

ansi::fg::white_i() {
    printf '%s97m' "$ANSI_CSI"
}

ansi::fg::yellow() {
    printf '%s33m' "$ANSI_CSI"
}

ansi::fg::yellow_i() {
    printf '%s93m' "$ANSI_CSI"
}

# ------------ # 

ansi::bg::reset() {
    printf '%s49m' "$ANSI_CSI"
}

ansi::bg() {
    printf '%s48;5;%sm' "$ANSI_CSI" "$1"
}

ansi::bg::rgb() {
    printf '%s48;2;%s;%s;%sm' "$ANSI_CSI" "$1" "$2" "$3"
}

ansi::bg::black() {
    printf '%s40m' "$ANSI_CSI"
}

ansi::bg::black_i() {
    printf '%s100m' "$ANSI_CSI"
}

ansi::bg::blue() {
    printf '%s44m' "$ANSI_CSI"
}

ansi::bg::blue_i() {
    printf '%s104m' "$ANSI_CSI"
}

ansi::bg::cyan() {
    printf '%s46m' "$ANSI_CSI"
}

ansi::bg::cyan_i() {
    printf '%s106m' "$ANSI_CSI"
}

ansi::bg::green() {
    printf '%s42m' "$ANSI_CSI"
}

ansi::bg::green_i() {
    printf '%s102m' "$ANSI_CSI"
}

ansi::bg::magenta() {
    printf '%s45m' "$ANSI_CSI"
}

ansi::bg::magenta_i() {
    printf '%s105m' "$ANSI_CSI"
}

ansi::bg::red() {
    printf '%s41m' "$ANSI_CSI"
}

ansi::bg::red_i() {
    printf '%s101m' "$ANSI_CSI"
}

ansi::bg::white() {
    printf '%s47m' "$ANSI_CSI"
}

ansi::bg::white_i() {
    printf '%s107m' "$ANSI_CSI"
}

ansi::bg::yellow() {
    printf '%s43m' "$ANSI_CSI"
}

ansi::bg::yellow_i() {
    printf '%s103m' "$ANSI_CSI"
}

#### IDEOGRAM ####

ansi::ig::left() {
    printf '%s62m' "$ANSI_CSI"
}

ansi::ig::left2() {
    printf '%s63m' "$ANSI_CSI"
}

ansi::ig::right() {
    printf '%s60m' "$ANSI_CSI"
}

ansi::ig::right2() {
    printf '%s61m' "$ANSI_CSI"
}

ansi::ig::stress() {
    printf '%s64m' "$ANSI_CSI"
}

ansi::ig::reset() {
    printf '%s65m' "$ANSI_CSI"
}

#### FRAMES ####

ansi::frame::encircle() {
    printf '%s52m' "$ANSI_CSI"
}

ansi::frame() {
    printf '%s51m' "$ANSI_CSI"
}

ansi::frame::reset() {
    printf '%s54m' "$ANSI_CSI"
}

ansi::frame::overline() {
    printf '%s53m' "$ANSI_CSI"
}

ansi::frame::overline_off() {
    printf '%s55m' "$ANSI_CSI"
}


#### REPORT ####

ansi::is_supported() {
    # Optionally override detection logic
    # to support post processors that interpret color codes _after_ output is generated.
    # Use environment variable "ANSI_FORCE_SUPPORT=<anything>" to enable the override.
    if [[ -n "${ANSI_FORCE_SUPPORT-}" ]]; then
        return 0
    fi

    if hash tput &> /dev/null; then
        if [[ "$(tput colors)" -lt 8 ]]; then
            return 1
        fi

        return 0
    fi

    # Query the console and see if we get ANSI codes back.
    # CSI 0 c == CSI c == Primary Device Attributes.
    # Idea:  CSI c
    # Response = CSI ? 6 [234] ; 2 2 c
    # The "22" means ANSI color, but terminals don't need to send that back.
    # If we get anything back, let's assume it works.
    ansi::report c "$ANSI_CSI?" c || return 1
    [[ -n "$ANSI_REPORT" ]]
}

ansi::report() {
    local buff c report

    report=""

    # Note: read bypass piping, which lets this work:
    # ansi --report-window-chars | cut -d , -f 1
    read -p "$ANSI_CSI$1" -r -N "${#2}" -s -t 1 buff

    if [ "$buff" != "$2" ]; then
        return 1
    fi

    read -r -N "${#3}" -s -t 1 buff

    while [[ "$buff" != "$3" ]]; do
        report="$report${buff:0:1}"
        read -r -N 1 -s -t 1 c || exit 1
        buff="${buff:1}$c"
    done

    ANSI_REPORT=$report
}

ansi::report::pos() {
    ansi::report 6n "$ANSI_CSI" R || return 1
    printf '%s\n' "${ANSI_REPORT//;/,}"
}

ansi::report::icon() {
    ansi::report 20t "${ANSI_OSC}L" "$ANSI_ST" || return 1
    printf '%s\n' "${ANSI_REPORT//;/,}"
}

ansi::report::screen_chars() {
    ansi::report 19t "${ANSI_CSI}9;" t || return 1
    printf '%s\n' "${ANSI_REPORT//;/,}"
}

ansi::report::title() {
    ansi::report 21t "${ANSI_OSC}l" "$ANSI_ST" || return 1
    printf '%s\n' "${ANSI_REPORT//;/,}"
}

ansi::report::window_chars() {
    ansi::report 18t "${ANSI_CSI}8;" t || return 1
    printf '%s\n' "${ANSI_REPORT//;/,}"
}

ansi::report::window_pixels() {
    ansi::report 14t "${ANSI_CSI}4;" t || return 1
    printf '%s\n' "${ANSI_REPORT//;/,}"
}

ansi::report::window_pos() {
    ansi::report 13t "${ANSI_CSI}3;" t || return 1
    printf '%s\n' "${ANSI_REPORT//;/,}"
}

ansi::report::window_state() {
    ansi::report 11t "$ANSI_CSI" t || return 1
    case "$ANSI_REPORT" in
        1)
            printf 'open\n'
            ;;

        2)
            printf 'iconified\n'
            ;;

        *)
            printf 'unknown (%s)\n' "$ANSI_REPORT"
            ;;
    esac
}

#### MAIN ####

ansi::ansi() {
    local addNewline b g m r readOptions restoreText restoreCursorPosition restoreCursorVisibility supported triggerRestore
    local m10 m22 m23 m24 m25 m27 m28 m29 m39 m49 m54 m55 m65

    addNewline=true
    m10=
    m22=
    m23=
    m24=
    m25=
    m27=
    m28=
    m29=
    m39=
    m49=
    m54=
    m55=
    m65=
    readOptions=true
    restoreCursorPosition=false
    restoreCursorVisibility=false
    restoreText=false
    supported=true
    triggerRestore=true

    if ! ansi::is_supported; then
        supported=false
    fi

    while $readOptions && [[ $# -gt 0 ]]; do
        case "$1" in
            --help | -h | -\?)
                ansi::help
                return 0
                ;;

            # Display Manipulation
            --insert-chars | --insert-char | --ich)
                $supported && ansi::ins::chars
                ;;

            --insert-chars=* | insert-char=* | --ich=*)
                $supported && ansi::ins::chars "${1#*=}"
                ;;

            --erase-display | --ed)
                $supported && ansi::erase::display
                ;;

            --erase-display=* | --ed=*)
                $supported && ansi::erase::display "${1#*=}"
                ;;

            --erase-line | --el)
                $supported && ansi::erase::lines
                ;;

            --erase-line=* | --el=*)
                $supported && ansi::erase::lines "${1#*=}"
                ;;

            --insert-lines | --insert-line | --il)
                $supported && ansi::ins::lines
                ;;

            --insert-lines=* | --insert-line=* | --il=*)
                $supported && ansi::ins::lines "${1#*=}"
                ;;

            --delete-lines | --delete-line | --dl)
                $supported && ansi::del::lines
                ;;

            --delete-lines=* | --delete-line=* | --dl=*)
                $supported && ansi::del::lines "${1#*=}"
                ;;

            --delete-chars | --delete-char | --dch)
                $supported && ansi::del::chars
                ;;

            --delete-chars=* | --delete-char=* | --dch=*)
                $supported && ansi::del::chars "${1#*=}"
                ;;

            --scroll-up | --su)
                $supported && ansi::scr::up
                ;;

            --scroll-up=* | --su=*)
                $supported && ansi::scr::up "${1#*=}"
                ;;

            --scroll-down | --sd)
                $supported && ansi::scr::down
                ;;

            --scroll-down=* | --sd=*)
                $supported && ansi::scr::down "${1#*=}"
                ;;

            --erase-chars | --erase-char | --ech)
                $supported && ansi::erase::chars
                ;;

            --erase-chars=* | --erase-char=* | --ech=*)
                $supported && ansi::erase::chars "${1#*=}"
                ;;

            --repeat | --rep)
                $supported && ansi::repeat
                ;;

            --repeat=* | --rep=N)
                $supported && ansi::repeat "${1#*=}"
                ;;

            # Cursor Positioning
            --up | --cuu)
                $supported && ansi::cur::up
                ;;

            --up=* | --cuu=*)
                $supported && ansi::cur::up "${1#*=}"
                ;;

            --down | --cud)
                $supported && ansi::cur::dn
                ;;

            --down=* | --cud=*)
                $supported && ansi::cur::dn "${1#*=}"
                ;;

            --forward | --cuf)
                $supported && ansi::cur::fw
                ;;

            --forward=* | --cuf=*)
                $supported && ansi::cur::fw "${1#*=}"
                ;;

            --backward | --cub)
                $supported && ansi::cur::bw
                ;;

            --backward=* | --cub=*)
                $supported && ansi::cur::bw "${1#*=}"
                ;;

            --next-line | --cnl)
                $supported && ansi::cur::nl
                ;;

            --next-line=* | --cnl=*)
                $supported && ansi::cur::nl "${1#*=}"
                ;;

            --previous-line | --prev-line | --cpl)
                $supported && ansi::cur::prev_line
                ;;

            --previous-line=* | --prev-line=* | --cpl=*)
                $supported && ansi::cur::prev_line "${1#*=}"
                ;;

            --column | --cha)
                $supported && ansi::cur::col
                ;;

            --column=* | --cha=*)
                $supported && ansi::cur::col "${1#*=}"
                ;;

            --position | --cup)
                $supported && ansi::cur::pos
                ;;

            --position=* | --cup=*)
                $supported && ansi::cur::pos "${1#*=}"
                ;;

            --tab-forward | --cht)
                $supported && ansi::cur::fw_tab
                ;;

            --tab-forward=* | --cht=*)
                $supported && ansi::cur::fw_tab "${1#*=}"
                ;;

            --tab-backward | --cbt)
                $supported && ansi::cur::bw_tab
                ;;

            --tab-backward=* | --cbt=*)
                $supported && ansi::cur::bw_tab "${1#*=}"
                ;;

            --column-relative | --hpr)
                $supported && ansi::cur::col_rel
                ;;

            --column-relative=* | --hpr=*)
                $supported && ansi::cur::col_rel "${1#*=}"
                ;;

            --line | --vpa)
                $supported && ansi::cur::lf
                ;;

            --line=* | --vpa=*)
                $supported && ansi::cur::lf "${1#*=}"
                ;;

            --line-relative | --vpr)
                $supported && ansi::cur::lf_rel
                ;;

            --line-relative=* | --vpr=*)
                $supported && ansi::cur::lf_rel "${1#*=}"
                ;;

            --save-cursor)
                $supported && ansi::cur::pos::save
                restoreCursorPosition=true
                ;;

            --restore-cursor)
                $supported && ansi::cur::restore
                ;;

            --hide-cursor)
                $supported && ansi::cur::hide
                restoreCursorVisibility=true
                ;;

            --show-cursor)
                $supported && ansi::cur::show
                ;;

            # Colors - Attributes
            --bold)
                $supported && ansi::fmt::bold
                restoreText=true
                m22="22;"
                ;;

            --faint)
                $supported && ansi::fmt::faint
                restoreText=true
                m22="22;"
                ;;

            --italic)
                $supported && ansi::fmt::italic
                restoreText=true
                m23="23;"
                ;;

            --underline)
                $supported && ansi::fmt::underline
                restoreText=true
                m24="24;"
                ;;

            --blink)
                $supported && ansi::cur::blink
                restoreText=true
                m25="25;"
                ;;

            --rapid-blink)
                $supported && ansi::cur::blink_rapid
                restoreText=true
                m25="25;"
                ;;

            --inverse)
                $supported && ansi::fmt::reverse
                restoreText=true
                m27="27;"
                ;;

            --invisible)
                $supported && ansi::fmt::invisible
                restoreText=true
                m28="28;"
                ;;

            --strike)
                $supported && ansi::fmt::strike
                restoreText=true
                m29="29;"
                ;;

            --font|--font=0)
                $supported && ansi::font::reset
                ;;

            --font=[123456789])
                $supported && ansi::font "${1#*=}"
                restoreText=true
                m10="10;"
                ;;

            --fraktur)
                $supported && ansi::fraktur
                restoreText=true
                m23="23;"
                ;;

            --double-underline)
                $supported && ansi::fmt::underline2
                restoreText=true
                m24="24;"
                ;;

            --normal)
                $supported && ansi::fmt::bold_off
                ;;

            --plain)
                $supported && ansi::fmt::italic_off
                ;;

            --no-underline)
                $supported && ansi::fmt::underline_off
                ;;

            --no-blink)
                $supported && ansi::cur::blink_off
                ;;

            --no-inverse)
                $supported && ansi::fmt::reverse_off
                ;;

            --visible)
                $supported && ansi::fmt::visible
                ;;

            --no-strike)
                $supported && ansi::fmt::strike_off
                ;;

            --frame)
                $supported && ansi::frame
                restoreText=true
                m54="54;"
                ;;

            --encircle)
                $supported && ansi::frame::encircle
                restoreText=true
                m54="54;"
                ;;

            --overline)
                $supported && ansi::frame::overline
                restoreText=true
                m55="55;"
                ;;

            --no-border)
                $supported && ansi::frame::reset
                ;;

            --no-overline)
                $supported && ansi::frame::overline_off
                ;;

            # Colors - Foreground
            --black)
                $supported && ansi::fg::black
                restoreText=true
                m39="39;"
                ;;

            --red)
                $supported && ansi::fg::red
                restoreText=true
                m39="39;"
                ;;

            --green)
                $supported && ansi::fg::green
                restoreText=true
                m39="39;"
                ;;

            --yellow)
                $supported && ansi::fg::yellow
                restoreText=true
                m39="39;"
                ;;

            --blue)
                $supported && ansi::fg::blue
                restoreText=true
                m39="39;"
                ;;

            --magenta)
                $supported && ansi::fg::magenta
                restoreText=true
                m39="39;"
                ;;

            --cyan)
                $supported && ansi::fg::cyan
                restoreText=true
                m39="39;"
                ;;

            --white)
                $supported && ansi::fg::white
                restoreText=true
                m39="39;"
                ;;

            --black-intense)
                $supported && ansi::fg::black_i
                restoreText=true
                m39="39;"
                ;;

            --red-intense)
                $supported && ansi::fg::red_i
                restoreText=true
                m39="39;"
                ;;

            --green-intense)
                $supported && ansi::fg::green_i
                restoreText=true
                m39="39;"
                ;;

            --yellow-intense)
                $supported && ansi::fg::yellow_i
                restoreText=true
                m39="39;"
                ;;

            --blue-intense)
                $supported && ansi::fg::blue_i
                restoreText=true
                m39="39;"
                ;;

            --magenta-intense)
                $supported && ansi::fg::magenta_i
                restoreText=true
                m39="39;"
                ;;

            --cyan-intense)
                $supported && ansi::fg::cyan_i
                restoreText=true
                m39="39;"
                ;;

            --white-intense)
                $supported && ansi::fg::white_i
                restoreText=true
                m39="39;"
                ;;

            --rgb=*,*,*)
                r=${1#*=}
                b=${r##*,}
                g=${r#*,}
                g=${g%,*}
                r=${r%%,*}
                $supported && ansi::fg::rgb "$r" "$g" "$b"
                restoreText=true
                m39="39;"
                ;;

            --color=*)
                $supported && ansi::fg "${1#*=}"
                restoreText=true
                m39="39;"
                ;;

            # Colors - Background
            --bg-black)
                $supported && ansi::bg::black
                restoreText=true
                m49="49;"
                ;;

            --bg-red)
                $supported && ansi::bg::red
                restoreText=true
                m49="49;"
                ;;

            --bg-green)
                $supported && ansi::bg::green
                restoreText=true
                m49="49;"
                ;;

            --bg-yellow)
                $supported && ansi::bg::yellow
                restoreText=true
                m49="49;"
                ;;

            --bg-blue)
                $supported && ansi::bg::blue
                restoreText=true
                m49="49;"
                ;;

            --bg-magenta)
                $supported && ansi::bg::magenta
                restoreText=true
                m49="49;"
                ;;

            --bg-cyan)
                $supported && ansi::bg::cyan
                restoreText=true
                m49="49;"
                ;;

            --bg-white)
                $supported && ansi::bg::white
                restoreText=true
                m49="49;"
                ;;

            --bg-black-intense)
                $supported && ansi::bg::black_i
                restoreText=true
                m49="49;"
                ;;

            --bg-red-intense)
                $supported && ansi::bg::red_i
                restoreText=true
                m49="49;"
                ;;

            --bg-green-intense)
                $supported && ansi::bg::green_i
                restoreText=true
                m49="49;"
                ;;

            --bg-yellow-intense)
                $supported && ansi::bg::yellow_i
                restoreText=true
                m49="49;"
                ;;

            --bg-blue-intense)
                $supported && ansi::bg::blue_i
                restoreText=true
                m49="49;"
                ;;

            --bg-magenta-intense)
                $supported && ansi::bg::magenta_i
                restoreText=true
                m49="49;"
                ;;

            --bg-cyan-intense)
                $supported && ansi::bg::cyan_i
                restoreText=true
                m49="49;"
                ;;

            --bg-white-intense)
                $supported && ansi::bg::white_i
                restoreText=true
                m49="49;"
                ;;

            --bg-rgb=*,*,*)
                r=${1#*=}
                b=${r##*,}
                g=${r#*,}
                g=${g%,*}
                r=${r%%,*}
                $supported && ansi::bg::rgb "$r" "$g" "$b"
                restoreText=true
                m49="49;"
                ;;

            --bg-color=*)
                $supported && ansi::bg "${1#*=}"
                restoreText=true
                m49="49;"
                ;;

            # Colors - Reset
            --reset-foreground)
                $supported && ansi::fg::reset
                ;;

            --reset-background)
                $supported && ansi::bg::reset
                ;;

            --reset-color)
                $supported && ansi::resetColor
                ;;

            --reset-font)
                $supported && ansi::font::reset
                ;;

            # Reporting
            --report-position)
                $supported || return 1
                ansi::report::pos || return $?
                ;;

            --report-window-state)
                $supported || return 1
                ansi::report::window_state || return $?
                ;;

            --report-window-position)
                $supported || return 1
                ansi::report::window_pos || return $?
                ;;

            --report-window-pixels)
                $supported || return 1
                ansi::report::window_pixels || return $?
                ;;

            --report-window-chars)
                $supported || return 1
                ansi::report::window_chars || return $?
                ;;

            --report-screen-chars)
                $supported || return 1
                ansi::report::screen_chars || return $?
                ;;

            --report-icon)
                $supported || return 1
                ansi::report::icon || return $?
                ;;

            --report-title)
                $supported || return 1
                ansi::report::title || return $?
                ;;

            --ideogram-right)
                $supported && ansi::ig::right
                restoreText=true
                m65="65;"
                ;;

            --ideogram-right-double)
                $supported && ansi::ig::right2
                restoreText=true
                m65="65;"
                ;;

            --ideogram-left)
                $supported && ansi::ig::left
                restoreText=true
                m65="65;"
                ;;

            --ideogram-left-double)
                $supported && ansi::ig::left2
                restoreText=true
                m65="65;"
                ;;

            --ideogram-stress)
                $supported && ansi::ig::stress
                restoreText=true
                m65="65;"
                ;;

            --reset-ideogram)
                $supported && ansi::noIdeogram
                ;;

            # Miscellaneous
            --icon)
                $supported && ansi::fmt::icon ""
                ;;

            --icon=*)
                $supported && ansi::fmt::icon "${1#*=}"
                ;;

            --title)
                $supported && ansi::fmt::title ""
                ;;

            --title=*)
                $supported && ansi::fmt::title "${1#*=}"
                ;;

            --no-restore)
                triggerRestore=false
                ;;

            -n | --no-newline)
                addNewline=false
                ;;

            --bell)
                ansi::bell
                ;;

            --reset)
                $supported || return 0
                ansi::reset
                ;;

            --)
                readOptions=false
                shift
                ;;

            *)
                readOptions=false
                ;;
        esac

        if $readOptions; then
            shift
        fi
    done

    printf '%s' "${1-}"

    if [[ "$#" -gt 1 ]]; then
        shift || :
        printf "${IFS:0:1}%s" "${@}"
    fi

    if $supported && $triggerRestore; then
        if $restoreCursorPosition; then
            ansi::cur::restore
        fi

        if $restoreCursorVisibility; then
            ansi::cur::show
        fi

        if $restoreText; then
            m="$m10$m22$m23$m24$m25$m27$m28$m29$m39$m49$m54$m55$m65"
            printf '%s%sm' "$ANSI_CSI" "${m%;}"
        fi
    fi

    if $addNewline; then
        printf '\n'
    fi
}


# Run if not sourced
if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
    ansi::ansi "$@" || exit $?
fi

