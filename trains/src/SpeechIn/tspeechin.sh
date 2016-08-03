#!/bin/sh
#
# tspeechin : Runs TRAINS version of sphinx with appropriate parameters
#
# George Ferguson, ferguson@cs.rochester.edu, 16 Jan 1995
# Time-stamp: <Fri Jan 10 11:41:29 EST 1997 ferguson>
#
# This script just runs the appropriate (arch-dependent) binary with
# a large bunch of command-line flags.
# This is based on the atis_live script from the Sphinx distribution
# (ie., that's where all the magic numbers are from). I've modifed it
# a bit to pass more stuff through to the -ui_arg argument.
#

usage="tspeech [-sex m|f] [-dictfn file] [-lmfn file]"

if test -z "$TRAINS_BASE"; then
    TRAINS_BASE=!TRAINS_BASE!
else
    echo "$0: using your TRAINS_BASE=$TRAINS_BASE" 1>&2
fi

FBS=$TRAINS_BASE/bin/tsphinx

# Default acoustic models from ATIS
datadir=$TRAINS_BASE/etc/SpeechData/atis

# Default lm and dict files live in separate directory
dict=$TRAINS_BASE/etc/SpeechData/tdc-75/tdc-75.dic
  lm=$TRAINS_BASE/etc/SpeechData/tdc-75/tdc-75.bigram

sex="m"
ui_arg=""
while test $# -gt 0; do
    case $1 in
	-help) 		echo "$usage" 1>&2; exit 1;;
	-sex)		sex="$2"; shift;;
	-dictfn)	dict="$2"; shift;;
	-lmfn)		lm="$2"; shift;;
	*)		ui_arg="$ui_arg $1";;
    esac
    shift
done

 phone=$datadir/atis-test.phone
   map=$datadir/atis-test.map.10000
  dict=${dict:-$datadir/rdb4.dic}
    lm=${lm:-$datadir/atis93.bigram3}
 model=$datadir/hmm-$sex-3
sendmp=$datadir/atis-10ksen-$sex.clstr

#
# beam-widths: there are two beam-widths.  one wrt BestScore, as before,
# and another wrt LastPhoneBestScore (bestscore among only the last phones
# of any word), since LM scores are computed only during transitions to the
# last phone of any word.
#   bw       = overall, widest beam width,
#   npbw     = for pruning transitions from one phone to next,
#   lpbw     = for pruning transitions to last phone,
#   lponlybw = wrt LastPhoneBestScore, for determining which last phones survive,
#   nwbw     = wrt LastPhoneBestScore, for determining which words make it
#              to the lattice.
#

bw=3e-6
npbw=3e-6
lpbw=3e-5
nwbw=1e-3
lponlybw=1e-3

nwpen=1.0
sp=1.0
top=1

lw=8.0
rlw=9.5
uw=0.5
ip=1.15
fp=1e-8

exec $FBS \
	-ui_arg "$ui_arg"	\
	-CepExt mfc		\
	-live TRUE		\
        -normmean TRUE		\
	-nmprior TRUE		\
	-compress TRUE		\
	-compressprior TRUE	\
	-matchscore TRUE	\
	-compondemand FALSE	\
	-forwardonly FALSE	\
	-fwd3g TRUE		\
	-usecitrans TRUE	\
	-usenoisewords	FALSE	\
	-agcmax TRUE		\
	-top $top	 	\
	-fillpen $fp		\
	-nwpen $nwpen		\
	-silpen $sp		\
	-inspen $ip 		\
	-langwt $lw 		\
	-rescorelw $rlw		\
	-ugwt $uw		\
	-beam $bw		\
	-npbeam $npbw		\
	-nwbeam $nwbw		\
	-lponlybw $lponlybw	\
	-lpbeam $lpbw		\
	-lmfn   $lm		\
	-dictfn $dict		\
	-phnfn  $phone		\
	-mapfn  $map		\
	-hmmdir $model		\
	-hmmdirlist $model	\
	-8bsen TRUE		\
	-sendumpfn $sendmp	\
	-cbdir $model		\
	-ccbfn cep.256 		\
	-dcbfn d2cep.256	\
	-pcbfn p3cep.256	\
	-xcbfn xcep.256		\
	-hmmext chmm		\
	-code1ext ccode		\
	-code2ext d2code 	\
	-code3ext p3code	\
	-code4ext xcode 	\
	-hmmsm    0.0000001 	\
	-transsm  0.0001 	\
	-cepfloor 0.0001 	\
	-dcepfloor 0.0001 	\
	-xcepfloor 0.0001 	\
	-latsize 30000		\
	-kbdumpdir $datadir	\
	-matchfn test-$sex.match
