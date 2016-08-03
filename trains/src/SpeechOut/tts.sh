#!/bin/sh
#
# tts : Invoke TrueTalk server
#
# George Ferguson, ferguson@cs.rochester.edu, 16 Jan 1996
# Time-stamp: <96/08/14 14:19:34 ferguson>
#
# This script just looks after setting up the environment for the
# TrueTalk server, then launches it, passing any arguments.
#

# Host running Entropics license server
ELM_HOST_DEFAULT=ruby

# Root of TrueTalk installation hierarchy
TT_BASE_DEFAULT="/s7/truetalk/tts.r1.`/bin/uname -s`.`/bin/uname -r`"

#
# Set ELM_HOST (host running license server) unless set already
#
if test -z "$ELM_HOST"; then
    ELM_HOST=$ELM_HOST_DEFAULT
    export ELM_HOST
elif test "$ELM_HOST" != $ELM_HOST_DEFAULT; then
    echo "$0: using your ELM_HOST=$ELM_HOST (default is $ELM_HOST_DEFAULT)" 1>&2
fi

#
# Set TT_BASE (root of TrueTalk tree) unless set already
#
if test -z "$TT_BASE"; then
    TT_BASE=$TT_BASE_DEFAULT
    export TT_BASE
elif test "$TT_BASE" != $TT_BASE_DEFAULT; then
    echo "$0: using your TT_BASE=$TT_BASE (default is $TT_BASE_DEFAULT)" 1>&2
fi

#
# Unbelievable, but if this isn't set tts crashes with "Memory fault"
#
if test -z "$HOME"; then
    HOME="/u/`/usr/ucb/whoami`"; export HOME
fi

#
# Now launch the real tts
#
exec $TT_BASE/bin/tts -server ${1+"$@"}
