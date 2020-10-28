#!/bin/bash
# copyrekt Shirakami Fubuki class Main Battle Tank 2020
# kiryu coco youtube channel chatbot
# "Fuck you and never come back! " ---- Kiryu Coco, idk-2020

######################################################################################################################################################################
function sendmessage() {
    message="$1"
    [ "$randomchannel" ] && channelno=$((RANDOM%$channels)) || channelno=$((totalmessagesent%$channels))
    finalchannel="${channel["$channelno"]}"
    auth=`echo "$finalchannel" | sed "s/'/\n/g" | grep "Authorization: " | sed 's/Authorization: //g'`
    cookie=`echo "$finalchannel" | sed "s/'/\n/g" | grep "Cookie: " | sed 's/Cookie: //g'`
    onbehalfofuser=`echo "$finalchannel" | sed "s/,/\n/g" | grep '"onBehalfOfUser"' | grep -Eo "[0-9]*"`
    params=`echo "$finalchannel" | sed "s/,/\n/g" | grep '"params"' | sed 's/"params":"//g' | sed 's/"$//g'`
    echo "channel $channelno sendin' message \"$message\""
    curl 'https://www.youtube.com/youtubei/v1/live_chat/send_message?key=AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101 Firefox/83.0' -H 'Accept: */*' -H 'Accept-Language: zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2' --compressed -H 'Content-Type: application/json' -H "Authorization: $auth" -H 'X-Origin: https://www.youtube.com' -H 'Origin: https://www.youtube.com' -H 'Connection: keep-alive' -H "Cookie: $cookie" -H 'TE: Trailers' --data "{\"context\":{\"client\":{ \"clientName\":\"WEB\",\"clientVersion\":\"2.20201023.02.00\"},\"request\":{ },\"user\":{ \"onBehalfOfUser\":\"""$onbehalfofuser""\"}},\"params\":\"""$params""\",\"richMessage\":{ \"textSegments\":[{\"text\":\"""$message""\"}]}}" >/dev/null 2>&1
    echo "channel $channelno finished sendin' message"
    echo
    let totalmessagesent+=1
    sleep "$interval"
}

function wheelbarrow() {
    [ "$randomline" ] && lineno=$((RANDOM%$lines)) || lineno=$((totalmessagesent%$lines))
    sendmessage "${line["$lineno"]}"
}

function cocojoke() {
    cuties=("Ann" "Chie" "Marie" "Yukari" "Fuuka" "Futaba" "Hifumi" "Riley" "Cosette" "Ryza" "Alice" "Barbara" "Sucrose")
    villains=("Kiryu Coco")
    villainquotes=("Fuck you and never come back! ")
    cutie1="Cosette"
    cutie2="Cosette"
    while [ "$cutie1" = "$cutie2" ]
    do
        cutie1=${cuties[$((RANDOM%${#cuties[@]}))]}
        cutie2=${cuties[$((RANDOM%${#cuties[@]}))]}
    done
    villain="$((RANDOM%${#villains[@]}))"
    echo $villian
    sendmessage "$cutie1 chan, $cutie2 chan, and ${villains["$villian"]} were all lost in the desert. "
    sendmessage "They found a lamp and rubbed it. A genie popped out and granted them each one wish. "
    sendmessage "$cutie1 chan wished to be back home. P o o f! She was back home. "
    sendmessage "$cutie2 chan wished to be at home with her family. P o o f! "
    sendmessage "She was back home with her family. ${villains["$villian"]} said, "
    sendmessage "\\\"${villainquotes["$villian"]}\\\":cocobitte:"
}

OLD_IFS=$IFS
IFS=$'\n'

original_parameters="$0"

for parameter in "$@"
do
    original_parameters="$original_parameters '$parameter'"
done

currentdir=`pwd`
parameters=`getopt -o bruhH -a -l random-channel,random-line,cocojoke,help,interval: -- "$@"`

if [ $? != 0 ]
then
    echo "Houston, we have an arsefockin' problem: Unrecognized Option Detected, Terminating....." >&2
    exit 2
fi

if [ $# -eq 0 ]
then
    echo "Houston, we have an arsefockin' problem: You MUST at least provide a parameter" >&2
    exit 1
fi

eval set -- "$parameters"

while true
do
    # echo $@
    case "$1" in
        --random-channel)
            randomchannel="JAJAJAJAJA"
            shift
            ;;
        --random-line)
            randomline="JAJAJAJAJA"
            shift
            ;;
        --cocojoke)
            cocojoke="JAJAJAJAJA"
            shift
            ;;
        --interval)
            interval="$2"
            shift 2
            ;;
        -h | -H | --help)
            echo "copyrekt Shirakami Fubuki class Main Battle Tank 2020"
            echo "kiryu coco youtube channel chatbot"
            echo
            echo "Usage: "
            echo "./dercocogang.sh [options] channelsfile linesfile"
            echo
            echo "Options: "
            echo "  --random-channel: randomize channel"
            echo "  --random-channel: randomize lines"
            echo "  --cocojoke: spam coco joke instead of lines in line file"
            echo "  --interval <sec>: wait for a certain secs before messages, if unset it would be 6 secs"
            echo
            echo "How to get your channel credentials into channel file: "
            echo "  1. use F12 to open up the developer tools, open up \"network\" and set the filter bar with \"send_message\""
            echo "  2. just send a normal message in whatever youtube chatroom you wanna chat (hakushin"
            echo "  3. you will find your own network request, right click it and copy it as cURL command (bash) or cURL command (UNIX)"
            echo "  4. just paste what you copied as a line in channel file, this script would do the rest"
            exit
            shift
            ;;
        --)
            channelsfilepath="$2"
            linesfilepath="$3"
            totalmessagesent=0
            [ "$interval" ] || interval=6
            break
            ;;
        *)
            echo "Internal error!"
            exit 255
            ;;
    esac
done

channels=0
for tempchannel in `cat "$channelsfilepath"`
do
    channel["$channels"]="$tempchannel"
    let channels+=1
done

if [ ! "$cocojoke" ]
then
    lines=0
    for templine in `cat "$linesfilepath"`
    do
        line["$lines"]="$templine"
        let lines+=1
    done
fi

[ "$cocojoke" ] && echo "Found $channels channel(s)" || echo "Found $lines line(s) and $channels channel(s)"

while true
do
    [ "$cocojoke" ] && cocojoke || wheelbarrow
done

IFS=$OLD_IFS
