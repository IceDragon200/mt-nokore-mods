# NoKore Player Stats Observer

Provides a simple callback mechanism to observe and trigger events whenever a stat provided by nokore_player_stats changes on a player.

Yes, register_on_player_hpchange exists, but that's the only thing that exists.

Other stats may not provide their own observation (i.e. breath), or has their own observers for different purposes (i.e. mana).

This mod provides a centralized way to just observe ANY stat provided by `nokore_player_stats`, by the good old method of: checking it every tick.
