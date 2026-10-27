# RO quests not guided yet (Renewal)

Quests near the Renewal chapters that `guide.ps1` leaves out for now: each
is a dead end or close to one on a server with a single player. Checked
against rathena-pin (app 1.7.0 pin 8aea17a), 2026-10-25. Every entry says
why, and what could open it.

| Quest (variable, file) | Chapter | Why not guided | Possible fix |
|---|---|---|---|
| Memory of Professor Worm (`ep14_2_profe`, re/quests/quests_eclage.txt) | 13 Eclage | Step 3 wants 20 Star Shape Mushrooms (6542). No Renewal monster drops them and no shop sells them; only the GM NPC hands them out. | A mod that adds the drop (kRO source to check), or a guide up to step 3 only. |
| Juperos Ruins History (`yuno_hist`, quests/quests_juperos.txt) | 7 Juno | Needs one each of the four Transparent Plates (7352-7355), 0.25% from one Dimik kind each: about 1,600 kills. One of the Wandering Bard's stories. | Drop-rate setting, or a mod with better plate rates. |
| Helping Lope and Euridi (`ep14_1_rope`, re/quests/quests_mora.txt) | 12 Mora | 30 Lope's Clues drop only from Parus, which lives only in the Hazy Forest instance. | Guide it with the Hazy Forest instance. |
| Find the Research Tools (`ep14_1_muk`, re/quests/quests_mora.txt) | 12 Mora | Several waits of hours of play time, samples to gather, and the researcher is away from 0:00 to 5:00 server time. | Doable, just long: a guide with the waits named. |
| Theore's Request (`ep14_1_bs`, re/quests/quests_mora.txt) | 12 Mora | A random fairy appears from a bush and you must later describe her (hair, skin, clothes, wings) correctly. | Guide with "note what she looks like"; check the matching table in the script. |
| Chesire's New Day (`ep14_1_cheshir2`, re/quests/quests_mora.txt) | 12 Mora | Needs `ep13_3_secret` > 22, the long Episode 13.3 El Dicastes story. | Guide Ep 13.3 first. |
| Veins Siblings (`rachel_camel`, quests/quests_veins.txt) | 10 Rachel | Needs `MISC_QUEST & 8192`, the end of the Rachel Sanctuary Quest. | Now possible with solo-community-goals (Sanctuary guide `ra_sanctuary`); write its guide next. |
| Rachel Sanctuary Quest (`ra_tem_q`) | 10 Rachel | The temple wants 10,000 donations from the whole server (500 million zeny). | Guided as `ra_sanctuary`, shown when solo-community-goals is on. |
| Nameless Island (`aru_monas`, quests/quests_nameless.txt) and what follows: Thor Volcano Base (`aru_vol`, quests/quests_veins.txt), Peace to Arunafeltz and Rachel Addition (`aru_em`) | - (catalog region 13) | Step 12 of the Nameless Island (High Priest Zhed at `aru_monas == 11`, quests/quests_rachel.txt line 5280) waits for the Sanctuary (MISC_QUEST 8192) and the Veins Siblings done (`rachel_camel == 25`), and Siblings needs the Sanctuary. The Thor Volcano Base starts at Zhed only after the Sanctuary and the Siblings Quest; Peace to Arunafeltz needs the Thor Volcano Base done (`aru_vol == 27`). | Opens with solo-community-goals, like Siblings: guide them after `ra_sanctuary`. |
| Malangdo Island, last part (`ma_tomas` 100 -> 101, re/quests/quests_malangdo.txt) | - (catalog region 21) | Pipielle (malangdo 137,200) wants 30 Unknown Fish (6451). No monster drops it and no shop or script gives it in rathena-pin (db/re, npc). The quest itself ends at 100; only her 200 E Grade Coins are lost. | A mod that adds a source (a fishing spot or a drop), or leave it out. |
| Guild Relay (`guildrelay_q`, quests/guildrelay.txt) | - (excluded) | A guild quest in the castles: needs a guild and its leader. | Leave out. |

Mora (Chapter 12) has no guide yet: all four of its quests are above.

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
