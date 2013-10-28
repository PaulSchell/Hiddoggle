#!/bin/sh
#script that toggles hiddenfiles on mac osx

#check if os is osx
OSTYPE="unname";
if  [[ "$OSTYPE" =~ ^darwin ]]; then
	echo "Not supported OS, wont execute";
	exit 1;
fi

#vars
osxVersion=$(sw_vers -productVersion);
#echo "OSX-Version: $osxVersion";

#read last actuall state from finder
#state="defaults read com.apple.finder AppleShowAllFiles 2>/dev/null";
state=$(defaults read com.apple.finder AppleShowAllFiles);
#echo "Hiddenfiles Status show: $state";

#set toggle
if [ "$state" == "TRUE" ]; then
	switch=FALSE;
#	echo "switched to false";
else
	switch=TRUE;
#	echo "switched to true";
fi

#comparesion and toggle true or false and run
if(expr "$osxVersion"  ">" "10.9" >/dev/null) then
	defaults write com.apple.Finder AppleShowAllFiles $switch;
elif(expr "$osxVersion" ">" "10.8" || "10.7" || "10.6" >/dev/null) then
	defaults write com.apple.finder AppleShowAllFiles $switch;
else
	echo "Couldnt determine your osx version";
fi

#output state
echo "HIDE FILES: $state";

#kill finder
#echo "Closing Finder to Apply changes";
killall Finder
