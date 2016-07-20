#!/bin/bash

if [ $# -eq 0 ]
  then
    echo ""
    echo "  No arguments supplied."
    echo "  You need to supply at least 1 argument being the folder of the language, e.g. en, fr or nl."
    echo "  With only 1 argument given the script will generate defaults for the other arguments."
    echo "  It is best to supply all 4 arguments."
    echo ""
    echo "  $ gen_voice.sh <language folder> <language> <voice generator> <prefix for zip file>"
    echo ""
    echo "  examples:"
    echo "     ./gen_voice.sh de German google de"
    echo "     ./gen_voice.sh en English fest en-m"
    echo "     ./gen_voice.sh en English google en"
    echo "     ./gen_voice.sh sl Slovenian govorec sl"
    echo ""
    echo " The script requires the sox and mpg123 packages to be installed."
    echo " Also a package for the prolog language, e.g. swi-prolog."
    echo " Be sure that your console/terminal locale matches the character encoding"
    echo " of the source ttsconfig.p file of the language, e.g. UTF8."
    echo ""
    exit 1
fi

CONFIG_FILE=$(readlink -m $1/config.p)
TARGET_FILE=$4
if [ -z $TARGET_FILE ]; then
TARGET_FILE="$1"
fi

ENGINE=$3
if [ -z $ENGINE ]; then
ENGINE="google"
fi

GOAL="gen('g_config.p','$ENGINE')"
mkdir -p work
echo "%%% !!! THIS IS GENERATED FILE !!! Modify ttsconfig.p" > $CONFIG_FILE

[ ! -r $1/ttsconfig.p ] && echo "ttsconfig.p file is missing in language folder!" && exit 1
sed "s/version(10[2-3])/version(0)/g" $1/ttsconfig.p >> $CONFIG_FILE

cp $CONFIG_FILE work/_config.p
sed "s/\"/'/g" $CONFIG_FILE > work/g_config.p
cd work
# clear previous files
# rm -f *.wav *.mp3 $1.zip

[ ! -r ../gen_config.p ] && echo "gen_config.p file is missing!" && exit 1

#default factor for speeding up or slowing down the generated speech
# < 1.0 .. slower
# = 1.0 .. no change
# > 1.0 .. faster
TEMPO_FACTOR="1.0"

echo "Interpreting the ttsconfig.p prolog file..."
if [ $ENGINE = "google" ]; then
	echo "google_gen." >> g_config.p
	prolog -s ../gen_config.p -q -t "$GOAL" > google.$1.sh
	chmod +x google.$1.sh
	echo "Generating voice files using Google online service..."
	./google.$1.sh
elif [ $ENGINE = "govorec" ]; then
	#  Use Slovenian TTS engine eGovorec: http://dis.ijs.si/e-govorec/
	echo "google_gen." >> g_config.p
	prolog -s ../gen_config.p -q -t "$GOAL" > govorec.$1.sh
	chmod +x govorec.$1.sh
	echo "Generating voice files using eGovorec online service..."
	./govorec.$1.sh
	TEMPO_FACTOR=1.3
elif [ $ENGINE = "ispeech_diff" ]; then
	echo "google_gen." >> g_config.p
	prolog -s ../gen_config.p -q -t "$GOAL" > ispeech_$1.sh
elif [ $ENGINE = "ispeech" ]; then
	echo "google_gen." >> g_config.p
	prolog -s ../gen_config.p -q -t "$GOAL" > ispeech_$1.csv
	cp ../$1/voice/* .
	# copy back to track differences
	mv ispeech_$1.csv  ../$1/
else
	echo "google_gen:-fail." >> g_config.p
	prolog -s ../gen_config.p -q -t "$GOAL" > fest.$1
	#festival -b fest.$1
fi

echo "Converting mp3 to wav..."
for t in `ls *.mp3`; do
	W=${t%????}
	mpg123 -w ${W}.wav $t
done

### for t in `ls *.wav` ; do oggenc $t ; done
# function updateFile { Og=${1::-4} && sox $1 r${Og}.ogg reverse && sox r${Og}.ogg ${Og}.ogg silence 1 0.1 0.01% reverse && rm r${Og}.ogg; }
# for t in `ls *.ogg` ; do Og=${t::-4} && sox $t r${Og}.ogg reverse && sox r${Og}.ogg ${Og}.ogg silence 1 0.1 0.01% reverse && rm r${Og}.ogg; done
echo "Reducing the silence..."
# see http://sox.sourceforge.net/sox.html silence
for t in `ls *.wav *.ogg`; do
	Og=${t%????}
	sox $t TEMPreverse_${Og}.ogg reverse
	sox TEMPreverse_${Og}.ogg ${Og}.ogg silence 1 0.1 0.01% reverse
	rm TEMPreverse_${Og}.ogg
done

# change the tempo (speed without altering the pitch),
# see http://sox.sourceforge.net/sox.html tempo
if [ $TEMPO_FACTOR != "1.0" ]; then
	echo "Changing tempo by factor $TEMPO_FACTOR ..."
	for Og in `ls *.ogg`; do
		cp ${Og} TEMPslow_${Og}
		sox TEMPslow_${Og} ${Og} tempo -s $TEMPO_FACTOR
		rm TEMPslow_${Og}
	done
fi

touch .nomedia
echo "Packaging voice files..."
echo "Voice Data $2 ($TARGET_FILE)" | zip ${TARGET_FILE}_0.voice.zip _config.p -c
zip ${TARGET_FILE}_0.voice.zip *.ogg .nomedia
rm -f *.wav *.mp3
rm -f *.ogg *.p

echo ""
echo "### You can find your zipped voice file ${TARGET_FILE}_0.voice.zip in the folder work ###"
echo ""
