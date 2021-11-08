# minecraft-hardcore-revival
Revives players by editing their playerdata.

This was tested on RHEL8. Requires nbt2yaml https://pypi.org/project/nbt2yaml/.

1) pip3 install nbt2yaml
2) clone this repo to wherever
3) Edit the playerdata dir variable and spawn location,
4) Put it in your crontab for whatever time you think is appropreate. I like midnight revives. Use this if you're not familliar with adding crontab entires: https://crontab.guru/

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
