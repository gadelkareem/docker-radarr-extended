#!/usr/bin/with-contenv bash

# create extended directory if missing
if [ ! -d "/config/extended" ]; then
	mkdir -p "/config/extended"
fi

# create scripts directory if missing
if [ ! -d "/config/extended/scripts" ]; then
	mkdir -p "/config/extended/scripts"
else
	echo "Removing previous scripts..."
	rm -rf /config/extended/scripts/*
fi

if [ -d "/config/extended/scripts" ]; then
	echo "Importing extended scripts..."
	cp -r /scripts/* /config/extended/scripts/
fi

# create cache directory if missing
if [ ! -d "/config/extended/cache" ]; then
	mkdir -p "/config/extended/cache"
fi

# create logs directory if missing
if [ ! -d "/config/extended/logs" ]; then
	mkdir -p "/config/extended/logs"
fi

# create configs directory if missing
if [ ! -d "/config/extended/configs" ]; then
	mkdir -p "/config/extended/configs"
fi

if [ ! -f "/config/extended/configs/sma.ini" ]; then
	cp /sma.ini "/config/extended/configs/sma.ini"
fi

echo "Setting up scripts..."
if [  -f "/config/extended/scripts/QueueCleaner.bash" ]; then
	echo "Removing old script, QueueCleaner.bash"
	rm "/config/extended/scripts/QueueCleaner.bash"
fi
echo "Downloading and setting up QueueCleaner.bash"
curl "https://raw.githubusercontent.com/gadelkareem/arr-scripts/main/QueueCleaner.bash" -o "/config/extended/scripts/QueueCleaner.bash"
chmod 777 "/config/extended/scripts/QueueCleaner.bash"

# set permissions
chmod 777 -R /usr/local/sma
find /config/extended -type d -exec chmod 777 {} \;
find /config/extended -type f -exec chmod 666 {} \;
chmod -R 777 /config/extended/scripts
echo "Complete..."
exit
