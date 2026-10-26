# RO quests not guided yet (Renewal)

Quests near the Renewal chapters that `guide.ps1` leaves out for now: each
is a dead end or close to one on a server with a single player. Checked
against rathena-pin (app 1.7.0 pin 8aea17a), 2026-10-25. Every entry says
why, and what could open it.

| Quest (variable, file) | Chapter | Why not guided | Possible fix |
|---|---|---|---|
| Memory of Professor Worm (`ep14_2_profe`, re/quests/quests_eclage.txt) | 13 Eclage | Step 3 wants 20 Star Shape Mushrooms (6542). No Renewal monster drops them and no shop sells them; only the GM NPC hands them out. | A mod that adds the drop (kRO source to check), or a guide up to step 3 only. |
| Juperos Ruins History (`yuno_hist`, quests/quests_juperos.txt) | 7 Juno | Needs one each of the four Transparent Plates (7352-7355), 0.25% from one Dimik kind each: about 1,600 kills. One of the Wandering Bard's stories. | Drop-rate setting, or a mod with better plate rates. |
| Lovers Quest (`EIN_LOVERQ`, quests/quests_ein.txt) | 6 Einbech | 40 Coal (best source Obsidian 2.5%), a Tuxedo, and `nude` at the end takes off all your equipment. | Coal source to find (kRO shops?); warn about `nude`. |
| Murder Quest (`Shinokas_Quest`, quests/quests_ein.txt) | 6 Einbech | Needs the Factory Quest past step 12 first (guided), then 100+ Apples per try at the drunk on the airship; a failed try (7 in 10) takes all of them. | Guide it after the Factory Quest, with the apple warning. |
| Biological Weapon (`hg_bio`, quests/quests_hugel.txt) | 11 Hugel | Needs the Hugel Medicine Quest (`hg_herb` 13, Allen Schuwell; it holds the 4-second medicine-drawer timing puzzle. Not the Juno Remedy Quest, which is `hg_ma1`) and 5 Coal, 3 Detrimindexta, herbs, Brigan, Cyfar, 20 Shells. One of the Bard's stories. | Guide Medicine + Weapon together once Coal has a source. |
| Helping Lope and Euridi (`ep14_1_rope`, re/quests/quests_mora.txt) | 12 Mora | 30 Lope's Clues drop only from Parus, which lives only in the Hazy Forest instance. | Guide it with the Hazy Forest instance. |
| Find the Research Tools (`ep14_1_muk`, re/quests/quests_mora.txt) | 12 Mora | Several waits of hours of play time, samples to gather, and the researcher is away from 0:00 to 5:00 server time. | Doable, just long: a guide with the waits named. |
| Theore's Request (`ep14_1_bs`, re/quests/quests_mora.txt) | 12 Mora | A random fairy appears from a bush and you must later describe her (hair, skin, clothes, wings) correctly. | Guide with "note what she looks like"; check the matching table in the script. |
| Chesire's New Day (`ep14_1_cheshir2`, re/quests/quests_mora.txt) | 12 Mora | Needs `ep13_3_secret` > 22, the long Episode 13.3 El Dicastes story. | Guide Ep 13.3 first. |
| Veins Siblings (`rachel_camel`, quests/quests_veins.txt) | 10 Rachel | Needs `MISC_QUEST & 8192`, the end of the Rachel Sanctuary Quest. | Now possible with solo-community-goals (Sanctuary guide `ra_sanctuary`); write its guide next. |
| Rachel Sanctuary Quest (`ra_tem_q`) | 10 Rachel | The temple wants 10,000 donations from the whole server (500 million zeny). | Guided as `ra_sanctuary`, shown when solo-community-goals is on. |
| Nameless Island (`aru_monas`, quests/quests_nameless.txt) and what follows: Thor Volcano Base (`aru_vol`, quests/quests_veins.txt), Peace to Arunafeltz and Rachel Addition (`aru_em`) | - (catalog region 13) | Step 14 of the Nameless Island waits for the Veins Siblings done (`rachel_camel == 25`, the Drunkard in ve_in), and Siblings needs the Sanctuary. The Thor Volcano Base starts at High Priest Zhed only after the Sanctuary (MISC_QUEST 8192) and Nameless Island step 11; Peace to Arunafeltz needs the Thor Volcano Base done (`aru_vol == 27`). | Opens with solo-community-goals, like Siblings: guide them after `ra_sanctuary`. |
| Party Relay (`party_relay`, quests/partyrelay.txt) | - (catalog region 3) | From the first talk (lines 204, 348; Lv 40) Ledrion wants the party leader, in a guild, with more than 5 party members; every later step asks the same. | To check: whether the app's Companions count as party members; otherwise leave out. |
| Unlucky Emerald (`treasure_nd`, then `jewel_nd`, quests/quests_nameless.txt) | - (catalog region 4) | Step 7: the Z-Gang's buried chest (moc_fild18 108,116) opens only with 2 or more members in your party (`getpartymember`, line 9909; offline members count too). The whole jewel part needs the emerald from that chest. | Same check as the Party Relay: Companions in the party, or a second character in a party. Steps 1-6 are in `ro-quest-steps.md`. |
| Orc's Memory (`yong_odun`, instances/OrcsMemory.txt) | - (catalog region 2; side 5) | The statue (gef_fild10 242,202) checks `instance_check_party(.@party_id,2,30,80)`: a party of 2+ online members, all Lv 30-80. | Side 5 already tells the memory from Wendel's notes when the statue refuses; same Companions check. |
| Guild Relay (`guildrelay_q`, quests/guildrelay.txt) | - (excluded) | A guild quest in the castles: needs a guild and its leader. | Leave out. |

Mora (Chapter 12) has no guide yet: all four of its quests are above.

The rows Nameless Island, Party Relay and Guild Relay were added on 2026-10-26 with `ro-quest-catalog.md`,
the list of every RO side quest on Renewal; the catalog marks each dead end
"dead end, see guide-deferred.md".
Unlucky Emerald and Orc's Memory were added the same day with step 2,
batch 1 (`ro-quest-steps.md`, regions 1-6).
