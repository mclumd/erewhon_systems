#!/bin/sh
#
# trains.noaudio : Run version 2.2 of the TRAINS system without audio
#
# George Ferguson, ferguson@cs.rochester.edu, 21 Oct 1996
# Time-stamp: <Wed Jan 22 16:34:34 EST 1997 ferguson>
#
# This script uses the following environment variables, if set:
#  DISPLAY			X Windows display
#  TRAINS_BASE			Root of TRAINS directory tree
#  TRAINS_LOGS			Used by SPLASH module to set log directory
#  TRAINS_LISP_HOST		Where to run Lisp modules (DM, Parser, PSM)
#  TRAINS_DM_HOST		Overrides TRAINS_LISP_HOST for DM
#  TRAINS_AUDIO_HOST		Where to do audio i/o (defaults to DISPLAY)
#  TRAINS_USER_SEX		Passed to sphinx with -sex, if set
#

echo 'This is TRAINS-96 v2.2'
TRAINS_BASE_DEFAULT=/u/trains/96/2.2
#TRAINS_SPEECH_IN_HOST_DEFAULT=micro
#TRAINS_DM_HOST_DEFAULT=milli
#TRAINS_LISP_HOST_DEFAULT=milli

# Set TRAINS_BASE unless set
if test ! -z "$TRAINS_BASE"; then
    echo "Using your TRAINS_BASE=\"$TRAINS_BASE\"" 1>&2
else
    TRAINS_BASE=$TRAINS_BASE_DEFAULT; export TRAINS_BASE
    echo "Using TRAINS_BASE=\"$TRAINS_BASE\"" 1>&2
fi

#############################################################################
#
# Command-line
#
sex=${TRAINS_USER_SEX:-m}
while test ! -z "$1"; do
    case "$1" in
	-sex) sex="$2"; shift;;
	*) echo "$0: unknown argument: $1" 1>&2; exit 1;;
    esac
    shift
done

#############################################################################
#
# Environment
#

# Get current hostname
current_host=`/bin/uname -n | cut -d. -f1`

# Make sure DISPLAY is set
if test -z "$DISPLAY" -o "$DISPLAY" = ":0.0" -o "$DISPLAY" = ":0" \
        -o "$DISPLAY" = "unix:0" -o "$DISPLAY" = "unix:0.0"; then
    DISPLAY="$current_host:0"
    echo "Using DISPLAY=\"$DISPLAY\"" 1>&2
else
    echo "Using your DISPLAY=\"$DISPLAY\"" 1>&2
fi
display_host="`echo $DISPLAY | cut -d: -f1`"

# Host for discourse manager (DM)
if test ! -z "$TRAINS_DM_HOST"; then
    dm_host=$TRAINS_DM_HOST
    echo "Using your TRAINS_DM_HOST=\"$dm_host\"" 1>&2
elif test ! -z "$TRAINS_LISP_HOST"; then
    dm_host=$TRAINS_LISP_HOST
    echo "Using your TRAINS_LISP_HOST=\"$dm_host\"" 1>&2
else
    if test -z "$TRAINS_DM_HOST_DEFAULT"; then
	TRAINS_DM_HOST_DEFAULT=$current_host
    fi
    dm_host=$TRAINS_DM_HOST_DEFAULT
    echo "Running dm on \"$dm_host\"" 1>&2
fi

# Host for other lisp modules (Parser, PSM)
if test ! -z "$TRAINS_LISP_HOST"; then
    lisp_host=$TRAINS_LISP_HOST
    if test ! -z "$TRAINS_DM_HOST"; then
        echo "Using your TRAINS_LISP_HOST=\"$lisp_host\"" 1>&2
    fi
else
    if test -z "$TRAINS_LISP_HOST_DEFAULT"; then
	TRAINS_LISP_HOST_DEFAULT=$current_host
    fi
    lisp_host=$TRAINS_LISP_HOST_DEFAULT
    echo "Running other lisp modules on \"$lisp_host\"" 1>&2
fi

if test ! -z "$TRAINS_LOGS"; then
    logdir=$TRAINS_LOGS
else
    logdir="$TRAINS_BASE/logs"
fi
if test -d "$logdir"; then
    echo "Using log directory $logdir"
else
    echo "Creating log directory $logdir"
    mkdir $logdir
fi

#############################################################################
#
# Here we go...
#

# Xhost
if test ! -z "$display_host"; then
    echo "Disabling X access control on $display_host..."
    rsh -n $display_host "setenv DISPLAY $DISPLAY; xhost + >/dev/null" &
fi

# Input Manager
echo 'Starting input manager...'
$TRAINS_BASE/bin/tim &
im_pid=$!
trap "kill $im_pid" 0 1 2 3 15

# Give it a moment to get going
sleep 3

# Process Manager
echo 'Starting process manager...'
$TRAINS_BASE/bin/tpm &
pm_pid=$!
trap "kill $im_pid $pm_pid" 0 1 2 3 15

# Give it a moment to get going
sleep 3

# Send the initial startup messages to the PM via the IM using tim_cat
echo 'Starting other modules...'
cat - <<_EOF_ | $TRAINS_BASE/bin/tim_cat
(register :receiver im :name init)
(request :receiver im :content (define-class user :parent any))
(request :receiver im :content (define-class user-input :parent user))
(request :receiver im :content (define-class speech-rec :parent user-input))
(request :receiver im :content (define-class user-output :parent user))
(request :receiver im :content (define-class system :parent any))
(request :receiver im :content (define-class runtime :parent any))
(request :receiver PM
         :content (start :name display
			 :class (user-input user-output)
			 :exec "$TRAINS_BASE/bin/tdisplay"
			 :argv ($TRAINS_BASE/bin/tdisplay -map northeast -iconic -showTextIn False -textOutHeight 60)))
(request :receiver PM
         :content (start :name keyboard
			 :class user-input
			 :exec "$TRAINS_BASE/bin/tkeyboard"
			 :argv ($TRAINS_BASE/bin/tkeyboard -iconic -rows 4)))
(request :receiver PM
         :content (start :name parser
			 :class system
			 :host $lisp_host
			 :exec "$TRAINS_BASE/bin/tparser"))
(request :receiver PM
         :content (start :name ps
			 :class system
			 :host $lisp_host
                         :exec "$TRAINS_BASE/bin/tpsm"))
(request :receiver PM
         :content (start :name pview
			 :class runtime
			 :exec "$TRAINS_BASE/bin/tpview"))
(request :receiver PM
         :content (start :name transcript
			 :class runtime
                         :exec "$TRAINS_BASE/bin/ttranscript"
			 :argv ($TRAINS_BASE/bin/ttranscript -iconic)))
(request :receiver PM
         :content (start :name shortcut
			 :class runtime
                         :exec "$TRAINS_BASE/bin/tshortcut"
			 :argv ($TRAINS_BASE/bin/tshortcut -iconic)))
(request :receiver PM
         :content (start :name scenario
			 :class runtime
			 $scenario_argv
                         :exec "$TRAINS_BASE/bin/tscenario"))
(request :receiver PM
         :content (start :name dm
			 :class system
			 :host $dm_host
                         :exec "$TRAINS_BASE/bin/tdm"
			 :argv ($TRAINS_BASE/bin/tdm -- -debug nil -speech-out nil)))
(request :receiver PM
         :content (start :name splash
			 :class runtime
                         :exec "$TRAINS_BASE/bin/tsplash"
			 :argv ($TRAINS_BASE/bin/tsplash -sex $sex -asksave False)))
_EOF_

# Wait for IM to die
wait $im_pid

# Bye
exit 0
