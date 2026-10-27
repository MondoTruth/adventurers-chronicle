# RO side quests on Renewal: catalog skeleton

Step 1 of the Renewal Side Quests tab (concept v3, 2026-10-26): every side
quest Ragnarok itself has on a Renewal server, grouped Region -> Storyline ->
Quest, with the links between them. Step 2 adds the steps, an explanation
for each and a `/navi map x/y`, region by region, in `ro-quest-steps.md`
(regions 1-13 and the entrances done on 2026-10-26, regions 14-22, 23-28
and 29 on 2026-10-27).

Source of truth: rathena-pin, commit 8aea17a (the app 1.7.0 pin). Every file
named here is loaded on Renewal (`npc/scripts_athena.conf`, which
`npc/re/scripts_main.conf` imports, or `npc/re/scripts_athena.conf`).
Titles come from the script's own section names or `db/re/quest_db.yml`.
Anything not read in the script itself says **to verify**.

## How to read an entry

```
- **Title** - one line on what it is about.
  `file` | variable 0->N (or quest ids) | Lv: the BaseLevel the script checks, or none
  | tags | needs / opens / closes / makes unnecessary
```

- File paths are relative to rathena's `npc/`. `re/` = Renewal only.
- **Lv**: only a check that turns you away (`if (BaseLevel < N) ... close`).
  EXP tiers by level are not a minimum and are left out. "none" = no check found.
