#!/bin/sh
#
# treplay : Script to run TRAINS in replay mode
#
# George Ferguson, ferguson@cs.rochester.edu, 14 Jul 1996
# Time-stamp: <Mon Jan 20 14:54:55 EST 1997 ferguson>
#

TRAINS_VERSION=2.2
TRAINS_BASE_DEFAULT=/u/trains/96/2.2
echo "This is TRAINS-96 v$TRAINS_VERSION replay"

treplay_argv="treplay.pl"
audio=1
while test ! -z "$1"; do
    case $1 in
	-audio) if echo "$2" | grep -is '^t'; then
		    audio=1
		else
		    audio=0
		fi
		shift;;
	*) treplay_argv="$treplay_argv $1";;
    esac
    shift
done


# Set TRAINS_BASE unless set
if test ! -z "$TRAINS_BASE"; then
    echo "Using your TRAINS_BASE=\"$TRAINS_BASE\"" 1>&2
else
    TRAINS_BASE=$TRAINS_BASE_DEFAULT; export TRAINS_BASE
    echo "Using TRAINS_BASE=\"$TRAINS_BASE\"" 1>&2
fi

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

if test $audio = 1; then
  # Use audio on same host as DISPLAY (if not set)
  if test ! -z "$AUDIOFILE"; then
    audio_host=`echo $AUDIOFILE | cut -d: -f1`
    echo "Using your AUDIOFILE=\"$AUDIOFILE\"" 1>&2
  else
    if test ! -z "$TRAINS_AUDIO_HOST"; then
	audio_host=$TRAINS_AUDIO_HOST
	echo "Using your TRAINS_AUDIO_HOST=\"$audio_host\"" 1>&2
    else
	audio_host=`echo $DISPLAY | cut -d: -f1`
	echo "Using audio on \"$audio_host\""
    fi
    AUDIOFILE="$audio_host:0"; export AUDIOFILE
  fi
fi

#############################################################################
#
# Here we go...
#

display_host="`echo $DISPLAY | cut -d: -f1`"
if test ! -z "$display_host" -a $display_host != $current_host; then
    echo "Disabling X access control on $display_host..."
    rsh -n $display_host "setenv DISPLAY $DISPLAY; xhost +" &
fi

if test $audio_host = $current_host; then
    echo "Starting AudioFile server ($AUDIOFILE)..."
    /u/trains/AF/bin/Asparc10 -rate 16000 &
    sleep 3; /u/trains/AF/bin/ahost +
else
    echo "Starting AudioFile server on $audio_host ($AUDIOFILE)..."
    rsh -n $audio_host "/u/trains/AF/bin/Asparc10 -rate 16000 & setenv AUDIOFILE $AUDIOFILE; sleep 3; /u/trains/AF/bin/ahost +" &
fi
au_pid=$!
trap "kill $au_pid" 0 1 2 3 15

echo 'Starting input manager...'
$TRAINS_BASE/bin/tim -nolog &
im_pid=$!
trap "kill $au_pid $im_pid" 0 1 2 3 15

# Give it a moment to get going
sleep 3

echo 'Starting process manager...'
$TRAINS_BASE/bin/tpm &
pm_pid=$!
trap "kill $au_pid $im_pid $pm_pid" 0 1 2 3 15

# Give it a moment to get going
sleep 3

# Send the initial startup messages to the PM via the IM using tim_cat
echo 'Initializing IM classes...'
$TRAINS_BASE/bin/tim_cat <<_EOF_
(register :receiver im :name init)
(request :receiver im :content (define-class user :parent any))
(request :receiver im :content (define-class user-input :parent user))
(request :receiver im :content (define-class user-output :parent user))
(request :receiver im :content (define-class system :parent any))
(request :receiver im :content (define-class runtime :parent any))
_EOF_

# Only start audio and speech-out if they're wanted
if test $audio = 1; then
    echo 'Starting audio modules...'
    $TRAINS_BASE/bin/tim_cat <<_EOF_
(request :receiver PM
	 :content (start :name audio
			 :host $audio_host
			 :exec "$TRAINS_BASE/bin/taudio"
			 :argv (taudio -mic False -linein False
		                -speaker True -jack True -lineout True
			        -inputLevel 0 -outputLevel 60
				-monitorLevel 0)))
(request :receiver PM
	 :content (start :name speech-out
			 :exec "$TRAINS_BASE/bin/tttalk"))
(request :receiver PM
	 :content (start :name sfx
                         :exec "$TRAINS_BASE/bin/tsfx"))
_EOF_
fi

# Send the initial startup messages to the PM via the IM using tim_cat
echo 'Starting other modules...'
$TRAINS_BASE/bin/tim_cat <<_EOF_
(request :receiver PM
	 :content (start :name speech-x
			 :exec "$TRAINS_BASE/bin/tspeechx"))
(request :receiver PM
	 :content (start :name display
			 :exec "$TRAINS_BASE/bin/tdisplay"
			 :argv (tdisplay -map northeast-small)))
(request :receiver PM
	 :content (start :name transcript
			 :exec "$TRAINS_BASE/bin/ttranscript"
			 :argv (ttranscript -nolog)))
(request :receiver PM
	 :content (start :name replay
                         :exec "$TRAINS_BASE/bin/treplay.pl"
			 :argv ($treplay_argv)))
_EOF_

# Wait for a child (IM or PM) to die
wait $im_pid

# Bye
exit 0
