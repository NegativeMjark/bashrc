#!/bin/sh

function _find_bzr_root()
{
  local HERE
  HERE="$PWD"
  while [ "$HERE" != "/" ]; do
    [[ -d "$HERE/.bzr" && -r "$HERE/.bzr/README" ]] && {
      return 0
    }
    HERE=$(dirname "$HERE")
  done
  return 1
}

function _find_git_root()
{
  local HERE
  HERE="$PWD"
  while [ "$HERE" != "/" ]; do
    [[ -d "$HERE/.git" && -r "$HERE/.git/HEAD" ]] && {
      return 0
    }
    HERE=$(dirname "$HERE")
  done
  return 1
}

function _find_svn_root()
{
  local HERE
  HERE="$(readlink -f $PWD)"
  while [ "$HERE" != "/" ]; do
    [[ -d "$HERE/.svn" ]]  && {
      return 0
    }
    HERE=$(dirname "$HERE")
  done
  return 1
}

function _find_p4_root()
{
  local HERE
  HERE="$PWD"
  while [ "$HERE" != "/" ]; do
    [[ -r "$HERE/.p4config" ]] && grep P4CLIENT "$HERE/.p4config" >/dev/null && {
      return 0
    }
    HERE=$(dirname "$HERE")
  done
  return 1
}

function _show_git() {
    echo $( \
        git rev-parse --abbrev-ref HEAD 2>/dev/null; \
        git describe --exact-match 2>/dev/null; \
        git rev-parse --short HEAD 2>/dev/null; \
    )
}

function _show_svn() {
    echo $( \
        svnversion 2>/dev/null; \
    )
}

function _reset_revcntl()
{
  if [ "$PWD" == "$REVCNTL_PWD" ] && [ -z "$REVCNTL_PS1" ]; then
    return
  fi

  local RCS
  RCS=""

  if [ -d CVS ];     then RCS="${RCS:+$RCS+}cvs"; fi
  if _find_svn_root; then RCS="${RCS:+$RCS+}svn $(_show_svn)"; fi
  if _find_bzr_root; then RCS="${RCS:+$RCS+}bzr"; fi
  if _find_git_root; then RCS="${RCS:+$RCS+}git $(_show_git)"; fi
  if _find_p4_root;  then RCS="${RCS:+$RCS+}p4";  fi

  if [ "$RCS" ]; then
    REVCNTL_PS1=" [${RCS}]"
  else
    REVCNTL_PS1=""
  fi

  REVCNTL_PWD="$PWD"
}

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;} _reset_revcntl"