- Tags: `opens a place` (dungeon, map, ship, NPC service), `repeatable`
  (daily or other cooldown; the Passport stamps once), `needs a mod`,
  `dead end` (see `guide-deferred.md`), `party N` (needs a party of N or
  more; party bots count as players, MondoTruth 2026-10-26, so these quests
  stay in, shown with the player count), `guided` (already has a guide in
  `guide.ps1`, key given), `side N` (inside Always's Side Quest N in `side.ps1`;
  only RO's own part belongs here).
- Links: **needs** = must be done first (Ragnarok asks first); **opens** =
  this unlocks it (can be a Story episode); **closes** = finishing this makes
  the other one impossible; **makes unnecessary** = the other stays possible
  but is no longer needed.
- Story episodes (12, 13.1-13.3, 14.1-14.3, 15) are the Story tab, not here;
  they appear only as link targets.
- Up to Episode 15 for now (MondoTruth, 2026-10-26): content of Episodes
  16-19 is only named under "Later", to be added with those episodes.
- Region = where the quest starts (MondoTruth, 2026-10-26), with "continues
  in ..." when it goes on elsewhere.
- Episode tag per region: classic Rune-Midgard regions have none; New World 13;
  Mora, Bifrost, Eclage, Flame Basin 14; Verus 15.

## Regions

1. Prontera and Izlude
2. Geffen
3. Payon and Archer Village
4. Morroc and the Sograt Desert
5. Alberta
6. Comodo
7. Umbala
8. Niflheim
9. Juno, Juperos and the Kiel Hyre area
10. Einbroch and Einbech
11. Lighthalzen
12. Hugel
13. Arunafeltz: Rachel, Veins and Nameless Island
14. Amatsu
15. Kunlun
16. Luoyang
17. Ayothaya
18. Moscovia
19. Brasilis
20. Dewata
21. Malangdo
22. Port Malaya
23. The New World: Midgard Camp, Splendide, Manuk, El Dicastes (Episode 13)
24. Mora and Bifrost (Episode 14.1)
25. Eclage (Episode 14.2)
26. Flame Basin (Episode 14.3)
27. Verus and the Phantasmagorika (Episode 15)
28. Rock Ridge
29. Quests from other mods (World Sync Extras 2.1.5)

Then: later (Episodes 16-19), not covered, excluded files, open questions.

---

## 1. Prontera and Izlude

### Storyline: The Geoborg Family Curse (continues in Arunafeltz)
- **The Geoborg Family Curse** - a busy boy in Prontera, historians in Juno and
  Morroc and the curse on the Geoborg family.
  `quests/quests_prontera.txt` | `prt_curse` 0->36/45/56/61 (four endings) | Lv: 60
  | opens: The Nameless Island (13), which needs one of the four endings.

### Storyline: Z-Gang and the Unlucky Emerald (continues in Morroc, Comodo)
- **The Z-Gang** - Prontera's wanted notice: the Z-Gang robbers.
  `quests/quests_nameless.txt` | `zdan_edq` 0->19, quests 3119-3134 | Lv: 71
  | opens: the Rogue Guild Investigation (needs `zdan_edq > 10`); the
  Unlucky Emerald's Man in Hiding only talks differently at `zdan_edq > 12`
  (not needed).
- **Rogue Guild Investigation** - a man from Morroc and the Rogue Guild's
  agents look into a rumour.
  `quests/quests_nameless.txt` | `rumour_nd` 0->22 | Lv: none
  | any class (the `Job_Rogue` checks only change lines) | needs: the Z-Gang
  past step 8 (`zdan_edq > 10`, Rogue Agent line 11540).

### Single quests
- **Prontera Culvert** - the Prontera Knights recruit volunteers against the
  culvert's insects. `quests/quests_prontera.txt` | MISC_QUEST bit 8 | Lv: none
  | opens a place: the Culvert (prt_sewb1).
- **The Spy Quest** - a kid in Prontera; prove or disprove a bard's innocence.
  `quests/quests_veins.txt` | `que_sch` 0->26 | Lv: none | continues in
  Morocc, an Arunafeltz prison (ra_in01), Comodo, the Airship and Einbroch
  (not in Veins itself); the Megaphone costs 500,000 zeny.
- **Eye of Hellion** - an old scholar's search for the Nile Rose.
  `quests/eye_of_hellion.txt` | `HELLIONQ` 0->36..70 | Lv: 60 (line 63
  refuses below 60).
- **The Sign** - three parts through all of Rune-Midgard, ending at the doors
  of Geffenia. Starts at a Sign in any of six towns (Prontera `147,305`,
  Geffen, Morocc, Payon, Al De Baran, Alberta); `re/quests/the_sign_quest.txt`
  only moves a part-1 soldier to `prt_cas 87,214`.
  `quests/the_sign_quest.txt` | `sign_q` 0->142 (fail 200-203), `sign_sq` | Lv: 50
  | needs: the Umbalian Language (7) for the Umbala step (`event_umbala >= 3`)
  | opens a place: Geffenia (gefenia01-04): Lucifer's Lament, from the Queen
  of the Dead after the end, opens a 45-second portal at Geffen's fountain.
- **The Message Delivery** - Erious in Prontera wants a message brought to his
  late wife in Niflheim. `quests/quests_niflheim.txt` | `nif_revive` 0->8,
  MISC_QUEST 16384, quests 11038-11043 | Lv: 80 (at Feylin, Niflheim)
  | continues in Umbala and Niflheim | one try: the spell works 13 times in
  100; a failure ends the quest with the leaves given back.
- **Help Me Shorty** - a black shadow in Izlude: Shorty, a guide you can call
  up. `re/quests/HelpMeShorty.txt` | quests 14688-14695 | Lv: under 31 only
  (`BaseLevel < 31` to start).

Not quests: Edgar's Offer (Izlude, `quests/quests_izlude.txt`, MISC_QUEST 16)
is a cheaper boat ride; the Illusion Investigation team in `prt_in` and the Illusion of the
Labyrinth (Prontera Maze) are Episode 16.2 content (see "Later").

## 2. Geffen

### Single quests
- **The Wandering Bard** (Minstrel) - help the bard in Geffen remember his
  song. `quests/bard_quest.txt` | `gef_bard_q` 0->30/31 (starts in Geffen
  or Morocc) | Lv: none.
- **Orc's Memory** - the Orc Village's statue shows an orc's memory.
  `instances/OrcsMemory.txt` (a memorial dungeon) | `mad`, `yong_odun` 0->2
  | Lv: 30-80 at the statue, 50 for the Mad Scientist | side 5 (RO part
  only) | `party 2`: the statue needs 2+ online party members, all Lv 30-80
  (line 43).

## 3. Payon and Archer Village

### Single quests
- **The Party Relay** - a relay race for a whole party (Payon, Comodo,
  Einbroch, Hugel, Rachel, Veins). `quests/partyrelay.txt` | `party_relay`
  0->32 (per runner), `party_relay_lv`, Mission Tickets 1-12 | Lv: 40
  | `party 6`: the party leader must lead 6+ members and be in a guild
  (lines 39, 114, 163, 204, 348); the runners must be a Swordman, Mage,
  Acolyte, Archer, Thief and Merchant; Lospii's three tasks want 10, 12 and
  14 players around her (`getareausers`) | repeatable.

## 4. Morroc and the Sograt Desert

Story only: Episode 12, Rebirth of Satan Morocc (`rebirth_moc_edq`,
`quests/quests_morocc.txt`, Lv 80).

### Storyline: Muff's Loan -> Broken Diamond -> Unlucky Emerald (starts in Comodo, see 6)

### Single quests
- **The Crow of Fate** - a man in the Morroc ruins and the story of the
  crow of fate, through Prontera and Juno's libraries.
  `quests/quests_morocc.txt` | `barmunt_crow` 0->16, quests 2063-2068 | Lv: 60
  | continues in Prontera, Juno and a cave off the Einbroch field.
- **The Unlucky Emerald** - a ragged man in Morroc and the origin of the
  Unlucky Emerald. `quests/quests_nameless.txt` | `treasure_nd` 0->12, then
  `jewel_nd` 0->31 | Lv: none for the treasure, 66 for the jewel part
  (`treasure_nd > 10 && BaseLevel > 65`) | needs: Broken Diamond done
  (`diamond_edq == 26`, Ibrahim) for the jewel part only | `party 2`: the
  treasure chest opens only for a party of 2+ (line 9909).
- **Pyramid nightmare hunts** - a suspicious cat in the Nightmare Pyramid
  hands out Verit and Mummy hunts. `re/quests/quests_morocc.txt` | quests
  2289-2292 | Lv: none | repeatable.

Not quests: Stop Post and Binoculars in `re/quests/quests_morocc.txt` are
headgear (excluded).

## 5. Alberta

### Storyline: Turtle Island
- **The Turtle Island Quest** - Kinsey's grandfather and the island of the
  Turtle General. `quests/quests_alberta.txt` | `TURTLE` 0->13, MISC_QUEST
  65536, quests 11029-11037 | Lv: none | opens a place: Turtle Island
  (tur_dun01, its dungeon) | side 9 (RO part only).

### Single quests
- **The Alberta Boy** - Iromo and his mother; a boy who never goes out.
  `quests/quests_alberta.txt` | `ep13_2_hiki` 0->13, quests 10079-10089 | Lv: 41
  | needs: the Rekenber Job Quest past 21 (`lhz_rekenber > 21`) and the
  Friendship Quest past 14 (`friendship > 14`), both region 11; two waits
  of one day.

## 6. Comodo

### Storyline: Muff's Loan -> Broken Diamond (continues in Morroc, Alberta, Payon)
- **Muff's Loan** - Muff in Comodo wants his loan back.
  `quests/quests_nameless.txt` | `diamond_edq` 0->14, quests 3100-3109
  | Lv: 61 (refused below 61 at step 3) | opens: Broken Diamond.
- **Broken Diamond** - Ibrahim in the Morroc ruins and a broken diamond.
  `quests/quests_nameless.txt` | `diamond_edq` 14->26, quests 3110-3118
  | Lv: 66 | needs: Muff's Loan | opens: the Unlucky Emerald's jewel part (4)
  | the Rogue Investigator's 10,000-zeny tip is optional (free for Rogues).

## 7. Umbala

### Storyline: The Umbalian Language
- **The Umbalian Language** - the Utan chief teaches you his tribe's tongue.
  `quests/quests_umbala.txt` | `event_umbala` 0->3 | Lv: none
  | closes: Umbala Domestic Dispute | opens: The Sign's Umbala step (1).
- **Umbala Domestic Dispute** - Phrenetan's family quarrel.
  `quests/quests_umbala.txt` | `um_wind` 0->5, then 0 and MISC_QUEST 32768
  | Lv: none; not as a Novice (line 998) | closed for good once you learn
  the language (`event_umbala >= 3`, line 985).

Not quests: the Utan Shaman's Create Essence/Dismantle Stone is a service
(`event_umbala` 4->7, the chief wants a Mr. Smile); excluded as crafting.
The header's "Umbala Skeletal Gate Quest" is the skull door into the
shaman's room (`#Skulldoor`, umbala 221,193): a gemstone test, or open at
`event_umbala >= 7`; an entrance, not a quest.

## 8. Niflheim

### Single quests
- **The Piano Key Quest** - escape from Niflheim: Alreg, Crayu and
  Kuzkahina. `quests/quests_niflheim.txt` (+ `re/quests/quests_niflheim.txt`
  for the last piano spot) | `nif_esc` 0->12, MISC_QUEST 32 | Lv: none
  | opens a place: the Witch's room and a way out of Niflheim to Umbala
  (the spot at nif_in 118,151 works at any time once done).
- The Message Delivery starts in Prontera (1).

## 9. Juno, Juperos and the Kiel Hyre area

### Storyline: Kiel Hyre (continues in Lighthalzen)
- **The Kiel Hyre Quest** - Juno's pub master, Elly of the academy, the
  cottage, the Rosimier mansion and Kiel Hyre himself.
  `quests/kiel_hyre_quest.txt` | `KielHyreQuest` 0->109 (+ `KHCottagePoem1/2`,
  `KHToastGirlEnd`) | Lv: none
  | opens a place: the Robot Factory floor 1 (kh_dun01, at 38) and floor 2
  (kh_dun02, Luxurious Keycard at 108).

### Single quests
- **The Metto Quest** - Metto, a scientist who trusts fate. `quests/quests_yuno.txt`
  | `metto_q` 0->9 | Lv: none (not as a Novice) | guided `yuno_metto` | opens:
  one of the Wandering Bard's stories (29).
- **Juperos Ruins History** - the scholar's files on Juperos.
  `quests/quests_juperos.txt` | `yuno_hist` 0->10 (and `jupe_hist`), quests
  11017-11022 | Lv: none | **dead end** at step 5 (Transparent Plates, see
  guide-deferred.md) | opens: one of the Wandering Bard's stories (29).
- **The Juno Remedy Quest** - Euslan in Juno needs a remedy; her fiance is
  in the Odin Shrine. `quests/quests_hugel.txt` (+ the airship's Kaci and
  Captain Ferlock in `quests/quests_airship.txt`) | `hg_ma1` 0->13, quests
  8044-8052 | Lv: 60 | `party 5`: Eukran is only reached through a Bingo
  game, and the Bingo waiting room starts at 5 players
  (`npc/other/hugel_bingo.txt`). No link to the Heart Fragment Quest: Hallen
  only waits while `hg_ma1 == 3`.
- **The Pile Bunker** - excluded (item).

## 10. Einbroch and Einbech

### Storyline: the Schwarzwald trilogy (continues in Lighthalzen)
- **The Factory Quest** - Einbroch's factory is short of hands.
  `quests/quests_ein.txt` | `EinFactory` 0->16, quests 8017-8031 | Lv: none
  | guided `ein_factory` | each one done adds to `$EinPolution` (smog alert)
  | opens: the Murder Quest's step 6 (`EinFactory > 12`).
- **The Murder Quest** - a sick old man, a maid and a murder in Einbech.
  `quests/quests_ein.txt` | `Shinokas_Quest` 0->11, quests 2071-2078 | Lv: none
  | needs: the Factory Quest past step 12 | opens: the President Quest
  (needed there, `Shinokas_Quest == 11`); the Heart Fragment skips a step
  (`Shinokas_Quest > 9`). The apples at the airship drunk (100+ per try, 7
  tries in 10 lose them) are sold in Einbroch, Hugel and Lighthalzen: not a
  dead end.
- **The Lovers Quest** - Calla and Klitzer in Einbroch and Einbech.
  `quests/quests_ein.txt` | `EIN_LOVERQ` 0->17, quests 8076-8088 | Lv: 60
  | 40 Coal (Banaspaty 5%, Panzer Goblin 2.9%, Obsidian 2.5%, or Hans in the
  Eden Market Group, Saturday 22:00-24:00) and a Tuxedo (Wedding Shop); the
  last talk takes off all equipment (`nude`). Not a dead end.

### Storyline: The Airship
- **Kain's Free Ticket** - a crewman on the airship, the Cherno family and an
  unidentified machine. `quests/quests_airship.txt` | `kain_ticket` 0->15,
  quests 2079-2085 | Lv: none | reward: 4 Free Ticket for Flyship | opens:
  the Unidentified Machine's free repairs (`kain_ticket > 12`).
- **Captain Tarlock: How the Airship Flies** - the brothers Tarlock and
  Ferlock. `quests/quests_airship.txt` | `lght_air` 0->7, quests 8032-8035
  | Lv: 60 (`BaseLevel <= 59` refuses) | opens: the Heart Fragment Quest's
  step 4.
- **The Heart Fragment Quest** - Hallen and Kaci on the airship.
  `quests/quests_airship.txt` | `lhz_heart` 0->13, quests 8036-8043 | Lv: 60
  | needs: Captain Tarlock done (`lght_air == 7`) at step 4.

The Einbroch Laboratory door (Security, a typing test) is the way in for
the Murder and Heart Fragment quests, not a quest of its own.
Excluded: Oridecon/Mineral Stone (`ein_gear1`, an exchange), Uwe Kleine.

## 11. Lighthalzen

### Storyline: Rekenber and the President (needs Einbroch, Hugel)
- **The Rekenber Job Quest** - a job at the Rekenber Corporation (employment,
  not a class change). `quests/quests_lighthalzen.txt` | `lhz_rekenber` 0->23,
  quests 12007-12013 | Lv: 70 (Kazien) | opens: a step of the Alberta Boy (5)
  at `lhz_rekenber > 21`.
- **The President Quest** (Schwarzwald Trilogy) - Ghalstein, the lab, the
  President's mission and the Secret Wing.
  `quests/quests_lighthalzen.txt` | `lhz_boss` 0->44, quests 12015-12028
  | Lv: 60 | needs: the Cube Room (MISC_QUEST 512, step 3) and the Murder
  Quest done (`Shinokas_Quest == 11`, step 11) | opens: one of the Wandering
  Bard's stories (29); the Rebellion Quest (`lhz_boss == 44`); the Cube Room
  early (`lhz_boss == 6`).
- **The Cube Room** - Fishbone and the secret cube room under Lighthalzen.
  `quests/quests_lighthalzen.txt` | `lhz_sincube` 0->10, `lhz_secret01-03`,
  MISC_QUEST 512, quest 12014 | Lv: 60 (or `lhz_boss == 6`)
  | opens a place: the Sewer Pipe into lhz_cube and on to the Bio Lab floor 2
  | opens: the President Quest's step 3.

### Single quests
- **The Cursed Spirit** - spirits in the Bio Lab and the city.
  `quests/quests_lighthalzen.txt` | `lhz_curse` 0->32, `lhz_spi01-04`, quests
  2086-2095 | Lv: none | needs: Handcuffs (7345, Bio Lab monsters) in the
  bag throughout | opens: one of the Wandering Bard's stories (29); the
  Rebellion Quest (`lhz_curse > 30`).
- **The Friendship Quest** - Digotz and Maku, old friends.
  `quests/quests_lighthalzen.txt` | `friendship` 0->16, quests 12000-12006
  | Lv: 50 (Digotz) | opens: Bruspetti (13); the Alberta Boy's last step (5)
  at `friendship > 14`; gives the Pass (7350, line 3091) the Uptown guards let
  through (Gangster Alert below).
- **Gangster Alert** and **the Pickpocket** - not quests: the guards between
  Uptown and the slums let only Pass holders through (the Pass comes from the
  Friendship Quest), gangsters raid on a timer, and "suspicious guys" steal
  10-200 zeny. `quests/quests_lighthalzen.txt` | shown as one line under the
  Friendship Quest ("a pass to Uptown"), no entry of their own.

## 12. Hugel

### Storyline: Hugel's herbs and the Biological Weapon
- **The Medicine Quest** - Allen and Postell Schuwell's herbs.
  `quests/quests_hugel.txt` | `hg_herb` 0->13, quests 8053-8056 | Lv: 50
  | has the 4-second medicine-drawer puzzle (`#DrawerOpener`)
  | opens: Biological Weapon (`hg_herb == 13`).
- **Biological Weapon** - Morriphen in Einbroch and a weapon from Hugel's
  herbs. `quests/quests_hugel.txt` | `hg_bio` 0->9, quests 11009-11016 | Lv: none
  | needs: the Medicine Quest at 13 | 3 Detrimindexta (Deviace 1%, Toad 0.5%,
  Dye the Alchemist in the Eden Market Group) and 5 Coal: not a dead end
  | opens: one of the Wandering Bard's stories (29).

### Storyline: The Rebellion (continues in Lighthalzen)
- **The Rebellion Quest** - Shede and Herico in Hugel and a plot that reaches
  Lighthalzen. `quests/quests_hugel.txt` | `hg_tre` 0->57 | Lv: none
  | needs: the President Quest done (`lhz_boss == 44`), the Cursed Spirit
  past 30 and the Odin Temple Excavation done (`hg_odin == 60`), both at
  step 3 | ends at the President in Juno (`hg_tre` 56->57).

### Single quests
- **The Memory Quest** - Manainne and a spirit in Niflheim.
  `quests/quests_hugel.txt` | `hg_memory` 0->12, quests 8057-8063 | Lv: 50.
- **Hide and Seek** - Torpy hides; his mother is worried.
  `quests/quests_hugel.txt` | `hg_ubu01` 0->9, quests 12044-12048 | Lv: 50
  | needs one Steamed Crab Nippers (cooking).
- **The Fish Cake Soup Delivery** - Cellette's soup for Hugel's people.
  `quests/quests_hugel.txt` | `hg_odeng` 0->10, then 0, quests 8064-8075 | Lv: none
  | repeatable.
- **Cow Milking** - Kurupe and Burupu's cow.
  `quests/quests_hugel.txt` | `hg_milk` 0->13, quests 12040-12043 | Lv: 50
  | repeatable (9->13).
- **The Odin Temple Excavation** - Alex's or Laura's dig team.
  `quests/quests_hugel.txt` | `hg_odin` 0->60, quests 11000-11008 | Lv: 60
  | guided `hg_odin` | opens: one of the Wandering Bard's stories (29); the
  Rebellion Quest's step 3.
- **The Thanatos Tower** - the tower keeper and the guides of Thanatos.
  `quests/thana_quest.txt` | `thana_tower` 0->10, quests 7048-7053
  | Lv: none; class check at the upper portal (2nd class or higher, line 2295)
  | opens a place: the upper Thanatos Tower.

## 13. Arunafeltz: Rachel, Veins and Nameless Island

### Storyline: The Rachel Sanctuary
- **The Lost Child** - Vincent's lost boy in Rachel.
  `quests/quests_rachel.txt` | `lost_boy` 0->13, quests 8089-8098 | Lv: 60
  | guided `ra_lostchild`.
- **The Sanctuary Quest** - the temple's donation lottery and the way into the
  Sanctuary. `quests/quests_rachel.txt` | `ra_tem_q` 0->23 then MISC_QUEST
  8192 | Lv: none | needs: 10,000 server donations (`$rachel_donate`)
  | **dead end** without solo-community-goals (`needs a mod`, guided
  `ra_sanctuary`) | opens a place: the Sanctuary (ra_san); opens: Veins
  Siblings.

### Storyline: The Nameless Island (starts on the airship after the Geoborg Curse)
- **The Nameless Island** - an event switch on the airship, Comodo and the
  cursed monastery. `quests/quests_nameless.txt` | `aru_monas` 0->26
  | Lv: none | needs: the Geoborg Family Curse at an ending (36/45/56/61);
  at step 12 (High Priest Zhed, `aru_monas == 11`) the Sanctuary (MISC_QUEST
  8192) and the Siblings Quest done (`rachel_camel == 25`) | **dead end**
  without the Sanctuary (see guide-deferred.md) | opens a place: Nameless
  Island and the Cursed Abbey.
- **The Siblings Quest** - a boy in Veins saves his little sister.
  `quests/quests_veins.txt` | `rachel_camel` 0->25, quests 3060-3083 | Lv: none
  | needs: the Sanctuary Quest (MISC_QUEST 8192) | **dead end** until the
  Sanctuary is possible (guide-deferred.md: Veins Siblings) | opens: the
  Nameless Island past step 11; the Thor Volcano Base.
- **The Thor Volcano Base** - infiltrate Thor Volcano: what is Arunafeltz up
  to? `quests/quests_veins.txt` | `aru_vol` 0->27, quests 2114-60212 | Lv: none
  | starts at High Priest Zhed (ra_temin 277,159, `quests/quests_rachel.txt`
  line 5582) | needs: the Sanctuary Quest (MISC_QUEST 8192) and the Siblings
  Quest done (`rachel_camel == 25`, line 5280) | **dead end** without the
  Sanctuary (see guide-deferred.md) | opens: Peace to Arunafeltz.
- **Peace to Arunafeltz** - a foreign merchant in the Morroc ruins.
  `quests/quests_nameless.txt` | `aru_em` 0->23, quests 2129-2140 | Lv: none
  | needs: the Thor Volcano Base (`aru_vol == 27`) | **dead end** without the
  Sanctuary, like the Thor Volcano Base | opens: Rachel Addition.
- **Rachel Addition** - Niren and Sippie in the Rachel temple.
  `quests/quests_nameless.txt` | `aru_em` (steps 10-12), quests 2132-2141
  | Lv: none | needs: Peace to Arunafeltz.

### Single quests
- **Bruspetti** - Katinshuell in Rachel. `quests/quests_rachel.txt` | `rach_vice`
  0->24, quests 8106-8122 | Lv: none | needs: the Friendship Quest past 10 (11)
  and its Knife.
- **The Ice Necklace** - Urstia, a sincere follower, and a man stuck in the
  Ice Cave. `quests/quests_rachel.txt` | `ice_necklace_q` 0->7, quests
  2109-2113 | Lv: none | opens: Mohadian buys Glacial Hearts; the Freezing
  Snow Powder wakes Ktullanux.
- **The Stone Quest** - help an old man in Veins with his job.
  `quests/quests_veins.txt` | `veins_stone` 0->8 | Lv: none (Renewal adds the
  old man at ve_fild02 337,314, `re/quests/quests_veins.txt`).

## 14. Amatsu

- **The Amatsu Dungeon Quest** - the lord's sick mother and the fox of the
  palace. `quests/quests_amatsu.txt` | `event_amatsu` 0->6, quests 8131-8135
  | Lv: none | opens a place: the Amatsu Dungeon | side 6 (RO part only).
- **The Momotaro Event** - a publisher in Amatsu and the story of Momotaro.
  `quests/quests_amatsu.txt` | `event_momo` 0->4, quests 8127-8130 | Lv: 30
  | a field trip through the tale on its own map (ama_test), prizes at the end.
Excluded: the Sushi Quest (exchange, see Excluded files).

## 15. Kunlun

- **The Broken Sword** - the chief's treasure, a drinker's tale and the
  smith's granddaughter. `quests/quests_gonryun.txt` | `b_sword` 0->33
  (11, 12, 13, 15 = closed by a wrong answer) | Lv: 51 | needs: the Lost
  Knife (`nakha == 3`, at Zuo Hei) | side 7 (RO part only).
- **The Lost Knife** - Han Ran Jiao. `quests/quests_gonryun.txt` | `nakha`
  0->3, quests 10034-10035 | Lv: 20 | opens: the Broken Sword past step 8.

## 16. Luoyang

- **The Soup Quest** - steal the restaurant's Dragon Soup broth for Jiu
  Lian Bu. `quests/quests_louyang.txt` | `ch_tre` 0->5 | Lv: none (`< 80` is
  a line of dialogue).
- **The Doctor Quest** - Hua Tuo and his patients.
  `quests/quests_louyang.txt` | `ch_par` 0->18 (10 = short ending), quests
  11044-11057 | Lv: 40 | opens: the Poison King's disciple (`ch_par > 9`).
- **The Poison King** - the Poison King's poem quiz and his disciple's
  revenge. `quests/quests_louyang.txt` | `ch_poison` 0->21 (14 = dark
  ending), quests 11070-11083 | Lv: none | needs: the Doctor Quest at
  `ch_par > 9`.
- **The Revolution Quest** - Sun Mao's revolt and the gunpowder expert.
  `quests/quests_louyang.txt` | `QL_REVOL` 0->9, `ch_make` 0/1 | Lv: 50 (the
  leader, at 8 members) | party 8 (every member makes gunpowder: to
  verify with bots).

## 17. Ayothaya

- **The Ayothaya Dungeon Quest** - Dusit, the shaman, the six slates and the
  holy thread. `quests/quests_ayothaya.txt` | `ayodunquest` 0->13, quests
  12035-12039 | Lv: none | opens a place: the Ancient Shrine's 2nd level
  | side 4 (RO part only).
- **The Ayothaya Ring** - a powerful-looking woman and a haggard man in the
  shrine. `quests/quests_ayothaya.txt` | `thai_find` 0->14, quests 12029-12034
  | Lv: none.
- **Tom Yum Goong** - Einon wants the dish. `quests/quests_ayothaya.txt`
  | `tomyumgoong` 0->8, quests 8123-8126 | Lv: none.

## 18. Moscovia

### Storyline: The Moving Island and Koshei
- **The Moving Island** (Whale Island) - Berbayeff, Mr. Ibanoff's ship and the
  Csar. `quests/quests_moscovia.txt` | `mos_whale_edq` 0->41 (91-94 and
  241-244 at sea), quests 18100-18120 | Lv: none | opens a place: the island
  (mosk_fild01, step 4), its far side and the Moscovia dungeons (mosk_fild02,
  mosk_dun01-03, `mos_whale_edq > 38`; no other way in) | opens: Koshei,
  Banish Winter, Help Mikhail's step 9.
- **Koshei the Immortal** - the sage, the gray wolf, Maria Morebna and Baba
  Yaga's golden key. `quests/quests_moscovia.txt` | `rhea_rus_main` 0->53
  (Baba Yaga's errand by class: 11-46) | Lv: none | needs: the Moving Island
  at `mos_whale_edq > 38` | opens: the Red Ring, Lusalka's Hair and the
  Golden Thread (they need `rhea_rus_main == 8` and the Iron Boots worn).
- **The Red Ring** - Vassili Grandpapa and Ryubaba. `rhea_rus_ring` 0->10 (9
  or 10) | needs: Koshei at 8, Iron Boots (2429/2430) worn.
- **Lusalka's Hair** - a worried mother and the water spirit. `rhea_rus_hair`
  0->9 | needs: Koshei at 8, same boots.
- **The Golden Thread** - Marozka's cave and riddles. `rhea_rus_quiz` 0->30
  | needs: Koshei at 8, same boots.

### Single quests
- **Help Mikhail** - Gallina, Anna and Mikhail in the inn.
  `quests/quests_moscovia.txt` | `mos_swan` 0->101 (25, 100, 101), quests
  18060-18069 | Lv: none | needs: the Moving Island at `mos_whale_edq > 38`
  (the swamp in mosk_dun03).
- **Banish Winter** - Baba Yaga the Horrible and the villagers.
  `quests/quests_moscovia.txt` | `mos_nowinter` 0->21, quests 18070-18079
  | Lv: 60 (Baba Yaga, with 40 Yaga's Pestle) | needs: the Moving Island at
  `mos_whale_edq > 38` (her hut is reached from mosk_dun02).
- Excluded: Shafka Hat, Acorn exchange (headgear, exchange), Larissa's
  pancakes (cooking).

## 19. Brasilis

- **The Brasilis Dungeon Access** - Pedro, the curator and the bathroom
  ghost. `quests/quests_brasilis.txt` | `brazil_ghost` 0->8, quests 2208,
  60351-60355 | Lv: 40 (the curator) | opens a place: the Brasilis Dungeon
  (`brazil_ghost > 6`) | opens: the Water Lily's dungeon steps, Iara.
- **The Guarana Candy** - the candy maker. `brazil_gua` 0->11, quests 2192-2200
  | Lv: none.
- **The Water Lily** - botanist Karmen. `brazil_regia` 0->10 | Lv: none
  | needs: the Dungeon Access at 7 (steps in bra_dun02).
- **Lost Puppies** - Angelo's puppies. quests 9030-9032 | Lv: 40 | repeatable
  (daily: until 4:00 server time, quest_db).
- **The Suspicious Beach** - Lucia and the Strange Hydras. quests 9028-9029
  | Lv: 40 | repeatable (until 4:00).
- **Iara** - the shaman and the river spirit. quests 4133-4135 | Lv: 40
  | repeatable (until 4:00, a buff) | needs: the Dungeon Access at 7.
All `quests/quests_brasilis.txt`.

## 20. Dewata

- **The Dewata Legend** - the tribal chief and the sage.
  `re/quests/quests_dewata.txt` | `dew_legend` 0->17, quests 9155-9165 | Lv: 60
  | opens: the Gatekeeper of Krakatau (dew_dun01).
- **Help Out the Old Man** - Memo. `dew_drink` 0->10, quests 5035-5044 | Lv: 60
  | then a daily, until 4:00 (quests 5045-5050).
Excluded: the Traditional Weapon (exchange).

## 21. Malangdo

- **Malangdo Island** - the village chief Tomas and the cats' meeting.
  `re/quests/quests_malangdo.txt` | `ma_tomas` 0->35, then 100 and 101, quests
  11209-11245 | Lv: 60 | Pipielle's last part (101) is a **dead end**: no
  source for Unknown Fish (see guide-deferred.md). The Octopus Cave and the
  Malangdo Culvert memorials are not opened by it.
- **Help the Bad Cats in Danger** - Gobonge's gang. quests 1145-1155 | Lv: 60
  | repeatable (until 4:00).
- **Clean the Ship** - Cleanyang. quests 7260-7275 | Lv: 60 | repeatable (until 4:00)
  | opens: Help Chef Nyas.
- **Help Chef Nyas** - quests 7264-7280 | Lv: 60 | repeatable (until 4:00)
  | needs: Clean the Ship (7264).
- **Play with Baby Cats** - the Meow Team. `nyadven` 0->14, `nyadven02`, quests
  7242-7259 | Lv: 60 | repeatable games after.
- **Cat Gamers** - the director's games. `malang_gamer` 0->20, quests 5058-5090
  | Lv: 60 | repeatable games after.
All `re/quests/quests_malangdo.txt`. Excluded: Archangel Wing enchants.

## 22. Port Malaya

### Storyline: The Cautious Village
- **The Cautious Village** - Rodel the guard, Phong and the six villagers;
  win their trust (the dailies run after it). `re/quests/quests_malaya.txt`
  | `malaya_hi` 0->25, `malaya_diwata`, quests 7350-7410 | Lv: 100 (dailies,
  Imelda) | repeatable parts | opens: Secret in the Woods, Bakonawa, the
  Nurse (all at `malaya_hi >= 20`).
- **Secret in the Woods** - the Buwaya. `malaya_buwaya` 0->15, quests 2271-2281
  | Lv: 100 | needs: Cautious Village at 20.
- **Bakonawa Extermination** - the old legend teller and the village chief.
  `malaya_bakona1` 0->7, `malaya_bakona2` 0->15, quests 1174-1193 | Lv: 120
  | needs: Cautious Village at 20; part 2 needs part 1 at 6.
- **The Nurse in Port Malaya** - the hospital of Bangungot. `malaya_bang`
  0->42 (1-20, 30-36, 40-42), quests 11284-11309 | Lv: 100 | needs: Cautious
  Village at 20 | party 1 (the Bangungot Hospital 2F memorial wants a party,
  even of one).

Excluded: traders, boss equipment upgrades, the Pintados Festival (a timed
festival where Ancient Grudges are handed in).

## 23. The New World (Episode 13)

Story: 13.1 Onward to the Other World (`ep13_ryu`), 13.2 Two Tribes
(`ep13_mdrama`), 13.3 Doha's Secret Orders (`ep13_3_secret`). Most side quests
here check `ep13_ryu > 99 || ep13_start > 99` (13.1 done, or the Cat Paw
passage). Not quests: the Yggdrasil Dungeon Floor 2 devices (a map puzzle,
no variable) and the extra Cat Paw Agents of `quests/quests_13_2.txt` (Cat Paw
Addition: the Trading Post's services by its credit `ep13_yong1`; see
"Entrances without a quest").

### Storyline: toward Splendide (opens 13.2)
- **Finding a Fairy & Finding a Giant Tree** - the small fairy in Splendide's
  field and the Tree Giant. `quests/quests_13_1.txt` | quests 2158, 2159
  | Lv: 70 | no 13.1 check of their own | opens: the Otherworld Language.
- **The Otherworld Language** - learn the Laphine and Sapha tongues; wear the
  Ring of the Wise King (2782). `quests/quests_13_2.txt` | `ep13_2_rhea` 0->12,
  100 | Lv: 70 (the fairy and the giant) | guided `ep13_language` | opens:
  Episode 13.2 (Story), Monster Suppression, the Manuk and Splendide dailies,
  Midgard Ore and Alfheim Perfume, Bazett's note.
- **Monster Suppression** - Manuk Galtun. `quests/quests_13_2.txt`
  | `ep13_2_days01` 0->2, quests 7074-7075 | Lv: none | once (nothing resets
  it) | needs: the Otherworld Language, the ring worn, and 13.2 past 5
  (`ep13_mdrama > 5`).
- **Manuk and Splendide dailies** (Refined Bradium, the Laphine Craftsman,
  Draco eggs, and the once-only "Wanted: Dandelion") - Manuk's engineer, the
  Laphine craftsman, the pet breeder, the wanted sign.
  `quests/quests_13_2.txt` | `ep13_2_dayegg`, `ep13_2_wanted`, quests 7076-7082
  | Lv: none | repeatable (until 4:00) | needs: the Otherworld Language and the
  ring (craftsman, breeder, sign also `ep13_mdrama > 5`).
- **Midgard Ore and Alfheim Perfume** - Dr. Lifeguard in Manuk and the High
  Laphine Grenouille. `quests/quests_13_2.txt` | `ep13_2_tre`, `ep13_2_tre1`,
  quests 2179-2186 | Lv: none | repeatable (18 hours) | needs: the Otherworld
  Language (100) and the ring worn.
- **Secret Note of Bazett** - Bazett Teablack. `quests/quests_13_2.txt`
  | `ep13_2_busut` 0->7, quests 11101-11105 | Lv: none | once (the script never
  resets 7) | needs: the Otherworld Language (100) and the ring worn.

### Storyline: toward El Dicastes (opens 13.3)
- **Sapha's Visit** - guards Ben, Maha and Aello: the way into El Dicastes.
  `re/quests/quests_dicastes.txt` | `ep13_3_invite` 0->6, quests 7182-7197
  | Lv: none | guided `ep13_sapha` | needs: 13.1 | opens: Episode 13.3 (Story),
  Frede's Request, the El Dicastes requests, the Unknown Relics.
- **Frede's Request** - Frede and the six Bradium miners.
  `re/quests/quests_dicastes.txt` | `ep13_3_bra` 0->9, quests 11159-11176
  | Lv: none | needs: Sapha's Visit past 5 and the ring worn.
- **El Dicastes requests** - six citizens hand out hunting, supply and
  transport requests; the department managers take them in.
  `re/quests/quests_dicastes.txt` | quests 12099-12164 | Lv: 80 (Hunting 1:
  97, Hunting 2: 100) | repeatable (one per citizen until 4:00) | needs:
  Sapha's Visit at 6 and the ring worn.
- **Unknown Relics** - the archive's Document Packages and Papyrus.
  `re/quests/quests_dicastes.txt` | quests 12165-12215 | Lv: 80 | repeatable
  | needs: Sapha's Visit at 6 and the ring worn.
- **Removing Traces** - Minister Ahat's Secret Adjutant.
  `re/quests/quests_dicastes.txt` | `ep13_3_ahtdayq`, quests 7200-7201 | Lv:
  none | repeatable (until 4:00) | needs: 13.3 past 18 | closed by: Jeruth
  Hesranta in the Flame Basin (26) at `ep13_3_secret == 24`.
- **Cat Paw Agent (El Dicastes)** - the Cat Paw passage from Morroc to the New
  World. `re/quests/quests_dicastes.txt` | `ep13_start` 0->100 | Lv: 70 | opens
  a place: the New World without 13.1 (`ep13_start` = 100 counts as 13.1 for
  most side quests) | 50,000 zeny.
Excluded: Cat Paw's enchantment (`ep13_3_ring2`).

### Single quests
- **New Surroundings** - Marian shows you the expedition camp.
  `quests/quests_13_1.txt` | `ep13_newbs` 0->24, 100, quests 11084-11100
  | Lv: none | needs: 13.1 (shown in the Story tab after 13.1; mockup v3).
- **Attitude to the New** - the monster scholar and the botanist.
  `quests/quests_13_1.txt` | `ep13_animal` 0->15, 100, quests 2147-2157 | Lv:
  none | needs: 13.1.
- **The Tripartite Union's Feud** - Ryosen, Hue and Hansenne quarrel.
  `quests/quests_13_1.txt` | `ep13_1_rhea` 0->26, 100, quests 8196-8210
  | Lv: none | needs: 13.1.
- **Part Time Work** - breeder Taab. `quests/quests_13_1.txt` | `ep13_alba`
  0->6, quests 7042-7047 | Lv: none | needs: 13.1 | repeatable (5 hours; he
  hires 10 minutes in every 130, 5 places for the server).
- **The Cat Paw Trading Post** - the Cat Paw merchants' credit.
  `quests/quests_13_1.txt` | `ep13_yong1` 0->10, then credit points
  | Lv: none (the guide's 118+ is a range) | guided `ep13_catpaw`
  | repeatable (fish and minerals until 4:00) | opens a place: save point at 3,
  storage at 20, the Cat Warp to Midgard at 40, Jotunheim warps at 100.
- **Report from the New World** - Hibba Agip's report.
  `quests/quests_13_1.txt` | `ep13_1_edq` 0->14, quests 3085-3094 | Lv: none
  | needs: `ep13_newbs + ep13_ryu + mao_morocc2 + ep13_1_rhea + ep13_animal +
  ep13_start > 115` (13.1 at 100 plus 16 from the camp quests) | its part from
  15 leads into Nidhoggur's Nest (Story).
- **Pursuing Rayan Moore** - the pursuit party. `quests/quests_13_1.txt`
  | `mao_morocc2` 0->31, 100, 101-108 (the sweet potatoes), quests 7012-7041
  | Lv: none | needs: 13.1.
- **The Magic Books** - excluded (skill books).

## 24. Mora and Bifrost (Episode 14.1)

Story: 14.1 Mistwood Maze (`ep14_1_mistwoods`). The Mistwood Maze instance
(`re/instances/HazyForest.txt`, Laphine Soldier `bif_fild01 158/340`) wants a
party leader (a party of one counts), no level, again 2 h 30 after entry.

### Storyline: Lope and Euridi
- **Helping Lope and Euridi** - `re/quests/quests_mora.txt` | `ep14_1_rope`
  0->11, quests 1109-1117 | Lv: 100 | 30 Lope's Clue from Parus (Lv 142, only
  in the Mistwood Maze) | opens: Knights of the Neighborhood.
- **Knights of the Neighborhood** - the knights' head in Mora.
  `ep14_1_mora_knight` section | `ep14_1_rope` 11->13, quests 1118-1119 | Lv:
  none | needs: Lope and Euridi (`ep14_1_rope == 11`) | 30 more Lope's Clue.

### Single quests
- **Theore's Request** - a white-gowned man at the camp and a fairy in the
  bushes. `ep14_1_bs` 0->19, `ep14_1_bs2`, quests 11182-11208 | Lv: 100 | the
  fairy's looks are fixed per fairy (Kusmi, Theodore, Pauchon): not a dead end.
- **Find the Research Tools** - the raffle researcher.
  `ep14_1_muk` 0->15, `ep14_1_goki`, quests 5016-5034 | Lv: 100 | long: waits
  of 1 hour, 1 day, 6 and 12 hours; the researcher is away 0:00-5:00.
- **Chesire's New Day** - Cheshire in El Dicastes and on Bifrost. quests
  7206-7210 | Lv: none | needs: 13.3 past 22 (`ep13_3_secret > 22`, Story) |
  repeatable (until 4:00).
- **Mora daily quests** - Elephantine, Hotcha, Bow-wow, Woof-grrr, the Mora
  dealers and the Soul Guide. quests 12225-12253 | Lv: 97 (Elephantine 135) |
  repeatable (until 4:00) | needs: 14.1 at 10 (`ep14_1_mistwoods >= 10`).
All `re/quests/quests_mora.txt`.

## 25. Eclage (Episode 14.2)

Story: 14.2 Encounter in a Strange Land (`ep14_2_mylord`, Lv 99), Light and
Darkness (`ep14_2_etran`, after `ep14_2_mylord > 6`).

### Storyline: Eclage's gate and the Laphines
- **Eclage's Entrance** - the security guards at the gate.
  `re/quests/quests_eclage.txt` | `ep14_2_oliver` 0->3, quests 11310-11311
  | Lv: none | guided `ep14_eclage` | opens a place: Eclage.
- **Oliver Wolf Hood (Dreaming Time)** - a fairy carpenter and Oliver's hood.
  `ep14_2_oliver` 3->30, quests 11312-11337 | Lv: 120 (fairy carpenter) | needs:
  Eclage's Entrance | opens: Laphines That Love the Land (at 5).
- **Laphines That Love the Land (Lost Adventurers)** - Fili and the laphines
  outside the gate, then New Oz in the tower. `ep14_2_nines` 0->6, quests
  13050-13066 | Lv: 100 (Fili) | guided `ep14_nines` (1-3) | needs:
  `ep14_2_oliver > 4` to start | repeatable from 3 and 6 (until 4:00).

### Single quests
- **Wanted to Be Big and Beautiful** - Wuhari. `ep14_2_big` 0->26, quests
  14118-14141 | Lv: 120.
- **The Mystery Burglary** - Daughter Luen's house. `ep14_2_detect` 0->15,
  quests 9225-9262 | Lv: 120.
- **Troublesome Fairies (Prankster of Eclage)** - Eirinn, Bourbon, Cecilia,
  Dominic. quests 4254-4265 | Lv: 120.
- **Memory of Professor Worm** - the professor in the Eclage tower dungeon.
  `ep14_2_profe` 0->12, quests 1214-1228 | Lv: 120 | **dead end** at step 3
  (Star Shape Mushrooms, see guide-deferred.md).
Not a quest: the Teleport Cats (see "Entrances without a quest").
All `re/quests/quests_eclage.txt`.

## 26. Flame Basin (Episode 14.3)

Story: 14.3 Dimensional Travel (`ep14_3_newerabs`, Lv 140, needs
`ep14_2_mylord` past 33).

- **Flame Basin dailies** - Instructor Igrid (Eliminating Risks, Daily
  Cleaning) and Adjutant Abidal (Frost Spider and Fire Wolf, Unending Hunt).
  `re/quests/quests_14_3_bis.txt` | quests 7581-7582, 7594, 7599 | Lv: 140
  (Abidal 160) | repeatable (until 4:00) | Abidal needs Demon God Subjugation
  taken.
- **Magic Scholar and Hishieh** - Collecting Mana, Unending Battle, Wandering
  Orb Magic, Promising Tomorrow. same file | quests 7583-7584, 7595, 7600 |
  needs: `ep14_2_mylord` at 33 (the scholar moves it to 34) | Lv: 140 (Hishieh
  160) | repeatable.
- **Jeruth Hesranta** - Rampaging Box, Collecting Bradiums, Collecting Every
  Day. same file | `ep13_3_secret` 24->27, quests 7578-7580 | Lv: 140 (from 25)
  | needs: 13.3 at 24 | closes: Removing Traces (23) | repeatable from 27.
- **Demon God Subjugation / Fall of the False God / Caged God** - Commander
  Hibba Agip and Guardian Nidhogg. same file | `ep4_3_mockill`, quests
  7593-7598 | Lv: 160 | needs: Morse's Cave done (`ep14_3_mors01`, memorial)
  | opens a place: the Temple of the Demon God (instance, party leader) |
  repeatable.
- **Flaming Basin and Doom Prayers** - the base investigator and the Doom
  Prayers. same file | `ep14_3_fall_bless` 0->13, quests 1264-1297 | Lv: 150.

## 27. Verus and the Phantasmagorika (Episode 15)

Story: 15 To Phantasmagorika!/Atnad excavation (`ep15_1_atnad`, Lv 140).

- **The Wandering Bard** - he tells a story and wants it lived.
  `re/quests/quests_15_1.txt` | quests 4295-4302 | Lv: 99 | guided `ver_bard`
  | needs (one story each): Cursed Spirit, President, Juperos History, Metto,
  Biological Weapon, Odin Temple; his own quest wants all six.
- **The Verus Police** - Chief Kesler and officers Salgran, Gerev, Seiden,
  Piffs. `re/quests/quests_15_1.txt` | `ep15_1_mang`, quests 5304-5318
  | Lv: 140 | repeatable (until 4:00).
- **New Power Source** - Machinist Lloyd. same file | quests 7628-7629 | Lv:
  none | needs: Story 15 past 16 | repeatable (until 4:00).
- **To Phantasmagorika! / Looking for the Traces** - guide Elisha and
  Scarlet. same file | `ep15_1_elb` 0->15, quests 11363-11376 | Lv: none | needs:
  `ep15_1_atnad >= 4` (Story 15) | opens: Vestige (`ep15_1_elb` 15).
- **Monthly Brigan** - Krotzel and the journalists. `re/quests/quests_15_2.txt`
  | `ep15_2_brigan` 0->8, quests 13195-13205 | needs: Story 15 at 19 |
  repeatable from 8 (until 4:00).
- **The Bunker: Restriction on the Journey** - head counts, air purifiers,
  grape harvest, patients, transport. `re/quests/quests_15_2.txt` |
  `ep15_2_memory`, quests 5341-5370 | repeatable (22 hours each) | needs: to
  verify.
- **Vestige / The Final Room** - Du, Mark and Alph in the bunker.
  `re/quests/quests_15_2.txt` | `ep15_2_bslast` 0->9, `ep15_2_bsmemo` 0->16,
  quests 11380-11389 | needs: Story 15 at 19 and `ep15_1_elb` 15.
Not quests: the Reward Coordinator and the contribution certificate machine
(Lv 80); the Doom Prayers event on verus04.

## 28. Rock Ridge

- **Rock Ridge, Land of Opportunities** (main line) - Karam Pucci in Alberta
  and the town of Rock Ridge. `re/quests/quests_rockridge.txt`
  | `rock_main_quest` 0->22, quests 7790-7809 | Lv: 100 | opens a place: Rock
  Ridge (harboro1). Standalone: Karam Pucci asks only `BaseLevel >= 100` and
  `rock_main_quest == 0`; no episode variable, and no other script reads
  `rock_main_quest`. The ship from Alberta costs 10,000 zeny.
- **Cacturon**, **Collecting Ore Fragments**, **Pipe Cleaning**, **Midnight**,
  **Gas! Gas!** - same file | quests 16078-16088, 9458-9461, 14672-14673,
  1298-1299 | Lv: none (Midnight 130/140) | repeatable (until 4:00) | needs: the
  main line at 22.
- **The town's jobs** (the Exotic Merchant, the Food Distributer, the Steel
  Vigilantes, the Desalination Facility) - same file | quests 12381-12411 |
  Lv: 100 (Vigilante #2: 140) | repeatable (until 4:00) | needs: to verify.
- **Mrs. McPhy and Spotty**, **Mr. McPhy** - same file | quests 1321-1332 |
  Lv: 100 | repeatable.

## Entrances without a quest

NPCs that only let you into a harder version of a place: no steps, shown as
"opens a place" with level, price and a /navi (MondoTruth, 2026-10-26).

- **Nightmare Clock Tower** - Belljamin Button (c_tower1 232,222; also
  c_tower2_ 274,26 and c_tower3_ 59,148). `re/quests/quests_aldebaran.txt`
  | Lv: 150 | 10,000 zeny to the warped tower's 2nd or 3rd floor.
- **Nightmare Glast Heim** - Hugin's follower (glast_01 195,273; back from
  gl_chyard_ 148,149 and gl_cas02_ 104,36). `re/quests/quests_glastheim.txt`
  | Lv: none (advice only) | 5,000 zeny to the Monastery Cemetery, 10,000
  zeny to the 2nd floor Corridor.
- **Nightmare Pyramid** - the Suspicious Cat (moc_prydb1 103,54) leads you in
  for 5,000 zeny (to moc_prydn1). `re/quests/quests_morocc.txt` | Lv: none.
  Its hunts are listed in Morroc (4).
- **Teleport Cats** - six Cat Paw cats along the New World (mid_camp 207,234;
  spl_fild02 53,242; man_fild02 135,49; dic_fild01 161,266; bif_fild02 293,325;
  ecl_fild01 118,311). `re/quests/quests_eclage.txt` | Lv: none | 10-55
  Malangdo Canned Specialties or 1,000 zeny a can.
- **Cat Paw Agents** of the New World (mid_camp 62,125; spl_fild02 25,211;
  man_fild02 132,47) - save point, storage (60 zeny) and the Cat Warp by the
  Trading Post's credit (23). `quests/quests_13_1.txt`, `quests/quests_13_2.txt`.

## Later: Episodes 16-19 (not in the catalog yet)

Named so nothing is lost; each gets its regions when its episode comes.

- Episode 16.1, the Royal Banquet: `re/quests/quests_16_1.txt` (`ep16_royal`,
  Lv 100, needs 13.1; the noble families, the royal kitchen, Warrior
  Discipline, the royal prison).
- Episode 16.2-17.1, Terra Gloria and the Rebellion: `re/quests/quests_16_2.txt`,
  `re/quests/quests_17_1.txt` (`terra_gloria_main` and the hideout's quests).
- The Illusion dungeons (16.2, "Terra Gloria - Illusion"):
  `re/quests/quests_illusion_dungeons.txt` - Moonlight (Payon, Lv 100), Vampire
  (Geffen, 130), Frozen (Ice Cave, 110/120), Turtle (Alberta, 150), Luanda
  (Comodo, 160), Underwater (Izlude, 140/180), Anthell (160), Teddy Bear
  (Einbroch, 150), Labyrinth (Prontera, 170); and Commander Joel's Illusion
  Investigation boards, `re/quests/illusion_investigation.txt` (Lv 100-170).
- Episode 17.2, Sage's Legacy: `re/quests/quests_17_2.txt` (`ep17_2_main`, the
  bathhouse, Chirp, the library, the water garden, Cotton).
- Episode 18, Direction of Prayer: `re/quests/quests_18.txt` (`ep18_main`,
  Lv 200; Grey Wolf Village and Rachel's quests, Lv 170).
- Episode 19, Issgard: `re/quests/quests_19.txt` (`ep19_main`, Lv 200).
- Level 175-250 content of those episodes' time: `re/quests/quests_exp_175.txt`
  (Abyss and Glast Heim research, Lv 175-190), `re/quests/quests_dungeons_200.txt`
  (Lv 200-240), `re/quests/garden_of_time.txt` (Lv 250) - to verify with
  MondoTruth that these wait too.

## 29. Quests from other mods (World Sync Extras 2.1.5)

Installed at `%APPDATA%\Ragnarok Offline\state\mods\world-sync-extras`
(v2.1.5, 2026-10-27). Compared with 2.1.2 (`D:\Claude\projects\world-sync-extras`):
no side quest added, removed or changed. 2.1.5 changes only the Jormungandr
story (Episode 20 gains the Drift Ice Zone and Twig's Nest instances, files
`ep20_drift.txt`, `ep20_twignest.txt`; other Episode 20/21 files and the
Jormungandr mob and instance db reworked), Varmundt Chapter 1's memorial
entry (`F_WSV_EnterMd` in `vr_common.txt`, used by `ch1_f_fortress.txt`),
one placeholder fewer (Verkhasel, ve_fild05: 72 instead of 73) and a new
`db/item_db.yml` (job lists of 16 iRO items). The files of the three guided
quests (`criminal_activities.txt`, `eye_of_the_beholder.txt`,
`seoyeon_trial.txt`) are unchanged; every coordinate of `wse_criminal`,
`wse_seoyeon` and `wse_beholder` in guide.ps1 is an NPC header in 2.1.5 and
their variables (`iq_crim`, `iq_beho`, `wsv_sy`, `wsv_sys`) are still used.
Every entry: `needs a mod` (World Sync Extras, block named). File paths are
relative to the mod's `npc/when/`. Story lines of the mod (Episodes 20 and
21, Varmundt chapters 1 and 2) are Story candidates for "Episodes 16-21",
not side quests. Steps: `ro-quest-steps.md` region 29 (batch 5, read in the
2.1.5 files).

- **Criminal Activities** (Agent York, Geffen inn; ends on the domestic
  airship and in Izlude) - `criminal_activities/criminal_activities.txt`
  | `iq_crim` 0->13 | Lv: 70 | guided `wse_criminal`.
- **Eye of the Beholder** (the Beholder on the international airship or by
  Rachel's temple; Beho and Bianca, Rachel) -
  `eye_of_the_beholder/eye_of_the_beholder.txt` | `iq_beho` 61001-61029,
  then 1 | Lv: 50 | guided `wse_beholder`.
- **Seoyeon's Trial** (Amatsu Dungeon) - `varmundt/seoyeon_trial.txt`
  | `wsv_sy` 0->5 | Lv: 70 | guided `wse_seoyeon` | needs: the Amatsu
  Dungeon Quest (region 14), which opens the dungeon.
- **Fantasy Book "Dungeon Food"** (Prontera East Library, new wing) -
  `varmundt/fantasy_dungeon_food.txt` | `wsv_df` 0->15 | Lv: 100
  | repeatable (until 4:00).
- **Overlook Water Dungeon** (The Sign west of Geffen) -
  `overlook_water_dungeon/overlook_water_dungeon.txt` | `iq_owd` 0->5 | Lv:
  30-85 (both ends) | opens a place (`iz_dun00t`-`iz_dun04t`).
- **2021 town quests** - block `town_quests_2021`, one storyline per town;
  each hunt is a story step once, then a daily (until 4:00) shared with the
  Eden Group's mission boards of mod eden-rework-2021:
  - **Morroc**: the old scholar's apprentice - `morroc.txt` | `iq_moc21`
    0->14 | Lv: 40.
  - **Prontera**: the playground, the Orc and Goblin subjugation, Glast
    Heim - `prontera.txt` | `iq_prt21` bits | Lv: none / 40 / 70.
  - **Payon**: the well, the grandson, the fox spirit, and the neighbours'
    requests - `payon.txt` | `iq_pay21` 0->8, `iq_pay_dd`, `iq_pay_side` |
    Lv: none (fox hunt 60).
  - **Geffen**: the tower dungeon - `geffen.txt` | `iq_gef21` bits | Lv:
    55-80.
  - **Izlude**: Instructor Pontes, Byalan, Leader Maxim - `izlude.txt`
    | `iq_izl21` bits | Lv: 20 / 40 / 50.
  - **Alberta**: the shipwreck (`iq_alb21` 0->12, Lv: 40) and Turtle Island
    (`iq_alb21t` 0->6, Lv: 90, needs: the Turtle Island Quest started,
    region 5) - `alberta.txt`.
  - **Comodo**: Que Sera, Sera - `comodo.txt` | `iq_cmd21` 0->9 | Lv: 30
    (the Vigilantes and the Explorer: 60).
  - **Aldebaran and the Juno fields**: the lunch run, the academy, the
    Clock Tower - `aldebaran.txt` | `iq_ald21` bits | Lv: 70 (80).
  - **Einbroch, Einbech, Lighthalzen**: Ernst's letter, the mine, the gas,
    the ghosts - `einbroch.txt` | `iq_ein21` bits | Lv: 80 (Einbech 85).
  - **Hugel**: Abyss Lake (`iq_hu21` 0->3, Lv: 120; the lake wants one
    Dragon Canine, Dragon Scale and Dragon Tail) and the fishermen's
    dailies (Lv: 40-80) - `hugel.txt`.
  - **Juperos**: Maxim's camp, dailies only - `juperos.txt` | Lv: 110.
  - **Rachel and Veins**: three first hunts - `rachel.txt` | `iq_ra21` bits
    | Lv: 90.
- **City Investment** (the City Merchant Union Manager at the Eden Group
  HQ, `moc_para01 53,34`; an Investment Manager and a Union shop in each of
  9 cities) - `city_investment/city_investment.txt` | quest 12370,
  `iq_ci_city[1..9]` | Lv: none | repeatable | one entry. Its Bulletin
  Board (deliveries and weekly Wanted bosses) is a board: listed only as a
  source of Union Insignias.
- **Devil in the Box** (the Mysterious Box, Clock Tower 1F, `c_tower1
  243,202`) - `iro_systems/devil_in_the_box.txt` | quests 5961-5971 | Lv:
  200 (the Unknown Basement, monsters Lv 253-255) | repeatable (meals 20
  hours, special meal weekly).
- Block `star_forest`: the Star Emperor job change is excluded (job quest);
  Herosria's Garden of Dawn gifts and Ash Village are services/trades
  (excluded, to verify). Acolyte training (Izlude Sunken Ship, `iro_systems`)
  is for Acolytes only: excluded as class training (MondoTruth, 2026-10-26).
- Not quests: Masha's street stall staffers
  (`city_investment/street_stall_staffers.txt`, a service), the Commemorative Card Exchange of the Fantasy Series (an
  exchange), the placeholders and @npcplace.

---

## Not covered (to decide)

- **Memorial dungeons** (`npc/instances/`, `npc/re/instances/`: Orc's Memory,
  Hazy Forest, Nidhoggur's Nest, Old Glast Heim, Bakonawa Lake, Buwaya Cave,
  Bangungot Hospital, Octopus Cave, Malangdo Culvert, Isle of Bios, Morse's
  Cave, Temple of the Demon God, ...). Many side quests above end in one. Not
  read for this catalog; Orc's Memory is listed because side 5 uses it.
- Quest NPCs outside the quest folders (`npc/cities`, `npc/re/cities`,
  `npc/merchants`, `npc/re/merchants`), e.g. access NPCs such as dungeon
  gatekeepers. Not searched.

## Excluded files

Job / class quests: `quests/first_class/*`, `re/quests/first_class/*`,
`quests/skills/*` and `re/quests/skills/*` (platinum skills), `quests/okolnir.txt`
(guild), `re/quests/homun_s.txt` (Genetic), `quests/gunslinger_quests.txt`,
`quests/ninja_quests.txt`, `re/quests/ninja_quests.txt` (class gear), the
Alchemist Brothers part of `quests/quests_yuno.txt`, `re/quests/magic_books.txt`
(Warlock/Sorcerer books).

Crafting, headgear, item exchange: `quests/newgears/*`, `re/quests/newgears/*`,
`quests/seals/*`, `re/quests/seals/*` (god items), `quests/cooking_quest.txt`,
`re/quests/cooking_quest.txt`, `quests/bunnyband.txt`, `quests/mrsmile.txt`,
`re/quests/mrsmile.txt`, `quests/monstertamers.txt`, `re/quests/monstertamers.txt`,
`quests/juice_maker.txt`, `quests/mage_solution.txt`, `quests/counteragent_mixture.txt`,
`quests/lvl4_weapon_quest.txt`, `quests/doomed_swords.txt`,
`quests/doomed_swords_quest.txt` (with the Doomed Swords parts of
`quests/quests_comodo.txt` and `quests/quests_yuno.txt`), `quests/quests_geffen.txt`,
`quests/quests_payon.txt`, `re/quests/quest_payon.txt`, `quests/quests_lutie.txt`, Elin's Doll Quest in
`quests/quests_alberta.txt` (dolls for food and potions),
`quests/quests_aldebaran.txt`, the headgear parts of `quests/quests_alberta.txt`
and `quests/quests_comodo.txt`, `re/quests/pile_bunker.txt`, the Oridecon/Mineral
quest of `quests/quests_ein.txt`, Moscovia's Shafka Hat and acorns, the
Malangdo wing enchants, Port Malaya's traders, El Dicastes's Cat Paw
enchantment, the Umbala shaman's essences. Exchange quests count as crafting
(MondoTruth, 2026-10-26): `quests/obb_quest.txt` (Old Blue Box for shells,
Brigan, Cyfar and cookies), Amatsu's Sushi Quest (Heart of Mermaid for sushi
and fish slices), Uwe Kleine in Einbroch (Large Jellopy for furnaces and
hammers), Dewata's Traditional Weapon (Steel, Oridecon, leather for Caress),
Port Malaya's Pintados Festival.

Hunting boards and the Eden Group (MondoTruth, 2026-10-27): the Eden Group
quests (`re/quests/eden/*`: the tutorial, Instructor Boya's and Instructor
Ur's training, the mission boards), the Juno Monster Society
(`re/quests/juno_monster_society.txt`), and World Sync Extras' Bounty Boards
(block `bounty_boards`), Gramps' weekly hunts at the Eden Group (block
`gramps_turn_ins`) and its dungeon-mission givers
(`town_quests_2021/dungeon_dailies.txt`: Morvand, the Traces of Fire, the
Museum Staff, Avril and Tart, Darkess and Chiab, Yerne, Theodore and Niu
Niu, Lartal, Rotert and the Rachel and Veins askers; the file says they
hand out the Eden Group's own dungeon missions, batch 5). The Eden Market Group's shops still count as item
sources.

Needs a guild or War of Emperium: `quests/guildrelay.txt` (dead end: guild
leader of a castle-owning guild), `re/quests/woe_te/*` (WoE TE missions and god
items).

Off in rAthena: `quests/dandelion_request.txt`, `re/quests/cupet.txt`,
`re/quests/eden/eden_iro.txt`, `npc/custom/quests/*`.

## Open questions

None open. Decided on 2026-10-26: up to Episode 15; region = where a quest
starts; entrances without a quest in their own group; exchange quests go with
crafting, story quests stay; City Investment one entry; Acolyte training
excluded. Decided on 2026-10-27: hunting boards and the Eden Group are out
(Excluded files), so the old regions 23-24 are gone and 25-31 became 23-29. Rock Ridge stays (standalone, no episode).
