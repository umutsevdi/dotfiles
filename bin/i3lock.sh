PICTURE=/tmp/i3lock.png
SCREENSHOT="scrot $PICTURE"
BLUR="16x9"
$SCREENSHOT
convert $PICTURE -blur $BLUR -flatten $PICTURE
i3lock -i $PICTURE
rm $PICTURE
