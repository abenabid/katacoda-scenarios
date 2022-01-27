#!/bin/bash
if test -f /root/lettre.txt.encrypted
then
	echo "done"
else
	exit 1
fi