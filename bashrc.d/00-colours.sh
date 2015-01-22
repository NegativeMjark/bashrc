#! /bin/bash

# Some bold colours
     SETRED=$'\e[1;31m'
   SETGREEN=$'\e[1;32m'
  SETYELLOW=$'\e[1;33m'
    SETBLUE=$'\e[1;34m'
 SETMAGENTA=$'\e[1;35m'
    SETCYAN=$'\e[1;36m'

# Some non-bold colours
     SETRED_N=$'\e[31m'
   SETGREEN_N=$'\e[32m'
  SETYELLOW_N=$'\e[33m'
    SETBLUE_N=$'\e[34m'
 SETMAGENTA_N=$'\e[35m'
    SETCYAN_N=$'\e[36m'

# Some other attributes
 SETUNDERLINE=$'\e[4m'
     SETBLINK=$'\e[5m'
   SETREVERSE=$'\e[7m'

# Reset
 SETNORMAL=$'\e[0m'

# Some xterm stuff
case "$TERM" in
  xterm*)
    SETCURSORRED=$'\e]12;red\07' ;;
  *)
    SETCURSORRED= ;;
esac

