#!/bin/bash

# Copies the playerdata dir into /var/tmp, just in case something happens.
create_backups () {
    playerdata_dir=$1
    /usr/bin/cp -rp $playerdata_dir /var/tmp/playerdata-$(date +%F_%T)
}

survival_revival () {
    # Files we're working with
    original_file=$1
    working_file=$original_file.yaml

    # Converts the gzipped NBT to yaml for parsing/edits.
    /usr/local/bin/nbt2yaml $original_file > $working_file

    # Checks to see if gamemode is survial. Skips if it's already survival mode.
    if ! /usr/bin/grep -q 'playerGameType: 0' $working_file; then
        # Notification it's running.
        echo "Running  survival revival for file $original_file"

        # Sets gamemode to survival
        /usr/bin/sed -e 's/  - playerGameType: .*/  - playerGameType: 0/g' $working_file > deleteme_survivalset.txt

        # Remove player's current location
        /usr/bin/sed -e '/Pos/{n;N;N;d}' deleteme_survivalset.txt > deleteme_nocoords.txt
        # Insert new location at xyz 0 60 0 
        # Note the escape before the 4 spaces. Spacing is important for NBT.
        /usr/bin/sed -e '/Pos/a \    - !double "0"' \
                     -e '/Pos/a \    - !double "60"' \
                     -e '/Pos/a \    - !double "0"' \
                     deleteme_nocoords.txt > deleteme_newcoords.txt

        # Reset rotation so they're looking at the door to exit.
        # Removes lines for rotation
        /usr/bin/sed -e '/Rotation/{n;N;d}' deleteme_newcoords.txt > deleteme_norotation.txt
        # Adds new rotation in
        /usr/bin/sed -e '/Rotation/a \    - 90' \
                     -e '/Rotation/a \    - 0' \
                     deleteme_norotation.txt > deleteme_newrotation.txt

        # Rename to final version
        /usr/bin/mv deleteme_newrotation.txt deleteme_final.txt

        # Convert from yaml back to NBT for Minecraft usage. Overwrite the oringal file. We have backups.
        /usr/local/bin/yaml2nbt deleteme_final.txt > $original_file

        # Cleanup deleteme files.
        /usr/bin/rm -f deleteme*;
        
    else
        # Notification it's not running.
        echo "Skipping survival revival for file $original_file"
    fi
}

main() {

    # Directory for playerdata
    playerdata_dir="/fio/files/nbtedit/playerdata"
    
    # Create backups in-case we hurt ourselves later.
    # Backups are located in /var/tmp
    create_backups "$playerdata_dir"

    # Get a list of files for us to process.
    playerdata_files=$(ls $playerdata_dir/*.dat)

    for playerdata in $playerdata_files; do
        survival_revival "$playerdata"
    done
}

main
exit 0