#!/bin/sh
echo "Created by Endkind Ender (www.endkind.net)"

if [ ! -f "/endkind/server.jar" ]; then
    /endkind/getFolia.sh

    if [ $? -ne 0 ]; then
        exit 1
    fi
fi

while true; do
    if [ -n "$ONLINE_MODE" ]; then
        if [ ! -f "/endkind/server.properties" ]; then
            echo "server.properties not found, server will start with default settings"
        else
            if grep -q "online-mode=" /endkind/server.properties; then
                echo "Updating online-mode to $ONLINE_MODE in server.properties"
                sed -i "s/online-mode=.*/online-mode=$ONLINE_MODE/" /endkind/server.properties
            else
                echo "Adding online-mode=$ONLINE_MODE to server.properties"
                echo "online-mode=$ONLINE_MODE" >> /endkind/server.properties
            fi
        fi
    fi

    java -Xms$MIN_RAM -Xmx$MAX_RAM $JAVA_FLAGS -Dcom.mojang.eula.agree=$MINECRAFT_EULA -jar /endkind/server.jar $FOLIA_FLAGS --nogui
    if [ $? -ne 0 ]; then
        exit 1
    fi
done
