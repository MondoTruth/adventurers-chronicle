# RO quests not guided yet (Renewal)

Quests near the Renewal chapters that `guide.ps1` leaves out for now: each
is a dead end or close to one on a server with a single player. Checked
against rathena-pin (app 1.7.0 pin 8aea17a), 2026-10-25. Every entry says
why, and what could open it.

| Quest (variable, file) | Chapter | Why not guided | Possible fix |
|---|---|---|---|
| Memory of Professor Worm (`ep14_2_profe`, re/quests/quests_eclage.txt) | 13 Eclage | Step 3 (`ep14_2_profe == 3`) wants 20 Star Shape Mushrooms (6542). No Renewal monster drops them and no shop sells them; only the GM NPC (Professor Aide, sec_in02 10,17) hands them out. Checked again with batch 4 (2026-10-27). | A mod that adds the drop (kRO source to check), or a guide up to step 3 only. |
| Juperos Ruins History (`yuno_hist`, quests/quests_juperos.txt) | 7 Juno | Needs one each of the four Transparent Plates (7352-7355), 0.25% from one Dimik kind each: about 1,600 kills. One of the Wandering Bard's stories. | Drop-rate setting, or a mod with better plate rates. |
| Veins Siblings (`rachel_camel`, quests/quests_veins.txt) | 10 Rachel | Needs `MISC_QUEST & 8192`, the end of the Rachel Sanctuary Quest. | Now possible with solo-community-goals (Sanctuary guide `ra_sanctuary`); write its guide next. |
| Rachel Sanctuary Quest (`ra_tem_q`) | 10 Rachel | The temple wants 10,000 donations from the whole server (500 million zeny). | Guided as `ra_sanctuary`, shown when solo-community-goals is on. |
| Nameless Island (`aru_monas`, quests/quests_nameless.txt) and what follows: Thor Volcano Base (`aru_vol`, quests/quests_veins.txt), Peace to Arunafeltz and Rachel Addition (`aru_em`) | - (catalog region 13) | Step 12 of the Nameless Island (High Priest Zhed at `aru_monas == 11`, quests/quests_rachel.txt line 5280) waits for the Sanctuary (MISC_QUEST 8192) and the Veins Siblings done (`rachel_camel == 25`), and Siblings needs the Sanctuary. The Thor Volcano Base starts at Zhed only after the Sanctuary and the Siblings Quest; Peace to Arunafeltz needs the Thor Volcano Base done (`aru_vol == 27`). | Opens with solo-community-goals, like Siblings: guide them after `ra_sanctuary`. |
| Malangdo Island, last part (`ma_tomas` 100 -> 101, re/quests/quests_malangdo.txt) | - (catalog region 21) | Pipielle (malangdo 137,200) wants 30 Unknown Fish (6451). No monster drops it and no shop or script gives it in rathena-pin (db/re, npc). The quest itself ends at 100; only her 200 E Grade Coins are lost. | A mod that adds a source (a fishing spot or a drop), or leave it out. |
| Guild Relay (`guildrelay_q`, quests/guildrelay.txt) | - (excluded) | A guild quest in the castles: needs a guild and its leader. | Leave out. |

Mora (Chapter 12) has no guide yet, but none of its quests is a dead end
(batch 4, below).

Batch 3 of the steps (2026-10-27, regions 14-22) found one new dead end,
Pipielle's Unknown Fish (Malangdo). Not dead ends, but worth knowing: the
Moscovia quests past the Moving Island need it at step 11 (the only way to
mosk_fild02 and the dungeons); the Revolution Quest (Luoyang) needs a party
of 8 where every member makes gunpowder (to verify with party bots); the
Nurse in Port Malaya ends in a memorial that wants a party, even of one.

The rows Nameless Island and Guild Relay were added on 2026-10-26 with `ro-quest-catalog.md`,
the list of every RO side quest on Renewal; the catalog marks each dead end
"dead end, see guide-deferred.md".
Party quests (Party Relay, Unlucky Emerald, Orc's Memory) left this list on
2026-10-26: party bots count as players, so the catalog keeps them with a
`party N` tag (MondoTruth).
Lovers Quest, Murder Quest and Biological Weapon left this list on
2026-10-26 with the batch 2 steps (`ro-quest-steps.md`): Apples are sold
in Einbroch, Hugel and Lighthalzen; Coal drops from Banaspaty, Panzer Goblin
and Obsidian and Hans in the Eden Market Group sells it (Saturday
22:00-24:00 server time); Detrimindexta drops from Deviace and Toad and Dye
the Alchemist in the Eden Market Group sells it. All three now have full
steps.

Batch 4 of the steps (2026-10-27, regions 23-28) found no new dead end, and
four Mora rows left this list: Helping Lope and Euridi (Parus lives in the
Mistwood Maze instance, which a party of one can enter: Laphine Soldier at
bif_fild01 158,340, again 2 h 30 after each entry), Theore's Request (each of
the three fairies has a fixed look in the script, so the description is
written into the steps), Find the Research Tools (only long: waits of 1 hour,
1 day, 6 and 12 hours), and Chesire's New Day (it only needs Episode 13.3 past
22, a Story link). Professor Worm stays: the mushrooms still have no source.
Worth knowing: quest_db `TimeLimit: 4h` (no `+`) ends at 4:00 server time, so
the Renewal "4 h" quests are dailies; the batch 3 wording was fixed in
ro-quest-steps.md and ro-quest-catalog.md.

Batch 5 of the steps (2026-10-27, region 29, the quests of World Sync
Extras 2.1.5) found no new dead end. The item checks now also read
rathena-pin's `db/re/mob_db_world.yml` (the World Sync monsters), which the
earlier batches left out; the Star Shape Mushroom (Professor Worm) and the
Unknown Fish (Pipielle) still have no source there. Worth knowing: the
Devil in the Box's snack wants 100 each of four items that only the Unknown
Basement's Lv 253-255 monsters drop (20-25%); Payon's Soul Cleansing daily
wants 15 Amulets (Munak 0.1%, Bongun 0.08%, Yao Jun 0.5%, no shop); Knight
Tybalt's Turtle Island line needs the boat of the Turtle Island Quest, and
Nahadan's Abyss Lake line needs a Dragon Canine, Dragon Scale and Dragon
Tail to open the lake.
