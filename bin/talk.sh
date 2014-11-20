#!/bin/bash

# $1 : sip account
# $2 : contents file

#cp hello.gsm /var/lib/asterisk/sounds/ja/hello.gsm
#cp hello.call /var/spool/asterisk/outgoing/

SOUNDS=/var/lib/asterisk/sounds/ja
OUTGOING=/var/spool/asterisk/outgoing

KEY=jtalk_`uuidgen | sed -e "s/-/_/g"`

SOX=/usr/bin/sox

JTALK_HOME=/usr/src/jtalk
JTALK=${JTALK_HOME}/open_jtalk-1.07/bin/open_jtalk
DIC=${JTALK_HOME}/open_jtalk-1.07/mecab-naist-jdic
VOICE=${JTALK_HOME}/MMDAgent_Example-1.4/Voice/mei/mei_normal.htsvoice


echo $2 | $JTALK \
-x $DIC \
-m $VOICE \
-ow ${SOUNDS}/${KEY}.wav \
-ot ${SOUNDS}/${KEY}.log

$SOX ${SOUNDS}/${KEY}.wav -r 8000 -c 1 ${SOUNDS}/${KEY}.gsm
rm ${SOUNDS}/${KEY}.wav
rm ${SOUNDS}/${KEY}.log



cat << _EOT_ > ${OUTGOING}/${KEY}.call
Channel: SIP/$1
Callerid: "websystem" <${KEY}>
WaitTime: 30
Application: Playback
Data: ${KEY}
_EOT_

find ${SOUNDS}/jtalk_* -ctime +3 -exec rm -f {} \;
