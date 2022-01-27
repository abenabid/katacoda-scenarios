echo changeit | keytool -list -cacerts -alias self-signed-badssl

if [[ "$?" == "0" ]]
then
	echo "done"
fi