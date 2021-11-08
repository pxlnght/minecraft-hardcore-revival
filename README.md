# minecraft-hardcore-revival
Revives players by editing their playerdata.

This was tested on RHEL8. Requires nbt2yaml https://pypi.org/project/nbt2yaml/.

1) pip3 install nbt2yaml
2) clone this repo to wherever
3) Edit the playerdata dir variable and spawn location,
4) Put it in your crontab for whatever time you think is appropreate. I like midnight revives. Use this if you're not familliar with adding crontab entires: https://crontab.guru/

How?

1) Copies the playerdata dir to /var/tmp with a timestamp.
2) nbt2yaml to uncompress and translate the NBT format to yaml. Honestly, using gunzip to uncompress would have been fine, but I like yaml.
3) Uses grep to see if the player is NOT in survival mode. If they are in survival, skip. If they're in any other mode, process them.
4) Changes the gamemode of the player via playerGameMode (sets to zero for survival).
5) Changes the location of the player via Pos. This is to prevent spectator-in-wall accidental deaths, which are clearly an OSHA violation. (I also built a cool revive shrine and wanted to have them 'revive' in there). (Currently set to xyz 0 60 0)
6) Changes the rotation of the player via Rotation. This is just a flex, I wanted them to be looking at the way out when they spawned. 90 0 points to east. 
7) Converts back to compressed NBT.
8) Copies file over top of existing playerdata. (SCARY, make sure you have backups. I don't care if the script is supposed to do it, make manual copies anyways.)
9) Deletes WIP files used by sed.
10) Done.

Why tho?

1) You're unable to edit offline player's gamemodes via the console or in game as op. 
2) Manually setting players from spectator back to survival was annoying.
3) It's possible to do this via a datapack, but I didn't feel like learning how datapacks work.
4) This is super light weight in terms of resource usage. A datapack would cause more load on the server than this. From my very very quick glance at how datapacks work, it would need to be a per-tick check. 
5) Just to flex, y'know?

Notes:

- Did not bother to cleanup the yaml files created by nbt2yaml. They get overwritten next run anyways.
- Make sure you have good backups.
- I love you too.
