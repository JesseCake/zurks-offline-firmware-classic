#!/bin/sh

ID=`echo "$QUERY_STRING" | awk -F= '{print $2}' | awk -F'&' '{print $1}' | sed -e 's/%2C//g' |  sed -e 's/%20/ /g' | sed -e 's/%3E/>/g' | sed -e 's/%22/"/g'`
echo "Content-type: text/html"
echo ""
echo "<html><head>"
echo "<title>Chumby Multi-Channel Widget Editor wf</title>"
echo "</head>"
echo "<body>"
echo "<h4>Zurk's Multi Channel Widget Editor wf</h4><form name=\"spark\">"
if echo "$ID" | grep -q "channels.c8"; then
echo "Filtering.... "
mv /mnt/usb/lighty/html/zchannel/parameters/parameters.txt /mnt/usb/lighty/html/zchannel/parameters/parametersf.txt
cat /mnt/usb/lighty/html/zchannel/parameters/parametersf.txt | sed -e 's/<widget_parameter>/<parameter/g' | sed -e 's/<\/value><\/widget_parameter>/"\/>/g' | sed -e 's/<name>/ name="/g' | sed -e 's/<\/name><value>/" value="/g'  >/mnt/usb/lighty/html/zchannel/parameters/parameters.txt
rm -f /mnt/usb/lighty/html/zchannel/parameters/parametersf.txt
fi
echo "Executing : $ID<br>"
sleep 5
$ID
sync
echo "</form>"
widget=`echo "$ID" | sed -e 's/.*channels.c/channels.c/' | sed -e 's/\/parameters.txt//'`
echo "<A HREF=\"widget_editor.sh?name=../html/zchannel/$widget\">Return to editor</A>"
echo "</body></html>"
