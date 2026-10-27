# RO side quests on Renewal: the steps

Step 2 of the Renewal Side Quests tab: the steps of every quest in
`ro-quest-catalog.md`, same regions, same numbers, same order. Batch 1
(2026-10-26): regions 1-6 and "Entrances without a quest". Batch 2
(2026-10-26): regions 7-13, the Party Relay and the Unlucky Emerald's jewel
part. Batch 3 (2026-10-27): regions 14-22. Batch 4 (2026-10-27): regions
23-28 and two more entrances. Batch 5 (2026-10-27): region 29, the quests of
World Sync Extras 2.1.5 (its own source of truth is the mod's files).

Source of truth: rathena-pin, commit 8aea17a (the app 1.7.0 pin). Every
coordinate, item, count, level and variable value below was read in the
script named under the quest title. Anything not read there says **to
verify**.

## How to read a step

```
N. **Short title** - what to do (NPC, what to choose or bring, counts).
   Why: one sentence of the story.
   `/navi map x/y` | done when: `variable >= value`
   Branches / fails: what goes wrong and what it costs.
```

- `/navi` uses rAthena's own map coordinates (the NPC header line).
- "done when" is the value the step leaves behind, so the Journal can tick
  it: the step is done once the variable has reached it (`>=` unless the
  quest has branches; then the exact values are given).
- Item names come from `db/re/item_db_*.yml`, quest titles from
  `db/re/quest_db.yml`.
- Choices are quoted as the menu shows them.
- **Reward** is RO's own (EXP as `base/job` on Renewal, `checkre` value).
- A dead end stops at the blocker: "dead end, see guide-deferred.md".
- **Players: N** marks a quest that needs a party of N or more; party bots
  count as players (MondoTruth, 2026-10-26).
- Cooldowns come from `db/re/quest_db.yml`. `TimeLimit: 4h` (no `+`) is a
  clock time: the wait ends at the next 4:00 server time, so such a quest
  is a daily. `TimeLimit: +4h` is a length: 4 hours after it starts.

---

## 1. Prontera and Izlude

### The Geoborg Family Curse
`quests/quests_prontera.txt` | `prt_curse` 0->36/45/56/61 | Lv 60 (the Busy
Boy only reacts at `BaseLevel > 59`). Every NPC first checks that you have
2,000 weight free and a free slot, or sends you to the Kafra.

1. **The busy boy** - walk into the Busy-Looking Boy in Prontera; he drops his
   books. Choose "Help him pile the books", then "Are these all yours?", then
   "Help him" to take his Pile of Books to Juno.
   Why: he must deliver books from the Prontera Library to a client in Juno,
   but he is too airsick to ride the Airship.
   `/navi prontera 248/212` | done when: `prt_curse >= 3` (you hold 1 Pile of Books)
   Branches: "Leave" sets 1 and "Don't help him" sets 2; talk to him again and
   choose "Help him". Lost the books? The Librarian in the Prontera Library
   (`/navi prt_in 162/99`) sells a new pile for 700 zeny while `prt_curse == 3`.
2. **Mr. Karlomoff** - give the books to Historian Karlomoff near the Juno
   Library.
   Why: the books are his; he studies the old royal families of Rune-Midgarts.
   `/navi yuno 311/195` | done when: `prt_curse >= 4` (books taken)
3. **The founding song** - talk to Karlomoff twice more: he tells of the
   Rekenber research group and the royal families, then sings a children's
   song about the kingdom's founding and hands you his report.
   Why: he wants the report taken to his colleague and rival in Morocc.
   `/navi yuno 311/195` | done when: `prt_curse >= 6` (you hold 1 File Folder)
   Note: "Can I listen to that song again?" repeats the song; you will have
   to type it later.
4. **Historian Rodafrian** - give the File Folder to Rodafrian in Morocc.
   Choose "Ask her about her research", then "Yes, I have." and type the line
   that follows the song's first two: `Then the eagle built its nest.` (or
   "Yes, but it is different." and type all four lines, one per box:
   `The great serpent swallowed the sea.` / `The eagle of the rainbow
   swallowed the serpent.` / `Then the eagle built its nest.` / `A nest upon
   the swallowed sea.`). Then give your name.
   Why: she cannot remember the song and wants the version Karlomoff found.
   `/navi morocc_in 45/126` | done when: `prt_curse >= 8`
   Fails: a wrong line sets 7 and takes the File Folder; talk to her again,
   give your name, and the quest goes on (to 8) all the same.
5. **Historian Mondo** - find Mondo on Mt. Mjolnir and type the same four
   lines of the song, one per box, exactly as above.
   Why: Rodafrian sent you for his lyrics; his version ends with snake scales
   growing on the eagle.
   `/navi mjolnir_01 135/168` | done when: `prt_curse >= 10`
   Fails: any wrong line sets 9; talk to him again and retype.
6. **The boy who sings** - talk to Mondo once more (11), then go down to the
   river in the east of the mountain: the boy Kaanu and his mother are there
   (song lines appear as you walk by). Talk to either and choose "What did
   you just sing?".
   Why: Mondo learned his version from a child singing near the river.
   `/navi mjolnir_01 313/269` | done when: `prt_curse >= 12`
7. **Bonnie's herbs** - talk to the Exhausted-Looking Woman (Bonnie Imbullea),
   choose "Accident?" and take her Leather Pouch of herbs.
   Why: she lives in exile for something she did, and sends thanks to the
   priest who stood by her.
   `/navi mjolnir_01 316/268` | done when: `prt_curse >= 13`
8. **Father Bamph** - in Prontera Church, give Father Bamph the Leather Pouch
   (14), then talk to him twice more: Jormungand's curse on the Geoborg
   first-born, the failed exorcism, the princes who died with snake-scale
   marks; you tell him the song.
   Why: the song you heard tells the royal family's secret curse.
   `/navi prt_church 185/106` | done when: `prt_curse >= 16`
9. **Back to Bonnie** - ask Bonnie Imbullea about the song and the exorcism.
   Why: she remembers a maid finding a fragment of Red Gemstone in the secret
   ceremonial grounds after the exorcism failed.
   `/navi mjolnir_01 316/268` | done when: `prt_curse >= 17`
10. **The secret ceremonial grounds** - tell Father Bamph about the Red
    Gemstone (18), click the bookshelf near him to go down, and talk to
    Father Bamph there (19).
    Why: a Red Gemstone has no place in a holy room; maybe the exorcism was
    sabotaged.
    `/navi prt_church 177/113` (bookshelf), `/navi prt_church 16/114` (Bamph
    below) | done when: `prt_curse >= 19`
11. **The three princes** - examine the bodies left to right: the first prince
    (20), the second (21), the third (22). At the third choose "Poison!"
    ("A weapon!" only loops back).
    Why: the marks on the second and third princes are darker; they may have
    been murdered.
    `/navi prt_church 19/111`, `21/111`, `24/111` | done when: `prt_curse >= 22`
    Note: to go back up, talk to Father Biscuss below (`/navi prt_church
    23/89`) and choose "Yes".
12. **Ask the Assassins** - talk to Father Bamph upstairs (23), then to the
    Assassin Guildsman in the desert: choose "Poison".
    Why: Bamph needs a way to prove poison; the Assassins are the experts.
    `/navi prt_church 185/106`, then `/navi moc_fild16 201/295` | done when:
    `prt_curse >= 24`
13. **Marjana** - in Morocc, step on the Assassins' bar door (`/navi morocc
    45/110`), walk through to the inner door (`/navi que_job01 80/77`):
    choose "Sure" and pay 1,000 zeny for Litheron's drink. Step on the room
    door (`/navi que_job01 51/55`): you get 4 minutes in the room. Talk to
    Marjana inside.
    Why: Marjana knows poisons: a Yellow Gemstone dissolved in a Green Potion
    shows one, and scale marks point to a poison from outside the kingdom.
    `/navi que_job01 10/16` | done when: `prt_curse >= 25`
    Fails: "Why should I?!" or 1,000 zeny or less puts you back at the door;
    one player at a time in the room ("Someone else is already inside": come
    back later); after 4 minutes you are put out. The bar is in
    `quests/quests_13_1.txt` (the copy in `quests/quests_morocc.txt` is
    commented out).
14. **Choose: Rodafrian or Bamph** - leave the bar; at the door outside
    (`/navi morocc 45/103`) you think it over: "Go to Rodafrian" (30) or
    "Go to Father Bamph" (50). This picks the ending.
    | done when: `prt_curse == 30` or `prt_curse == 50`
15. **Path "Go to Rodafrian"** (30) - at Rodafrian choose "Tell her about
    Jormungand's curse" (31) or "Don't tell her" (40).
    `/navi morocc_in 45/126` | done when: `prt_curse == 31` or `== 40`
16. **The poison test** - tell Father Bamph what Marjana said (32 / 41 / 51);
    bring 1 Yellow Gemstone and 1 Green Potion down to the third prince and
    use them (33 / 42 / 52, both taken); talk to Father Bamph below (34 / 43
    / 53); then to Father Bamph upstairs.
    Why: the mark vanishes: the princes were poisoned, not cursed.
    `/navi prt_church 185/106`, `/navi prt_church 24/111` | done when:
    `prt_curse` 35 (told Rodafrian), 44 (did not tell) or 54 (went to Bamph)
17. **Endings**
    - 35: talk to **Father Biscuss** in the church (`/navi prt_church
      184/110`): 36 and 90,000 base EXP. (Bonnie also sets 36 at 35, but
      without the EXP: see Biscuss first.)
    - 44 (EXP came from Bamph in step 16): tell **Bonnie Imbullea** she was
      not to blame: 45.
    - 54 (EXP from Bamph): Bonnie (55), then **Rodafrian**: "Tell her about
      Jormungand's curse" (60), then **Father Bamph** (61); "Don't tell her"
      ends at 56.
    | done when: `prt_curse` is 36, 45, 56 or 61
    Reward: 90,000 base EXP, once (Biscuss at 35, or Bamph at 43 / 53).
    Opens: the Nameless Island (region 13), at Father Bamph, after any ending.

### The Z-Gang
`quests/quests_nameless.txt` | `zdan_edq` 0->19, quests 3119-3134 | Lv 71
(the Chief Officer wants `BaseLevel > 70`).

1. **The Wanted Notice** - read the National Wanted Notice in north Prontera.
   Why: Louis Von Silokens, Martha Hertizan and Catfoii, the Z-Gang, are wanted.
   `/navi prontera 150/326` | done when: `zdan_edq >= 1`
2. **The Chief Officer** - talk to the Chief Officer beside it.
   Why: the Homeland Security Office wants any word on the gang.
   `/navi prontera 148/326` | done when: `zdan_edq >= 2`
   Fails: at Lv 70 or less he turns you away.
3. **Valdes** - find Valdes, a drunk ex-knight, indoors in Prontera, and
   choose "Ask About Z Gang".
   Why: he hunted the gang and lost his post for failing.
   `/navi prt_in 168/18` | done when: `zdan_edq >= 3`
4. **Five bottles of wine** - bring Valdes 5 Morocc Fruit Wine (taken).
   Why: he talks only for wine; he gives you the Rogue Marybell's password,
   "The dawn is yet to come."
   `/navi prt_in 168/18` | done when: `zdan_edq >= 4`
   Note: Morocc Fruit Wine is cooked (Level 4 Cookbook: 10 Strawberry,
   4 Lemon, 10 Orange, 2 Alcohol, 5 Grape, `db/re/produce_db.txt`); the
   Chef Assistant in Prontera sells the cookbook (`/navi prontera 156/212`).
   The only drop is the Payon Soldier in Sara's Memory (an instance).
5. **Marybell** - in the Rogue Guild (way in: `/navi cmd_fild07 193/117`),
   talk to Marybell, choose "Password", type `The dawn is yet to come.`, then
   "Ask About Z Gang".
   Why: the Rogues hunt the gang too; she trusts you only if the White
   Meteor does.
   `/navi in_rogue 359/116` | done when: `zdan_edq >= 5`
6. **The White Meteor** - in Payon, Moonho Ahn: "I'm here to challenge you."
   (6), then "Yes, let's play!" and win Coin Shake, best two of three
   rounds, 500 zeny a game (have more than 500). When you guess, type `Odd`
   or `Even`; when he guesses, pick either. It is pure luck.
   Why: beating the old gambler earns his mark on your wrist.
   `/navi payon 244/62` | done when: `zdan_edq >= 7`
   Fails: a lost game costs only the 500 zeny; play again.
7. **Marybell's intel** - show Marybell the mark (8), then ask all three of
   "Z Gang's Goal", "Z Gang's Recent Movements", "Z Gang's Stronghold" and
   choose "Thanks for the tip!".
   `/navi in_rogue 359/116` | done when: `zdan_edq >= 9`
8. **The informer** - in the Morocc ruins walk up to the Suspicious Man (at
   one of two spots); he attacks, runs and drops a note (10). Find him at
   the other spot and talk to him.
   Why: he is a Z-Gang informer; the hideout is in South Morocc, behind a
   password.
   `/navi moc_ruins 90/67` or `/navi moc_ruins 75/171` | done when: `zdan_edq >= 11`
   Fails: if someone else just met him (30-second lock), come back later.
9. **The blank letter** - tell Marybell (12); take the Rogue Guild's decoding
   request to Gooho Ahn in Payon (13) and bring him 20 Live Coal,
   1 Matchstick, 2 Alcohol, 10 Burning Heart (taken).
   Why: the informer's letter is in invisible ink, written in the jumbled
   Aegye tongue.
   `/navi payon 192/176` | done when: `zdan_edq >= 14`
   Note: write down the letter: "Weii arr prowd Z G gna / Aynoen hwo sspotp
   uys / wlil eb kckide on htier ssa!"
10. **The hideout** - tell Marybell (15). In the desert south of Morocc talk
    to the Odd Slab and type the three lines, one per box:
    `Weii arr prowd Z G gna`, `Aynoen hwo sspotp uys`,
    `wlil eb kckide on htier ssa!`. You are let in (16).
    `/navi moc_fild17 209/235` | done when: `zdan_edq >= 16`
    Fails: a wrong line shuts the slab; try again. One player at a time.
11. **The guards** - inside, Catfoii calls 2 Skeleton Prisoners (Lv 91) and
    1 Firelock Soldier (Lv 88). Kill all three within 5 minutes.
    `/navi z_agit 98/78` | done when: `zdan_edq >= 17`
    Fails: after 5 minutes you are put out at the slab (`zdan_edq` stays 16);
    type the lines again.
12. **The gang** - talk to Louis, Martha or Catfoii: they hand over the Book
    of Forbidden Mystery (item Forbidden Secret Art) and you are put out.
    `/navi z_agit 97/101` | done when: `zdan_edq >= 18`
13. **Report** - give the Forbidden Secret Art to the Chief Officer.
    `/navi prontera 148/326` | done when: `zdan_edq >= 19`
    Reward: 100,000 base EXP.
    Opens: the Rogue Guild Investigation (needs `zdan_edq > 10`, step 8);
    the Unlucky Emerald's Man in Hiding (needs `zdan_edq > 12`, step 9).

### Rogue Guild Investigation
`quests/quests_nameless.txt` | `rumour_nd` 0->22 | Lv none. Any class: the
Rogue Agent takes you once `zdan_edq > 10` (Z-Gang step 8). Some NPCs say
other lines, or send you round once more, when `zdan_edq <= 12`.

1. **Rumours** - by the Prontera fountain, the Man from Morocc: "How's Morocc
   lately?", then "What crazy rumors?".
   `/navi prontera 163/204` | done when: `rumour_nd >= 1`
2. **The Rogue Agent** - in the Rogue Guild, the Rogue Agent: "Can I help?"
   (needs `zdan_edq > 10`), then talk again.
   Why: the Rogues trace odd crimes in every town.
   `/navi in_rogue 355/28` | done when: `rumour_nd >= 3`
3. **Al De Baran** - take the report of the Rogue Agent in south Al De Baran.
   `/navi aldebaran 114/56` | done when: `rumour_nd` 4 (`zdan_edq > 12`) or 24
   Branch: at 24 take it to the Rogue Agent in the guild first (25), who
   sends you on to Geffen.
4. **Geffen** - give it to the Rogue Guild Agent in south Geffen and bring
   proof the Geffen Tower ghosts stay inside: 1 Jack o' Pumpkin,
   1 Horseshoe, 1 Little Evil Horn, 1 Golden Hair, 1 Fabric (taken).
   Why: the Z-Gang spreads rumours of ghosts pouring out of the tower.
   `/navi geffen 91/36` | done when: `rumour_nd >= 6`
   Branch: on the 25 path with `zdan_edq <= 12` (26) he takes 2 Jack o'
   Pumpkin, 3 Horseshoe, 2 Little Evil Horn, 3 Golden Hair, 1 Fabric.
5. **Payon** - the Rogue Guild Agent in south Payon: "I'm here to help a
   Rogue Agent!", then either answer.
   `/navi payon 209/44` | done when: `rumour_nd >= 8`
6. **The black well** - talk again and bring 1 Green Herb (taken).
   Why: the Z-Gang "poisoned" a well; the agent, who cannot read, mixes up
   his herbs.
   `/navi payon 209/44` | done when: `rumour_nd >= 11`
   Branch: with `zdan_edq <= 12` he asks for a Red Herb (10); bring the
   Green Herb anyway.
7. **The counteragent** - talk again and bring 1 Alcohol (taken).
   `/navi payon 209/44` | done when: `rumour_nd >= 15`
   Branch: an Alchemist can choose "Wait, Karvodailnirol?!" (12, one
   Alcohol). Anyone else gets 14: he used the wrong ingredient; bring a
   second Alcohol.
8. **Payon's report** - talk again: he sends you to Comodo (18) or, by
   mistake, to Al De Baran (16).
   `/navi payon 209/44` | done when: `rumour_nd` 16 or 18
   Note: at 16 go straight to Comodo (it takes 16 or 18).
9. **Comodo's drill** - the Rogue Guild Agent in Comodo: "Yes, Sir!" twice
   and "Bring monster masks!" (19). Come back with any one of these in your
   inventory and answer "Yes, Sir!": Mr. Smile, Opera Masque, Opera Phantom
   Mask, Mr. Scream, Welding Mask, Goblin Mask, Gas Mask, Alarm Mask, Poker
   Face, Surprised Mask, Annoyed Mask, Goblin Leader Mask, Hahoe Mask,
   Smiling Mask, Tiger Mask, Zealotus Mask, Lion Mask, Mythical Lion Mask,
   Bride Mask, Kabuki Mask (not taken).
   Why: he takes you for a Rogue trainee and drills you before he reads the
   note.
   `/navi comodo 233/199` | done when: `rumour_nd >= 20`
   Fails: "..." or "Uh huh." only means asking again. He gives one random
   level 4 stat dish as an apology.
10. **Morocc** - report to the Rogue Guild Agent in south Morocc.
    `/navi morocc 116/39` | done when: `rumour_nd >= 21`
11. **Back to the guild** - report to the Rogue Agent in the Rogue Guild.
    `/navi in_rogue 355/28` | done when: `rumour_nd >= 22`
    Reward: 1 Gift Box.

### Prontera Culvert
`quests/quests_prontera.txt` | MISC_QUEST bit 8 | Lv none.

1. **Volunteer** - the Recruiter in Prontera: "Volunteer." (or
   "Situation...?", then "Volunteer."). He warps you to the Culvert.
   Why: the Capital Defense Headquarters recruits fighters against the vermin
   in the quarantined Culvert.
   `/navi prt_in 88/105` | done when: `MISC_QUEST & 8`
   Reward: 3 Red Potion, 1 Milk, 1 Orange Potion.
   Opens a place: the Culvert Guardian (`/navi prt_fild05 270/212`) lets
   volunteers into the Culvert (prt_sewb1); the Recruiter warps them there.

### The Spy Quest
`quests/quests_veins.txt` (sections "Spy Quest" and "Escort Dancers to
Schwarzwald Republic") | `que_sch` 0->26 | Lv none. Starts in Prontera and
goes through Morocc, an Arunafeltz prison, Comodo, the Airship and Einbroch.
Lasda and Vitre want 2,000 weight free and a free slot.

1. **The lost delivery boy** - talk to the Kid in Prontera: "What's wrong?",
   then "Do you need any help?".
   Why: he must deliver a letter to a bard named Lasda Midar and cannot find him.
   `/navi prontera 202/122` | done when: `que_sch >= 1`
2. **Lasda Midar** - in Prontera Church, the singing Bard: "Excuse me...",
   then "Are you Lasda Midar?". He reads the letter and gives you 100 zeny
   for the kid.
   `/navi prt_church 89/108` | done when: `que_sch >= 2`
3. **Pay the kid** - give the Kid the 100 zeny (you need at least 100).
   `/navi prontera 202/122` | done when: `que_sch >= 3`
4. **Vitre's letter** - back to Lasda: "Sure." twice.
   Why: the letter is from his old friend Vitre, jailed in Morocc on false
   charges.
   `/navi prt_church 89/108` | done when: `que_sch >= 4`
5. **The prison ward** - talk to the Prison Ward in Morocc twice (5, 6); he
   lets you in for 1 Fried Monkey Tails (taken).
   `/navi morocc 53/87` | done when: `que_sch >= 7`
   Note: Fried Monkey Tails is cooked (Level 1 Cookbook: 5 Yoyo Tail, 1 Old
   Frying Pan, 1 Cooking Oil, `db/re/produce_db.txt`); the Chef Assistant in
   Prontera sells the cookbook, Cooking Oil and cooking kits (`/navi
   prontera 156/212`).
6. **Sir Krieg** - the Public Security Officer (Krieg) in Morocc castle:
   "I'd like to see a prisoner, Mr. Vitre." He refuses without someone he
   trusts.
   `/navi morocc_in 79/163` | done when: `que_sch >= 8`
7. **Lasda's word** - tell Lasda "Krieg told me that."; he writes a letter
   (9). Give Krieg "Here's a letter from Lasda." (10).
   `/navi prt_church 89/108`, `/navi morocc_in 79/163` | done when: `que_sch >= 10`
8. **Vitre** - the Prison Ward lets you in. In the cell, Vitre Bizlita:
   "Excuse me...", then "I'm here on behalf of Mr. Lasda."
   Why: he can break out with a Megaphone and a Violin; the Megaphone is
   only at the Dancer job-change hall in Comodo.
   `/navi morocc 53/87`, then `/navi ra_in01 50/387` | done when: `que_sch >= 11`
9. **The Dance Instructor** - in Comodo, Bor Robin takes you to the Dancer
   job-change hall ("Go to the Job Change Area", `/navi comodo 193/151`).
   The Dance Instructor: "I want a Megaphone.", "Please! I'll do anything!",
   "Listen", "Sounds good.".
   Why: she lends the Megaphone for 500,000 zeny and for guarding her
   Dancers on a trip to the Schwarzwald Republic.
   `/navi job_duncer 93/106` | done when: `que_sch >= 12`
10. **The escort** - talk to one of the three Dancers at the entrance of the
    hall, "Yes" (to the Airship, 13); on the Airship talk to the Mature
    Looking Dancer: you land at an Einbroch hotel (14).
    `/navi job_duncer 85/49`, then `/navi airplane 79/55` | done when: `que_sch >= 14`
11. **The dinner party** - walk past the Hotel Manager (15), then walk to the
    spot in the hall where a Rekenber executive and an Arunafeltz priest talk
    in secret (16). Tell the Hotel Manager (17); the Mature Looking Dancer
    takes you back to Comodo.
    Why: Vitre's arrest touches a secret deal between Rekenber and Arunafeltz.
    `/navi ein_in01 279/221`, `/navi ein_in01 176/285`, `/navi ein_in01
    170/266` | done when: `que_sch >= 17`
12. **The Megaphone** - pay the Dance Instructor 500,000 zeny: "Yes".
    `/navi job_duncer 93/106` | done when: `que_sch >= 18` (1 Megaphone)
    Note: a Violin is sold by the Weapon Dealer in Comodo (`/navi cmd_in01
    128/165`). A lost Megaphone costs another 500,000 here.
13. **The breakout** - bring the Megaphone and a Violin to Vitre (both taken);
    you end up outside Morocc with him.
    `/navi ra_in01 50/387` | done when: `que_sch >= 19`
14. **Three songs** - the Thin-Faced Bard (Vitre) east of Morocc asks you to
    hear three people in order: Chada in Prontera (21), Ghez in Geffen (22),
    Nosdan in Comodo's north cave (23).
    `/navi morocc 297/154`, `/navi prontera 109/161`, `/navi geffen 196/167`,
    `/navi comodo 135/299` | done when: `que_sch >= 23`
15. **The arrest** - back to Vitre: "Yes". You get an Old Blue Box (24); the
    Secret Service arrests him: Vitre was a spy, his singers were his sources.
    `/navi morocc 297/154` | done when: `que_sch >= 25`
16. **Lasda explains** - back to Lasda in Prontera Church.
    `/navi prt_church 89/108` | done when: `que_sch >= 26`
    Reward: 1 Jewelry Box, 60,000 base EXP (plus the Old Blue Box of step 15).

### Eye of Hellion
`quests/eye_of_hellion.txt` | `HELLIONQ` 0->36..70 (starts at 36) | Lv 60
(Chilias'Tyus refuses below 60). Most NPCs want 2,000 weight free.

1. **Chilias'Tyus** - the Old Scholar in Morocc: "What are you looking for?",
   then "Of course, I will." ("I'm sorry, but I can't." sets 37: talk again,
   "I will help you.").
   Why: he seeks someone pure of heart to find the Hellion's gem and seal it.
   `/navi morocc_in 116/101` | done when: `HELLIONQ >= 36`
2. **Clanux Heffron** - in north-east Prontera: "He wants me to help you."
   (either answer then) or "He wants you to help me." (38: then "W-wait!
   Let's work together!").
   Why: Clanux hunts the gem for money; he found a broken sword and a cogwheel.
   `/navi prontera 269/326` | done when: `HELLIONQ >= 39`
3. **The training dummy** - in the old Swordman training ground in Prontera,
   inspect the dummy's gash.
   Why: a bearing inside reads "Veggie Lady N9 W3 BINGO".
   `/navi prontera 223/82` | done when: `HELLIONQ >= 40`
4. **Veggie Lady** - walk to the spot and type `BINGO`; get the cogwheel from
   Clanux ("In fact, I found this."). Either order.
   `/navi prontera 45/67`, `/navi prontera 269/326` | done when: `HELLIONQ >= 43`
5. **The machine** - in the Prontera tool shop, the Unknown Machine: "Insert
   Cogwheel." (44), then type `3847147298`.
   `/navi prt_in 128/79` | done when: `HELLIONQ >= 45` (Piece of Slate 1)
   Note: Clanux asks what you found: what you tell him changes only his lines.
6. **Back to Tyus** - talk to Chilias'Tyus (47); he sends you to Payon.
   `/navi morocc_in 116/101` | done when: `HELLIONQ >= 47`
7. **Grout'he's clues** - Grout'he Tuccok in Payon: "Alright, I'll buy your
   clues." and pay 10,000 zeny (have 1,000 weight free). You get a Stone
   Heart, Green Herb, Grape Juice and Skirt of Virgin (keep them).
   `/navi payon 182/132` | done when: `HELLIONQ >= 48`
8. **Payon's trail** - follow the clues in this order: the spot at
   `/navi payon 101/190` (49), the Pile of Stone `/navi payon 82/109` (50),
   the Dried Fish `/navi payon 239/56` (51), the Vat `/navi payon 240/160`
   (52); then Grout'he: "Yes, please!" (53).
   | done when: `HELLIONQ >= 53`
9. **The wooden floor** - at the Wooden Floor choose "Dig through the dust.":
   Grout'he's four items are used (54); click again (55); tell Grout'he (56).
   `/navi payon 159/129` | done when: `HELLIONQ >= 56`
10. **The Buddha statue** - in Archer Village, the Buddha Statue asks a
    question: answer "I won't kill, but I'll find a way to live!".
    `/navi pay_arche 142/28` | done when: `HELLIONQ >= 57` (Piece of Slate 2)
    Fails: the other three answers drop your HP to 0; ask again.
11. **Tyus again** - bring Slate 1 and 2 to Chilias'Tyus.
    `/navi morocc_in 116/101` | done when: `HELLIONQ >= 58` (Piece of Slate 3)
    Fails: coming without the slate pieces, he drops your HP to 0.
12. **Sage Welshyun** - in Geffen: "Yes, please help me." (59). ("Shut up, I
    know you have it..." sets 60: talk again and give him 1 White Potion, 62.)
    `/navi geffen 110/200` | done when: `HELLIONQ` 59 or 62
13. **Enoz** - Welshyun's student in Geffen Tower: "Actually, Welshyun sent
    me." and type `Monster Life in the Geffen Area`.
    `/navi gef_tower 116/37` | done when: `HELLIONQ >= 63`
14. **The reference book** - Welshyun gives Enoz's book back to you (64);
    take it to Enoz (65); bring Welshyun 1 Blue Gemstone and type
    `Valaskjalf`.
    `/navi geffen 110/200`, `/navi gef_tower 116/37` | done when: `HELLIONQ >= 66` (Piece of Slate 4)
15. **The four pieces** - show Chilias'Tyus all four pieces (67), then let
    Welshyun join them into the Slate (68). "Alright, I'll do it!" sends you
    to the Geffen field.
    `/navi morocc_in 116/101`, `/navi geffen 110/200` | done when: `HELLIONQ >= 68`
16. **Hellion's lair (optional)** - at the Hidden Cave choose "Insert the
    Tablet." to enter Geffen Dungeon 3, where one Hellion Revenant (Lv 59,
    respawns in 10-15 minutes) drops the Eye of Hellion (80%).
    `/navi gef_fild09 296/59`
17. **The seal** - bring the Slate to Chilias'Tyus.
    `/navi morocc_in 116/101` | done when: `HELLIONQ >= 69`
    Reward: with the Eye of Hellion (69): Nile Rose, Old Blue Box, 120,000
    base EXP. Without it (70): Nile Rose, 100,000 base EXP.

### The Sign
`quests/the_sign_quest.txt` (+ `re/quests/the_sign_quest.txt`, which moves
one soldier to Prontera Castle) | `sign_q` 0->142 (fail ends 200-203),
`sign_sq` for sub-steps and timers | Lv 50 (the Archeologist refuses below 50).
Three parts, about 140 values; the steps below group them by NPC. Several
NPCs keep server hours (`gettime(DT_HOUR)`, server time). Needs: the
Umbalian Language (`event_umbala >= 3`, region 7) for the Umbala step.

**Part 1: the Sobbing Starlight's crumbs**

1. **A Sign** - read one of the Signs in Prontera, Geffen, Morocc, Payon,
   Al De Baran or Alberta.
   `/navi prontera 147/305` (or `geffen 168/175`, `morocc 168/265`,
   `payon 160/183`, `aldebaran 54/223`, `alberta 35/241`) | done when: `sign_q >= 1`
2. **The Archeologist** - in Prontera, the Archeologist (Metz): "I've been
   following these signs and..." (2); talk again (3).
   Why: he looks for brave adventurers and tests them through his friends.
   `/navi prt_in 227/45` | done when: `sign_q >= 3`
3. **Arian's shopping list** - the Rogue (Arian) in Morocc: answer with your
   own name (the second choice; "Metz sent me here." throws you out, "Who
   are you then?" costs half your HP). Then bring, one at a time: 100 Fluff
   (4), 50 Poison Spore (5), 30 Scorpion Tail (6), 20 Rotten Bandage (7),
   15 Little Evil Horn (8), 10 Coral Reef (9), and talk once more (10, 11).
   Fails: carry only the item asked for: any later item on the list that you
   already carry is taken too, without counting.
   `/navi morocc_in 115/154` | done when: `sign_q >= 11`
4. **Ganaan's test** - the Young Man at the counter beside Arian asks five
   questions; more than 33 points pass (13). Best answers: "Explore the
   island." (10), "Stay quiet." or "Find a way out." (7), "Stay put." (10),
   "Try to find my friends first." (7), "What else? Save the world." (10).
   Then Arian gives the first Crumb of Sobbing Starlight (14).
   `/navi morocc_in 114/162` | done when: `sign_q >= 14`
   Fails: 33 or less sets 12; Arian sends you back to retake it.
5. **Daewoon** - in Payon, Daewoon (have the Crumb) asks six questions; more
   than 26 points pass. Best: "No, but would you tell me?", "I'll do my
   best!", "Yes, I do.", "I hate people who do that.", "I'd close my eyes,
   then destroy it.", "Yes, of course!". Second Crumb (15).
   `/navi payon_in03 11/31` | done when: `sign_q >= 15`
   Fails: 26 or less: ask again.
6. **Sir Jore** - in Al De Baran, only between 17:00 and 21:59 server time:
   "Daewoon sent me." (16); bring 10 Empty Test Tube, 2 Yggdrasil Leaf,
   10 Green Herb (17).
   Why: the sickly researcher wants the truth about the Stone of Sage.
   `/navi aldeba_in 155/101` | done when: `sign_q >= 17`
7. **The vanished alchemists** - in the Labyrinth Forest (from `prt_fild01`
   north), Gordon and his daughter Pleur: "Roar~!" calls 3 Flora and
   2 Marine Sphere (18, kill them), or "Excuse me."; then "Ask about Stone of
   Sage" (19, you are sent out to Mjolnir).
   `/navi prt_maze02 14/183` | done when: `sign_q >= 19`
   Note: Piru Piru in Al De Baran (`/navi aldeba_in 156/118`, 12:00-24:00)
   tells of them. The way through the maze to Gordon: to verify.
8. **Red gemstone** - tell Sir Jore (17:00-21:59): type `red gemstone`.
   Third Crumb (20).
   `/navi aldeba_in 155/101` | done when: `sign_q >= 20`
9. **Jesqurienne's quiz** - in Geffen, Jesqurienne: "Stuck-up chick." (21);
   talk to Aaron beside her (22): a quiz duel of random questions. A tie or
   a win passes (24); type your name for her; fourth Crumb (25).
   Correct answers (each question has one): Barcardi; not Karvodailnirol;
   Marine; Gloria; Empty Bottle; Sapphire; Earth; 2 / LUK +2; Golem -
   Immortal; Tristram lll; Penomena; Marduk; Hunter; 31; 2 (of 1/2/3);
   3 (of 0/1/2/3); Alberta; 260; 573; 601; Weapon Shop; Shockwave Trap;
   Hammer Goblin; Evil Druid; Izlude Meat Merchant; Wooden Mail.
   `/navi geffen_in 59/74`, `/navi geffen_in 61/72` | done when: `sign_q >= 25`
   Fails: a loss sets 23; "I can't let you win!" for a rematch.
10. **The Strange Guy** - in Comodo, the Strange Guy: "Excuse me...", "I'm here
    for Metz...?" (26; "Oh, nothing." knocks you out and throws you out);
    pay 30,000 zeny (27); come back between 19:00 and 22:59 (28); talk
    again (29); bring collectibles worth more than 10 points (all you carry
    of these are taken, one each): Red Frame, Chung Jah, China, Yellow Plate,
    Puppet, Poring Doll (1 each), Crystal Mirror, Chonchon Doll (2), Spore
    Doll, Rocker Doll (3), Frozen Rose, Yoyo Doll, Raccoon Doll (4),
    Baphomet Doll, Osiris Doll (7). You are sent to the dance test (30).
    `/navi cmd_in02 88/51` | done when: `sign_q >= 30`
11. **The dance test** - talk to the Examiner, enter the "DANCE~ DANCE~" chat
    room (Lv 50+), and step on the marked poles as each direction is
    announced. The grader sets 32 (fail), 33 (pass) or 34 (best).
    `/navi cmd_in01 33/25` | done when: `sign_q` 33 or 34
    Fails: 32: talk to the Examiner and retake it.
12. **Fifth crumb** - back to the Strange Guy: fifth Crumb (35); at 34 also
    20,000 zeny.
    `/navi cmd_in02 88/51` | done when: `sign_q >= 35`
13. **Mr. Bakerlan** - in Alberta, the Wealthy-looking Merchant: "Mr. Metz sent
    me." (36); show exactly 5 Crumbs ("Here...", 37).
    `/navi alberta_in 125/101` | done when: `sign_q >= 37`
14. **Errands for the house** - the Refined Steward gives you a Stone with
    your name (38); deliver it to the Knight in Juno ("Yes, I have your
    order.", 39, Receipt); Receipt to the Steward (40); the Merchant (41);
    the Steward: "You have another assignment for me." (42).
    `/navi alberta_in 114/178`, `/navi yuno 330/100` | done when: `sign_q >= 42`
15. **The maid's brother** - the Maid: "Excuse me, but Mahatra sent me...",
    "Actually, he wants me to help you.", "Sure, why not?" (46; the other two
    answers set 44/45: talk again and say "Yes.").
    `/navi alberta_in 154/171` | done when: `sign_q >= 46`
16. **Vigorgra** - the Alchemist in Al De Baran's guild: "Vigorgra?", "I need
    Vigorgra for... a friend." (47); bring 10 Royal Jelly, 20 Honey,
    30 Bear's Footskin, 1 Hinalle Leaflet, 1 Ment, 1 Empty Bottle and
    10,000 zeny (48, Vigorgra; 2 in 100 tries fail and the items are lost).
    `/navi alde_alche 169/162` | done when: `sign_q >= 48`
17. **The tired soldier** - give the Maid the Vigorgra (49, Letter from
    Sister); bring Vigorgra and letter to the soldier at Prontera Castle (50);
    back to the Maid (51, 3 Panacea); the Steward (52); the Merchant (53,
    sixth Crumb); the Archeologist (54, seventh Crumb).
    `/navi prt_cas 87/214` (soldier), `/navi prt_in 227/45` | done when: `sign_q >= 54`

**Part 2: restoring the Sobbing Starlight**

18. **Engel Howard's family** - in Geffen, the Lonely-looking Woman: type
    `Engel Howard` (55); the Cute Girl: "Apprentices?", "He also misses you
    a lot.", "I'll bring this to him." (56, Doodled Message).
    `/navi geffen_in 159/48`, `/navi geffen_in 171/42` | done when: `sign_q >= 56`
    Note: the Archeologist names Engel Howard only 1 time in 5; the woman
    takes the name anyway.
19. **The Flaming Spirit Man** - in Mjolnir Dungeon 2: "Here is a letter for
    you.", "Please look at this." (the message and 7 Crumbs are taken, 57).
    Bring 5 Mini Furnace, 2 Oridecon Hammer and 1 anvil (58-61 by anvil; he
    gives a Letter to Wife).
    `/navi mjo_dun02 88/295` | done when: `sign_q >= 58`
20. **Letters home** - the Letter to Wife to the woman (+4), then the Cute
    Girl (+4, 10 Candy): 66-69.
    `/navi geffen_in 159/48`, `/navi geffen_in 171/42` | done when: `sign_q >= 66`
21. **The Sobbing Starlight** - back to Engel: success by anvil: Anvil 37%,
    Oridecon Anvil 66%, Golden Anvil 90%, Emperium Anvil 100% (71, Sobbing
    Starlight). On failure (70) bring the furnaces and hammers again with a
    Golden or Emperium Anvil (and no lesser anvil in your bag).
    `/navi mjo_dun02 88/295` | done when: `sign_q >= 71`
22. **Reading the gem** - Archeologist (72); in Geffen Tower the Annoyed Man:
    type `Metz Brayde` or `Sobbing Starlight` (73); in Umbala the Native
    (needs the Umbalian language) wants a Mr. Smile mask: "Sure~" (74,
    taken).
    `/navi prt_in 227/45`, `/navi gef_tower 118/36`, `/navi umbala 163/256`
    | done when: `sign_q >= 74`
23. **The ancient document** - inside Umbala's tree, the Fastidious-Looking
    Guy: "Would you look at this?" (75); bring 10 Worn Out Page (76, Record
    of Ancient Language; fewer costs 30% HP and throws you out).
    `/navi um_in 27/23` | done when: `sign_q >= 76`
24. **Frank** - Archeologist: "Where is he?" (77); in Alberta the Fastidious
    Old Man (78); with Glasses and the record: "Wait, I've got a pair of
    glasses...", "Interpret Ancient Document" (79, both taken); keep talking
    to him: 1 talk in 50 he hands the Translated Ancient Language (80).
    `/navi alberta 165/83` | done when: `sign_q >= 80`
25. **To Valhalla** - in the field east of Geffen, step on the spot with
    4 Resin, 12 Stone Heart and 365 Coral Reef (all taken, 81); the Valkyrie
    (82) sends you back to Geffen.
    `/navi gef_fild07 182/241`, `/navi himinn 48/86` | done when: `sign_q >= 82`

**Part 3: Niflheim, Glast Heim and the witch**

26. **The lady in Niflheim** - the Pleasant-Featured Lady (Serin): "Sure, go
    ahead.", "Sure, let's do it.", then "Sure, why not?" (83, helping the
    souls of Niflheim) or "Why should I help them?" (84).
    `/navi niflheim 313/70` | done when: `sign_q` 83 or 84
27. **Helping the souls** (83) - in this order: the Cursed Soul's books
    (third book, then spell `Klaatu` / `Verata` / `Nictu`; 1 try in 5 gives the
    Witch's Spell Scroll, else Orc Skeletons attack); the lost child (house
    `/navi nif_in 156/91`, "What can I do?"); the witch's house (`/navi nif_in
    186/168`, "There's a lost child here..."): Crow Wing; the child; the
    witch's house again. Then the Lady gives Serin's Gold Ring (85) and points
    you to a bard (86).
    `/navi niflheim 348/257` | done when: `sign_q >= 86`
    Path 84: the Lady sends you straight on (87).
28. **The bard and the witch** - Crayu (`/navi nif_in 102/81`, "How do I
    become one of the chosen?", 87); the Depressing Man (88); the witch's house:
    with the ring 89 then 92 ("How do I get the symbol?"); without it 90:
    the Cursed Soul's book (91), then the Witch (through `/navi nif_in
    140/177`), who takes the scroll (92).
    `/navi niflheim 146/241` | done when: `sign_q >= 92`
29. **The Queen of the Dead** - the Lady: "About the Queen of the Dead..."
    and the questions that follow (93, 94, 95); the Valkyrie in Valhalla (96,
    through the Geffen field spot).
    `/navi niflheim 313/70`, `/navi himinn 48/86` | done when: `sign_q >= 96`
30. **Laichin's map** - the Mad Man in Niflheim: "Pay Laichin 40,000 Zeny",
    "What do you mean by big and small?", "Pay him." (60,000 zeny in all) to
    get one of four routes (101-104); paying 40,000 now and 20,000 later
    works too (97-100, then 101-104).
    `/navi niflheim 102/54` | done when: `sign_q` 101-104
31. **Angrboda's seals** - in Glast Heim's Chivalry (gl_dun02) hit the seals of
    your route, each with a weapon in your inventory (better weapons break
    them more often: from 2% with a Girl's Diary to 50% with Mjolnir; retry
    freely). Each gives a Piece of Spirit; the last takes 3 and gives
    Spiritual Whispers (117).
    Routes (seal numbers; coordinates on gl_dun02): 101: 1-3-4-7;
    102: 2-5-7-8; 103: 3-6-7-8; 104: 2-3-5-6. Seals: 1 `262/265`,
    2 `271/100`, 3 `268/32`, 4 `16/26`, 5 `42/251`, 6 `123/234`,
    7 `140/72`, 8 `119/182`.
    | done when: `sign_q >= 117`
32. **The Symbol of the Nine Realms** - in the witch's realm, the Queen of
    the Dead takes the whispers (118, Symbol of the Nine Realms).
    `/navi que_sign01 45/227` | done when: `sign_q >= 118`
33. **Serin's choice** - two ways:
    - **The Lady's way**: the Lady, "W-what should I do?" (131), her
      questions (132), she sends you to Serin; give Serin the symbol (133);
      "No, you have to be stopped." (134), then talk on (135, 136).
    - **The Witch's way**: give the Witch the symbol (119), with Serin's ring
      (120) or without (121); ask all three questions (122/123): Witch's
      Tonic, 5 Witch's Medal (and Serin's Gold Ring at 122) (124). At Serin
      (the Witch sends you): "I can't let you do this!" (125), talk on (126,
      Tonic taken 127, 128); bring the Witch the 5 medals.
    | done when: `sign_q` 129 (holding Serin's Gold Ring) or 130
    Fails: at Serin, "Okay, have it your way." / "Alright. I'll let you go."
    followed by "I do, and it's alright..." sets 200 (failed). The side
    ways in (the Niflheim switch at 126, "Follow the trace.") add a small
    random fail chance.
34. **The Sign** - the Valkyrie gives you The Sign (137); the Archeologist
    takes it (138) and wants you back later: the day is cut in 2-hour slots
    (server time) and he answers only in the slot two after the one you left
    him in (2 to 6 hours later); he returns The Sign (139); Engel takes it
    (140) with the same wait; he gives The Sign accessory (141); show it to
    the Archeologist (142).
    Fails: coming back in another slot only gets a "not yet".
    `/navi himinn 48/86`, `/navi prt_in 227/45`, `/navi mjo_dun02 88/295`
    | done when: `sign_q >= 142`
    Reward: The Sign (accessory), 200,000 base EXP at the end; small EXP at
    each Crumb.
35. **Geffenia (optional)** - give the Queen of the Dead the Sobbing
    Starlight: "Sobbing Starlight", "Please take it..." (143), talk again
    (144, Lucifer's Lament). Throw it into Geffen's fountain: the portal to
    Geffenia opens for 45 seconds.
    `/navi que_sign01 45/227`, `/navi geffen 119/48` (portal `geffen 119/55`)
    | done when: `sign_q >= 144`
    Opens a place: Geffenia (gefenia01-04). The Lament is not taken by the
    fountain (no delitem in the script).

Fail end: at 200 the Witch takes the ring and tonic (201); the Archeologist
takes the Sobbing Starlight for 10,000 base EXP and an Old Violet Box (202).

### The Message Delivery
`quests/quests_niflheim.txt` | `nif_revive` 0->6, then MISC_QUEST bit 16384,
quests 11038-11043 ("Meet the Dead") | Lv 80 (Feylin, step 4: `BaseLevel >
79`). One try only: the spell's outcome is final.

1. **Erious** - in Prontera, Erious mourns his wife Elly: "I can deliver your
   message to her."
   Why: she died a month ago; he wants her to know it was his fault.
   `/navi prt_in 161/20` | done when: `nif_revive >= 1`
2. **Billik** - in Umbala, Billik: "I have to meet somebody there.".
   Why: he knows the way to the town of the dead and sends you to Feylin with
   a rose as a sign.
   `/navi umbala 215/181` | done when: `nif_revive >= 2`
3. **Feylin** - in Niflheim talk to Feylin (3), then "But..." (4).
   `/navi niflheim 153/215` | done when: `nif_revive >= 4`
4. **The summoning** - bring a Witherless Rose and 10 Yggdrasil Leaf (both
   taken), Lv 80+: "I'm willing to do this.", "Yes". 13 times in 100 Elly's
   spirit comes: "I brought a message from your husband.", "Forgive him for
   what happened a month ago." (6, Memento). 87 times in 100 the spell fails:
   your HP drops to 1% (5).
   `/navi niflheim 153/215` | done when: `nif_revive` 5 or 6
5. **Back to Erious** - at 6 give him the Memento: 2 Yggdrasil Berry,
   2 Yggdrasil Seed, 10 Yggdrasil Leaf. At 5 he gives back 10 Yggdrasil
   Leaf. Either way the quest is closed.
   `/navi prt_in 161/20` | done when: `MISC_QUEST & 16384`

### Help Me Shorty
`re/quests/HelpMeShorty.txt` | quests 14688 "My name is Shorty", 14689 "Help
Shorty", 14693 "To Payon", 14694 "To Prontera Field" | Lv: under 31 to
start, 31 or more for the second half.

1. **The black shadow** - in Izlude, below Lv 31, walk near the black shadow
   (it shows when you come close): "Well, let's go together.", "My name is
   (you).", "You want to go in the bag?", "Where is that person?".
   Why: Shorty, a small creature, is looking for his friend Salty.
   `/navi izlude 173/210` | done when: quest 14688 done (you get the Help Me
   Shorty item)
2. **Shorty** - use the Help Me Shorty item: Shorty appears beside you.
   "How can you help me?" (quest 14689). He gives buffs (Increase AGI,
   Blessing, again after a cooldown, quest 14695) and beginner tips.
   | done when: quest 14689 done
3. **To Payon** - at Lv 31 or more, call Shorty and choose "Now did you get
   that idea?" (14693).
   | done when: quest 14693 started
4. **Chanmo** - in Payon's inn talk to Chanmo: Salty was sent out for jelly
   and acorns (14694).
   `/navi payon_in01 193/23` | done when: quest 14694 started
5. **Salty** - in the field east of Prontera (prt_fild10) walk near one of
   Salty's spots until she shows; talk to her.
   `/navi prt_fild10 318/191` (other spots: `262/39`, `332/128`, `222/293`,
   `26/196`, `311/167`, `298/212`) | done when: quest 14694 gone and no
   Help Me Shorty item (the item is taken)
   Reward: Costume Penguin Cap, 4,000 base / 1,000 job EXP.

## 2. Geffen

### The Wandering Bard (Minstrel)
`quests/bard_quest.txt` | `gef_bard_q` 0->30/31 (two starts: 1-15 from
Geffen, 20-27 from Morocc, they join at 10) | Lv none.

1. **The bard in Geffen** - talk to the Bard in south Geffen: "Who are you?"
   (1). Or start with the Bard in Morocc (20; then the Geffen Bard's "Who
   are you?" sets 21).
   Why: Errende, the Geffen bard, has forgotten the true words of an old song.
   `/navi geffen 132/38` (or `/navi morocc 134/111`) | done when: `gef_bard_q >= 1`
2. **An upbeat song** - ask him "Would you play a song?", "Play an upbeat
   song~!"; when he asks for help, "Sure, no problem." (2 / 22). If the song
   he plays is another one, ask again (random). "I ain't gonna help you."
   sets 7 / 27: talk again, "Is there any way I can help you?".
   `/navi geffen 132/38` | done when: `gef_bard_q` 2 or 22
3. **The bard in Payon** - type the song's name `At One, I Fall in Love`,
   then the composer `Minty Errende` (3 / 23).
   `/navi payon 181/172` | done when: `gef_bard_q` 3 or 23
4. **Kino Kitty** - back to Errende: type `Kino Kitty`, then "I can, so stop
   crying." (4 / 24). "No, thanks." sets 5 / 25 (a random talk later offers
   the job again); a wrong name sets 6 / 26 (type again).
   `/navi geffen 132/38` | done when: `gef_bard_q` 4 or 24
5. **The bard in Morocc** - Kino Kitty, the Morocc Bard: "I'm looking for Kino
   Kitty..." (10).
   `/navi morocc 134/111` | done when: `gef_bard_q >= 10`
6. **The Seal of Friendship** - Errende marks your left wrist (11).
   `/navi geffen 132/38` | done when: `gef_bard_q >= 11`
7. **Mr. Sketzi's book store** - in Juno, the Old Man: "Show him your left
   hand." (12).
   `/navi yuno_in01 172/100` | done when: `gef_bard_q >= 12`
8. **The lyrics** - Kino Kitty in Morocc: "Here you go.", then "No, I don't
   mind." (14, a letter with the old lyrics). "Yes, I mind!" sets 13: then
   read the Old Book in Sketzi's store until you find the lyrics (1 try in
   5, `/navi yuno_in01 163/101`, 15).
   `/navi morocc 134/111` | done when: `gef_bard_q` 14 or 15
9. **The song restored** - bring the lyrics to Errende (30 / 31).
   `/navi geffen 132/38` | done when: `gef_bard_q >= 30`
   Reward: base EXP by level, 450 (below Lv 56) up to 15,678 (Lv 91+).

### Orc's Memory
`instances/OrcsMemory.txt` (a memorial dungeon) | `mad` 0->1, `yong_odun`
0->2 | Lv 50 for the Mad Scientist; the statue takes Lv 30-80
| **Players: 2** (2+ online party members, all Lv 30-80,
`instance_check_party(.@party_id,2,30,80)`, line 43). Side 5 tells the
memory from Wendel's notes for those over Lv 80.

1. **The Mad Scientist** - in the Orc Village, the Mad Scientist (Lv 50+):
   "Orcs don't attack you?", "Oh? Like what, travel to alternate space?",
   "...Um, that doesn't sound legal?", "Alright... What do I do?".
   Why: his statue, the Dimensional Gorge Piece, carries you into an orc's
   memory.
   `/navi gef_fild10 238/202` | done when: `mad >= 1`
2. **The memory** - the party leader touches the statue: "Reserve the Orc's
   Memory", then "Enter the Dungeon" (everyone). Inside, fight beside the
   orc warrior Kruger through two floors (kill the one Enchanted Orc in each
   basement zone; the leader lights the braziers on floor 2) to the altar,
   where Shaman Cargalache and the Depraved Orc Hero wait. Talk to the dying
   Kruger at the end (facts from side.ps1, side 5).
   `/navi gef_fild10 242/202` | done when: `yong_odun >= 2`
   Fails: the statue needs 2 hours between runs (quest 12059 "Orc's Memory
   Time Limit").

## 3. Payon and Archer Village

### The Party Relay
`quests/partyrelay.txt` | `party_relay` 0->32 (each runner's own value),
`party_relay_lv`, Mission Tickets 1-12 (7730-7741) | Lv 40 (`BaseLevel >
39`) | **Players: 6** in the party, and up to **14** around Lospii at the
end. Ledrion only talks to a party leader who leads 6+ members and is in a
guild (`getcharid(2) > 0`, lines 39, 114, 163, 204, 348). The six runners
must be a Swordman, Mage, Acolyte, Archer, Thief and Merchant (any later
class of them counts, `BaseClass`). Repeatable (it starts over at 0).

The four NPCs stand in Payon, and the same four in Comodo, Einbroch, Hugel,
Rachel and Veins (lines 3094-3121); any town's set works. Payon: Ledrion
`payon 103/113`, Gatan `payon 83/327`, Bafhail `payon 204/221`, Lospii
`payon 168/314`. Each one only works at certain hours of the **server
clock** (`gettime(DT_HOUR)`; the NPCs say "Pacific Standard Time"). A
runner holding another runner's ticket is turned away, so pass each ticket
on at once. Every runner first needs room for more items.

1. **Ledrion** - the party leader: "Sure!" (1), then talk again: he gives
   Mission Ticket 1 for the Swordman (2).
   Why: a rich philanthropist bet that adventurers can still work together.
   `/navi payon 103/113` | done when: leader `party_relay >= 2`
2. **Gatan: the Swordman** - the Swordman brings Ticket 1 to Gatan at
   11:00-14:00 or 0:00-3:00. He asks for Base Levels: Lv 40-59 three more
   (4), Lv 60-79 two (3), Lv 80-94 one (99), Lv 95+ none (5). Gain them and
   come back in the same hours (5), then talk again: Ticket 2 and 2
   Yggdrasil Berry (6).
   Why: Gatan, Ledrion's lazy friend, tests whether you keep growing.
   `/navi payon 83/327` | done when: Swordman `party_relay >= 6`
3. **Bafhail: the Thief** - the Thief brings Ticket 2 to Bafhail. At
   21:00-24:00 he asks for 10 Fish Tail, 10 Porcupine Quill, 10 Elder
   Pixie's Moustache (7); at 8:00-11:00 for 10 Wooden Heart, 10 Wolf Claw,
   10 Shoulder Protector (8). Bring them at 8:00-11:00 or 21:00-24:00
   (taken): Ticket 3 and 2 Yggdrasil Berry (9).
   Why: his trial is to gather items and bring them on time.
   `/navi payon 204/221` | done when: Thief `party_relay >= 9`
   Fails: script bug at 8: he checks for 10 Piano Key but takes 10 Wooden
   Heart (line 2224), so the morning list needs 10 Piano Key too (kept).
   Hand Ticket 2 over at 21:00-24:00 to get the other list.
4. **Lospii: the Archer** - the Archer brings Ticket 3 at 14:00-17:00 or
   18:00-21:00 (10). Then come back in the same hours with 10 players
   standing within 8 cells of Lospii (`getareausers`, line 2469): Ticket 4
   and 2 Yggdrasil Berry (11).
   Why: the child Lospii wants to see how many friends you have.
   `/navi payon 168/314` | done when: Archer `party_relay >= 11`
5. **Ledrion again** - the leader brings Ticket 4: 3 Gift Box, 1 Old Blue
   Box and Ticket 5 for the Mage (12).
   `/navi payon 103/113` | done when: leader `party_relay >= 12`
6. **Gatan: the Mage** - the Mage brings Ticket 5 at 8:00-11:00 or
   21:00-24:00; levels as in step 2 (15 = three, 14 = two, 13 = one, 16 =
   none). Come back after 8:00 (at 15 only 8:00-11:00: its evening check
   can never be true, line 909) (16), then talk again: Ticket 6 and 2
   Yggdrasil Leaf (17).
   `/navi payon 83/327` | done when: Mage `party_relay >= 17`
7. **Bafhail: the Acolyte** - the Acolyte brings Ticket 6. At 14:00-17:00
   he asks for 10 Dark Mask, 10 Dokebi Horn, 10 Peco Peco Feather (18); at
   18:00-21:00 for 10 Tongue, 10 Leopard Claw, 10 Poisonous Toad Skin (19).
   Bring them between 14:00 and 21:00 (taken): Ticket 7 and 2 Yggdrasil
   Leaf (20).
   `/navi payon 204/221` | done when: Acolyte `party_relay >= 20`
8. **Lospii: the Merchant** - the Merchant brings Ticket 7 at 11:00-14:00
   or 0:00-3:00 (21), then comes back in the same hours with 12 players
   within 8 cells: Ticket 8 and 2 Yggdrasil Leaf (22).
   `/navi payon 168/314` | done when: Merchant `party_relay >= 22`
9. **Ledrion again** - the leader brings Ticket 8: 3 Old Blue Box, 1 Old
   Violet Box and Ticket 9 for a Swordman or Mage (23).
   `/navi payon 103/113` | done when: leader `party_relay >= 23`
10. **Gatan: Swordman or Mage** - Ticket 9 at any hour; levels: Lv 40-59
    three (26), 60-79 two (25), 80-94 one (24), 95+ none (27). Come back
    at 14:00-17:00 or 18:00-21:00 (27), then talk again: Ticket 10, 2
    Yggdrasil Leaf, 2 Yggdrasil Berry (28).
    `/navi payon 83/327` | done when: runner `party_relay >= 28`
11. **Bafhail: Thief or Acolyte** - Ticket 10 at 11:00-14:00 or 0:00-3:00
    (29); bring 20 Frill, 20 Horrendous Hair, 20 Anolian Skin in the same
    hours (taken): Ticket 11, 2 Yggdrasil Leaf, 2 Yggdrasil Berry (30).
    `/navi payon 204/221` | done when: runner `party_relay >= 30`
12. **Lospii: Archer or Merchant** - Ticket 11 at 21:00-24:00 (at
    8:00-11:00 only a first-job Archer or Merchant, `BaseJob`, line 2563)
    (31); come back at 8:00-11:00 or 21:00-24:00 with 14 players within 8
    cells: Ticket 12, 2 Yggdrasil Leaf, 2 Yggdrasil Berry (32).
    `/navi payon 168/314` | done when: runner `party_relay >= 32`
13. **The prize** - the leader brings Ticket 12 to Ledrion (taken; the
    leader's `party_relay` goes back to 0).
    `/navi payon 103/113` | done when: Ticket 12 handed in
    Reward: 6 Gift Box, 3 Old Blue Box, and one of Sabbath, Slaughter or
    Quadrille (1 in 7 each), otherwise 3 Old Violet Box. Every ticket
    handed out also gives the runner base EXP: 1,080 (Lv 40-49), 2,880
    (50-59), 6,720 (60-69), 19,560 (70-79), 38,520 (80-89), 85,920 (90-94),
    104,760 (95+) (`F_PartyRelay_Exp`, Renewal values marked "unconfirmed").
    To verify: whether bots count for `getareausers` (it counts characters
    on the map, not party members).

## 4. Morroc and the Sograt Desert

Muff's Loan and Broken Diamond start in Comodo (region 6); the Unlucky
Emerald's jewel part follows them.

### The Crow of Fate
`quests/quests_morocc.txt` | `barmunt_crow` 0->16, quests 2063-2068 ("The Crow
of the Fate - 1..6") | Lv 60 (`BaseLevel > 59`).

1. **The book-touching man** - in the Morocc ruins: "Speak", then "Help him".
   Why: he hunts for "The Crow of the Fate", a novel that seems cursed.
   `/navi moc_ruins 137/70` | done when: `barmunt_crow >= 1`
2. **Prontera Library** - the Library Curator: "Search books." and look it up
   by title `The Crow of the Fate`, by author `Oliver Hilpert`, or by a
   keyword (Fate, Crow, Oliver, Hilpert).
   `/navi prt_in 179/92` | done when: `barmunt_crow >= 2`
3. **Juno Library** - the Library Master in Juno (or just walk past the spot
   beside him) (3).
   `/navi yuno 333/210` | done when: `barmunt_crow >= 3`
4. **The bestseller corner** - in the Juno Library, click the Hot Bestseller
   Corner (4): you fall into the book's past. Walk east through the rooms
   (talk to the Female Researcher if lost) to the third room's spot (5, you
   are blinded for 10 minutes), then to the next spot (6); you wake in the
   library: step on the spot there (7).
   `/navi yuno_in04 100/5`, then `/navi que_ba 102/56`, `/navi que_ba
   53/232`, `/navi yuno_in04 100/3` | done when: `barmunt_crow >= 7`
5. **Old newspapers** - the Library Part-Timer points to the old news; read
   the Old News Scrapbook until the page on the mine collapse comes (1 page
   in 10) (8).
   `/navi yuno_in04 117/102` | done when: `barmunt_crow >= 8`
6. **The northern cave** - from the Einbroch field (entrance `/navi ein_fild01
   28/261`), the Cave Settler: "No, listen to me!" and type `Eva` (9).
   `/navi cave 82/97` | done when: `barmunt_crow >= 9`
   Fails: "Step back." or another name throws you back.
7. **The monstrous man** - deeper in the cave (warp at `cave 86/167`) talk to
   the Monsterous Man about the cave village, himself and Eva, then end the
   talk (10).
   `/navi cave 22/186` | done when: `barmunt_crow >= 10`
8. **Mami's photo album** - back to the book-touching man: "I'll take it."
   (11).
   `/navi moc_ruins 137/70` | done when: `barmunt_crow >= 11`
9. **The author's room** - the Library Part-Timer sends you into another past
   (12).
   `/navi yuno_in04 111/57` | done when: `barmunt_crow >= 12`
10. **The worn-out book** - the Worn-out Book in the library: "Sell" gives the
    album away (14: Author Autograph, Author Memo, Old Violet Box). "Don't
    Sell" sets 13: then the Suspicious Man (`/navi yuno_in04 169/123`), "Yes",
    gives the same (14).
    `/navi yuno_in04 167/120` | done when: `barmunt_crow >= 14`
11. **Oliver** - after the scene in the author's house, talk to the
    Suspicious Man (Oliver Hilpert) and answer either way (15).
    `/navi yuno_in04 169/123` | done when: `barmunt_crow >= 15`
12. **The end of the book** - give the memo and autograph to the
    book-touching man: "Give".
    `/navi moc_ruins 137/70` | done when: `barmunt_crow >= 16`
    Reward: 90,000 base / 90,000 job EXP (plus the Old Violet Box of step 10).

### The Unlucky Emerald
`quests/quests_nameless.txt` | `treasure_nd` 0->12, then `jewel_nd` 0->31 |
Lv none for the treasure; 66 for the jewel part (`treasure_nd > 10 &&
BaseLevel > 65`, Ibrahim) | **Players: 2** at step 7: the treasure chest
opens only for a party of 2 or more (`getpartymember`, line 9909; offline
members count).

1. **The ragged man** - in Morocc: "How may I help you?", "Umm... So?", "I can
   give you some money." and pay 1,200 zeny (2). ("Why don't you just
   walk?" sets 1: talk again, "Give Money".)
   Why: a ruined treasure hunter wants to go home; he tips you off about a
   man who found the treasure.
   `/navi morocc 143/63` | done when: `treasure_nd >= 2`
2. **The man in north Morocc** - "Tell me about the treasure.", then "What'd
   you have in mind?" (4). ("No, thanks." sets 3: talk again, "I guess so.")
   `/navi morocc 102/298` | done when: `treasure_nd >= 4`
3. **His price** - bring him 2 Pearl, 2 Zargon, 20 Memento (taken) (5).
   `/navi morocc 102/298` | done when: `treasure_nd >= 5`
4. **The buried chest** - in the desert, find the chest: a magic aura keeps
   it shut (6).
   `/navi moc_fild18 108/116` | done when: `treasure_nd >= 6`
5. **Half a spell** - back to the man: ask "Who was going to help you?" and
   "Your clients gave you something?": he gives half of the opening spell,
   "[Open" (7) or "[Unlock" (8), at random.
   `/navi morocc 102/298` | done when: `treasure_nd` 7 or 8
6. **The man in hiding** - in Comodo's east, the Man in Hiding gives the
   other half: "Sesame]" (to 10) or "Treasure]" (to 9). With `zdan_edq > 12`
   (Z-Gang past step 9) the talk differs, same result.
   `/navi comodo 339/224` | done when: `treasure_nd` 9 or 10
7. **The chest opens** - in a party of 2 or more, type the whole spell at
   the chest as one word. Note the
   script's own swap: at 9 the answer is `OpenSesame`, at 10 `UnlockTreasure`
   (the opposite of the halves you hold).
   You would get: Unlucky Emerald, Dead Branch, Two-Handed Sword, and a curse.
   `/navi moc_fild18 108/116` | done when: `treasure_nd` 11 or 12

The jewel part (`jewel_nd` 0->31) needs the Unlucky Emerald in your bag at
the steps that say so; the Old Soldier takes it at the end.

8. **Ibrahim and the emerald** - after Broken Diamond (`diamond_edq` 26),
   at Lv 66 with the emerald: "Sure, why not?", then "I'm going to sell it."
   (1) or "I'm going to study it." (10).
   Why: Ibrahim, owner of another Cursed Jewel, wants to see yours.
   `/navi moc_ruins 152/147` | done when: `jewel_nd` 1 or 10
9. **No buyer (only after "sell")** - at Jhonnita, Kimeunbang or Leblo:
   "I have a rare emerald to sell..." (2); nobody dares buy it. Back to
   Ibrahim: "Everyone seems scared!" (9).
   Why: the jewellers fear the curse.
   `/navi alberta 102/80` (or `payon 69/65`, `geffen 128/153`), then
   `/navi moc_ruins 152/147` | done when: `jewel_nd` 9 or 10
10. **The antique appraiser** - the Scholar in Comodo: at 10 "Ask About
    Cursed Jewel", "No, it's the Unlucky Emerald." (11); at 9 just talk
    (11). Talk again for the jewel's story (12).
    Why: everyone who owned the emerald was ruined or died; a shaman may
    talk to their spirits.
    `/navi comodo 139/184` | done when: `jewel_nd >= 12`
11. **The shaman** - in Alberta: "Actually, I have a Cursed Jewel." (with
    the emerald, 13), then pay 200,000 zeny (14); talk again: he wants
    100,000 more (15); pay it (16).
    Why: he says the ritual against the curse is costly and risky.
    `/navi alberta_in 70/109` | done when: `jewel_nd >= 16`
12. **The ritual** - talk again: he lists the offerings (17). Bring 1 Holy
    Water, 1 Red Blood, 1 Witherless Rose, 1 Crystal Blue, 1 Wind of Verdure
    (taken, 18).
    Why: in the trance he sees a blood-covered warrior with a sword.
    `/navi alberta_in 70/109` | done when: `jewel_nd >= 18`
13. **The archeologist** - in Juno, with the emerald: "Ask About the
    Jewel's Curse" (19).
    Why: he says there is no curse; only the Comodo gambler died.
    `/navi yuno_in04 38/48` | done when: `jewel_nd >= 19`
14. **The shaman's pride** - back to the shaman: "The archaeologist
    said..." (20), then talk again with the emerald (21).
    Why: to prove himself he reads the jewel: something west of Geffen
    will react to it.
    `/navi alberta_in 70/109` | done when: `jewel_nd >= 21`
15. **The wanderer's ghost** - leave Geffen by the west gate, cross the
    bridge to the high ground and step on the spot with the emerald: the
    Wanderer appears. Talk to him (22), then again (23).
    Why: the ghost of a warrior who says Cobolds killed his comrades.
    `/navi gef_fild08 182/182` (spot; ghost at `182/185`) | done when:
    `jewel_nd >= 23`
    Note: he vanishes after 60 seconds; step on the spot again to call him.
16. **The records** - the archeologist (24), then again (25).
    Why: a witness wrote that one warrior survived, covered in blood; the
    witness is a retired soldier in Prontera.
    `/navi yuno_in04 38/48` | done when: `jewel_nd >= 25`
17. **The Old Soldier** - in Prontera: "Ask About Fallen Warrior" (26).
    Why: he was there when the warrior was found alive among the dead.
    `/navi prontera 140/304` | done when: `jewel_nd >= 26`
18. **The truth** - call the Wanderer again (`/navi gef_fild08 182/182`):
    "You weren't killed by Cobolds, were you?" (27), "Do you remember your
    last moment?" (28; "You killed your comrades!" only loops), "How did
    your comrades die?", "You slashed everything..." (29).
    Why: he went berserk and cut down everything, friends included.
    `/navi gef_fild08 182/185` | done when: `jewel_nd >= 29`
19. **The end of the curse** - the Old Soldier: "I met the warrior's
    spirit.", "Do you believe the jewel is really cursed?" (30); with the
    emerald he takes it (31). ("I feel so sorry for him." just ends the
    talk.)
    `/navi prontera 140/304` | done when: `jewel_nd >= 31`
    Reward: 1 Old Blue Box and base EXP by level: 5,000 (Lv 66-74), 18,000
    (75-80), 36,000 (81-85), 50,000 (86-90), 80,000 (91-95), 100,000
    (96+); below Lv 66 a Yggdrasil Berry. Bringing the emerald later (at
    30) gives the smaller table: 5,000 / 8,000 / 15,000 / 20,000 / 40,000 /
    50,000.

### Nightmare Pyramid hunts
`re/quests/quests_morocc.txt` | quests 2289 "Verit Hunting (Nightmare)",
2292 "Mummy Hunting (Nightmare)", cooldowns 2290 / 2291 (until 4:00) | Lv none |
repeatable.

1. **The Suspicious Cat** - in the Pyramid's basement, the cat: "Mummy? What
   happened?", "Strong mummies? Where are they?", "I would like to go, too.",
   "Pay 5,000 zeny and set out." (to the Nightmare Pyramid).
   `/navi moc_prydb1 103/54` | done when: on `moc_prydn1`
2. **Choose a hunt** - the cat inside: "Eliminate Verit" or "Eliminate
   Ancient Mummy", then "Help him".
   `/navi moc_prydn1 94/98` | done when: quest 2289 or 2292 started
3. **Hunt** - kill 20 Verit (Nightmare) or 20 Ancient Mummy (Nightmare), then
   talk to the cat.
   `/navi moc_prydn1 94/98` | done when: quest 2290 or 2291 (cooldown) started
   Reward: Verit 300,000 base / 100,000 job EXP; Mummy 600,000 base /
   200,000 job EXP. Each again after the next 4:00 server time.

## 5. Alberta

### The Turtle Island Quest
`quests/quests_alberta.txt` | `TURTLE` 0->1..12, then MISC_QUEST bit 65536
(TURTLE back to 0), quests 11029-11037 "Going to the Turtle Island.." | Lv
none | side 9 (its RO steps were reused here).

1. **Grandpa Turtle** - in his house in Alberta (door `/navi alberta 65/233`,
   then the room to the north): "How can I get there?".
   Why: he sailed with Captain Jornadan Niliria, who found Turtle Island; only
   the sailor Gotanblue still knows the way.
   `/navi alberta_in 23/104` | done when: `TURTLE >= 1`
2. **The Voyage Log** - read the log on the Alberta dock. Half the time the
   page is the captain's last entries: read again. The page you find picks
   your secret: the poisoned bananas (2), the turtle-crystal page (3) or the
   turtle-stone page (4).
   `/navi alberta 246/117` | done when: `TURTLE` 2, 3 or 4
3. **To the island** - Gotanblue, the sailor on the dock: "How can I get
   there?", "Turtle island -> 10000 zeny". A Sailor where you land takes you
   back (`/navi tur_dun01 165/29`).
   `/navi alberta 244/118` | done when: on `tur_dun01`
   Note: the island is Lv 86-100 (Dragon Tail, Permeter on floor 1; Freezer,
   Assaulter below), all aggressive (side 9).
4. **The island's secret** - follow your page:
   - 2: the Skull Stone on floor 1 (`/navi tur_dun01 160/81`).
   - 3: the Turtle Tree Roots on floor 2 (`/navi tur_dun02 132/251`, 7), the
     pile of turtle crystals (`/navi tur_dun02 46/125`, 8), the Turtle Pillar
     (`/navi tur_dun02 49/158`).
   - 4: the turtle stones on floor 1 (`/navi tur_dun01 203/155`, 10), floor 2
     (`/navi tur_dun02 75/249`, 11), floor 3 (`/navi tur_dun03 118/233`, 12),
     then the Turtle Statue on floor 4 (`/navi tur_dun04 113/178`).
   Ways down: floor 1->2 `tur_dun01 154/241`, 2->3 `tur_dun02 167/19`,
   3->4 `tur_dun03 217/71` (side 9).
   | done when: `MISC_QUEST & 65536`
   Reward (random): skull page: 5 Banana and/or 5 Banana Juice; crystal page:
   one red item (Red Gemstone, Red Jewel, Red Frame, Red Muffler, Animal
   Blood); stone page: 1 time in 20 a Gift Box, Old Card Album, Old Violet
   Box or Dead Branch.
   Opens a place: Gotanblue's boat to Turtle Island takes anyone who has
   started (`TURTLE` > 0) or finished the quest.

### The Alberta Boy
`quests/quests_alberta.txt` | `ep13_2_hiki` 0->13, quests 10079-10089
"Escape from the reality, into the broad world" | Lv 41 (`BaseLevel > 40`,
his mother) | needs: the Rekenber Job Quest past 21 (`lhz_rekenber > 21`,
step 8) and the Friendship Quest past 14 (`friendship > 14`, step 10), both
in Lighthalzen (region 11).

1. **A worried mother** - talk to Iromo's Mother in Alberta (1).
   Why: her son Iromo never goes out any more.
   `/navi alberta_in 120/93` | done when: `ep13_2_hiki >= 1`
2. **Iromo** - talk to Iromo (2), then his mother again (3).
   `/navi alberta_in 131/95` | done when: `ep13_2_hiki >= 3`
3. **His friend** - the Little Boy in Alberta wants a Banana (4); bring one
   (taken, 5); talk again: Iromo loved Monster's Feed in Red Potion soup (6).
   `/navi alberta 45/106` | done when: `ep13_2_hiki >= 6`
4. **His favourite lunch** - bring Iromo 1 Monster's Feed and 1 Red Potion
   (taken, 7).
   `/navi alberta_in 131/95` | done when: `ep13_2_hiki >= 7`
   Reward: 3,750 base EXP.
5. **The furious cat** - his mother tells how he came home hurt; Iromo is
   afraid of a cat. Talk to Iromo (8). The hunt (quest 10084) has no target
   in `db/re/quest_db.yml`, so it counts as done at once (to verify in game).
   `/navi alberta_in 131/95` | done when: `ep13_2_hiki >= 8`
   Reward: 4,700 base EXP.
6. **A day later** - after a day of play time (quest 10085, 1 day) talk to
   him again (9).
   | done when: `ep13_2_hiki >= 9`
7. **Siblings** - with `lhz_rekenber > 21`: "A story about a pair of
   siblings." (10).
   | done when: `ep13_2_hiki >= 10`
   Reward: 5,700 base EXP.
8. **Another day** - after a day (quest 10087) talk again (11).
   | done when: `ep13_2_hiki >= 11`
   Reward: 6,700 base EXP.
9. **Friends** - with `friendship > 14` talk again (12), then once more (13).
   `/navi alberta_in 131/95` | done when: `ep13_2_hiki >= 13`
   Reward: 8,000 base EXP.

## 6. Comodo

### Muff's Loan
`quests/quests_nameless.txt` | `diamond_edq` 0->14, quests 3100-3109
"Consolidating Heavy Debt" | Lv 61 (Muff: below 61 he sets 3 and refuses;
come back at 61). Muff, Dorian and the machine first check that you can
carry more items.

1. **Muff** - in Comodo: "You look troubled.", "Do you know where you lost
   it?" (1).
   Why: he lost the bond of debt that proves Belder of Alberta owes him.
   `/navi comodo 224/187` | done when: `diamond_edq >= 1`
2. **The heap of earth** - in the field north-west of Comodo: "Dig Up the
   Spot" (2), then click again (4: a soggy wallet with the bond).
   `/navi cmd_fild01 55/160` | done when: `diamond_edq >= 4`
3. **The ruined bond** - back to Muff: "Accept His Request" (6). ("Decline"
   sets 5: talk again and accept.)
   Why: the ink has run; the inventor Dorian in Izlude has a magic dryer.
   `/navi comodo 224/187` | done when: `diamond_edq >= 6`
4. **Dorian** - in Izlude: "I want to use your Magic Dryer.", "This Bond of
   Debt", "Zzz..." and type `3 Centrifuge Wavelength Theory` (9).
   `/navi izlude_in 57/92` | done when: `diamond_edq >= 9`
   Fails: "Oh, please!" or "My Hair" offends him (7); talk again (6).
5. **Repair materials** - bring 20 Rusty Screw, 10 Iron Ore, 5 Steel, 2 Ruby,
   5 Red Gemstone (all taken; he says "10 Red Gemstones", the script takes 5)
   (10).
   `/navi izlude_in 57/92` | done when: `diamond_edq >= 10`
6. **The Mystic Dryer** - at the Strange Machine: "Replace the Engine";
   "Tighten the Screw" until you hear *Click* (2 to 5 turns; one more breaks
   it); then "Press a Switch" by the engine's sound: Buzz = Red, Purr = Blue,
   Bzzz = Yellow, Pzzzz = Green. After each colour has been right once, press
   once more (12).
   `/navi izlude_in 58/90` (rAthena marks the spot "unconfirmed") | done when:
   `diamond_edq >= 12`
   Fails: a broken screw or a wrong switch sets 11; Dorian resets you (10).
7. **The restored bond** - tell Dorian (13); use the machine again: it gives
   the Debt Note.
   `/navi izlude_in 57/92`, `/navi izlude_in 58/90` | done when: you hold
   the Debt Note at 13
8. **Back to Muff** - give him the Debt Note (14).
   `/navi comodo 224/187` | done when: `diamond_edq >= 14`
   Fails: talking to Muff at 13 without the Debt Note sets 10: the machine
   has to be fixed again.
   Reward: 1 Old Blue Box, 4 Yggdrasil Seed.
   Opens: Broken Diamond.

### Broken Diamond
`quests/quests_nameless.txt` | `diamond_edq` 14->26, quests 3110-3118 "Stolen
Diamond" | Lv 66 (Ibrahim: `BaseLevel > 65`) | needs: Muff's Loan.

1. **Ibrahim** - in the Morocc ruins: "How can I help you?", "Sure, I'll help
   you." (15).
   Why: his Diamond of Destruction, one of the Four Cursed Jewels, was stolen.
   `/navi moc_ruins 152/147` | done when: `diamond_edq >= 15`
2. **The jewellers** - Jhonnita in Alberta and Kimeunbang in Payon only talk
   (Kimeunbang, "What's wrong?", gives a Pearl, 16); Leblo in Geffen trades
   news for a favour: "Deal." (17).
   `/navi geffen 128/153` (`alberta 102/80`, `payon 69/65`) | done when:
   `diamond_edq >= 17`
3. **Doctor Wola** - in Payon, walk into Wola's room (18), talk (19), bring
   20 Fine Sand, 10 Brigan, 10 Soft Blade of Grass, 5 Empty Bottle (taken,
   20), then "Leblo's back medicine?" (21).
   Why: Leblo insulted his doctor; you mend her broken medicine pot.
   `/navi payon_in03 167/149` | done when: `diamond_edq >= 21`
4. **Leblo's news** - give Leblo his medicine (22): a young couple of the
   Z-Gang tried to sell him the diamond.
   `/navi geffen 128/153` | done when: `diamond_edq >= 22`
5. **The Rogue Investigator (optional)** - in the Rogue Guild: "Sounds
   good!" and 10,000 zeny for the hideout's place (23; a Rogue hears it for
   free and stays at 22).
   `/navi in_rogue 366/46` | done when: `diamond_edq` 22 or 23
6. **The Z-Gang's warehouse** - in Comodo, through the Kafra building
   (`/navi comodo 130/195`) to the back rooms: click the Small Safe; a switch
   shows by the barrels (`/navi cmd_in02 69/196`), then another under the
   boxes (`/navi cmd_in02 80/189`) (24); open the safe: Diamond of Ruin (25).
   `/navi cmd_in02 69/188` | done when: `diamond_edq >= 25`
7. **Back to Ibrahim** - give him the diamond (26).
   `/navi moc_ruins 152/147` | done when: `diamond_edq >= 26`
   Reward: 2 3carat Diamond, 1 Old Blue Box.
   Opens: the Unlucky Emerald's jewel part (region 4).

## 7. Umbala

### The Umbalian Language
`quests/quests_umbala.txt` | `event_umbala` 0->3 | Lv none.

1. **The Utan chief** - talk to Karkatan, chief of the Utan tribe, in the
   great tree (1).
   Why: he learned your language from an adventurer long ago, but only
   teaches his own to those who respect Utan ways.
   `/navi um_in 39/122` | done when: `event_umbala >= 1`
2. **A mask** - wear a mask and choose "I want to learn Utan language."
   (2). Any one of: Mr. Smile, Goblin Mask, Mr. Scream, Welding Mask, Gas
   Mask, Opera Masque, Opera Phantom Mask (`isequipped`, line 137).
   Why: Utans hide their faces so that looks never decide how others are
   treated.
   `/navi um_in 39/122` | done when: `event_umbala >= 2`
   Fails: without a mask he sends you to look around the village; nothing
   is lost.
3. **The lesson** - bring 10 Oil Paper, 5 Slick Paper, 1 Squid Ink, 1
   Feather of Birds (taken) (3).
   Why: paper and ink to write the lessons down.
   `/navi um_in 39/122` | done when: `event_umbala >= 3`
   Opens: you understand the Utans; The Sign's Umbala step (region 1).
   Closes: Umbala Domestic Dispute (it is played in the Utan tongue).

The Utan Shaman (`/navi um_in 44/71`) then asks for the chief's leave
(4); the chief wants 1 Mr. Smile (5, taken at 6); the shaman agrees (7).
That only unlocks her Create Essence / Dismantle Stone service (excluded as
crafting) and opens the skull door in Umbala (`/navi umbala 221/193`) into
her room without the gemstone test (`event_umbala >= 7`, line 827).

### Umbala Domestic Dispute
`quests/quests_umbala.txt` | `um_wind` 0->5, then 0 and MISC_QUEST bit 32768
| Lv none. Only before the Umbalian Language (`event_umbala` below 3) and
not as a Novice (`BaseJob == Job_Novice && Upper != 2`, line 998). You
will not understand a word: the women only answer after 19:00 server time
(`gettime(DT_HOUR) > 18`).

1. **Phrenetan** - talk to the angry woman in the house (1).
   Why: her husband Umpokoriohtan chases every girl in the village.
   `/navi um_in 139/48` | done when: `um_wind >= 1`
2. **Wainatan** - after 19:00, talk to her (2).
   `/navi um_in 101/73` | done when: `um_wind >= 2`
3. **Bertztan** - after 19:00 (3).
   `/navi um_in 94/123` | done when: `um_wind >= 3`
4. **Chabimatan** - after 19:00, outside (4): Umpokoriohtan appears in his
   house.
   `/navi umbala 145/217` | done when: `um_wind >= 4`
5. **Caught** - walk into Phrenetan's house: she beats her husband and
   throws you out (5).
   `/navi um_in 141/46` | done when: `um_wind >= 5`
6. **A leaf** - where you land, step on the spot: "Take it." (a Yggdrasil
   Leaf) or "Leave it." Both end the quest (MISC_QUEST 32768).
   `/navi umbala 94/181` | done when: `MISC_QUEST & 32768`
   Reward: 1 Yggdrasil Leaf (if taken).
## 8. Niflheim

### The Piano Key Quest
`quests/quests_niflheim.txt` (the last piano spot in
`re/quests/quests_niflheim.txt`) | `nif_esc` 0->12, MISC_QUEST bit 32 | Lv
none. Six Piano Keys (7184) open a way out of Niflheim. Alreg picks one of
two orders at random (`nif_esc` 1 or 2); the steps say which way.

1. **Alreg** - touch the hungry giant in Niflheim: he takes a bite (60% of
   your HP) and gives a Piano Key (1 or 2).
   Why: he has not tasted a living one for a long time; the key is his
   thanks.
   `/navi niflheim 224/243` | done when: `nif_esc` 1 or 2
   Note: later talks only cost 30% HP.
2. **Crayu, the bard** - listen to her song and type the line she asks
   for, exactly: 1 `Mountain sunset to the west`, 2 `Where the purple dusk
   falls`, 3 `Surrounded by beautiful melody`, 4 `You become the key that
   ignores its master`. Gives a key.
   Why: the song hides the secret of the piano.
   `/navi nif_in 105/81` | done when: `nif_esc` 3 (order 1) or 6 (order 2,
   after step 3)
   Fails: a wrong line costs nothing; talk again (the line is random).
3. **Kuzkahina's shop** - the dead shopkeeper hands you "junk" to throw
   away: a key.
   Why: even dead he cannot make his store pay.
   `/navi nif_in 31/20` | done when: `nif_esc` 5 (order 1) or 4 (order 2,
   then go to Crayu)
4. **The graves** - step on the two spots in the graveyard and choose
   "Yes" each time: order 1 the first grave twice (7, 9), then the second
   (11); order 2 the second grave (8), then the first twice (10, 11).
   `/navi niflheim 208/103` (first), `/navi niflheim 169/71` (second) | done
   when: `nif_esc >= 11` (6 keys)
5. **The piano** - in the house, step by the piano: the 6 keys go in (12).
   `/navi nif_in 115/181` | done when: `nif_esc >= 12`
6. **The last key** - step on the spot at the left end of the keyboard:
   you become the last key and float away (MISC_QUEST 32), into the
   Witch's room; she sends you to Umbala.
   `/navi nif_in 118/151` (Witch: `nif_in 188/168`) | done when:
   `MISC_QUEST & 32`
   Opens a place: a way out of Niflheim. Once done, the same spot takes you
   to the Witch at any time, and she warps you to `umbala 138/208`.

The Message Delivery (`nif_revive`, the same file) starts in Prontera
(region 1).
## 9. Juno, Juperos and the Kiel Hyre area

### The Kiel Hyre Quest
`quests/kiel_hyre_quest.txt` | `KielHyreQuest` 0->109 (side values
`KHToastGirlEnd`, `KHCottagePoem1/2`) | Lv none. Many typed answers: type
them exactly as shown.

Part 1: the delivery and Elly's cookies

1. **The pub master** - walk up to the Pub Master in Juno (1), then talk:
   "You look worried, what's up?", "Do you want me to help you?", "Sure
   I'll do it" (2, a bottle of Culinary Wine).
   Why: his delivery man was hurt; the wine must reach Mrs. Lecollane at
   the Kiel Hyre Academy.
   `/navi yuno_in01 35/179` | done when: `KielHyreQuest >= 2`
2. **The academy gate** - the Security Guard: "I'm here for a delivery.",
   type `Lecollane`, then `Culinary Wine`: he lets you in.
   `/navi yuno_fild08 158/194` | done when: inside `kh_school`
   Note: from now until Elly's note (step 16) the guard lets you in.
3. **Mrs. Lecollane** - "Yes, that's right!" (4; the wine is taken).
   Why: a crash next door: her student Elly broke something again.
   `/navi kh_school 176/60` | done when: `KielHyreQuest >= 4`
4. **Elly** - the Cute Student: "What happened?", "What can I do to help
   you?", "Accept" (6).
   Why: she spilled her cookie ingredients and fails the semester if the
   cookies are not baked today.
   `/navi kh_school 179/39` | done when: `KielHyreQuest >= 6`
5. **The ingredients** - gather 7 Milk, 2 Cheese, 5 Cacao (Yoyo drop), 1
   Culinary Wine (the Pub Master: "I need more wine...", plus 1,000 zeny
   pay) and 1 Delivery Package: the Little Kid's toast stand in Juno, "I'm
   here for Elly" (`/navi yuno 217/114`), the Windmill Owner in
   Lighthalzen, "I'm here for Cezu" (`/navi lighthalzen 366/299`), then
   back to the kid. Bring all to Elly (taken, 8).
   `/navi kh_school 179/39` | done when: `KielHyreQuest >= 8`
6. **Cookies for grandfather** - talk to Elly again (10, 5 Well-baked
   Cookie), then "What do you need?", "Sure" (12).
   Why: she wants her grandfather, Kiel Hyre, to taste her first unburnt
   cookies.
   `/navi kh_school 179/39` | done when: `KielHyreQuest >= 12`

Part 2: Kiel Hyre's cottage

7. **The cottage keeper** - north of the academy: "I have an appointment
   with Kiel Hyre.", "Yes" (14): Kiel Hyre is not home.
   `/navi yuno_fild02 93/210` | done when: `KielHyreQuest >= 14`
8. **The spare key** - back to Elly (16, a Cottage Key).
   `/navi kh_school 179/39` | done when: `KielHyreQuest >= 16`
9. **The letter** - at the cottage, the left door: "Unlock" (18); inside,
   step on the letter on the floor (20).
   `/navi yuno_fild02 75/218`, then `/navi kh_vila 179/11` | done when:
   `KielHyreQuest >= 20`
10. **Bad news** - give the letter to Elly (22). Then ask "What's with
    this academy?", "Strange incidents?" (24): a ghost curses students; if
    it ever gets her, shout "Wake up, Elly!". Talk once more (26).
    Why: the letter is ten days old: Kiel Hyre went to meet his son Kiehl.
    `/navi kh_school 179/39` | done when: `KielHyreQuest >= 26`
11. **The secret path** - in the cottage study, click the bookshelf books
    until a wall opens (1 try in 10, 28); walk through the wall.
    `/navi kh_vila 184/20` (also `181/20`, `178/20`, `175/19`; wall `kh_vila
    191/14`) | done when: `KielHyreQuest >= 28`
12. **The first poem** - in the hidden part: the Map, "Examine" (poem 1);
    the Pot, "Try it."; the Map again; the Pool: "Pull Handles", "Left
    Handle", "Investigate", "Press button".
    `/navi kh_vila 44/126`, `33/184`, `44/126`, `39/41` | done when:
    `KHCottagePoem1 >= 4`
13. **The second poem** - the Desk (poem 2); the Medicine Chest: "Of
    course! Let's try it!", "Try Blue Liquid".
    `/navi kh_vila 118/144`, `kh_vila 123/170` | done when: `KHCottagePoem2 >= 2`
    Note: if the Vicious Dog blocks you (`kh_vila 181/178`), buy Pet Food
    at the vending box (`/navi kh_vila 16/175`, 1,100 zeny), then "March
    forward", "Give Pet Food".
14. **The swords** - the Sword Hilt: "Of course!", "Insert Ornamental
    Swords", then "Second Snake", "Fourth Snake", "First Snake", "Third
    Snake": you drop into the lab. At the Test Tube: "Press Button" and
    type `little lost devil` (30).
    `/navi kh_vila 136/68`, then `/navi kh_vila 185/68` | done when:
    `KielHyreQuest >= 30`
    Fails: a wrong snake order or answer only sends you back; try again.
15. **Three keys** - still in the cottage: the Calabash, "Look Inside
    Calabash" (Old Bronze Key); the Box, "Use Old Bronze Key" (Green
    Keycard); the Bookshelf: "Examine Book", "Examine the steel surface",
    "Try all your keys", first "Cottage Key", then "Green Keycard" (Iron
    Box; both keys taken); the Drawer, "Open Drawer" (Yellow Keycard).
    `/navi kh_vila 14/55`, `107/126`, `181/138`, `115/186` | done when: you
    hold the Iron Box and the Yellow Keycard

Part 3: Elly's curse and the Robot Factory

16. **Elly's window** - at night she asked you to her dorm: below her
    window, "Climb Water Pipe" (1 try in 3; a fall costs 10% HP). In her
    room, the Cookie Basket: "Read Note" (32).
    `/navi yuno_fild08 69/185`, then `/navi kh_school 175/176` | done when:
    `KielHyreQuest >= 32`
17. **Wake up, Elly!** - Elly stands frozen: "Wake her up by yelling." and
    type `Wake up, Elly!` (34: Golden Key and Kiel Button). Talk again
    with the Iron Box: the Golden Key opens it (36: Blue Keycard and a
    note).
    `/navi kh_school 178/180` | done when: `KielHyreQuest >= 36`
    Note: leave by the window (`/navi kh_school 188/185`).
18. **The grave** - the grave behind the academy: type `Yellow Keycard`,
    then the password `4772961` (38). Then "Enter": the Robot Factory.
    `/navi yuno_fild08 71/170` | done when: `KielHyreQuest >= 38`
    Opens a place: the Robot Factory floor 1 (`kh_dun01`).
19. **Allysia** - in the factory, the Heavy Door: "Open Door", type `Blue
    Keycard` (to a room under the academy). The Beautiful Lady: choose
    "Golden Key" (the "Carved Button" calls 4 Bombs). In her room,
    Allysia: "What happened to Kiel Hyre?" (40, a Red Keycard); talk again
    to go down into the factory.
    `/navi kh_dun01 235/48`, `/navi kh_school 119/149`, `/navi kh_school
    122/186` | done when: `KielHyreQuest >= 40`
20. **Kiel Hyre's voice** - at the Mechanical Device type `Red Keycard`;
    walk to the door of Factory area B: Kiel Hyre, locked in, slides you a
    metal fragment (42).
    `/navi kh_dun01 166/223`, then `/navi kh_dun01 224/233` | done when:
    `KielHyreQuest >= 42`
21. **His orders** - back to Allysia (through the Heavy Door): she takes
    the fragment (44); talk again: she takes all three keycards and sends
    you to the mansion in Lighthalzen (46).
    `/navi kh_school 122/186` | done when: `KielHyreQuest >= 46`

Part 4: the mansion and Agent Mitchell

22. **Kiel Hyre** - the mansion in Lighthalzen (`/navi lighthalzen
    188/204`): the Steward, "Present Golden Key". Ask Kiel Hyre all three:
    "Robots?", "Kiehl?", "Elly's button?" (48; Golden Key and button
    taken), then talk again (50).
    `/navi kh_mansion 78/55`, then `/navi kh_mansion 22/28` | done when:
    `KielHyreQuest >= 50`
    Reward: 70,000 base EXP, 1 Taming Gift Set.
23. **Kidnapped** - step out of the mansion: you are knocked out (99% of
    your HP) and wake before a Mysterious Woman: "I'll tell you
    everything!", "Okay" (52); talk again (54), "Yes": to Juno.
    Why: she is Agent Mitchell of the Schwarzwald government, watching Kiel
    Hyre and Rekenber; she wants to know about an Allysia who died 30
    years ago.
    `/navi lighthalzen 188/200` (`kh_mansion 25/79`) | done when:
    `KielHyreQuest >= 54`
24. **The odd grandma** - in Juno: "What are you doing?" (56).
    `/navi yuno 257/140` | done when: `KielHyreQuest >= 56`
25. **The old lady** - "Do you know that grandma?", "Was Allysia...?",
    "Wait, who's James Rosimier?", "May I borrow the Master Key?" (58,
    Rosimier Key).
    `/navi yuno 250/132` | done when: `KielHyreQuest >= 58`
26. **The Rosimier mansion** - walk into its door with the key; take: the
    Table (Family Portrait); the Shelf, "Use Key", "First Box" (Elysia
    Portrait); the Desk, "Second Drawer" (a letter of Kiel Hyre); the
    Bookshelf (James's memo).
    `/navi yuno 273/141`, then `/navi kh_rossi 23/23`, `92/40`, `144/286`,
    `148/288` | done when: you hold all four
    Fails: "Check Bedsheets" at the Bed costs 10% HP.
27. **Allysia's past** - the old lady: "Why did Allysia...?" (60; key
    taken).
    `/navi yuno 250/132` | done when: `KielHyreQuest >= 60`
28. **The old fisherman** - bring 10 Raw Fish (taken): "30 years ago, a
    woman killed herself...", "Do you remember his name?" (62).
    `/navi yuno_fild12 232/222` | done when: `KielHyreQuest >= 62`
29. **The wooden board** - a man's portrait under a board (64).
    `/navi yuno_fild09 158/217` | done when: `KielHyreQuest >= 64`
30. **Report to Mitchell** - the mansion Steward: "Mitchell"; the
    Mysterious Woman gives you a hidden mic (68).
    `/navi kh_mansion 78/55` | done when: `KielHyreQuest >= 68`
31. **Face Kiel Hyre** - the Steward: "Kiel Hyre"; then "About
    Allysia...", "Reveal Kiel's Portrait from Hut", "Reveal Portrait of
    Rosimiers", "Show James's Note", "Show K.H.'s note" (70; all five
    taken). Talk again: "Accept" (or "Okay", "Nod"), "Allysia's Ring?"
    (74, a Toy Motor).
    `/navi kh_mansion 22/28` | done when: `KielHyreQuest >= 74`

Part 5: Kiehl

32. **Kiehl's lair** - Kiel Hyre: "Yes": a warp opens beside him into
    Kiehl's cave. The Receiver (76) calls an Alicel and an Aliot: kill them
    for a Black Keycard (talk to it again for more). The Box: type `open
    the door` (Toy Key).
    `/navi kh_mansion 27/27`, then `/navi kh_kiehl01 17/39`, `19/25` | done
    when: `KielHyreQuest >= 76`
33. **The big doors** - type `Black Keycard` at the doors at `kh_kiehl01
    44/33` and `77/108` (1 card each) and `42/177` (2 cards), `Toy Key` at
    `174/40`; the robots at `15/179` also leave a Black Keycard. Each door
    stays open 30 seconds.
    | done when: at the last door (`kh_kiehl01 166/187`)
34. **The last door** - try it three times (each try calls 4 robots; 86),
    then pry it with "Solid Iron Piece" four times (one each, from Alicel
    and Aliot, 15%) (94), then "Yes": into Kiehl's room.
    `/navi kh_kiehl01 166/187` | done when: `KielHyreQuest >= 94`
35. **Kiehl** - kill 5 of the robots he calls, talk (100); talk again and
    defeat Kiehl (boss); talk to him: he takes the Toy Motor (104), a
    3-minute countdown starts; talk again (106, Allysia's Ring) and leave
    by the exit before it ends.
    `/navi kh_kiehl02 50/52` (exit `49/56`) | done when: `KielHyreQuest >= 106`
    Fails: one player at a time in the room; it resets after 20 minutes or
    when the countdown ends (you are put out in Lighthalzen).
36. **The ring** - give it to Kiel Hyre (108).
    `/navi kh_mansion 22/28` | done when: `KielHyreQuest >= 108`
    Reward: 100,000 base EXP, 1 Old Card Album, the Luxurious Keycard.
    Opens a place: Robot Factory floor 2 (`kh_dun02`): type `Luxurious
    Keycard` at the Entrance Device (`/navi kh_dun01 44/203`).
37. **Elly's letter** - in Elly's room, the Cookie Basket: read her letter
    and type anything (109).
    `/navi kh_school 175/176` | done when: `KielHyreQuest >= 109`

### The Metto Quest (Scientist Who Trusts Fate)
`quests/quests_yuno.txt` | `metto_q` 0->9 | Lv none (not as a Novice) |
guided `yuno_metto`.

1. **Wagan's plan** - talk to Wagan: "Leave it to me." (1).
   Why: Wagan wants Metto to give up experiments that frighten the
   district; Metto believes in fate, so fate must seem against him.
   `/navi yuno_in01 17/30` | done when: `metto_q >= 1`
2. **Three warnings** - hear Metto out (2); Stangckle: "I'm here to stop
   your research." (3); Metto (4); Kato: "I want to stop you from making a
   mistake." (5); Metto (6); CiCi: "I want to warn you." (7); Metto (8).
   Why: three others tried his experiment and failed; he begins to believe
   it is fate.
   `/navi yuno_in03 26/39`, `yuno_in01 17/95`, `yuno_in01 19/183`, `yuno_in03
   178/43` | done when: `metto_q >= 8`
3. **Fate decides** - tell Wagan (9).
   `/navi yuno_in01 17/30` | done when: `metto_q >= 9`
   Reward: 5 Blue Gemstone (a Sage: 10 Yellow Gemstone).
   Opens: one of the Wandering Bard's stories (29).

### Juperos Ruins History
`quests/quests_juperos.txt` | `yuno_hist` 0->10, `jupe_hist`, quests
11017-11022 | Lv none | dead end at step 4.

1. **The thesis** - in the Juno library, the Bundle of Files: "Table of
   Contents.", "Preface" (1).
   `/navi yuno_in04 186/125` | done when: `yuno_hist >= 1`
2. **Fayruz** - the Scholar: "By any chance..." (2).
   Why: she studies the fall of Juperos and needs someone to go there.
   `/navi yuno_in04 190/125` | done when: `yuno_hist >= 2`
3. **The bronze statue** - in Juperos: "Investigate" (3).
   `/navi juperos_01 99/112` | done when: `yuno_hist >= 3`
4. **The inscription** - Fayruz: "I found something in Juperos." (4).
   `/navi yuno_in04 190/125` | done when: `yuno_hist >= 4`
5. **The plates** - she needs the four Transparent Plates (7352-7355, one
   each), dropped only by the four Dimik kinds at 0.25% (`db/re/mob_db.yml`;
   Plate 1 also 1.25% from the champion Dimik). Dead end, see
   guide-deferred.md.
   Note: a plate 7355 alone cannot be used: the script deletes 7352
   instead (line 325).

### The Juno Remedy Quest
`quests/quests_hugel.txt` (Juno, Hugel) and `quests/quests_airship.txt`
(the airship) | `hg_ma1` 0->13, quests 8044-8052 | Lv 60 (`BaseLevel <
60`, Euslan) | **Players: 5** at step 5: Eukran is only reached through a
Bingo game, and the Bingo waiting room starts at 5 players.

1. **Euslan** - the coughing woman in Juno: "Speak to Euslan" (1), again
   "Speak to Euslan", "Are you alright?", "Offer to find Thierry" (3).
   ("Leave her alone" sets 2; talk again and offer.)
   Why: her fiance Thierry went looking for her medicine and has not come
   back.
   `/navi yuno 111/156` | done when: `hg_ma1 >= 3`
2. **Kaci** - on the domestic airship: "Do you know a guy named Thierry?"
   (4).
   `/navi airplane 33/69` | done when: `hg_ma1 >= 4`
   Note: Hallen (`airplane 236/63`) only sends you to Kaci; he will not
   start the Heart Fragment Quest while `hg_ma1` is 3.
3. **The passenger list** - Captain Ferlock: "I am looking for a man named
   Thierry.", "Will you let me check the history of passenger lists?" (5).
   Why: Thierry flew to Hugel on the route's first day and saved the
   airship from dragons.
   `/navi airplane 236/163` | done when: `hg_ma1 >= 5`
4. **Back to Euslan** - "Well, I met Kaci on the Airship." (6).
   `/navi yuno 111/156` | done when: `hg_ma1 >= 6`
5. **Eukran** - in Hugel's Bingo hall (`/navi hugel 55/208`), play one
   Bingo game (waiting room `que_bingo 48/84`, 1,000 zeny, starts at 5
   players; winning is not needed). At the end the plate takes you to
   Eukran: "Talk about Euslan" (8).
   `/navi que_bingo 53/190` | done when: `hg_ma1 >= 8`
6. **Thierry** - in the Odin Shrine, walk to where two men talk; Thierry
   appears for 3 minutes: "Mr. Thierry?", "Tell him about Euslan", "What
   are you doing here?" (9).
   `/navi odin_tem01 129/127` (Thierry `130/134`) | done when: `hg_ma1 >= 9`
7. **The plot** - walk on to overhear the men: they plan to kill Thierry
   (10). Warn him: "Warn Thierry about Suspicious Men" (11).
   Why: they are Rekenber agents digging for a giant's remains under the
   shrine.
   `/navi odin_tem01 111/144`, then `/navi odin_tem01 130/134` | done when:
   `hg_ma1 >= 11`
8. **The runes** - bring Thierry 5 Rune of Darkness (taken, 12): he makes
   the medicine.
   `/navi odin_tem01 130/134` | done when: `hg_ma1 >= 12`
9. **The medicine** - give it to Euslan (13).
   `/navi yuno 111/156` | done when: `hg_ma1 >= 13`
   Reward: 90,000 base / 60,000 job EXP.

Not quests here: the Pile Bunker (`re/quests/pile_bunker.txt`, an item) and
the Doomed Swords and Alchemist parts of `quests/quests_yuno.txt` are
excluded (crafting, job).

## 10. Einbroch and Einbech

The Einbroch Laboratory door (Security, `/navi einbroch 51/52`) is used by
the Murder Quest and the Heart Fragment Quest: walk onto it while the
quest is at that step, choose "Identify." and type the two lines it shows,
exactly (case and spaces count), within 60 seconds in all. Fails: a typo
or more than 60 seconds; try again. It lets you in to `ein_in01 283/25`.

### The Factory Quest
`quests/quests_ein.txt` | `EinFactory` 0->16, quests 8017-8031 | Lv none |
guided `ein_factory`. Every finished quest adds 1 to `$EinPolution`; at 10
the Einbroch Smog Alert fills the town with Toxic Fogs and hides the
townsfolk (Zelmeto sends you away while it lasts).

1. **Zelmeto** - the overseer in the factory: "You're understaffed?", "I
   can help you." (1).
   Why: the factory is so short of hands that the machines run unwatched.
   `/navi ein_in01 67/242` | done when: `EinFactory >= 1`
2. **The rounds** - click each machine, then report to Zelmeto: the 2nd
   Control Panel (2, report 3), the 3rd Pressure Governor (4, 5), the Main
   Control Panel (6, 7), the Conveyor (8, 9), the Pipe (10, 11), the other
   Conveyor (12).
   `/navi ein_in01 49/232`, `108/217`, `62/258`, `46/197`, `100/266`,
   `95/239` | done when: `EinFactory >= 12`
3. **Liotzburg** - report to Zelmeto (13), then walk up to Liotzburg in
   the streets (14).
   Why: he has his own view of what the factory does to Einbroch.
   `/navi einbroch 132/84` | done when: `EinFactory >= 14`
4. **Spare parts** - tell Zelmeto (15), then bring 20 Flexible Tube, 10
   Rusty Screw, 10 Used Iron Plate: "Give him materials." (16).
   `/navi ein_in01 67/242` | done when: `EinFactory >= 16`
   Reward: base EXP by level: 61 (Lv 40 or less), 307, 660, 1,850, 3,206,
   7,602, 29,067 (Lv 91+).
   Opens: the Murder Quest's step 6 (`EinFactory > 12`).

### The Murder Quest
`quests/quests_ein.txt` | `Shinokas_Quest` 0->11, quests 2071-2078 | Lv
none | needs: the Factory Quest past step 12 (at step 7).

1. **Buender Hikeman** - the old miner in Einbech: "'What are you talking
   about?'", then any answer (1).
   Why: he takes you for someone from the old mine collapse and mutters
   about a mysterious ore.
   `/navi einbech 165/105` | done when: `Shinokas_Quest >= 1`
2. **The accident** - talk again; answer either way (2).
   `/navi einbech 165/105` | done when: `Shinokas_Quest >= 2`
3. **The sick old man** - in Einbroch, the Sick Old Man: ask "Remember the
   mine tunnel collapse?" or "Didn't you used to be a miner?" seven times
   in a row (never "Have you lived in Einbroch all your life?", which
   starts the count over), then "Have you ever heard of Hikeman before?"
   (3).
   Why: he is Shinokas, Hikeman's friend who caused the collapse.
   `/navi ein_in01 231/163` | done when: `Shinokas_Quest >= 3`
4. **His story** - talk again: "Did you find it?", "Wait, who's trying to
   get you?" (4).
   Why: he sold out his friends for an ore and has been hunted ever since;
   he wants to know what it was.
   `/navi ein_in01 231/163` | done when: `Shinokas_Quest >= 4`
5. **The Kapellthaine maid** - in the manor, ask the Maid (5).
   `/navi ein_in01 32/133` | done when: `Shinokas_Quest >= 5`
6. **Where is the ore?** - back to Shinokas (6); with `EinFactory > 12`,
   talk again and choose "Laboratory" (7).
   `/navi ein_in01 231/163` | done when: `Shinokas_Quest >= 7`
7. **The laboratory** - get in through the Security door (see the top of
   this region); the Scientist inside: "What's wrong?" (8).
   Why: the lab head spends his days on the airship with a woman.
   `/navi ein_in01 254/35` | done when: `Shinokas_Quest >= 8`
8. **The drunk on the airship** - the Drunken Man on the domestic airship
   loses his apples at dice. Bring 100 or more Apples (all taken, each
   try): 3 tries in 10 he wins. Then "So what was that about Ymir's
   Heart?", "Project?" (9).
   `/navi airplane 31/77` | done when: `Shinokas_Quest >= 9`
   Fails: a lost try (7 in 10) takes all your apples; 11-99 apples are not
   enough to play. Apples are sold in Einbroch (`/navi einbroch 82/199`),
   Hugel and Lighthalzen.
9. **Too late** - back to Shinokas, found stabbed; type what the ore was
   (`Ymir`, either answer goes on) (10).
   `/navi ein_in01 231/163` | done when: `Shinokas_Quest >= 10`
10. **Hikeman** - "Tell Hikeman about Shinokas's death." (11; "Don't notify
    Hikeman." leaves it at 10).
    `/navi einbech 165/105` | done when: `Shinokas_Quest >= 11`
    Reward: base / job EXP: 30,000 (below Lv 70), 40,000 (70-79), 70,000
    (80-89), 90,000 (90+), the same as job EXP.
    Opens: a branch of the President Quest (`Shinokas_Quest == 11`); the
    Heart Fragment Quest skips a step (`Shinokas_Quest > 9`).

### The Lovers Quest
`quests/quests_ein.txt` | `EIN_LOVERQ` 0->17, quests 8076-8088 | Lv 60
(Calla: `BaseLevel < 60` only talks).

1. **Calla** - in Kapellthaine Manor, Einbroch (1).
   Why: the rich man's daughter envies your freedom.
   `/navi ein_in01 31/138` | done when: `EIN_LOVERQ >= 1`
2. **Klitzer** - in Einbech, the young man (2).
   Why: he loves Calla but thinks himself a coward and a fool.
   `/navi ein_in01 200/101` | done when: `EIN_LOVERQ >= 2`
3. **The violin** - Calla gives you her Violin for him (3).
   `/navi ein_in01 31/138` | done when: `EIN_LOVERQ >= 3`
   Fails: Megass, Calla's father, stands in the manor (`ein_in01 21/147`):
   coming within 3 cells of him throws you out to `einbroch 112/245`, and
   with the violin he also takes it and 90% of your HP (4). Calla then
   gives you another (3).
4. **Klitzer's flower** - give Klitzer the violin (5; he restores your HP).
   He asks you to bring Calla 1 Flower.
   `/navi ein_in01 200/101` | done when: `EIN_LOVERQ >= 5`
   Reward: base EXP 61 (Lv 40 or less), 600 (41-60), 3,000 (61-80),
   20,000 (81-98), 30,000 (99+).
5. **Names** - give Calla the Flower and type your character's name (6);
   then at Klitzer type your name too (7).
   `/navi ein_in01 31/138`, `/navi ein_in01 200/101` | done when:
   `EIN_LOVERQ >= 7`
6. **Klitzer's mother** - Kaijeta, in Einbech (8).
   `/navi ein_in01 191/102` | done when: `EIN_LOVERQ >= 8`
7. **Lady Satra** - Calla's mother, in the manor (9): she wants Coal.
   Bring 10 Coal four times (taken each time, 10, 11, 12, 13); at the
   last, type who gathered it: `Klitzer` (13).
   Why: she looks down on Einbech's miners; Coal "from Klitzer" earns him
   a tea with her.
   `/navi ein_in01 31/151` | done when: `EIN_LOVERQ >= 13`
   Note: Coal drops from Banaspaty 5%, Panzer Goblin 2.9%, Obsidian 2.5%
   (`db/re/mob_db.yml`); Hans in the Eden Market Group sells it for 10,000
   zeny, only on Saturday 22:00-24:00 server time (`re/merchants/eden_market.txt`).
8. **Tea with her mother** - tell Klitzer (14); Kaijeta says he needs a
   Formal Suit or a Tuxedo (15).
   `/navi ein_in01 200/101`, `/navi ein_in01 191/102` | done when:
   `EIN_LOVERQ >= 15`
9. **The tuxedo** - give Klitzer a Tuxedo (sold by the Wedding Shop Dealer
   in Prontera and Lighthalzen): "Give it to him." (16).
   `/navi ein_in01 200/101` | done when: `EIN_LOVERQ >= 16`
   Reward: one random gem (Olivine, Phlogopite, Agate, Rose Quartz,
   Turquoise, Citrine or Pyroxene).
10. **Calla's thanks** - talk to Calla (17).
    `/navi ein_in01 31/138` | done when: `EIN_LOVERQ >= 17`
    Reward: base EXP as in step 4.
    Warning: her "massage" takes off all your equipment (`nude`); put it
    back on afterwards.

### Kain's Free Ticket
`quests/quests_airship.txt` | `kain_ticket` 0->15, quests 2079-2085 | Lv
none.

1. **Kain** - the Crewman on the domestic airship: "About the Airship..."
   twice (1, 2), then again: "What's wrong?", "I have time for a long
   story.", "I'm sorry to hear that.", "Have you tried looking for her?",
   "Einbroch" (4). ("Juno" sets 3: ask again.)
   Why: Kain Himere was a miner who lost his little daughter long ago.
   `/navi airplane 47/61` | done when: `kain_ticket >= 4`
2. **A lost box** - talk again: a box for Defru Ark at the Einbroch Hotel
   (5). Walk to the hotel door (6).
   `/navi ein_in01 227/279` | done when: `kain_ticket >= 6`
3. **Elle** - walk up to the girl: "What are you singing?" (7).
   Why: she sings a miner's song.
   `/navi ein_in01 261/241` | done when: `kain_ticket >= 7`
4. **The Cherno workshop** - Theo or Tarsha Cherno: "Your daughter asked
   me to visit you." (8); look in the Mirror (9); Tarsha again (10).
   Why: Tarsha was raised by foster parents; her real father sang the
   miner's song.
   `/navi ein_in01 125/99` (mirror `121/99`) | done when: `kain_ticket >= 10`
5. **Back to Kain** - either answer (11).
   `/navi airplane 47/61` | done when: `kain_ticket >= 11`
6. **The diary** - in Einbech, click the trees by the station until you
   find Kain's diary (1 try in 10) (12).
   `/navi einbech 45/113` (also `36/100`, `44/90`, `53/94`) | done when:
   `kain_ticket >= 12`
7. **Tarsha's scar** - Tarsha: "Check her hands." (13; the other choices
   cost 10-20% HP).
   `/navi ein_in01 125/99` | done when: `kain_ticket >= 13`
8. **Elle's letter** - walk up to Elle (14, Doodled Message).
   `/navi ein_in01 261/241` | done when: `kain_ticket >= 14`
9. **Kain's daughter** - give Kain the message (15).
   `/navi airplane 47/61` | done when: `kain_ticket >= 15`
   Reward: 4 Free Ticket for Flyship.
   Opens: the Unidentified Machine in the Cherno workshop repairs all
   broken items for free (`/navi ein_in01 117/80`, `kain_ticket > 12`).

### Captain Tarlock: How the Airship Flies
`quests/quests_airship.txt` | `lght_air` 0->7, quests 8032-8035 | Lv 60
(`BaseLevel <= 59` refuses at step 2).

1. **Captain Tarlock** - on the international airship: "How does this
   Airship fly?" (1).
   `/navi airplane_01 238/154` | done when: `lght_air >= 1`
2. **A favour** - ask again: "Yes, I really want to know!", "Sure." (2,
   his letter).
   Why: the secret is for captains only, but he will trade it for a favour.
   `/navi airplane_01 238/154` | done when: `lght_air >= 2`
3. **Captain Ferlock** - on the domestic airship: "Give him Tarlock's
   Letter." (3); bring 2 Will of Darkness and 2 Prickly Fruit (taken):
   "Here are the items I've found." (4).
   Why: monsters raiding Tarlock's ship stole the things Tarlock borrowed.
   `/navi airplane 236/163` | done when: `lght_air >= 4`
4. **The reply** - back to Tarlock three times: "I handed the letter to
   Captain Ferlock." (5), "You finished reading the letter?" (6),
   "Already finished reading?" (7).
   `/navi airplane_01 238/154` | done when: `lght_air >= 7`
   Reward: 20,000 base / 1,000 job EXP.
   Opens: the Heart Fragment Quest's step 4 (`lght_air == 7`).

### The Heart Fragment Quest
`quests/quests_airship.txt` | `lhz_heart` 0->13, quests 8036-8043 | Lv 60
(Hallen) | needs: Captain Tarlock done (step 4).

1. **Hallen** - the cabin boy on the domestic airship: "Hey kid, what are
   you doing?", "Kaci?" (1); again: "What is it?" (2, a letter).
   `/navi airplane 236/63` | done when: `lhz_heart >= 2`
   Note: while the Juno Remedy Quest waits at `hg_ma1 == 3` he only talks
   about Thierry; ask Kaci first.
2. **Kaci** - "Give her the letter from Hallen." (3); then ask all three:
   "Ask about Hallen", "Ask about Mawong", "Ask about the Airship" (4).
   `/navi airplane 33/69` | done when: `lhz_heart >= 4`
3. **Hallen's worry** - either answer (5); then "Sage Varmunt?" (6).
   Why: someone is trying to steal the Rune stones that fly the airship.
   `/navi airplane 236/63` | done when: `lhz_heart >= 6`
4. **Another power source** - with `lght_air == 7`: "Umm, yeah, kind of.",
   "Actually, there's another power source." (7); talk again (8, or 9 if
   the Murder Quest is past step 9; a Red Potion).
   `/navi airplane 236/63` | done when: `lhz_heart` 8 or 9
5. **The drunk** - at 8, Kaci: "Who's that drunk over there?" (9).
   `/navi airplane 33/69` | done when: `lhz_heart >= 9`
6. **The laboratory** - get in through the Security door; pick up the
   Password Checker (10), then at the inner door type a 3-digit password
   (digits 1-9, all different): it answers how many digits are right and
   in place; 5 tries in 3 minutes (11).
   `/navi ein_in01 264/17`, then `/navi ein_in01 261/35` | done when:
   `lhz_heart >= 11`
   Fails: after 5 wrong tries it shows the answer and makes a new one.
7. **Captain Ferlock** - "Well, there's someone I need to help...", "I
   promise...", "Wait, what's the Varmunt Project?" (12); talk again (13).
   `/navi airplane 236/163` | done when: `lhz_heart >= 13`
   Reward: 70,000 base / 40,000 job EXP.

Excluded: the Oridecon/Mineral quest (Cavitar, `ein_gear1`) and Uwe Kleine
(Large Jellopy exchange) as crafting.

## 11. Lighthalzen

### The Rekenber Job Quest
`quests/quests_lighthalzen.txt` | `lhz_rekenber` 0->23, quests 12007-12013
| Lv 70 (Kazien: `BaseLevel < 70` refuses at step 2). Kazien is the Young
Man in the Rekenber building (`lhz_in01 174/258`); Lyozien rides the
international airship (`airplane_01 96/48`); Mr. Ahman, the Scamp, stands
at the Izlude airport (`izlude 172/73`, `re/quests/quests_lighthalzen.txt`).

1. **The old man** - in Lighthalzen (1).
   Why: Kazien at the Rekenber Corporation is short of hands.
   `/navi lighthalzen 141/162` | done when: `lhz_rekenber >= 1`
2. **Kazien** - "Yes, of course." (2), then talk again (3).
   Why: his first job is a test: ask after a researcher named Garins at
   the Einbroch Laboratory.
   `/navi lhz_in01 174/258` | done when: `lhz_rekenber >= 3`
3. **The laboratory guard** - in Einbroch: "Whoa, I'm leaving!" (or
   "Actually, I do have business here.", "I'll... come back later.") (5).
   `/navi einbroch 55/52` | done when: `lhz_rekenber >= 5`
   Fails: "I need to see Mr. Garins..." tells the guard your job (4):
   Kazien fails you (6) and only 1 talk in 15 he forgets you and you can
   start over (0).
4. **The test** - tell Kazien (7): Garins never existed. Talk again (8).
   `/navi lhz_in01 174/258` | done when: `lhz_rekenber >= 8`
5. **Lyozien** - on the international airship (9): tell Mr. Ahman in
   Izlude his packages arrived. The Scamp (10); Lyozien (11); Kazien (12).
   `/navi airplane_01 96/48`, `/navi izlude 172/73`, `/navi lhz_in01
   174/258` | done when: `lhz_rekenber >= 12`
   Reward: 40,000 base EXP.
6. **The thugs** - Lyozien (13): two Thugs attack the packages; kill them
   (14). Then the Scamp (15), Lyozien (16), Kazien (17).
   `/navi airplane_01 96/48` | done when: `lhz_rekenber >= 17`
   Reward: 45,000 base EXP.
7. **What is in the packages?** - Lyozien (18), again (19): three Thugs;
   kill them, then step on the packages to peek inside: weapons and parts
   for castle guardians. Lyozien (20, a White Potion); the Scamp (21);
   Kazien (22).
   `/navi airplane_01 99/47` | done when: `lhz_rekenber >= 22`
   Reward: 55,000 base EXP.
8. **A flashback** - walk out of Kazien's office: Lyozien's voice (23).
   `/navi lhz_in01 187/247` (or `75/248`) | done when: `lhz_rekenber >= 23`
   Opens: the Alberta Boy's step 7 (`lhz_rekenber > 21`, region 5).

### The Friendship Quest
`quests/quests_lighthalzen.txt` | `friendship` 0->16, quests 12000-12006 |
Lv 50 (Digotz). Digotz lives in Uptown (`lhz_in02 201/210`), Maku in the
slums (`lighthalzen 337/232`).

1. **Maku** - talk to him (1).
   `/navi lighthalzen 337/232` | done when: `friendship >= 1`
2. **Digotz** - "Do you know someone named Maku?" (2).
   Why: they were best friends; the guards keep rich and poor apart.
   `/navi lhz_in02 201/210` | done when: `friendship >= 2`
3. **Messages** - Maku: "I actually met Digotz and..." (3); Digotz: "Yes, I
   did already..." (4): he gives you a message for Maku.
   | done when: `friendship >= 4`
4. **Digotz's message** - Maku: "Speaking of which...", then type the six
   lines one per box: `Hopeless bastard!` / `You're still a stubborn
   jerk!` / `You owe me at least 3 lunches!` / `Not to mention an
   apology!` / `But who cares what you think?!` / `I'm so goddamn happy
   without you!` (5).
   `/navi lighthalzen 337/232` | done when: `friendship >= 5`
5. **Maku's temper** - talk again (6; he hits you for 50% of your HP);
   Digotz (7).
   Why: both miss their third friend, Benkaistein.
   | done when: `friendship >= 7`
6. **Benkaistein** - in the Juno Library, the Student (8); the
   Passionate Student: "Excuse me...", "Hey...", "HEY YOU...!" (9), "Tell
   him about Maku and Digotz." (10).
   `/navi yuno_in04 107/14`, `/navi yuno_in04 96/106` | done when:
   `friendship >= 10`
7. **The diary** - the Book in the library (11, Friend's Diary); show it
   to Benkaistein (12).
   `/navi yuno_in04 168/117` | done when: `friendship >= 12`
8. **Reunion** - Digotz: "Show Benkaistein's Journal." (13); Maku (14;
   the diary is taken); Digotz (15, a Knife); Benkaistein (16).
   | done when: `friendship >= 16`
   Reward: twice (at 14 and 16) base EXP 20,000 (Lv 75 or less), 40,000
   (76-90), 70,000 (91+); a Knife; the Pass.
   Opens: the Pass lets you through the guards between Uptown and the
   slums; Bruspetti (region 13); the Alberta Boy's step 9
   (`friendship > 14`).

### The Cube Room
`quests/quests_lighthalzen.txt` | `lhz_sincube` 0->10, `lhz_secret01-03`,
MISC_QUEST bit 512, quest 12014 | Lv 60 (Fishbone: `BaseLevel >= 60`, or
the President Quest at 6).

1. **Fishbone** - the shady guard in the slums: talk four times (4).
   Why: he was a Regenschirm scientist until they laid him off.
   `/navi lighthalzen 341/224` | done when: `lhz_sincube >= 4`
2. **His price** - "Okay." (5); bring exactly 20 Jellopy: "Here you go!"
   (taken, 6); "Yes." (7): he sends you into the cube maze.
   `/navi lighthalzen 341/224` | done when: `lhz_sincube >= 7`
3. **The maze** - walk from room to room (each wall has warps) to the
   furnished room (around `lhz_cube 237/190`). to verify: the route.
4. **The red chain** - the Bundle of Files: "Rummage through the files."
   (Red Key); the Drawer: type `Red Key` (a Jackknife); the Picture: "Look
   behind picture.", type `Jackknife`: note the nine numbers (one of `4 3
   2 9 1 6 8 2 7`, `3 6 4 1 2 8 7 1 5`, `4 9 3 7 6 2 8 6 6`).
   `/navi lhz_cube 237/198`, `242/201`, `234/202` | done when:
   `lhz_secret01` 3-5
5. **The axe and the barrel** - the Chest: "Take the utility Axe." (8);
   the Barrel: type `Axe` (9), then again: type the nine numbers, one per
   box (Yellow Key); the Power Generator: type `Yellow Key`; the Status
   Light: "Smash the light bulb."; the Experiment Tube: type `Black Key`.
   `/navi lhz_cube 248/179`, `237/183`, `224/192`, `244/201`, `224/197` |
   done when: `lhz_secret01 >= 9`
6. **The sticks** - the Desk: "Under the desk"; the Bed: "Under the bed"
   twice, the second time type `Long Stick`.
   `/navi lhz_cube 234/200`, `247/198` | done when: `lhz_secret02 >= 4`
7. **The green chain** - the Goblet: "Examine the goblet."; the Chemicals:
   type `Rusty Key`; the Cabinet: type `Green Key`.
   `/navi lhz_cube 229/184`, `231/202`, `249/191` | done when:
   `lhz_secret03 >= 3`
8. **The box** - three holes: "Oval Hole" type `Oval`, "Cube Hole" type
   `Cube`, "Polygon Hole" type `Polygon`; then "Open the box." (10, the
   Laboratory Permit).
   `/navi lhz_cube 248/193` | done when: `lhz_sincube >= 10`
9. **Downstairs** - the Experiment Tube: type `Laboratory Permit`, "Go
   downstairs" (MISC_QUEST 512).
   `/navi lhz_cube 224/197` | done when: `MISC_QUEST & 512`
   Opens a place: the Sewer Pipe in the slums (`/navi lighthalzen
   313/301`) takes you to the cube room again, and from there to the Bio
   Laboratory's second floor (`lhz_dun02`). Opens: the President Quest's
   step 3.

### The Cursed Spirit Quest
`quests/quests_lighthalzen.txt` | `lhz_curse` 0->32, `lhz_spi01-04`, quests
2086-2095 | Lv none. Keep at least 1 Handcuffs (7345, dropped by the Bio
Laboratory's Seyren, Howard, Cecil, Kathryne 15%) in your bag the whole
time: the spirits only show to its holder.

1. **A spirit in the lab** - walk onto a haunted spot in the Bio
   Laboratory (1; you are cursed for a moment).
   `/navi lhz_dun01 147/106` (also `239/135`, `66/213`, `225/198`, or on
   floors 2-3) | done when: `lhz_curse >= 1`
2. **Four voices in the slums** - walk onto the four spots: you hear the
   last words of the poor.
   `/navi lighthalzen 344/278`, `/navi lhz_in03 178/22`, `/navi lighthalzen
   295/227`, `/navi lighthalzen 364/315` | done when: `lhz_spi01..04` all 1
3. **The old woman** - the Elder: "Um, burden...?", "Things?", "Yes! How do
   I get rid of them?", either answer, "Y-yes, I have." (6).
   Why: spirits of slum people follow you; something in the Rekenber
   building holds them.
   `/navi lighthalzen 346/263` | done when: `lhz_curse >= 6`
4. **The Rekenber building** - walk onto the spot by the entrance (7); the
   Representative: "Corporation History" (8); the other Representative:
   "Corporation History" twice (10); the Rekenber Guidebook (11); the spot
   upstairs (12); the spot in the hall (a vision); talk to either man in it
   (13).
   `/navi lhz_in01 113/150`, `114/181`, `27/247`, `25/251`, `272/227`,
   `206/129` | done when: `lhz_curse >= 13`
5. **The mad scientist** - "Do you need any help?" (14); "Let me speak with
   you." (15); bring 1 Glass Bead (taken): "Why do you want Glass Beads?",
   either, "What kind of research?", "Um, what are you testing on?" (16).
   `/navi lhz_in01 273/121` | done when: `lhz_curse >= 16`
6. **The pendant** - walk onto the spot (a vision): talk to the man (17, a
   Worn Out Pendant).
   `/navi lhz_in01 282/166` | done when: `lhz_curse >= 17`
7. **The rites** - the Elder: "Show him the Pendant." (18); bring 5 Holy
   Water and 1 Bunch of Flowers (taken) (19).
   `/navi lighthalzen 346/263` | done when: `lhz_curse >= 19`
8. **The crippled girl** - "Show her the Pendant.", "Break it to her
   gently", then "Distract her" or "Comfort her" (25; the pendant is
   taken). ("Brutal Truth" sends you outside (20): walk through her door
   three times (23), then give her the pendant (24).)
   `/navi lhz_in03 32/162` | done when: `lhz_curse >= 24`
9. **Peace** - walk onto the spot in front of her house (26).
   `/navi lighthalzen 319/321` | done when: `lhz_curse >= 26`
   Reward: base / job EXP 30,000 / 30,000 (below Lv 70), 40,000 / 70,000
   (70-79), 70,000 / 90,000 (80-89), 90,000 / 90,000 (90+).
10. **Secretary Slierre** - "About the Slums" (27); "About the Laboratory"
    (28); "Wolfchev's Research", "I'm a friend of his.", "W-Wait!", "About
    Wolfchev's Research", "Wolfchev's Test Subjects", "His experiments are
    suspicious...", "Show Evidence" (the Handcuffs), then any answers (30);
    talk again: "What was he doing...?" (31).
    `/navi lhz_in01 286/226` | done when: `lhz_curse >= 31`
    Reward: 1 Old Blue Box, 10 Speed Up Potion.
11. **The end** - take the warp (`/navi lhz_in01 43/114`) and walk onto the
    spot (32).
    `/navi lhz_que01 94/24` | done when: `lhz_curse >= 32`
    Opens: one of the Wandering Bard's stories (29); with the President
    Quest done, a step of the Rebellion Quest (`lhz_curse > 30`, region 12).

### The President Quest (Schwarzwald Trilogy)
`quests/quests_lighthalzen.txt` | `lhz_boss` 0->44, quests 12015-12028 |
Lv 60 (Ghalstein) | needs: the Cube Room (step 8) and the Murder Quest done
(`Shinokas_Quest == 11`, step 21). Ghalstein is the Ordinary Man in
Lighthalzen (`lighthalzen 179/170`); the President's office is in Juno
(`yuno_pre`); Esuna waits outside Lighthalzen (`lhz_fild01 66/219`).

1. **The ordinary man** - talk to him (1); walk onto the spot behind him:
   "Keep listening." (2).
   `/navi lighthalzen 179/170`, `/navi lighthalzen 173/167` | done when:
   `lhz_boss >= 2`
2. **Ghalstein** - "Uh, what were you doing just now?", "But I heard you
   talking about something..." (3); "Yes, I'm sure of it!", "I'm not
   interrogating...", "Who are you dealing with?" (4); "How can I
   cooperate?", "Sure, I'll cooperate.", "Take it." (5); talk again (6).
   Why: he is an agent of Secret Wing, fighting the Rekenber Corporation.
   `/navi lighthalzen 179/170` | done when: `lhz_boss >= 6`
   Fails: refusing ("No, thanks.", "Don't cooperate") starts the quest
   over (0) and puts you out.
3. **The lab** - do the Cube Room (it lets you in at `lhz_boss == 6`
   whatever your level); on Bio Lab floor 2, the Broken Machine:
   "Investigate it.", "This might be important." (7, Ymir's Heart Piece).
   `/navi lhz_dun02 282/278` | done when: `lhz_boss >= 7`
4. **The evidence** - bring Ghalstein the piece, 10 Research Chart (Bio Lab
   monsters, 10-25%) and 10 Handcuffs (taken) (8, a Membership Card).
   `/navi lighthalzen 179/170` | done when: `lhz_boss >= 8`
5. **Gusharr** - the Dismal Guy near Juno: "Red Tonic", "Oh, right!" (9);
   talk twice more (11).
   `/navi yuno_fild04 165/245` | done when: `lhz_boss >= 11`
6. **The president's office** - in Juno, the Secretary: "Show Secret Wing
   Card." (only 11:00-15:00 and 20:00-24:00 server time). The Guard (12);
   talk again until Eridan Keshnaar walks out (1 in 10) (13); "Who was
   that gentleman...?" (14).
   `/navi yuno_pre 69/20`, `/navi yuno_pre 95/71` | done when: `lhz_boss >= 14`
7. **Mr. President** - "I'm ready for my mission.", "Yes sir, Mr.
   President." (15); talk again (16, a File Folder); the Secretary: "I
   brought this." (17).
   `/navi yuno_pre 69/79` | done when: `lhz_boss >= 17`
8. **Benith** - in the Kafra Headquarters in Al De Baran: "Okay.", "Are you
   Benith..?", "Show Membership Card." (18).
   `/navi aldeba_in 155/240` | done when: `lhz_boss >= 18`
9. **Jargeah** - the Wounded Man in the Lighthalzen field: "Jargeah?",
   type `Secret Wing` (or `Kafra Corporation`) (19, a Sealed File Folder).
   `/navi lhz_fild02 228/214` | done when: `lhz_boss >= 19`
10. **His file** - Benith: "He's in a better place." (20); again (21, the
    file); give it to the President (22). Talk to him until he has read it
    (1 in 5) (23, or 24 if the Murder Quest is done).
    `/navi aldeba_in 155/240`, `/navi yuno_pre 69/79` | done when:
    `lhz_boss` 23 or 24
11. **Shinokas** - at 24: "Actually, Shinokas is..." (25), then talk until
    he is done (1 in 10) (26). At 23: finish the Murder Quest (region 10),
    then talk to him (26).
    `/navi yuno_pre 69/79` | done when: `lhz_boss >= 26`
12. **Esuna** - walk to her outside Lighthalzen (27).
    `/navi lhz_fild01 76/214` | done when: `lhz_boss >= 27`
13. **Agent Lestin** - in the Rekenber lab, the researcher: "Red", "Yes",
    "Show Secret Wing Card."; the second researcher (28, Archive Permit).
    `/navi lhz_in01 93/45`, then `/navi lhz_in01 285/169` | done when:
    `lhz_boss >= 28`
14. **The secret archive** - step by the archive door and wait for the
    guards to change ("Sneak in now."), "Insert Card", type `738495`,
    "Enter" (29). The File Search Engine: "Search Engine.", type
    `shinokas` (31). The shelf "Area 1-5" (35, Shinokas Case File). You
    have 3 minutes inside.
    `/navi lhz_in01 187/31`, `182/35`, `184/40` | done when: `lhz_boss >= 35`
    Fails: three wrong codes throw you out; the 3 minutes too.
15. **Out with the file** - the second researcher (36, permit taken);
    Esuna (37); the President, with the case file (38); Esuna (39, a
    Sealed File Folder); the President: "Give the file from Esuna." (40).
    | done when: `lhz_boss >= 40`
16. **The traitor** - Esuna: "What happened?", "Who could have done
    such....?" (41); the President (42), again (43): Kurelle betrayed
    Secret Wing.
    `/navi lhz_fild01 66/219`, `/navi yuno_pre 69/79` | done when:
    `lhz_boss >= 43`
17. **Ghalstein** - report (44).
    `/navi lighthalzen 179/170` | done when: `lhz_boss >= 44`
    Reward: 180,000 base EXP, 1 Old Violet Box.
    Opens: one of the Wandering Bard's stories (29); the Rebellion Quest's
    step at `lhz_boss == 44` (region 12).

Not quests: the Gangster Alert and the pickpocketing "suspicious guys"
(see the catalog).

## 12. Hugel

### The Medicine Quest
`quests/quests_hugel.txt` | `hg_herb` 0->13, quests 8053-8056 | Lv 50
(Allen: `BaseLevel > 49`).

1. **Allen Schuwell** - the sick old man: "Sure." (1).
   Why: his son Postell went out east and has his medicine, "Kolbun A".
   `/navi hu_in01 387/245` | done when: `hg_herb >= 1`
2. **Postell** - outside town: "But your father needs you!" (2).
   `/navi hu_fild06 34/123` | done when: `hg_herb >= 2`
3. **A White Potion** - Allen has an attack: "Give White Potion" (taken)
   (3); talk again (4).
   `/navi hu_in01 387/245` | done when: `hg_herb >= 4`
4. **The medicine drawer** - step away from Allen and walk into him again
   (5): the drawer next to him opens a moment later. Click the drawer
   between 1 and 4.5 seconds after (6). Talk to Allen (7) and do it once
   more (8, then 9).
   `/navi hu_in01 370/255` | done when: `hg_herb >= 9`
   Fails: clicking too early or too late shuts the drawer (back to 4 or 7):
   walk into Allen again.
5. **Postell comes home** - Allen: 1 talk in 3 the medicine works (10;
   otherwise back to 7, repeat step 4). Talk again: Postell comes in (11);
   again (12).
   `/navi hu_in01 387/245` | done when: `hg_herb >= 12`
6. **Help yourself** - open the medicine drawer (13).
   `/navi hu_in01 370/255` | done when: `hg_herb >= 13`
   Reward: 5,000 base EXP, 1 Old Blue Box.
   Opens: Biological Weapon.

### Biological Weapon
`quests/quests_hugel.txt` | `hg_bio` 0->9, quests 11009-11016 | Lv none |
needs: the Medicine Quest (`hg_herb == 13`).

1. **Morriphen** - the coughing man in Einbroch: "Help him" (1).
   Why: he needs his medicine from his wife in Hugel.
   `/navi ein_in01 16/36` | done when: `hg_bio >= 1`
2. **Siria** - his wife in Hugel (2): she is out of medicine too.
   `/navi hu_in01 326/307` | done when: `hg_bio >= 2`
3. **Dono** - Morriphen's old colleague in Lighthalzen (3); bring him 3
   Detrimindexta, 5 Coal, 1 Unripe Apple, 1 each of Red, Yellow, White,
   Green and Blue Herb, 5 Cyfar, 5 Brigan, 20 Shell (taken) (4).
   `/navi lighthalzen 88/79` | done when: `hg_bio >= 4`
   Note: Detrimindexta drops from Deviace 1% and Toad 0.5%, and Dye the
   Alchemist in the Eden Market Group sells it (20,000 zeny, every day but
   Wednesday). Coal: see the Lovers Quest (region 10).
4. **Makkie** - Dono sends you to Makkie (5); back to Dono (6, the
   medicine).
   `/navi lhz_in03 193/28`, `/navi lighthalzen 88/79` | done when:
   `hg_bio >= 6`
5. **Two patients** - Morriphen (7): the medicine must go to Siria; Siria
   (8).
   `/navi ein_in01 16/36`, `/navi hu_in01 326/307` | done when: `hg_bio >= 8`
   Reward: 30,000 base EXP.
6. **Friends again** - Morriphen (9).
   Why: he left Rekenber for Siria; Dono kept their secret all along.
   `/navi ein_in01 16/36` | done when: `hg_bio >= 9`
   Reward: 70,000 base EXP.
   Opens: one of the Wandering Bard's stories (29).

### The Rebellion Quest
`quests/quests_hugel.txt` | `hg_tre` 0->57 | Lv none | needs: the President
Quest done (`lhz_boss == 44`) and the Cursed Spirit past step 10
(`lhz_curse > 30`) and the Odin Temple Excavation done (`hg_odin == 60`),
all at step 3.

1. **Shede** - in Hugel: "Do you want me to help you?" (a random job: 10
   mushrooms, 20 clams or 30 bugs).
   `/navi hugel 70/137` | done when: `hg_tre` 10, 20 or 30
2. **The job** - gather 5: "Gather them." / "Catch them." at the spots
   (4 tries in 5 succeed; a used spot rests a while), then Shede (40).
   Mushrooms: `/navi hu_fild06 168/359`, `194/341`, `198/339`; clams:
   `/navi hugel 209/163`, `203/166`, `217/158`, `204/150`; bugs: `/navi
   hu_fild06 155/309`, `218/320`, `249/329`, `218/373` | done when:
   `hg_tre >= 40`
3. **Herico** - with the President and Cursed Spirit quests done, Shede
   (41). Herico, in his room: "Yes, you are right." (42); talk (43); with
   the Odin dig done (44); talk (45).
   Why: Herico survived the old mercenary rebellion against Rekenber.
   `/navi hu_in01 256/40` | done when: `hg_tre >= 45`
4. **The reporter** - Enquro Carson in Lighthalzen: "Mercenary Rebellion"
   (46); bring a Tropical Sograt and a Vermilion on the Beach (taken, 47).
   `/navi lhz_in03 39/44` | done when: `hg_tre >= 47`
   Note: the bartender in the closed pub of Morocc sells both, 1,000 zeny
   each (`/navi morocc_in 166/76`, `quests/skills/bard_skills.txt`; to
   verify: how to get into the pub).
5. **The survivor's daughter** - the Girl (48); her Book: "Read the small
   book.", "Page 9" (49).
   `/navi hu_in01 310/380`, `/navi hu_in01 317/312` | done when: `hg_tre >= 49`
6. **Regenschirm** - Herico: either answer (50); "Yes, I will." (51); talk
   (52). In the Rekenber building, the Pile of Paper (53, a File Folder; two
   Guards attack). Give it to Herico (54).
   `/navi lhz_in01 214/129` | done when: `hg_tre >= 54`
7. **The machine** - buy a Marine Sphere Bottle from the Bomb Maker in
   Einbech (3,000 zeny); on Bio Lab floor 2 use it on the Unethical Machine
   (55; the blast costs 10% HP).
   `/navi einbech 208/124`, `/navi lhz_dun02 244/226` | done when: `hg_tre >= 55`
8. **Who can stop them?** - Herico: type `President Karl` (56, a File
   Folder).
   `/navi hu_in01 256/40` | done when: `hg_tre >= 56`
9. **The President** - in Juno (57).
   `/navi yuno_pre 69/79` | done when: `hg_tre >= 57`
   Reward: 200,000 base EXP, 1 Old Violet Box.
   Herico then trades 100 Handcuffs for one random dish, as often as you
   like (an exchange).

### The Memory Quest
`quests/quests_hugel.txt` | `hg_memory` 0->12, quests 8057-8063 | Lv 50
(the tree: `BaseLevel > 49`).

1. **The old tree** - walk to the big tree in Hugel (1).
   `/navi hugel 198/169` | done when: `hg_memory >= 1`
2. **Manainne** - the old woman by the tree (2).
   Why: her sister Kanainne loved El Schatt, who now only thinks of money.
   `/navi hugel 191/172` | done when: `hg_memory >= 2`
3. **El Schatt and Perfitz** - El Schatt (3); Perfitz (4); El Schatt (5);
   Manainne (6).
   `/navi hugel 196/164`, `/navi hugel 100/103`, `/navi hugel 191/172` |
   done when: `hg_memory >= 6`
4. **A spirit in Niflheim** - find the spirit in Niflheim (7; it sends you
   back to Hugel).
   `/navi niflheim 90/106` | done when: `hg_memory >= 7`
5. **The last words** - Manainne three times (10), then once more (11); El
   Schatt (12).
   `/navi hugel 191/172`, `/navi hugel 196/164` | done when: `hg_memory >= 12`
   Reward: 8,000 base EXP, 1 Old Blue Box.

### Hide and Seek
`quests/quests_hugel.txt` | `hg_ubu01` 0->9, quests 12044-12048 | Lv 50
(Torpy).

1. **Torpy** - "What's wrong?", "Really? Tell me more..." (1).
   Why: his mother has hidden and he cannot find her.
   `/navi hugel 107/67` | done when: `hg_ubu01 >= 1`
2. **His mother** - Torpy's Mom in the field (2); Torpy (3).
   `/navi hu_fild06 190/367`, `/navi hugel 107/67` | done when: `hg_ubu01 >= 3`
3. **The barrel** - the Suspicious Barrel: "I'll bring you Steamed Crab
   Nippers" (4); bring 1 (taken, 5).
   `/navi hugel 100/176` | done when: `hg_ubu01 >= 5`
   Note: Steamed Crab Nippers are a cooked dish (the Cooking Quest
   teaches the recipe and gives one, `quests/cooking_quest.txt`).
4. **The strange man** - next to the barrel (6); Torpy (7); his mother (8);
   Torpy (9).
   `/navi hugel 100/174` | done when: `hg_ubu01 >= 9`
   Reward: 5,000 base EXP, 3 Green Salad (from his mother).

### The Fish Cake Soup Delivery
`quests/quests_hugel.txt` | `hg_odeng` 0->10, then 0, quests 8064-8075 | Lv
none | repeatable.

1. **Cellette** - "Sure, I'll work for you!" (a Fish Cake Soup, and a
   random customer: 1 Neha, 2 Maewan, 3 Layoma, 4 Erjan).
   `/navi hu_in01 15/372` | done when: `hg_odeng` 1-4
2. **The delivery** - bring the customer the soup (it stays with you): he
   asks for one item: Neha a Whip, Maewan a Bookclip in Memory, Layoma a
   Mushroom Spore, Erjan a China. Bring it with the soup (both taken, 10).
   `/navi hugel 76/134` (Neha), `87/139` (Maewan), `84/125` (Layoma),
   `102/161` (Erjan) | done when: `hg_odeng >= 10`
   Fails: lost the soup? Cellette sells another for 100 zeny; with less
   than 100 zeny she calls you irresponsible (5) and never deals with you
   again.
3. **Paid** - Cellette (back to 0).
   `/navi hu_in01 15/372` | done when: `hg_odeng == 0` after 10
   Reward: 3 Fish Cake Soup, 100 base EXP.

### Cow Milking
`quests/quests_hugel.txt` | `hg_milk` 0->13, quests 12040-12043 | Lv 50
(Kurupe) | repeatable after step 5.

1. **Kurupe** - walk up to the farmer (1); talk: "Sure." (2).
   Why: his helper Burupu has not come to work and the milk is due
   tomorrow.
   `/navi hugel 56/104` | done when: `hg_milk >= 2`
2. **Burupu** - in the field (3, 4): "Alright." (5); bring him a Rapier
   (taken, 6).
   `/navi hu_fild06 217/270` | done when: `hg_milk >= 6`
3. **Permission** - Kurupe (7). Read Burupu's notebook by the cow.
   `/navi hugel 56/104`, `/navi hugel 72/101` | done when: `hg_milk >= 7`
4. **Booboo** - with 3 Concentration Potion (taken): "Attempt to Milk
   Booboo". Listen to her sound and type the brush strokes: joy 3, so-so 5,
   sad 10, angry 0, love 1. Then she sings the notebook's song with one
   word changed: type the notebook's word (one of `Brrbrr`, `Brrrrrr`,
   `Rrrrboo`, `Boobooru`, `Boobooboo`, `B`) (8).
   `/navi hugel 68/99` | done when: `hg_milk >= 8`
   Fails: a wrong count or word costs the 3 potions; try again.
5. **The milk** - Kurupe (9).
   `/navi hugel 56/104` | done when: `hg_milk >= 9`
   Reward: 10,000 base EXP, 3 Fruit Mix.
   Again: Kurupe "Sure, I'll milk Booboo." (10), Burupu (11), Kurupe (12),
   Booboo as in step 4 (13), Kurupe: a random reward (5 Milk, 5 Orange
   Potion, 5 Yellow Potion, 3 Honey or a Bundle of Food) and back to 9.

### The Odin Temple Excavation
`quests/quests_hugel.txt` | `hg_odin` 0->60, quests 11000-11008 | Lv 60 |
guided `hg_odin` (steps from guide.ps1).

1. **The notice** - read the Sign in Hugel (1).
   `/navi hugel 91/152` | done when: `hg_odin >= 1`
2. **A team** - Alex: "I saw the recruitment notice and..." or Laura: "Yes,
   I'll do it!" (2).
   `/navi hu_in01 19/161` (Alex), `/navi hu_in01 14/11` (Laura) | done when:
   `hg_odin >= 2`
3. **Runes from the temple** - the Boatman: "Sure!" to sail to the temple;
   sail back (`odin_tem01 93/146`) and talk to your leader, twice. Alex:
   "Yes, I do.", then "There you go!" with 5 Rune of Darkness (Skogul,
   Frus); Laura: any answers, "Yes!", then "Right here!". Then Laura (17).
   `/navi hugel 209/109` | done when: `hg_odin >= 17`
4. **Ymir's Heart** - walk through the door to Alex's room (`hu_in01
   15/108`), then Laura: "Ymir's Heart" (20).
   `/navi hu_in01 14/11` | done when: `hg_odin >= 20`
5. **The hidden way** - on the temple's top floor one of five spots pulls
   you into the sealed hall (it moves after use): `odin_tem03 266/302`,
   `288/271`, `283/241`, `179/275`, `320/264`. Inside, the object: "Explore"
   (1 try in 3), "Pick it up"; then the way back (23).
   `/navi que_hugel 35/29`, `163/178` | done when: `hg_odin >= 23`
6. **The dig house** - walk into it (`/navi hugel 52/90`): Laura (25), Ashe
   (59).
   `/navi hu_in01 159/84`, `162/85` | done when: `hg_odin >= 59`
7. **Ashe in the desert** - walk to the spot, either question (60).
   `/navi moc_fild12 160/365` | done when: `hg_odin >= 60`
   Reward (guide): an Old Blue Box for the runes, 100,000 base EXP at the
   end.
   Opens: one of the Wandering Bard's stories (29); the Rebellion Quest's
   step 3.

### The Thanatos Tower
`quests/thana_quest.txt` | `thana_tower` 0->10, quests 7048-7053 | Lv none;
the 7th floor takes only 2nd classes or higher (or Super Novice, Taekwon,
Star Gladiator, Soul Linker, Ninja, Gunslinger, Summoner at Lv 95+, line
2295).

1. **The tower keeper** - "Enter the tower", "Enter": 5,000 zeny (3,000
   once you work there).
   `/navi hu_fild01 140/163` | done when: inside the tower
2. **A work contract** - the Guide on floor 1: "Temporary Work Contract",
   "Sure, I'd like to work for you.", "Yes", "Sign" (1).
   `/navi tha_t01 149/78` | done when: `thana_tower >= 1`
3. **The entrance guide** - floor 2: "Start a conversation.", "About the
   development.", "Just tell me about it.", "What accident are you
   referring to?", "Ok! I will." (4).
   `/navi tha_t02 231/161` | done when: `thana_tower >= 4`
4. **The red key** - floor 3, the Rune Device: "Investigate it." with a
   level 4 weapon in hand (a Taekwon kicks); "Concentrate on it." (5).
   `/navi tha_t03 67/70` | done when: `thana_tower >= 5`
5. **The yellow key** - floor 4, the Rune Device: a 3-digit code (digits
   1-9, all different); it tells you how many digits are right and in
   place. Then "Concentrate on it." (6).
   `/navi tha_t04 195/195` | done when: `thana_tower >= 6`
6. **The blue key** - floor 5, the Brilliant Statue: "Stick the key into
   the crack...", type `Red Key`, then `Yellow Key`; "Concentrate on it."
   (7).
   `/navi tha_t05 62/179` | done when: `thana_tower >= 7`
7. **The green key** - floor 6, the Brilliant Statue: "Investigate.",
   "Investigate the Wheels", then set all five the same way: "1st Small
   Wheel" "Lower Wheel", "2nd Small Wheel" "Press Wheel", "1st Big Wheel"
   "Raise Wheel", "2nd Big Wheel" "Vertically Shift Wheel", "3rd Big Wheel"
   "Lower Wheel"; "Concentrate on it." (8).
   `/navi tha_t06 226/230` | done when: `thana_tower >= 8`
8. **The black key** - the Splendid Sword: "Observe it.", "Towards the
   hilt of the sword", "Insert the sword into the hole" (9, Barmund's
   note). The other choices cost 20% HP.
   `/navi tha_t06 204/181` | done when: `thana_tower >= 9`
9. **Varmunt's journal** - the Entrance Guide: "Start a conversation.", "I
   found Varmunt's Journal..." (10).
   `/navi tha_t02 231/161` | done when: `thana_tower >= 10`
   Reward: 120,000 base / 10,000 job EXP, 1 Old Violet Box.
   Opens a place: the upper tower: with the Black Key, the warp to the 7th
   floor (`/navi tha_t06 119/120`); on floor 8 the Shining Crystals turn
   each key into a Charm Stone, and on floor 12 the four statues take them
   to open Thanatos' memory (the MVP).

## 13. Arunafeltz: Rachel, Veins and Nameless Island

### The Lost Child (The Stolen Gem)
`quests/quests_rachel.txt` | `lost_boy` 0->13, quests 8089-8098 | Lv 60 |
guided `ra_lostchild` (steps from guide.ps1).

1. **Vincent** - the steward of High Priest Zhed's mansion: "Sure, why
   not?" (1).
   Why: a gem the Pope gave Zhed was stolen, and the servant Phobe ran off
   the same night.
   `/navi ra_in01 384/246` | done when: `lost_boy >= 1`
2. **Phobe's trail** - Logan (2), Manson (3), Jenny (4), an idle merchant
   (5), another idle merchant (6); each sends you to the next.
   `/navi rachel 114/232`, `ra_in01 372/200`, `rachel 48/237`, `rachel
   138/73`, `rachel 120/47` | done when: `lost_boy >= 6`
3. **The suspicious man** - south of Rachel (7). He hits you for half your
   HP before he talks: come with full HP.
   `/navi ra_fild01 245/325` | done when: `lost_boy >= 7`
4. **The truth** - Vincent (8), the Kid (9), Vincent (10), Jenny (11),
   Vincent (12).
   `/navi ra_in01 384/246`, `rachel 263/32`, `rachel 48/237` | done when:
   `lost_boy >= 12`
5. **The High Priest** - Zhed in the inner temple: "I'm here on Vincent's
   behalf", "Actually... I was just curious.", "Tell him your name." (13).
   `/navi ra_temin 277/159` | done when: `lost_boy >= 13`
   Reward (guide): an Old Violet Box from Vincent, 90,000 base EXP from
   Zhed.

### The Sanctuary Quest
`quests/quests_rachel.txt` | `ra_tem_q` 0->23, then MISC_QUEST bit 8192 | Lv
none | **needs a mod**: the temple only opens after 10,000 donations from
the whole server (`$rachel_donate`); solo-community-goals opens it (setting
"Donations to open Rachel's Sanctuary"). Guided `ra_sanctuary` (steps from
guide.ps1). Without the mod: dead end at step 1, see guide-deferred.md.

1. **Priestess Nemma** - in the temple (1).
   Why: a gate is locked from the inside.
   `/navi ra_temple 116/174` | done when: `ra_tem_q >= 1`
2. **The candy kid** - "Yeah." or "Sure, I love the stuff~", and give him a
   Candy if he asks ("Sure.") (2).
   `/navi rachel 243/37` | done when: `ra_tem_q >= 2`
3. **Through the window** - at the temple's side, "Enter Through Window";
   walk onto each spot in turn, investigate the Bloody Spot twice, then
   "Push Gate" (10).
   `/navi ra_temple 67/209`, then `que_rachel 60/80`, `59/112`, `94/139`,
   `132/70`, `28/315` (twice), `170/37`, `169/18` | done when: `ra_tem_q >= 10`
4. **Panno** - "Hey, did you open the gate?", "The locked gate to the
   temple!", "Explain."; talk again (12).
   `/navi ra_temin 170/46` | done when: `ra_tem_q >= 12`
5. **Firecrackers** - Nemma twice; the second time "Yes." with 20
   Firecrackers (Party Supplies Shop in Hugel, `hu_in01 23/311`, 5 for 500
   zeny) (14).
   `/navi ra_temple 116/174` | done when: `ra_tem_q >= 14`
6. **High Priest Zhed** - "Yes, sure." (15).
   `/navi ra_temin 277/159` | done when: `ra_tem_q >= 15`
7. **Glacial Hearts** - the Pope's Office Guard lets you pass for 40
   Glacial Hearts (Ice Titan, Snowier, Gazeti in the Ice Cave) (16).
   `/navi ra_temin 134/128` | done when: `ra_tem_q >= 16`
8. **The Pope** - past the guard (`ra_temin 134/131`), up through `275/226`:
   "No, not at all...!", type anything twice, "R-really...?", "Holy
   Ground?" (17).
   `/navi ra_temsky 99/99` | done when: `ra_tem_q >= 17`
9. **The small key** - tell Zhed (18), listen at the hidden spot (19), Zhed:
   "Ask about Bekento" (20), the key: "Pick It Up" (21).
   `/navi ra_temin 277/159`, `288/151`, `272/143` | done when: `ra_tem_q >= 21`
10. **Into the Sanctuary** - the gate: "Use Small Key"; walk to the way on
    (`ra_san01 139/13`), north to the far end (`que_san04 119/203`); in
    Rachel walk onto the spot (`rachel 163/152`) (23).
    `/navi ra_temin 28/319` | done when: `ra_tem_q >= 23`
11. **Zhed's answer** - "Did something happen?" (MISC_QUEST 8192).
    `/navi ra_temin 277/159` | done when: `MISC_QUEST & 8192`
    Reward (guide): EXP along the way, 90,000 base / 60,000 job at the end.
    Opens a place: the Rachel Sanctuary. Opens: the Siblings Quest.

### The Siblings Quest
`quests/quests_veins.txt` | `rachel_camel` 0->25, quests 3060-3083 | Lv none
| needs: the Sanctuary Quest (MISC_QUEST 8192; the Kid in Veins,
`veins 327/185`, only talks after it). Dead end without the Sanctuary, see
guide-deferred.md (Veins Siblings). Steps: with the Sanctuary's batch.
Opens: the Nameless Island's step 12 and the Thor Volcano Base.

### The Nameless Island
`quests/quests_nameless.txt` (with `quests_prontera.txt`, `quests_rachel.txt`,
`quests_veins.txt`) | `aru_monas` 0->26 | Lv none | needs: the Geoborg
Family Curse at an ending (`prt_curse` 36, 45, 56 or 61). Dead end at step
12: High Priest Zhed goes on only with the Sanctuary (MISC_QUEST 8192) and
the Siblings Quest done (`rachel_camel == 25`), see guide-deferred.md.

1. **The agent on the airship** - on the international airship, walk to
   the spot by the agent (1).
   Why: Priest Bamph is waiting for you at the Prontera church.
   `/navi airplane_01 90/63` | done when: `aru_monas >= 1`
2. **Priest Bamph** - (2).
   `/navi prt_church 185/106` | done when: `aru_monas >= 2`
3. **Comodo** - the Ordinary Man: "Excuse me.", "Priest Bamph sent me."
   (3; he takes you to a back room); the other man: "Why to the west?" (4).
   Why: someone close to Bamph was kidnapped, maybe by people from
   Arunafeltz.
   `/navi cmd_in02 174/89`, then `/navi cmd_in02 111/52` | done when:
   `aru_monas >= 4`
4. **Bamph again** - "Tell him what Larjes said." (5); talk again: "Of
   course, I'll help." (6).
   `/navi prt_church 185/106` | done when: `aru_monas >= 6`
5. **The Rachel restaurant** - the Waiter: "Yes, I've come for another
   reason.", "Yes." (7, a seat); listen to the men at the next table:
   "...Yes, that sounds good." (8).
   `/navi ra_in01 308/59`, then `/navi ra_in01 301/43` | done when:
   `aru_monas >= 8`
   Note: with more than 3,000 zeny you pay 3,000 for the meal and get 4
   Assorted Seafood.
6. **The Veins magistrate** - "Are you in trouble?" (9); the Soldier: "Who
   are the smugglers?" (10); the Magistrate: "I want to know about the
   smugglers." (11).
   `/navi ve_in 78/314`, `/navi ve_in 81/296` | done when: `aru_monas >= 11`
7. **High Priest Zhed** - "Ask About Veins Incident" (12). Only with the
   Sanctuary and the Siblings Quest done: dead end, see guide-deferred.md.
   `/navi ra_temin 277/159`

### The Thor Volcano Base
`quests/quests_veins.txt` (starts in `quests/quests_rachel.txt`) | `aru_vol`
0->27, quests 2114-60212 | Lv none | needs: the Sanctuary (MISC_QUEST 8192)
and the Siblings Quest done (`rachel_camel == 25`): High Priest Zhed
(`ra_temin 277/159`) offers it then (when `aru_monas` is 11 he does the
Nameless Island step first). Dead end without the Sanctuary, see
guide-deferred.md. Opens: Peace to Arunafeltz.

### Peace to Arunafeltz and Rachel Addition
`quests/quests_nameless.txt` | `aru_em` 0->23 | Lv none | needs: the Thor
Volcano Base (`aru_vol == 27`). Dead end without the Sanctuary, like the
Thor Volcano Base, see guide-deferred.md.

### Bruspetti
`quests/quests_rachel.txt` | `rach_vice` 0->24, quests 8106-8122 | Lv none |
needs: the Friendship Quest past step 10 (`friendship > 10`, region 11);
keep its Knife for step 9.

1. **Katinshuell** - the man who wants to be left alone (1).
   `/navi ra_in01 235/194` | done when: `rach_vice >= 1`
2. **Mr. Shendar** - (2); Lachellen (3); Katinshuell (4); Mr. Shendar (5).
   Why: Katinshuell is Benkaistein's lost friend from Lighthalzen.
   `/navi ra_in01 250/19`, `/navi rachel 73/244` | done when: `rach_vice >= 5`
3. **A memory in Lighthalzen** - walk into Digotz's room in Uptown (6);
   Lachellen (7); walk onto the spot in south-east Rachel (8); Mr. Shendar
   (9); the Book in his house (10).
   `/navi lhz_in02 213/207`, `/navi rachel 265/47`, `/navi ra_in01 255/25`
   | done when: `rach_vice >= 10`
4. **Names** - Katinshuell: type `Bruspetti` (or `Lighthalzen`, `Freya's
   Spring`) (11); Lachellen: type `Freya's Spring` (12); the Grandma (13);
   Mr. Shendar (14; he hits you for 50% HP).
   `/navi ra_in01 235/194`, `/navi rachel 73/244`, `/navi rachel 266/35`,
   `/navi ra_in01 250/19` | done when: `rach_vice >= 14`
5. **The blue diary** - the Book (15, Diary of Blue); give it to
   Katinshuell (16).
   `/navi ra_in01 255/25` | done when: `rach_vice >= 16`
6. **His story** - Katinshuell: "Lighthalzen", "Recent Break-up", "Freya's
   Spring" (17); talk three times more (20).
   `/navi ra_in01 235/194` | done when: `rach_vice >= 20`
7. **The knife** - with a Knife: talk (21), again (22; the Knife is taken).
   `/navi ra_in01 235/194` | done when: `rach_vice >= 22`
8. **Goodbye** - walk onto the spot in south-east Rachel (23), again (24).
   `/navi rachel 265/47` | done when: `rach_vice >= 24`
   Reward: base EXP 45,000 (Lv 75 or less), 85,000 (76-90), 130,000 (91+).

### The Ice Necklace
`quests/quests_rachel.txt` | `ice_necklace_q` 0->7, quests 2109-2113 | Lv
none.

1. **Urstia** - the sincere follower: "Freya? I'd like to know more.",
   "Alright, I'll do it." (1, Ashy Necklace).
   Why: Freya's power should free a man stuck in the Ice Cave.
   `/navi rachel 157/183` | done when: `ice_necklace_q >= 1`
2. **The man in the ice** - walk up to him (2).
   `/navi ice_dun02 120/105` | done when: `ice_necklace_q >= 2`
3. **Hamion** - (3); bring 5 Rough Wind, 1 Hammer, 1 Blank Scroll (taken):
   "Don't worry, I checked." (4, Wind Hammer).
   `/navi rachel 265/98` | done when: `ice_necklace_q >= 4`
4. **Breaking the ice** - the man in the ice, with the Wind Hammer and the
   necklace: four Snowiers attack; kill them (5: Sparkling Necklace, 4
   Freezing Snow Powder).
   `/navi ice_dun02 120/105` | done when: `ice_necklace_q >= 5`
5. **Back to Urstia** - give her the necklace (6).
   `/navi rachel 157/183` | done when: `ice_necklace_q >= 6`
   Reward: 90,000 base EXP.
6. **Mohadian** - walk up to him: "Sure." (7): from then on he buys
   Glacial Hearts for zeny.
   `/navi rachel 113/97` | done when: `ice_necklace_q >= 7`
   Opens: the Freezing Snow Powder puts out the four Blazing Fires on Ice
   Cave floor 3 (`ice_dun03 126/126`, `172/126`, `172/172`, `127/172`),
   which wakes Ktullanux.

### The Stone Quest
`quests/quests_veins.txt` (the old man's place on Renewal in
`re/quests/quests_veins.txt`) | `veins_stone` 0->8 | Lv none.

1. **The wincing old man** - "Gosh, how bad is it?", "Can I help?", "I will
   help you.", "What do you want me to do?", then "Nothing." (1).
   Why: his back is broken and his stone job is unfinished.
   `/navi ve_fild02 337/314` | done when: `veins_stone >= 1`
2. **Zabaroo** - the Strange Old Man in Veins: "........", "Oh, I-I'm...",
   "I'm here for Mr. Zabaroo...", "What materials...?" (2). ("Excuse me..."
   costs 30% HP and throws you out.)
   `/navi ve_in 169/310` | done when: `veins_stone >= 2`
3. **Materials** - bring 5 Steel, 5 Root of Maneater, 2 Glacial Heart
   (taken, 3); talk again (4).
   `/navi ve_in 169/310` | done when: `veins_stone >= 4`
4. **The message** - the old man: "Yes, here...", "This message...", "Huh?
   What is it?" (5).
   `/navi ve_fild02 337/314` | done when: `veins_stone >= 5`
5. **The factory** - the Factory Manager: "I've brought these...", "I'm
   here on his behalf." (6); the Factory Worker: "He still hurts.", "I have
   a question...", "What's this Hetarium??", "How do they use Hetarium??"
   (7).
   `/navi ve_in02 37/28`, `/navi ve_in02 54/49` | done when: `veins_stone >= 7`
6. **Done** - the old man (8).
   `/navi ve_fild02 337/314` | done when: `veins_stone >= 8`
   Reward: 30,000 base EXP, 3 Elunium.

## 14. Amatsu

### The Amatsu Dungeon Quest
`quests/quests_amatsu.txt` | `event_amatsu` 0->6, quests 8131-8135 | Lv
none | side 6 (RO part only). The castle door is `/navi amatsu 85/235`;
inside, the stairs go up at `ama_in02 195/44`, `56/44`, `59/160` to the
lord's floor, and one more at `222/161` to Jyuro's floor.

1. **The Gate Soldiers** - the soldiers guarding a house in Amatsu (either
   one) (1).
   Why: the lord's mother lies sick in that house and no doctor can help.
   `/navi amatsu 164/174` (or `171/174`) | done when: `event_amatsu >= 1`
2. **Lord Ishida** - at the top of the castle: "I heard about your
   mother..." (2).
   Why: the lord begs you to cure his mother.
   `/navi ama_in02 200/176` | done when: `event_amatsu >= 2`
3. **Kouji's song** - the boy singing in the streets (3); talk again for
   the quest log (8133).
   Why: his song tells of a fox that follows someone, and a priest at the
   north shrine.
   `/navi amatsu 189/166` | done when: `event_amatsu >= 3`
4. **The north shrine** - leave by the north-east road (`amatsu 248/292`);
   the shrine door is at `ama_fild01 174/331`. Inside, the boy in the
   Kitsune Mask: "Taaaaah!!" (4).
   Why: he teaches you to shout a fox out of a body.
   `/navi ama_in01 180/173` | done when: `event_amatsu >= 4`
5. **The possessed mother** - into the guarded house (door `amatsu
   168/182`), talk to the Grandma: "Taaaah!!" (5, Nine Tails).
   `/navi ama_in01 22/111` | done when: `event_amatsu >= 5`
   Fails: it works 1 time in 4; carrying 1 Holy Water, Bear's Footskin or
   Tiger Skin (not taken) makes it 1 in 2 (Acolytes and Monks 1 in 2 too,
   Priests 3 in 4). A failure throws you out to `amatsu 167/197`: walk in
   and try again.
6. **Proof** - bring the Nine Tails (taken) to Lord Ishida (6).
   `/navi ama_in02 200/176` | done when: `event_amatsu >= 6`
   Reward: Feudal Lord Permit.
   Opens: the Amatsu Dungeon. Jyuro, the soldier one floor up
   (`/navi ama_in02 115/177`): "Open the gate", "I will go in" (the permit
   is kept) warps you to `ama_dun01 229/10`; the Soldier there
   (`ama_dun01 229/7`, "Yes, I do") takes you back. A lost permit: the
   Soldier at `ama_in02 170/62`, "Issue me a Transit Permit", 10,000 zeny.
   Warning: showing a permit to Jyuro before step 6 loses it.

### The Momotaro Event
`quests/quests_amatsu.txt` | `event_momo` 0->4, quests 8127-8130 | Lv 30
(Publisher: `BaseLevel > 29`). One run only. The field trip is a small
map (`ama_test`) for one player at a time, 6 minutes.

1. **The Publisher** - "What is Momotaro Story?" first, then "I want to
   try!" (warps you to `ama_test 52/35`). Keep your weight low (she
   refuses an overweight bag) and put a pet back into its egg.
   Why: her company celebrates a million copies of the Momotaro tale.
   `/navi amatsu 223/236` | done when: on `ama_test`
2. **The waiting room** - the Assistant Satoshi: "Yes" (you heard the
   story; "No" sends you back to Amatsu), then join his waiting room
   "Waiting Exhibit.": it starts with you alone. Walk up to the old couple
   (1).
   `/navi ama_test 52/44` | done when: `event_momo >= 1`
3. **The Dokebis** - kill the 9 Dokebi (Lv 68) around the couple within
   the 6 minutes (2).
   Why: Dokebis robbed the old couple, like in the tale.
   `/navi ama_test 50/93` | done when: `event_momo >= 2`
   Fails: time out warps you back to Amatsu (still 1): the Assistant asks
   again, "Yes" to try again, "No, I want to go back" resets to 0.
4. **The Coach** - he appears in the middle: "Well, well. It is nothing~"
   ends here (2). For the harder fight: "It was boring.", "Bring it on,
   foo'!" (70% HP back), kill 3 Am Mut (Lv 141) before the 6 minutes run
   out (3).
   `/navi ama_test 50/100` | done when: `event_momo` 2 or 3
5. **The reward** - back to the Publisher (4).
   `/navi amatsu 223/236` | done when: `event_momo >= 4`
   Reward: one random pet food or toy: after the Am Mut fight one of Her
   Heart, Sweet Potato, Tropical Banana, Armlet of Obedience, No
   Recipient, Well-Dried Bone, Old Broom, Orc Trophy, Monster Juice,
   Contract in Shadow; otherwise one of Rainbow Carrot, Sweet Milk,
   Singing Flower, Fatty Chubby Earthworm, Earthworm the Dude, Unripe
   Apple, Bitter Herb, Orange Juice, Rusty Iron, Rotten Fish.

Excluded: the Sushi Quest (exchange).

## 15. Kunlun

The chief's hall: door `/navi gonryun 109/131`, then the inner door
`gon_in 42/35`. The tavern: door `/navi gonryun 215/114`. The Kunlun
Dungeon: `/navi gonryun 159/201`.

### The Broken Sword
`quests/quests_gonryun.txt` | `b_sword` 0->33 (fails: 11, 12, 13, 15) | Lv
51 (Chief: `BaseLevel > 50`) | needs: the Lost Knife done (step 7) | side
7 (RO part only). A wrong answer at steps 3, 5 or 6 closes the quest for
this character.

1. **The chief** - Shi Yan Wen only greets you (1).
   `/navi gon_in 17/93` | done when: `b_sword >= 1`
2. **The hostess** - Mei Yen Fang in the tavern (2).
   Why: she tells you the chief's house was robbed last night.
   `/navi gon_in 152/35` | done when: `b_sword >= 2`
3. **Offer your help** - the chief: "I heard that something was
   stolen...", "What was stolen?", "Can I find it for you?" (3).
   Why: his family sword, an heirloom of many generations, is gone.
   `/navi gon_in 17/93` | done when: `b_sword >= 3`
   Fails: "Hope you find it soon." sets 11: the quest is closed.
4. **The hostess again** - she points you to the drinker (4).
   `/navi gon_in 152/35` | done when: `b_sword >= 4`
5. **The drinker** - Xue Bong, with 1 Green Potion (taken): "Here, drink
   this!" (5), "About a thief...", "Where to?" (6).
   Why: he saw someone on the chief's roof, fleeing toward a shrine.
   `/navi gon_in 165/16` | done when: `b_sword >= 6`
   Fails: "No." then "Sorry, I don't have any." sets 12: closed.
6. **Back to the chief** - (7).
   `/navi gon_in 17/93` | done when: `b_sword >= 7`
   Reward: 3 White Potion.
7. **Three blade pieces** - one on each floor of the Kunlun Dungeon. The
   thief's trace is invisible and waits on one of five or seven spots per
   floor, moving on after 10 seconds: stand on a spot 3 seconds, step away
   and back; the piece then lies there (or close by) and is picked up by
   walking onto it (8 on floor 1, 9 on floor 2, 10 on floor 3).
   Floor 1 spots: `gon_dun01 201/25`, `190/160`, `163/53`, `133/183`,
   `139/257`. Floor 2: `gon_dun02 65/168` (piece at `202/25`), `265/200`,
   `247/129`, `149/74`, `23/105`, `249/39`. Floor 3: `gon_dun03 11/75`,
   `199/103`, `14/162`, `155/263`, `169/90`, `162/40` (piece at `68/39`),
   `68/212`.
   Why: the wounded thief broke the sword rather than give it up; his
   bones lie on floor 3 (`gon_dun03 62/222`, "Yes." reads his note).
   `/navi gonryun 159/201` | done when: `b_sword >= 10`
   Note: floor 2 is a maze of warp tiles; side 7 in `side.ps1` lists the
   route. Floors are around Lv 90-97, the Evil Snake Lord Lv 105.
8. **Repair it?** - the chief: "Alright." (14).
   `/navi gon_in 17/93` | done when: `b_sword == 14`
   Reward: 1 Old Blue Box.
   Fails: "No way." sets 15: closed (also an Old Blue Box).
9. **Zuo Hei** - the stranger on the north-west edge: "Ask about the
   blacksmith.", "Exactly." With the Lost Knife not yet done he sends you
   to help someone first (16); with it done he names a smith in Geffen
   (17).
   Why: he only helps people who keep their promises.
   `/navi gonryun 100/241` | done when: `b_sword >= 17`
10. **Aumgarl the smith** - in Geffen (house door `geffen 172/174`): "Sir...?",
    "I came to repair this sword." (18). He throws you out: keep talking
    to him, 1 time in 8 he listens (19). Then "Your granddaughter is such
    a pretty girl.", "Anything wrong?", "I'll make her happy.", "I want to
    take her with me.", "I am sorry.", "Well...", "Sure.", "Yes, Sir."
    (20).
    Why: he will not touch a sword while his granddaughter Lyroo lies
    dying.
    `/navi geffen_in 71/112` | done when: `b_sword >= 20`
11. **Neil** - by the east wall of Prontera (21).
    Why: a doctor from Juno cured him.
    `/navi prontera 275/86` | done when: `b_sword >= 21`
12. **Hisa** - the girl in Juno (22): the doctor is Cylrnel.
    `/navi yuno 208/164` | done when: `b_sword >= 22`
13. **Cylrnel's house** - walk in; a voice throws you out, 1 time in 10
    you are let in (23).
    `/navi yuno 245/147` | done when: `b_sword >= 23`
14. **The moody doctor** - Cylrnel: keep talking; "You're so beautiful.",
    then "Yes, I fell in love at first sight." and "Well, actually..."
    (24). Each try is random; a bad mood sends you out (`yuno 246/143`).
    `/navi yuno_in01 99/101` | done when: `b_sword >= 24`
15. **The symptoms** - "Yes, Here.", "Turns hot and cold repeatedly.", "No
    sweating at all.", "Becomes paralyzed often.", "Heart beats
    irregularly.", "Yes, I am sure.", "I'm sure." (26).
    Why: Lyroo has Amarhade.
    `/navi yuno_in01 99/101` | done when: `b_sword == 26`
    Fails: other symptoms set 25 and a shorter list (1 Yggdrasil Seed, 1
    Aloe, 5 Witched Starsand, 3 Burning Heart, 3 Ice Cubic) that brews the
    wrong cure: the items are taken and you are back at 24.
16. **The medicine** - bring 2 Yggdrasil Seed, 3 Aloe, 1 Witherless Rose,
    10 Witched Starsand, 5 Burning Heart, 5 Ice Cubic (taken) (27,
    Aloevera).
    `/navi yuno_in01 99/101` | done when: `b_sword >= 27`
17. **Lyroo** - upstairs in the smith's house: "It's your medicine." (28).
    `/navi geffen_in 106/106` | done when: `b_sword >= 28`
18. **The materials** - Aumgarl: "Would you repair the sword for me?",
    "Alright, I'll go get them." (30); bring 1 Anvil, 2 Rough Oridecon, 5
    Broken Sword, 2 Steel, 1 Hammer of Blacksmith, 2 Star Crumb, 5 Live
    Coal (taken) (31). Keep talking: 1 time in 5 the sword is done (32,
    Haedonggum).
    `/navi geffen_in 71/112` | done when: `b_sword >= 32`
19. **Home** - give the Haedonggum to the chief (33).
    `/navi gon_in 17/93` | done when: `b_sword >= 33`
    Reward: Shoes.

### The Lost Knife
`quests/quests_gonryun.txt` | `nakha` 0->3, quests 10034-10035 | Lv 20
(Han Ran Jiao: `BaseLevel >= 20`).

1. **Han Ran Jiao** - by the cliff in the north-east of the village (1).
   Why: she dropped her family knife on the field below.
   `/navi gonryun 237/226` | done when: `nakha >= 1`
2. **The knife** - walk onto the spot under the leaves (2, Knife).
   `/navi gon_fild01 245/257` | done when: `nakha >= 2`
3. **Return it** - "Return the knife." (3; "Refuse." keeps it, ask again).
   `/navi gonryun 237/226` | done when: `nakha >= 3`
   Reward: 2 Blue Potion.
   Opens: the Broken Sword's step 9.

## 16. Luoyang

Doors used below: the restaurant `/navi louyang 280/167`, the hospital
`/navi louyang 263/93`, the tool shop `/navi louyang 136/97` (its store
room is behind it), City Hall `/navi louyang 309/80` (upstairs at
`lou_in02 201/94`), the palace `/navi louyang 218/255`.

### The Soup Quest
`quests/quests_louyang.txt` | `ch_tre` 0->5 | Lv none (Chi Wu Ping's
`BaseLevel < 80` only changes a line). No reward but a secret spot.

1. **Jiu Lian Bu** - the young man on the field south of Luoyang: "What
   restaurant?", "I'll do it!" (1).
   Why: he wants to ruin the restaurant that throws him out by stealing
   its Dragon Soup broth.
   `/navi lou_fild01 195/177` | done when: `ch_tre >= 1`
2. **The pot** - in the restaurant kitchen, click a pot: "Take the pot."
   (2 = a wrong broth, 3 = the real one, 1 in 4). Then walk out without
   an employee or the chef walking into you.
   `/navi lou_in02 50/185` (or `49/185`) | done when: `ch_tre` 2 or 3
   Fails: caught by the staff puts you back to 1 (the chef also throws
   you out to `louyang 280/161`). The chance to be caught depends on the
   server hour: 10:00-14:00 8 in 10, 14:00-17:00 9 in 10, 17:00-22:00 5
   in 10, at night (restaurant closed) 4 in 10. Go at night.
3. **The taste test** - bring it to Jiu Lian Bu: a wrong broth sends you
   back for another pot (1); the real one (4) takes you to his spot.
   `/navi lou_fild01 195/177` | done when: `ch_tre >= 4`
4. **Shout it out** - talk to him there and type anything to shout (5).
   Why: shouting is his way of letting go of what weighs on him.
   `/navi lou_fild01 175/173` | done when: `ch_tre >= 5`
   Opens: he takes you back there whenever you ask ("Sure, let's go~").

### The Doctor Quest
`quests/quests_louyang.txt` | `ch_par` 0->18 (10 = the short ending),
quests 11044-11057 | Lv 40 (Doctor: `BaseLevel < 40` refuses at step 2).
Keep 2,000 weight free for the doctor and the store room.

1. **The doctor** - Hua Tuo in the hospital (or his patient at
   `lou_in02 272/55`) (1).
   `/navi lou_in02 265/69` | done when: `ch_par >= 1`
2. **His errand** - talk again: "I can help you.", either answer (2).
   Why: the hospital ran out of medicine and he cannot leave his patients.
   `/navi lou_in02 265/69` | done when: `ch_par >= 2`
3. **The tool shop** - the master: "I'm here to get something for the
   doctor..." (3).
   `/navi lou_in02 248/166` | done when: `ch_par >= 3`
4. **The store keeper** - "I'm on an errand for the doctor.", "Um, what
   is it?" (5-8: he names one document and wants you to fetch it).
   `/navi lou_in02 201/166` | done when: `ch_par` 5 to 8
   Branch: "Sorry, I'm busy." (4) lets you search the five supply stacks
   yourself (`lou_in02 204/169`, `207/168`, `206/163`, `198/170`,
   `192/170`) at about 1 try in 2,000 each; a find jumps to step 7 (9).
5. **City Hall** - the officer downstairs: "I need a document.", "A
   little zeny to cut the red tape, eh?", type a bribe of 10,000 zeny or
   more (taken; you must have more than you type) (11-14).
   `/navi lou_in02 210/47` | done when: `ch_par` 11 to 14
6. **The document** - the studying officer upstairs: "I came to pick up
   my documents.", type the name the store keeper said, exactly:
   `Residence Transfer Application` (11), `Summer SAT Class Application`
   (12), `Sandy Dust Phenomenon Report` (13) or `Communication Proposal`
   (14). (15). Bring it to the store keeper: "Excuse me." (16, Herbal
   Medicine).
   `/navi lou_in02 156/38`, `/navi lou_in02 201/166` | done when:
   `ch_par >= 15`, then 16
7. **The medicine** - give the doctor the Herbal Medicine: "No problem."
   (17) to go on.
   `/navi lou_in02 265/69` | done when: `ch_par == 17`
   Branch: "I'm sorry, I can't help you." ends here (10).
   Reward (10): 2 Pilule, 1,000 base EXP.
8. **More medicine** - bring 2 Leopard Claw, 10 Solid Peach, 5 Poisonous
   Toad Skin, 20 Brown Root, 10 Sprout, 5 Honey Pot (taken) (18).
   `/navi lou_in02 265/69` | done when: `ch_par >= 18`
   Reward: 5 Pilule, 10,000 base EXP.
   Opens: the Poison King's disciple talks to you (`ch_par > 9`).

### The Poison King
`quests/quests_louyang.txt` | `ch_poison` 0->21 (14 = the dark ending),
quests 11070-11083 | Lv none | needs: the Doctor Quest at step 7 or later
(`ch_par > 9`, from step 5). The Poison King, Nagash Arses, sits in a
house in Luoyang (`lou_in02 123/39`); his disciple Song Zhi Du works in
the hospital (`lou_in02 253/45`).

1. **The old man** - listen to his poem, then choose "Show him a sad
   look." (1).
   Why: a famous Assassin and poison master, he has been a wanted man in
   Luoyang for 40 years.
   `/navi lou_in02 123/39` | done when: `ch_poison >= 1`
2. **The poem** - carry a Green Potion, Green Herb or Red Gemstone (not
   taken) and talk until the four-topic menu shows (2 times in 3): "Ask
   about the poem." He asks four random questions; all four must be
   right, then the line he asks for (2). Answers: "in bed", "frost",
   "homesick.", "Wistful", "Separation", "In bed.", "It's a quatrain, of
   course.", "Moonlight and frost", "All places and peoples share the same
   moon.", "head", "He's homesick, so the moonlight looks cold"; the lines
   are "As I lay in bed looking up at the moonlight", "It looks like the
   frost on the ground", "I lift my head to look at the bright moon", "I
   lower my head feeling homesick."
   `/navi lou_in02 123/39` | done when: `ch_poison >= 2`
   Fails: one wrong answer: try again.
3. **His hometown** - same way to the menu: "Ask about his hometown.",
   "Just listen." (sometimes he forgets: try again) (3).
   Why: he was the poison expert of Morroc's Assassin band "Canine of
   Desert", shipwrecked here 40 years ago.
   `/navi lou_in02 123/39` | done when: `ch_poison >= 3`
4. **His situation** - "Ask about his situation.", "It must have been
   good." or "I don't know, but how did it go?" (4).
   Why: rivals poisoned the lord's son and blamed his school; he was
   jailed and broken.
   `/navi lou_in02 123/39` | done when: `ch_poison >= 4`
5. **Poison** - "Ask about use of Poison." (5): go to his disciple.
   `/navi lou_in02 123/39` | done when: `ch_poison >= 5`
6. **Song Zhi Du** - (needs `ch_par > 9`) "Yes, I fully understand." (8).
   Why: he wants revenge on Lord Bai Long for his master.
   `/navi lou_in02 253/45` | done when: `ch_poison >= 6`
   Branch: "But revenge isn't good." (6); then "I'm sorry for last
   time." (7) and bring 4 Bee Sting, 10 Venom Canine, 10 Empty Potion
   Bottle, 30 Green Potion (taken) (8).
7. **The delivery** - the firecracker lady at the town's entrance: "Yes.",
   type `Song Zhi Du`, pay 1,000 zeny (9, Large Jellopy).
   `/navi lou_fild01 224/348` | done when: `ch_poison >= 9`
8. **The brew** - give Song Zhi Du the Large Jellopy (all taken): it
   fails (10). Bring 4 Bee Sting, 10 Venom Canine, 10 Empty Potion
   Bottle, 30 Green Potion, 1 Large Jellopy (all you carry of them is
   taken each try); 3 tries in 10 work (11, 2 Poison Bottle).
   `/navi lou_in02 253/45` | done when: `ch_poison >= 11`
   Fails: a failed brew takes the whole set: bring another.
9. **The plan** - talk again (12): he wants the poison in the lord's
   drink.
   `/navi lou_in02 253/45` | done when: `ch_poison >= 12`
10. **Tell the master** - with both Poison Bottles: "I want to talk about
    your diciple.", "Give him Poison Bottle." (1 taken), "Explain to him
    what happened." (15); talk again (16).
    Why: he begs you to save the lord and his disciple from this.
    `/navi lou_in02 123/39` | done when: `ch_poison >= 16`
    Branch (dark ending): go straight to the palace at 12, put the poison
    in the drink (13), back to Song Zhi Du (14, 3 Poison Bottle, a pill
    and base EXP by level 500 to 11,000): the quest ends there.
11. **The lord's drink** - carry 1 Sticky Mucus and 1 Empty Bottle. Click
    the crack in the palace wall (`louyang 217/278`), then the drink
    bottle (both taken) (17); the spot at `lou_in01 118/167` takes you
    out.
    `/navi lou_in01 107/163` | done when: `ch_poison >= 17`
    Fails: the palace's front way is trapped and guarded while you are at
    12 or 16: any trap or soldier throws you out to `louyang 218/246`.
12. **The journal** - back to the Poison King (18, his journal).
    `/navi lou_in02 123/39` | done when: `ch_poison >= 18`
13. **Lord Bai Long** - give him the journal in the palace (19).
    `/navi lou_in01 99/158` | done when: `ch_poison >= 19`
    Reward: 1 Old Blue Box.
    Note: the script moves the Journal entry to quest 11802 ("The Lady of
    Purification") here, a typo for 11082 (rAthena bug).
14. **The master's thanks** - (20).
    `/navi lou_in02 123/39` | done when: `ch_poison >= 20`
    Reward: base EXP by level: 1,050 (below 56), 1,230, 1,570, 2,300,
    3,400, 4,500, 9,000, 18,000, 20,000 (91+).
15. **Song Zhi Du** - (21).
    `/navi lou_in02 253/45` | done when: `ch_poison >= 21`
    Reward: 5 Poison Bottle.

### The Revolution Quest
`quests/quests_louyang.txt` | `QL_REVOL` 0->9, `ch_make` 0/1 | Lv 50 (the
leader at step 3: `BaseLevel < 50` waits) | **Players: 8**. Every member
of the party must do step 4 with their own character.

1. **Sun Mao** - the hermit: "I will join you!", "I am 100% sure." (1).
   Why: he gathers people for a revolt against Luoyang's corrupt
   officials.
   `/navi lou_in02 77/37` | done when: `QL_REVOL >= 1`
2. **Recruits** - as party leader, add one member at a time and talk to
   him after each (2 ... 7). Two or more new members at once are refused.
   `/navi lou_in02 77/37` | done when: `QL_REVOL >= 7`
3. **Eight** - with the eighth member: he gives the leader 8 Burnt Tree, 8
   Lava, 8 Mud Lump (8). Each member needs one of each.
   `/navi lou_in02 77/37` | done when: `QL_REVOL >= 8`
4. **The gunpowder expert** - Hao Chenryu, held in the palace building.
   The soldier at `lou_in01 82/139` lets nobody in who carries the
   chemicals, and the one at `45/138` nobody out who carries Gunpowder:
   hide them in a Cart. Each member (with `QL_REVOL` set, in a party of 8)
   with one of each: "Make Gunpowder." (`ch_make` 1, 1 Gunpowder).
   `/navi lou_in01 43/147` | done when: `ch_make == 1` for each member
5. **Back to Sun Mao** - the leader, in a party of 8, with 8 Gunpowder
   (all taken) (9).
   `/navi lou_in02 77/37` | done when: `QL_REVOL >= 9`
   Reward: 8 Red Envelope (to share).
   To verify: how to reach `lou_in01 82/139`; whether party bots can do
   step 4 (if not, it needs 8 real characters).

## 17. Ayothaya

The way to the Ancient Shrine: leave Ayothaya by the east road
(`ayothaya 276/176`); on that field Puraim (`/navi ayo_fild01 129/197`)
pushes you down the hill to `ayo_fild02` if you carry a Holy Threads or
Holier Threads ("Yes."); Aik (`ayo_fild02 25/154`) takes you back up. The
Shrine's door is `/navi ayo_fild02 285/149`.

### The Ayothaya Dungeon Quest
`quests/quests_ayothaya.txt` | `ayodunquest` 0->13, quests 12035-12039 |
Lv none | side 4 (RO part only). Boonthom lives behind the door at
`ayothaya 62/104`.

1. **Dusit** - "What is it?", "Yes, I do" and "I think they're scary!" (1).
   Why: he tells of the Sa-mhing Tiger, a man-eater sealed in the shrine.
   `/navi ayothaya 83/132` | done when: `ayodunquest >= 1`
2. **The shaman** - Boonthom: "I want to explore the ancient ruins.",
   "Sure!" (2).
   `/navi ayo_in01 181/193` | done when: `ayodunquest >= 2`
3. **The Holy Thread** - bring 1 Fabric, 1 Nine Tails, 1 Solid Husk, 1
   Holy Water (taken) (3, Holy Threads). A lost thread: the same items
   again.
   Why: the thread keeps the shrine's spirits off you.
   `/navi ayo_in01 181/193` | done when: `ayodunquest >= 3`
4. **Six slates** - on the shrine's first level click the stone slates in
   order (4 ... 9): `ayo_dun01 198/164`, `87/16`, `268/214`, `147/274`,
   `99/118`, `16/188`.
   Why: they spell a dead man's warning not to go deeper without more
   holy power.
   `/navi ayo_dun01 198/164` | done when: `ayodunquest >= 9`
5. **A stronger thread** - tell Boonthom (10); bring 2 Holy Water, 1
   Yggdrasil Leaf, 2 Fabric, 2 Nine Tails (taken) (11, Holier Threads).
   `/navi ayo_in01 181/193` | done when: `ayodunquest >= 11`
   Note: Yggdrasil Leaf is sold by Ayothaya's Tool Dealer
   (`ayo_in01 18/182`).
6. **The second level** - with the Holier Threads, the way down in the far
   north-west of the first level (`ayo_dun01 24/283`); then the remains
   (12).
   Why: Boonthom's friend died keeping the tiger sealed.
   `/navi ayo_dun02 268/108` | done when: `ayodunquest >= 12`
   Reward: 1 Old Blue Box.
   Opens: the shrine's second level (the way down needs `ayodunquest >
   10` and the Holier Threads).
7. **The old letter** - back to Boonthom (13).
   `/navi ayo_in01 181/193` | done when: `ayodunquest >= 13`

### The Ayothaya Ring
`quests/quests_ayothaya.txt` | `thai_find` 0->14, quests 12029-12034 | Lv
none.

1. **The powerful-looking woman** - by the water: talk until she speaks
   to you (1 time in 2), "Lies~!", either answer (1).
   Why: her fiance Annon lost her engagement ring and ran off to train.
   `/navi ayothaya 233/105` | done when: `thai_find >= 1`
2. **The fisherman** - each try costs 1 Monster's Feed and 50 zeny; 1 try
   in 10 fishes up the Engagement Ring (2). (Other catches: Stone, Red
   Potion, Yellow Potion, Sushi, Flower Ring, Diamond Ring.)
   `/navi ayothaya 253/99` | done when: `thai_find >= 2`
3. **The ring** - give it to the woman, either answer (3).
   `/navi ayothaya 233/105` | done when: `thai_find >= 3`
4. **The old man** - he saw Annon run toward the shrine (4).
   `/navi ayothaya 193/171` | done when: `thai_find >= 4`
5. **Footprints** - walk over each spot in order; each pass finds the
   prints 1 time in 3 (5 ... 12): `ayo_dun01 255/62`, `74/142`, `244/256`,
   `17/257`, then `ayo_dun02 145/120`, `135/168` (either answer), `77/213`,
   `86/254`.
   `/navi ayo_dun01 255/62` | done when: `thai_find >= 12`
6. **Blood** - walk up to the bushes under the big tree (1 time in 3)
   (13); then click them: "Dig up the bushes." (or "Scatter the bushes.",
   "I'm not Shuda!") until the Haggard Man shows up.
   `/navi ayo_dun02 91/263` | done when: `thai_find >= 13`
7. **Annon** - "Treat his wound first." with a White Potion (taken), "What
   do you want me to do?" (14).
   Why: Annon swears to come home once his training is done.
   `/navi ayo_dun02 91/264` | done when: `thai_find >= 14`
   Reward: base EXP by level: 900 (below 56), 1,050, 1,868, 2,741, 7,075,
   13,024, 15,034, 18,205, 40,678 (91+).

### Tom Yum Goong
`quests/quests_ayothaya.txt` | `tomyumgoong` 0->8, quests 8123-8126 | Lv
none. Keep 4,000 weight free.

1. **Einon** - "Sure thing." (1).
   Why: he longs for Ayothaya's famous dish.
   `/navi ayothaya 196/265` | done when: `tomyumgoong >= 1`
2. **The cook** - in the pub (door `ayothaya 229/69`): "Sure!", "Where can
   I find them?" (2).
   `/navi ayo_in01 145/163` | done when: `tomyumgoong >= 2`
3. **Shrimp** - Thongpool: "I need Shrimp for Tom Yum Goong.", "I will take
   them." (11,000 zeny, 20 Shrimp) (3); give them to the cook (4).
   `/navi ayothaya 153/86` | done when: `tomyumgoong >= 4`
4. **Lemons** - Mr. Jun: "I need some Lemons.", "Yes, I will pay you.",
   "Sure, why not!": a game of Scissors / Rock / Paper, 3 wins before he
   has 5 (5, 10 Lemon); give them to the cook (6).
   `/navi ayothaya 121/240` | done when: `tomyumgoong >= 6`
   Fails: a lost game: play again.
5. **Chiles** - the merchant: "Thanks, I'll take it." (2,000 zeny, 30 Red
   Chile) (7); give them to the cook (8).
   `/navi ayothaya 213/94` | done when: `tomyumgoong >= 8`
   Reward: 10 Tom Yum Goong.

## 18. Moscovia

The Csar's palace: door `/navi moscovia 256/138`; the Csar is at
`mosk_in 131/92`, his Prime Minister at `mosk_in 127/89`.

### The Moving Island
`quests/quests_moscovia.txt` | `mos_whale_edq` 0->41 (the sea legs use
91-94 and 241-244), quests 18100-18120 | Lv none.

How the sea legs work: on Mr. Ibanoff's ship (`mosk_ship`) the captain
(`mosk_ship 98/110`) calls a direction; steer it at the rudder
(`mosk_ship 101/111`). Then keep talking to him until he says the
currents changed and names a new direction (1 time in 3 or 4), and steer
again. Sea monsters can board the ship (more often after a wrong
direction): kill them all before he talks again. Mr. Ibanoff only sails
at low tide: server hours 0-3, 6-9, 12-15, 18-21.

1. **Berbayeff** - the fisherman: "Do you have a problem?", "Tell me.",
   "The island doesn't appear anymore?" (1); talk again until he names Mr.
   Ibanoff.
   Why: he saw an island that moves, and nobody believes him.
   `/navi moscovia 171/71` | done when: `mos_whale_edq >= 1`
2. **Mr. Ibanoff** - "Tell me an adventure story.", "Interesting. Keep
   talking." (2); then "Lend me your ship." (3).
   `/navi moscovia 135/49` | done when: `mos_whale_edq >= 3`
3. **Repairs** - bring 10 Strange Steel Piece, 10 Rusty Screw, 5 Flexible
   Tube, 10 Jubilee (taken) (4).
   `/navi moscovia 135/49` | done when: `mos_whale_edq >= 4`
4. **First voyage** - at low tide talk to him to board; on the ship: East
   (5, 6), North (7, 8), then the random directions he calls (91-94, 10)
   until he spots something (11, 12); walk around the deck to the bow
   (13): a whale rises and you land on the island.
   `/navi mosk_ship 98/110`, deck `mosk_ship 81/110` | done when:
   `mos_whale_edq >= 13`
5. **The aged stranger** - on the island; talk until he sends you home
   (14, 15, back to Moscovia).
   Why: an old man lives alone on the back of a giant whale.
   `/navi mosk_fild01 86/104` | done when: `mos_whale_edq >= 15`
6. **Tell the tale** - Mr. Ibanoff: "Explain the whole story." (16); the
   Prime Minister: "To see the dear Csar.", "I have an adventure story
   for him." (17); the Csar: "Tell the story all the while." (18).
   Why: the Csar laughs at a tale without proof.
   `/navi moscovia 135/49`, `/navi mosk_in 127/89`, `/navi mosk_in
   131/92` | done when: `mos_whale_edq >= 18`
7. **Second voyage** - Mr. Ibanoff: "Try again to find Whale Island."
   (19); at low tide, the same sailing: East (20, 21), North (22, 23),
   random directions (241-244, 25) until the island shows (26, 30, you
   land on it).
   `/navi mosk_ship 98/110` | done when: `mos_whale_edq >= 30`
8. **A proof** - the aged stranger: "Explain the whole story.", "Don't
   you have a way?" (31), "I am ready." (32, home).
   `/navi mosk_fild01 86/104` | done when: `mos_whale_edq >= 32`
9. **The materials** - Mr. Ibanoff (33) takes you back to the island
   ("Let's go."); bring the stranger 30 Log, 20 Tough Vines, 20 Antelope
   Horn, 10 Sea-Otter Fur (taken) (34).
   `/navi mosk_fild01 86/104` | done when: `mos_whale_edq >= 34`
10. **The Gusli** - talk to him until it is ready (1 time in 3) (35,
    Gusli).
    `/navi mosk_fild01 86/104` | done when: `mos_whale_edq >= 35`
    Opens: back to the island whenever you like: equip the Gusli and walk
    onto the dock at `moscovia 136/46`, "Go to Whale Island."
11. **Learn to play** - "I want to learn the Gusli" (36); equip the Gusli
    and play after him until it works: 1 time in 6 (Bard and Clown 1 in
    3) (37 while failing, 38).
    `/navi mosk_fild01 86/104` | done when: `mos_whale_edq == 38`
    Opens: the stranger's "Venture into the unknown." sends you to the
    far side of the island (`mosk_fild02`).
12. **The Csar** - with the Gusli (41).
    `/navi mosk_in 131/92` | done when: `mos_whale_edq == 41`
    Reward: 1 Old Purple Box, 100,000 base EXP.
    Branch: showing the Csar the Gusli at 35, without learning it, ends
    the quest: "I can't play it." (40: Old Navy Box, 70,000 base EXP) or
    "I can play." (39: he is angry; Old Navy Box, 50,000).

### Koshei the Immortal
`quests/quests_moscovia.txt` | `rhea_rus_main` 0->53 (the errand of step
9 uses 11-46 by class) | Lv none | needs: the Moving Island at step 11
(`mos_whale_edq > 38`: the far side of the island, `mosk_fild02`, and the
Moscovia dungeons are only reached through the aged stranger) | opens: the
Red Ring, Lusalka's Hair and the Golden Thread (at `rhea_rus_main == 8`).

1. **The sage** - "Ok, let's talk.", "Show him a Poring Card" (shown, not
   taken) (1).
   Why: the immortal Koshei holds Maria Morebna prisoner in the forest.
   `/navi mosk_fild02 198/252` | done when: `rhea_rus_main >= 1`
2. **The stone** - in the forest (`mosk_dun01`): "Middle" (2). "Right"
   costs half your HP and SP, "Left" curses you; both send you back.
   `/navi mosk_dun01 169/162` | done when: `rhea_rus_main >= 2`
3. **The gray wolf** - (3); the stone again (4); the wolf: "Ok, I'll help"
   (5, he takes you to the wall).
   `/navi mosk_dun01 167/160` | done when: `rhea_rus_main >= 5`
4. **The wall** - talk until a voice answers (1 time in 3): "Ok, I can"
   (6).
   Why: Maria is walled in; only a golden key opens it.
   `/navi mosk_dun01 45/259` | done when: `rhea_rus_main >= 6`
5. **The blacksmith** - in Moscovia (7); bring 25 Steel (taken) (8, Iron
   Boots). Wear the Iron Boots for every talk of steps 6-7 and of the
   three quests below.
   `/navi moscovia 178/127` | done when: `rhea_rus_main >= 8`
6. **The key's materials** - finish the Red Ring, Lusalka's Hair and the
   Golden Thread; with 2 Cursed Ruby, 3 Gold, 1 Red Ring, 2 Lusalka's
   Hair, 10 Golden Thread, the blacksmith takes the boots (9).
   `/navi moscovia 178/127` | done when: `rhea_rus_main >= 9`
7. **Baba Yaga** - in her hut (`mosk_dun02`): she takes the materials
   (10) and sets you an errand by your class (step 8).
   `/navi mosk_dun02 48/214` | done when: `rhea_rus_main >= 10`
8. **Baba Yaga's errand** - one of six, then back to her (Golden Key, 47):
   - Archer (11): walk up to one of her three cows (`mosk_dun02
     257/193`, `146/247`, `102/107`); 1 time in 4 you can cast: type
     `Good feed is orange-flavored` (41).
   - Acolyte (16): the Noisy Coffin (`mosk_dun02 65/232`): "Pour Holy
     Water on him" (1 Holy Water) (17), "Pray" (18), "Sing a hymn" (19),
     "Kick him" (20), talk again (42).
   - Thief (21): her silver spoons in the Sunken Ship (`treasure01`): the
     Old Bed `24/39` "Bed sheet" (22), the Dirty Wall `98/119` (23), the Old
     Wooden Box `61/183` "Put hand inside the box" (1 in 7) (24), the
     Opened Treasure Chest `27/115` (25), the Old Treasure Box `165/58`
     with a Crystal Mirror, "Insert the key into the lock" (43, Baba
     Yaga's Silver Spoon; a Medusa and Obeaunes appear).
   - Mage (26): the Momotaro publisher in Amatsu (`amatsu 233/234`): type
     `Baba Yaga` (27, Mystery Magic Book); Baba Yaga (28, 29, 44).
   - Swordman (31): the House Ghost Jar (`mosk_dun02 57/220`) (32, kill
     the Thief Bugs and the Ancient Worm); "Can I play with you?" (33);
     guess its card (Poring, Angeling or Ghostring) right 3 times (34);
     give it a Milk (45).
   - Any other class (36): the Broom Grandma in Payon (`payon 65/119`)
     (37); the Ghost Tree in the Payon Cave (`pay_dun04 163/186`): "Ok,
     ask me!" (38), type `Curly Sue`, `Jasmine`, `Roxie`, `Pavianne`,
     `Blossom` (39), `Antonio` (40), then roll the same number as the tree
     within 3 throws (46).
   `/navi mosk_dun02 48/214` | done when: `rhea_rus_main >= 47`
9. **Koshei** - the wall with the Golden Key (taken) (48): Koshei, the
   Immortal (Lv 85, about 600,000 HP) appears; kill him, then talk to the
   wall (49).
   `/navi mosk_dun01 45/259` | done when: `rhea_rus_main >= 49`
   Note: only one player at a time can fight him (`$@rus_req02`).
10. **Life and Death Water** - Baba Yaga (50); bring 1 Holy Water, 1
    Cursed Water, 2 Yggdrasil Leaf, 10 Hinalle Leaflet (taken) (51).
    `/navi mosk_dun02 48/214` | done when: `rhea_rus_main >= 51`
11. **Maria** - at the wall: "Death Water" first, then "Life Water" (52).
    `/navi mosk_dun01 45/259` | done when: `rhea_rus_main >= 52`
    Reward: base / job EXP by level: 1,300 / 350 (below 56), 2,460 /
    615, 4,242 / 1,060, 6,489 / 1,622, 16,491 / 4,123, 27,629 / 6,907,
    34,041 / 8,510, 41,846 / 10,462, 88,814 / 22,204 (91+; at max level
    an Old Purple Box instead), and one random stat dish (Special Toast,
    Incredibly Spicy Curry, Bearfoot Special, Royal Family Tea, Giant
    Burito, Strawberry Flavored Rice Ball).
    Fails: "Life Water" first wastes it: try again.
12. **Baba Yaga** - (53).
    `/navi mosk_dun02 48/214` | done when: `rhea_rus_main >= 53`
    Opens: Baba Yaga brews Condensed Red and Yellow Potions for
    ingredients and zeny (a service).

### The Red Ring
`quests/quests_moscovia.txt` | `rhea_rus_ring` 0->10 (9 or 10 at the end)
| Lv none | needs: Koshei at 8, the Iron Boots worn. Keep 3,500 weight
free.

1. **Vassili Grandpapa** - "I have something to ask...", type `Red Ring`
   (1).
   `/navi moscovia 206/81` | done when: `rhea_rus_ring >= 1`
2. **Ryubaba** - his daughter: "Yes, you are right." (2).
   `/navi moscovia 213/216` | done when: `rhea_rus_ring >= 2`
3. **The little boy** - give him a Candy or a Well-Baked Cookie (3).
   `/navi moscovia 223/210` | done when: `rhea_rus_ring >= 3`
4. **Ryubaba** - give her a Witherless Rose or a Frozen Rose (4); "You
   are...", type `Red Ring` (5).
   `/navi moscovia 213/216` | done when: `rhea_rus_ring >= 5`
5. **The shepherdess** - (6); cut 25 Sharp Branch from the thorny trees
   (1 try in 3, each tree rests a minute) and bring them (taken) (7,
   Wooden Flute). Trees: `mosk_fild02 151/188`, `160/227`, `160/179`,
   `142/247`, `149/223`, `114/223`, `101/197`, `125/182`.
   `/navi mosk_fild02 157/233` | done when: `rhea_rus_ring >= 7`
6. **The ring** - Ryubaba: "Exchange" (9, Red Ring). Or "Not exchange"
   (8) and give the flute to Vassili (10, Red Ring).
   `/navi moscovia 213/216` | done when: `rhea_rus_ring >= 9`
   Reward: base EXP by level: 470 (below 56) up to 30,000 (91+).

### Lusalka's Hair
`quests/quests_moscovia.txt` | `rhea_rus_hair` 0->9 | Lv none | needs:
Koshei at 8, the Iron Boots worn. Carry a Holy Water for Lusalka.

1. **The worried mother** - "I will find her." (1); talk again (2).
   Why: her daughter vanished at the marsh, maybe turned into a Lusalka.
   `/navi moscovia 166/145` | done when: `rhea_rus_hair >= 2`
2. **Lusalka** - walk up to the lake shore (`mosk_fild02 116/202`), then
   talk to her: "I am an adventurer and...", "Ok, I will do it" (3).
   `/navi mosk_fild02 124/202` | done when: `rhea_rus_hair >= 3`
3. **The wanderer** - in Prontera: type `Igor` (4).
   `/navi prontera 228/279` | done when: `rhea_rus_hair >= 4`
4. **A Morroc villager** - (5).
   `/navi morocc 165/82` | done when: `rhea_rus_hair >= 5`
5. **The soldier** - deep in the Pyramids (6); talk again (7).
   `/navi moc_pryd04 126/120` | done when: `rhea_rus_hair >= 7`
6. **Back to Lusalka** - (8); walk up to the shore again (9).
   `/navi mosk_fild02 124/202` | done when: `rhea_rus_hair >= 9`
   Reward: 2 Lusalka's Hair.

### The Golden Thread
`quests/quests_moscovia.txt` | `rhea_rus_quiz` 0->30 | Lv none | needs:
Koshei at 8, the Iron Boots worn.

1. **The portal** - at the wall: "Open the portal!", then walk onto it
   (`mosk_dun01 45/250`) to Marozka's cave (`mosk_que`); a voice greets
   you (1).
   `/navi mosk_dun01 45/259` | done when: `rhea_rus_quiz >= 1`
2. **The stone furnace** - search it (1 time in 3) (2); a Marozka's Guard
   (Lv 73) attacks.
   `/navi mosk_que 45/131` | done when: `rhea_rus_quiz >= 2`
3. **The apple tree** - search it (1 time in 5) (3); the way out is at
   `mosk_que 47/217`.
   `/navi mosk_que 56/202` | done when: `rhea_rus_quiz >= 3`
4. **Marozka** - (4); come back in another server hour (28); talk (29).
   `/navi mosk_fild02 243/270` | done when: `rhea_rus_quiz >= 29`
5. **His riddles** - "I will take it!", then "A Mirror", "4", "Day", "A
   Candle", "An Hourglass" (30).
   `/navi mosk_fild02 243/270` | done when: `rhea_rus_quiz >= 30`
   Reward: 10 Golden Thread.
   Fails: one wrong answer: try again.

### Help Mikhail
`quests/quests_moscovia.txt` | `mos_swan` 0->101 (25, then 100 and 101
at the end), quests 18060-18069 | Lv none | needs: the Moving Island at
step 11 (`mos_whale_edq > 38`) for step 9: Moscovia's dungeons are only
reached from the far side of the island. Gallina's house: door
`moscovia 205/98`, then `mosk_in 220/273`. The landlady, the pub and Victor:
door `moscovia 229/208`.

1. **Gallina** - "Talk to her.", "Yes, I will!" (1).
   Why: her son Mikhail has disappeared from the inn.
   `/navi mosk_in 144/279` | done when: `mos_swan >= 1`
2. **The fire pot** - look at it (2).
   `/navi mosk_in 205/268` | done when: `mos_swan >= 2`
3. **Anna** - "About the situation" (3).
   `/navi mosk_in 148/274` | done when: `mos_swan >= 3`
4. **The landlady** - "Ask her about Mikhail.", "Stay overnight and get
   the info. - 5000z" (4, 5,000 zeny; you wake in a room), walk out of the
   room (5), ask her again (7).
   `/navi mosk_in 135/191` | done when: `mos_swan >= 7`
5. **The pub** - the owner: "Ask him about Mikhail." (8), then buy a drink
   for 1,000 zeny (9).
   `/navi mosk_in 141/212` | done when: `mos_swan >= 9`
6. **Victor** - in the pub (10): he sends you to a bubbling swamp.
   `/navi mosk_in 147/202` | done when: `mos_swan >= 10`
7. **The swamp** - click it (11).
   `/navi mosk_dun03 153/90` | done when: `mos_swan >= 11`
8. **Mikhail found** - the fire pot: "Look it over", "Mikhail is in the
   fire pot." (12).
   Why: the boy is a swan that got stuck in the fire pot.
   `/navi mosk_in 205/268` | done when: `mos_swan >= 12`
9. **Glue** - Victor (13); click the swamp: each click gives a Sticky
   Herb 1 time in 2 (else a Green Herb) (23 after 10 herbs); bring Victor
   10 Sticky Herb and 1 Medicine Bowl (taken) (24, High Strength
   Adhesive).
   `/navi mosk_dun03 153/90`, `/navi mosk_in 147/202` | done when:
   `mos_swan >= 24`
10. **Free him** - use the adhesive at the fire pot (25).
    `/navi mosk_in 205/268` | done when: `mos_swan >= 25`
11. **Gallina** - (100).
    `/navi mosk_in 144/279` | done when: `mos_swan >= 100`
    Reward: 90,000 base EXP.
12. **Larissa** - the cook (101).
    `/navi mosk_in 211/259` | done when: `mos_swan >= 101`
    Reward: 5 Jam Pancake, 5 Honey Pancake. (After that she cooks
    pancakes for ingredients: an exchange, not part of the quest.)

### Banish Winter
`quests/quests_moscovia.txt` | `mos_nowinter` 0->21, quests 18070-18079 |
Lv 60 (Baba Yaga: `BaseLevel > 59`) | needs: the Moving Island at step 11
(Baba Yaga's hut is reached from `mosk_dun02 53/220`). Bring 80 Yaga's
Pestle in all (40 shown to Baba Yaga, 40 taken by the Csar); they drop
from the Baba-Yaga monsters (Lv 87).

1. **Baba Yaga, the Horrible** - walk into her hut with 40 Yaga's Pestle
   (not taken) (2). Below Lv 60 she takes some of them and throws you out.
   `/navi mosk_in 215/46` | done when: `mos_nowinter >= 2`
2. **Her secret medicine** - "A present?", "I don't need them anymore.",
   "Well...", "Good, but I think you're lying.", "Ok, I will." (5).
   Why: she offers to end Moscovia's winter with a spell.
   `/navi mosk_in 215/46` | done when: `mos_nowinter >= 5`
3. **The list** - talk again; "...Are you sure?" (6) or "A glue? You want
   me to kill you?!" (7, no Sticky Mucus). Bring 20 Grasshopper's Leg, 5
   Spawn, 20 Wing of Red Bat, 10 Witched Starsand, 10 Fine Grit, 1
   Detonator, 5 Red Blood, 10 Burning Heart, a 1, 2 or 3 carat Diamond,
   and at 6 also 10 Sticky Mucus (all taken) (8).
   `/navi mosk_in 215/46` | done when: `mos_nowinter >= 8`
4. **The dragon's lair** - the pile of skeletons: "Look for it." (6 times
   in 20; Thieves always) (9, Magic Gourd Bottle).
   `/navi mosk_dun03 225/233` | done when: `mos_nowinter >= 9`
5. **Voices** - show Baba Yaga the bottle (10); in Moscovia, talk to the
   townsfolk until a child, a young person and an older one each say
   they want no winter (3 times in 10 each) (11). Children: `moscovia
   252/203`, `255/203`, `202/102`, `228/80`; young: `233/204`,
   `204/188`, `220/172`, `192/80`, `211/215`, `196/71`; older: `219/229`,
   `167/97`, `253/175`, `168/135`, `149/112`, `234/168`.
   `/navi moscovia 252/203` | done when: `mos_nowinter >= 11`
6. **Arrested** - go back to the hut: soldiers take you to the Csar (12);
   "Explain the circumstances.", show 40 Yaga's Pestle (taken) (14).
   `/navi mosk_in 131/92` | done when: `mos_nowinter >= 14`
   Fails: without the pestles you stay at 13 ("Yes, I did." with them
   later).
7. **The book** - back to Baba Yaga with the bottle (taken) (15); read the
   book: "Read from the marked page." (16).
   `/navi mosk_in 215/46`, book `mosk_in 217/45` | done when:
   `mos_nowinter >= 16`
8. **The pot** - follow the book at the pot: "Put the materials in it."
   Powder Of Wing Of Bat, Liquid Of Spawn, Grasshopper's Leg; "Pour water
   in it."; "Stir it up." type `20`; then Starsand Of Witch and Fine
   Grit; "Stir it up." type `15`; then in this order Red Blood, Detonator,
   Burning Heart, Piece Of Diamond; "It is over!" (17, 18).
   `/navi mosk_in 221/43` | done when: `mos_nowinter >= 18`
   Fails: a wrong step: start over (17).
9. **The medicine** - Baba Yaga (19, Baba Yaga's Secret Medicine).
   `/navi mosk_in 215/46` | done when: `mos_nowinter >= 19`
10. **The town centre** - click the spot (20).
    `/navi moscovia 224/190` | done when: `mos_nowinter >= 20`
11. **The Csar** - (21).
    `/navi mosk_in 131/92` | done when: `mos_nowinter >= 21`
    Reward: 1 Old Blue Box.

Excluded: the Shafka Hat and the Acorn Exchange (exchange), Larissa's
pancakes (cooking for ingredients).

## 19. Brasilis

Coconut and Banana: the Fruit Gardener (`/navi brasilis 221/128`).

### The Brasilis Dungeon Access
`quests/quests_brasilis.txt` | `brazil_ghost` 0->8, quests 2208,
60351-60355 | Lv 40 (the curator: `BaseLevel < 40` refuses) | opens a
place: the Brasilis Dungeon. In the haunted bathroom, each object first
wants a line of the magic words typed exactly, then an action.

1. **Pedro** - "Ask about the gossip.", "Can you tell me more?", "So then
   what happened?", "So was it a ghost?", "Did anyone tell you the magic
   words?", "Wanna help me find this ghost?" (1).
   Why: children say a ghost haunts the museum's bathroom.
   `/navi brasilis 185/246` | done when: `brazil_ghost >= 1`
2. **The curator** - in the museum, with 1 Coconut (taken): "I need to use
   the bathroom.", "But I forgot something inside.", "It's such a hot
   day!" (2, you are in the bathroom).
   `/navi bra_in01 7/181` | done when: `brazil_ghost >= 2`
3. **The door** - "Turn the key.", type `Mother the door won't open!`,
   "Turn the key.", type `7` (3).
   `/navi bra_in01 149/184` | done when: `brazil_ghost >= 3`
4. **The toilet** - "Use the toilet", type `Mother the water is
   flooding!`, "Flush the toilet.", type `3` (4).
   `/navi bra_in01 144/187` | done when: `brazil_ghost >= 4`
5. **The faucet** - "Examine it.", type `Mother the drought has started!`,
   "Turn on the water.", type `1` (5).
   `/navi bra_in01 134/189` | done when: `brazil_ghost >= 5`
6. **The carpet** - "Examine it.", type `Mother where are my friends?`,
   "Shake the carpet.", type `7` (6).
   `/navi bra_in01 138/184` | done when: `brazil_ghost >= 6`
7. **The mirror** - "Examine it.", type `Where are you mom?`, "Take the
   eye bandage off.": a dice throw against the ghost; a higher throw wins,
   a tie is thrown again
   (7, you are taken to the manhole room).
   Why: the ghost is a mother still looking for her child.
   `/navi bra_in01 151/180` | done when: `brazil_ghost >= 7`
   Fails: a lower throw (or "Run away~.") sends you back to 1: start
   again at the curator with a new Coconut.
8. **The open manhole** - (8).
   `/navi bra_in01 206/188` | done when: `brazil_ghost >= 8`
   Reward: 90,000 base EXP (135,000 with VIP).
   Opens: the Brasilis Dungeon: the manhole leads to `bra_dun01`; later
   the pipe on the field (`bra_fild01 323/136`, `brazil_ghost > 6`) takes
   you back to the manhole room.

### The Guarana Candy
`quests/quests_brasilis.txt` | `brazil_gua` 0->11, quests 2192-2200 | Lv
none.

1. **The candy maker** - "How can I taste this guarana candy?", "How do I
   find guarana?" (1).
   `/navi brasilis 187/162` | done when: `brazil_gua >= 1`
2. **Cherto** - "Guarana?", "Whaaaat??", "What are you talking about?"
   (2); talk again: "Guarana kid?" (3).
   Why: only a strange kid knows where guarana grows.
   `/navi bra_in01 95/179` | done when: `brazil_gua >= 3`
3. **The strange kid** - "Try to talk.", then "End conversation." (4).
   `/navi brasilis 203/64` | done when: `brazil_gua >= 4`
4. **Cherto** - (5).
   `/navi bra_in01 95/179` | done when: `brazil_gua >= 5`
5. **Mage Paje** - "What kind of magic?" (6).
   `/navi brasilis 56/224` | done when: `brazil_gua >= 6`
6. **The toucan** - on the field: walk up to it, "What are you talking
   about?", "Not yet... but I want to be a friend.", "Absolutely!" (7).
   `/navi bra_fild01 75/83` | done when: `brazil_gua >= 7`
7. **The jaguar** - "Yes? N...o......actually...." (8).
   `/navi bra_fild01 34/184` | done when: `brazil_gua >= 8`
8. **The monkey** - "I've come here to help him." (9).
   `/navi bra_fild01 245/52` | done when: `brazil_gua >= 9`
9. **The kid** - (10, Guarana Fruit).
   `/navi brasilis 203/64` | done when: `brazil_gua >= 10`
10. **The candy** - give the candy maker the Guarana Fruit (11).
    `/navi brasilis 187/162` | done when: `brazil_gua >= 11`
    Reward: 1 Guarana Candy, 70,000 base / 10,000 job EXP (105,000 /
    15,000 with VIP).
    Opens: the candy maker sells Guarana Candy (4,000 zeny).

### The Water Lily
`quests/quests_brasilis.txt` | `brazil_regia` 0->10 | Lv none | needs: the
Brasilis Dungeon Access at 7 (steps 4-6 are in `bra_dun02`).

1. **Botanist Karmen** - (1).
   `/navi brasilis 203/286` | done when: `brazil_regia >= 1`
2. **Marta** - (2).
   `/navi bra_in01 142/27` | done when: `brazil_regia >= 2`
3. **The girl** - walk up to her: "What's wrong?", "Just trying to
   help.", "Help Jasira." (3).
   `/navi brasilis 270/145` | done when: `brazil_regia >= 3`
4. **The recluse** - in the dungeon: "Are you the moon?" (4).
   `/navi bra_dun02 67/205` | done when: `brazil_regia >= 4`
5. **The water lily** - with 10 Banana (taken) (5).
   `/navi bra_dun02 71/200` | done when: `brazil_regia >= 5`
6. **The girl** - (6); the recluse with 5 Coconut (taken) (7); the water
   lily (8, Lotus Flower).
   `/navi brasilis 270/145`, `/navi bra_dun02 67/205` | done when:
   `brazil_regia >= 8`
7. **The girl** - give her the Lotus Flower (9).
   `/navi brasilis 270/145` | done when: `brazil_regia >= 9`
   Reward: Flower Lily (headgear, with one of three random cards).
8. **Karmen** - (10).
   `/navi brasilis 203/286` | done when: `brazil_regia >= 10`
   Reward: 50,000 base / 10,000 job EXP (75,000 / 15,000 with VIP).

### Lost Puppies
`quests/quests_brasilis.txt` | quests 9030-9032 (`brazil_kid` counts the
puppies) | Lv 40 | repeatable (daily: until 4:00 server time, quest 9032).

1. **Angelo** - (quest 9030).
   `/navi brasilis 297/307` | done when: quest 9030 active
2. **Three puppies** - on the field, click 3 puppies; each one found
   shows the next somewhere near (quest 9031). Spots: `bra_fild01 98/96`,
   `59/116`, `62/142`, `80/163`, `73/210`, `80/210`, `38/235`, `307/64`,
   `260/60`, `234/101`, `200/84`, `176/63`.
   `/navi bra_fild01 98/96` | done when: quest 9031 active
3. **Back to Angelo** - (quest 9032, the wait until 4:00).
   `/navi brasilis 297/307` | done when: quest 9032 active
   Reward: 50,000 base EXP (75,000 with VIP), a Yggdrasil Berry's effect,
   sometimes 2 White Potion or 1 Yggdrasil Seed.

### The Suspicious Beach
`quests/quests_brasilis.txt` | quests 9028-9029 | Lv 40 | repeatable (until 4:00,
quest 9029).

1. **Lucia** - "Yes." (quest 9028, Hydra Ball).
   Why: Strange Hydras have surrounded the beach.
   `/navi brasilis 192/133` | done when: quest 9028 active
2. **A Strange Hydra** - use the Hydra Ball on one at the beach; it works
   1 time in 2 (Mystic Leaf Cat Ball). A failed ball: ask Lucia for
   another.
   done when: you carry a Mystic Leaf Cat Ball
3. **Back to Lucia** - (quest 9029).
   `/navi brasilis 192/133` | done when: quest 9029 active
   Reward: 3 Light Blue Potion or 5 Blue Potion and the effects of a
   Yggdrasil Berry and three stat dishes.

### Iara
`quests/quests_brasilis.txt` | quests 4133-4135 | Lv 40 | repeatable (until 4:00,
quest 4135, a buff) | needs: the Brasilis Dungeon Access at 7 (Iara is in
`bra_dun02`).

1. **The shaman** - "Okay, I'll do it." (quest 4133).
   `/navi brasilis 315/334` | done when: quest 4133 active
2. **The purification potion** - bring 20 Heart of Mermaid, 10 Leopard
   Claw, 3 Ancient Lips (taken) (quests 4134 done, 4135 = the wait; 2 Puri
   Potion).
   `/navi brasilis 315/334` | done when: quest 4134 done
3. **Iara** - walk up to her with a Puri Potion: "Yes." (1 taken).
   `/navi bra_dun02 157/74` | done when: the buff is on
   Reward: full HP and SP, +20 Flee and +10 Critical for an hour, and the
   effects of six stat dishes. Without a potion she curses or confuses
   you.

## 20. Dewata

### The Dewata Legend
`re/quests/quests_dewata.txt` | `dew_legend` 0->17, quests 9155-9165 |
Lv 60 (the hideout: `BaseLevel > 59`).

1. **The hideout** - walk into the hidden spot on the field (1).
   `/navi dew_fild01 57/274` | done when: `dew_legend >= 1`
2. **Sage Kasyapa** - "I overheard talk about a crown?", "Anything I can
   do to help?" (2).
   Why: the Jaty tribe's crown is lost, and with it a legend.
   `/navi dew_in01 22/48` | done when: `dew_legend >= 2`
3. **Tribal Chief Paiko** - "I overheard the story by accident",
   "Kasyapa was talking about a crown..." (3); walk to the hidden corner
   (`dew_in01 15/33`) (4); the chief: "Crown-a-whatsis?", "Ok, I will
   help" (5).
   `/navi dew_in01 15/49` | done when: `dew_legend >= 5`
4. **Feathers** - bring 15 Cendrawasih Feather (taken) (6); they drop from
   the Cendrawasih (Lv 84). Talk again (7).
   `/navi dew_in01 15/49` | done when: `dew_legend >= 7`
5. **The sage** - he makes a Shining Cendrawasih Feather (8).
   `/navi dew_in01 22/48` | done when: `dew_legend >= 8`
6. **Satay deliveries** - the chief: "Of course, I can help" (9, 2 Satay);
   each time give one Satay where he sends you, choose "Tribal Chief
   Paiko", and report back for the next (2 Satay each time):
   the Jaty Tribe Warrior (10, back 11), the Tribe Manager (12, back 13),
   the Gatekeeper of Krakatau (14, back 15), the Borobudur Temple Manager
   (16).
   `/navi dew_fild01 78/288`, `/navi dew_fild01 185/300`, `/navi dewata
   235/56`, `/navi dewata 78/192` | done when: `dew_legend >= 16`
   Fails: eating the Satay ("I ate them all."): ask the chief again.
7. **The crown** - the chief (17).
   `/navi dew_in01 15/49` | done when: `dew_legend >= 17`
   Reward: Jaty Crown, 5 Satay.
   Opens: the Gatekeeper of Krakatau ("Allow me through") takes you into
   the Krakatau volcano (`dew_dun01`).

### Help Out the Old Man
`re/quests/quests_dewata.txt` | `dew_drink` 0->10, quests 5035-5044 | Lv
60 (Memo: `BaseLevel < 60` refuses) | the daily part after it: quests
5045-5050 (cooldown 5044, until 4:00 server time).

1. **Memo** - (talks 1 time in 3) "What happened?", "Sounds like a big
   problem.", "No, I am not busy." (1).
   Why: the old man is building an ark against a flood he fears.
   `/navi dewata 109/262` | done when: `dew_drink >= 1`
2. **Lero** - "Excuse me, but are you Lero?", "Memo sent me here.", "Yes,
   I will find them." (2).
   `/navi dew_fild01 114/275` | done when: `dew_drink >= 2`
3. **Poby** - (3); Lero: "Poby.....", "Why don't I get the ingredients?"
   (4).
   `/navi dew_fild01 259/48`, `/navi dew_fild01 114/275` | done when:
   `dew_drink >= 4`
4. **Palm fruit** - shake or kick the palm trees near Poby: 5 times in 20
   a fruit (sometimes five), else a Stone, Great Leaf, Worm Peelings,
   damage or a throw across the field. Bring Lero 60 Oil Palm Fruit
   (taken) (5). Keep 5,000 weight free. Trees: `dew_fild01 247/62`,
   `276/73`, `278/63`, `301/88`, `314/72`, `320/68`.
   `/navi dew_fild01 114/275` | done when: `dew_drink >= 5`
5. **Back to Memo** - "Palm tree... became." (6); Lero (7, 30 Palm Oil).
   `/navi dewata 109/262`, `/navi dew_fild01 114/275` | done when:
   `dew_drink >= 7`
6. **The palm oil** - give Memo 30 Palm Oil (taken) (8); come back after 5
   minutes (10).
   `/navi dewata 109/262` | done when: `dew_drink >= 10`
   Reward: 50,000 base / 10,000 job EXP, 1 Old Purple Box.
   Opens: a daily: Memo, "I will help you.", wants Palm Oil (Lero turns
   Oil Palm Fruit into it) for Coco Juice.

Excluded: the Traditional Weapon (Gatti, exchange).

## 21. Malangdo

The cats' meeting hall and the ship are `mal_in02`, the village houses
`mal_in01`; the Malangdo Culvert field dungeon is `mal_dun01` (door
`/navi malangdo 73/239`). Malangdo Canned Specialties are the island's
money for Portali's teleports (`malangdo 190/167`).

### Malangdo Island
`re/quests/quests_malangdo.txt` | `ma_tomas` 0->35, then 100 and 101,
quests 11209-11245 | Lv 60 (Tomas: `BaseLevel < 60` refuses). The
choices of steps 2-8 are not all read: **to verify**.

1. **Tomas** - the village chief: "Try to talk to him.", "It's my first
   time to Malangdo." (1).
   `/navi mal_in02 22/62` | done when: `ma_tomas >= 1`
2. **The cats' meeting** - the President of Meeting (2), Scottfold (3),
   Koon (4), Linguist Devore (5), Geologist Mali (6), Brie (7).
   `/navi mal_in02 182/61`, `178/66`, `177/58`, `174/64`, `179/57`,
   `181/55` | done when: `ma_tomas >= 7`
3. **Rican's fruit** - Brie: "About Rican." (8); Rican in the village:
   "Excuse me. Is this Rican's house?", "Ask about Yggdrasil Berry.",
   "I'll help him." (9); dig 30 Fresh Fruit from the Suspicious Sand
   Piles (`malangdo 221/139`, `208/174`, `191/223`, `150/195`, `116/196`,
   `178/145`, `142/120`, `136/122`, `152/143`, `242/175`) (10); the Dry
   Machine: "Put the fruits in." (11); Rican (12, 20 E Grade Coin); Brie
   (13).
   `/navi mal_in01 114/169`, machine `mal_in01 116/168` | done when:
   `ma_tomas >= 13`
4. **The cracks** - Mali: "Help repairing." (14); Bob: "Yes.", "Stop it!
   Tell me how to repair the cracks." (15, Fix Kit); at a crack in the
   village "Use the stapler." until it holds (1 in 3) (16; 1 time in 10
   the ground swallows you into `mal_dun01`). Cracks: `malangdo
   114/157`, `284/237`, `134/150`, `173/199`, `233/197`, `137/239`,
   `239/157`, `221/155`, `217/109`, `162/183`. Bob (17), Mali (18, 20 E
   Grade Coin).
   `/navi mal_in02 140/94` | done when: `ma_tomas >= 18`
5. **Star Candy** - Devore (19); Star Candy in the culvert: "Support?"
   (20); Devore (21).
   `/navi mal_dun01 133/125` | done when: `ma_tomas >= 21`
6. **Biscuit** - in the culvert (22), ask all three topics (23-25):
   "Okay." (26); bring 30 Delicious Jelly (taken; Siorava Lv 87, Wild
   Rider Lv 95) (27, 5 E Grade Coin); "I'll help." (28).
   `/navi mal_dun01 136/122` | done when: `ma_tomas >= 28`
7. **Scrubbing** - the Cleaning Staff gives a Pail and a Cleaning Brush
   (`mal_in02 102/94`); fill the pail at the 1st Rate Point (`malangdo
   246/184`); scrub the four skins in the culvert in order (29-32): Dry
   Skin `mal_dun01 143/137`, Prickly Skin `131/150`, Chapped Skin
   `116/144`, Hard Skin `120/129`; one full pail per skin (33).
   `/navi mal_dun01 143/137` | done when: `ma_tomas >= 33`
8. **Biscuit's thanks** - keep 1,000 weight free (34).
   `/navi mal_dun01 136/122` | done when: `ma_tomas >= 34`
   Reward: 100 E Grade Coin, 20 Malangdo Canned Specialties.
9. **Devore** - (35, 30 E Grade Coin); **Tomas** - (100, 30 E Grade
   Coin).
   `/navi mal_in02 174/64`, `/navi mal_in02 22/62` | done when:
   `ma_tomas >= 100`
10. **Pipielle** - "I met an Admiral Tomas...", then 30 Unknown Fish
    (101, 200 E Grade Coin).
    `/navi malangdo 137/200` | done when: `ma_tomas >= 101`
    Blocker: no monster drops Unknown Fish and no shop sells it in
    rathena-pin: dead end, see guide-deferred.md.

### Help the Bad Cats in Danger
`re/quests/quests_malangdo.txt` | quests 1145-1155 (`malang_bad_guys`) |
Lv 60 | repeatable (until 4:00, quest 1152). Order of the clue spots: **to
verify**.

1. **Gobonge** - "Sure I will.", "Need help?", "Yes, I'll do it!" (1145).
   `/navi malangdo 175/206` | done when: quest 1145 active
2. **The clues** - two spots in the village (1146-1148), the Awfully
   Suspicious Dealer (1149), a sack in the meeting hall (1150, Bad Canned
   Food Sack), the dealer again (1151).
   `/navi malangdo 196/120`, `155/179`, `171/163`, `mal_in02 184/77`
   | done when: quest 1151 active
3. **The bad cans** - bring Gobonge the sack and 30 Bad Canned Food (Red
   Eruma, Lv 91) (taken) (1152).
   `/navi malangdo 175/206` | done when: quest 1152 active
   Reward: 20 Malangdo Canned Specialties.
   Repeat: "Sure I will!", the Patrol Leader (`malangdo 125/147`): kill
   20 Red Eruma (1154, 1155); Gobonge: 5 E Grade Coin.

### Clean the Ship
`re/quests/quests_malangdo.txt` | quests 7260-7275 (`mal_qook`) | Lv 60 |
repeatable (until 4:00, quest 7267).

1. **Cleanyang** - (7260): find the Cat Biscuits that bugs gather around:
   searching a spot makes a Quick Dark Shadow appear and gives a Cat
   Biscuit. Spots: `mal_in02 29/67`, `183/49`, `103/22`, `malangdo
   141/178`, `133/134`, `232/131`, `mal_in01 74/20`, `159/225`, `24/72`.
   `/navi mal_in02 76/63` | done when: the spots of the quest log done
2. **Chef Nyas** - (7264), back to Cleanyang (7267).
   Reward: 80,000 base / 80,000 job EXP, 30 Malangdo Canned Specialties.
   Repeat: Cleanyang (7268): 30,000 / 40,000 EXP, 10 cans.

### Help Chef Nyas
`re/quests/quests_malangdo.txt` | quests 7264-7280 (`mal_food`) | Lv 60 |
repeatable (until 4:00, quest 7276) | needs: Clean the Ship's step 2 (7264).

1. **Chef Nyas** - (7265, 7266); bring 10 Bag of Grain and 1 Savory Sauce
   (7276).
   `/navi mal_in02 187/58` | done when: quest 7276 active
   Repeat: he names a dish (7281-7340) to bring with the grain and sauce:
   E Grade Coins and 50,000 / 80,000 EXP.

### Play with Baby Cats
`re/quests/quests_malangdo.txt` | `nyadven` 0->14 (`nyadven02` for the
games), quests 7242-7259 | Lv 60. The games' rules are **to verify**.

1. **Expert Cat** - (1).
   `/navi malangdo 165/223` | done when: `nyadven >= 1`
2. **The Meow Team** - Charo (2, 3); the Beginning Compass game (`malangdo
   212/204`), Meowbell (`malangdo 175/163`) (4), Charo (5, 6); the Cat
   Detective (`malangdo 172/178`) and the Noisy Machine (`malangdo
   174/175`) (7-12); Charo (13).
   `/navi malangdo 211/203` | done when: `nyadven >= 13`
3. **Expert Cat** - (14).
   `/navi malangdo 165/223` | done when: `nyadven >= 14`
   Reward: 100 E Grade Coin.
   Repeat: Roku (`malangdo 215/201`) and the Noisy Machine run daily
   games (until 4:00): 3 E Grade Coin, 20,000 / 20,000 EXP each.

### Cat Gamers
`re/quests/quests_malangdo.txt` | `malang_gamer` 0->20, quests
5058-5090 | Lv 60. Choices **to verify**.

1. **The director** - (1, 2, 3); the Strange Cat (`malangdo 127/111`)
   (4); the director (5-8); the Strange Cat (9); the director (10-12,
   with waits between rounds: 3 minutes (5060), until 4:00 (5068), 1
   hour (5069)) (20).
   `/navi mal_in01 31/210` | done when: `malang_gamer >= 20`
   Reward: G Honor Certificate.
   Opens: the gamers Ser, Paa, Kuka and KungKung (`mal_in01 91/216`,
   `86/222`, `91/222`, `134/221`) play daily games (until 4:00, quests 5070-5072) for cans and coins.

Excluded: the Archangel Wing enchants.

## 22. Port Malaya

### The Cautious Village
`re/quests/quests_malaya.txt` | `malaya_hi` 0->25, quests 7350-7410 | Lv
100 (for the dailies and Imelda; the start has no check) | opens: Secret
in the Woods, Bakonawa and the Nurse (`malaya_hi >= 20`). The six
villagers: Old Man Nardo `malaya 181/353`, Romel `224/267`, Talah
`223/267`, Collection Dealer Woeon `295/171`, Blacksmith Pandoi
`119/217`, Pedro the Sailor `326/68`.

1. **Rodel the Guard** - (1).
   `/navi malaya 266/76` | done when: `malaya_hi >= 1`
2. **Leader Phong** - in Mumbaki: "Step toward the shadow." (10).
   `/navi malaya 185/358` | done when: `malaya_hi >= 10`
3. **The villagers' fears** - talk to all six villagers (quests
   7352-7357) (11).
   `/navi malaya 181/353` | done when: `malaya_hi >= 11`
4. **Spiritual protection** - Phong: "Explain what happened.", then the
   talk about "Holy Water!" and the Blue Gemstone (12).
   `/navi malaya 185/358` | done when: `malaya_hi >= 12`
5. **Hand them out** - give each of the six villagers 1 Holy Water and 1
   Blue Gemstone (taken): "Hand over the prepared items." (13).
   `/navi malaya 181/353` | done when: `malaya_hi >= 13`
6. **Phong** - (20).
   `/navi malaya 185/358` | done when: `malaya_hi >= 20`
   Reward: 200,000 base / 200,000 job EXP.
7. **Imelda** - (Lv 100) (21); bring 6 Sharp Bamboo (Black Bamboo,
   `ma_fild01 178/206`), 6 Salt Bag (Sand Trap, `malaya 62/274`), 6
   Silver Cross (Blacksmith Pandoi) (taken) (22); talk again (23, 6 Soul
   Protection).
   `/navi malaya 169/350` | done when: `malaya_hi >= 23`
8. **Soul Protection** - give one to each of the six villagers (24).
   `/navi malaya 181/353` | done when: `malaya_hi >= 24`
9. **Imelda** - (25).
   `/navi malaya 169/350` | done when: `malaya_hi >= 25`
   Reward: 200,000 / 200,000 EXP.
   Opens: the villagers' dailies (Lv 100, each until 4:00): Imelda, Nardo,
   Woeon, Pandoi, Pedro (the Ghost Diwata in `ma_in01`, `malaya_diwata`),
   Kiko in Mumbaki (`ma_fild01 261/208`), Dhong the Guard (`ma_fild01
   239/253`), Maries (`ma_fild01 200/190`), Budidai (`ma_fild02 241/39`):
   200,000 / 200,000 EXP each. Details **to verify**.

### Secret in the Woods
`re/quests/quests_malaya.txt` | `malaya_buwaya` 0->15, quests 2271-2281 |
Lv 100 | needs: the Cautious Village at 20 (`malaya_hi > 19`).

1. **The guard** - walk up to him: "Treasure?" (1).
   `/navi malaya 305/281` | done when: `malaya_buwaya >= 1`
2. **A villager** - (2).
   `/navi malaya 276/288` | done when: `malaya_buwaya >= 2`
3. **Totoy** - (3, 4, 5).
   `/navi ma_in01 47/101` | done when: `malaya_buwaya >= 5`
4. **The Master of Hunting** - (6-9); the soil next to him (10, Collected
   Sample).
   `/navi malaya 290/152` | done when: `malaya_buwaya >= 10`
5. **The Guard Leader** - (11); the dog in the woods (12); Totoy (13,
   14, Lesser Agimat).
   `/navi malaya 290/340`, `/navi ma_fild02 312/259` | done when:
   `malaya_buwaya >= 14`
6. **The Guard Leader** - (15).
   `/navi malaya 290/340` | done when: `malaya_buwaya >= 15`
   Reward: 1,000,000 base / 600,000 job EXP.
   Opens: the Buwaya Cave memorial (Lv 130 for its reward).

### Bakonawa Extermination
`re/quests/quests_malaya.txt` | `malaya_bakona1` 0->7, `malaya_bakona2`
0->15, quests 1174-1193 | Lv 120 | needs: the Cautious Village at 20.

1. **The Old Legend Teller** - "Calm Bakonawa?", "I'll help." (1); the
   old man's granddaughter (`malaya 304/100`) (2); the teller (3).
   `/navi malaya 285/332` | done when: `malaya_bakona1 >= 3`
2. **The immigrants** - `ma_fild02 40/240` (4), `ma_fild01 165/237` (5),
   the spot `ma_fild01 171/235` (6).
   done when: `malaya_bakona1 >= 6`
3. **The teller** - (7).
   `/navi malaya 285/332` | done when: `malaya_bakona1 >= 7`
   Reward: 500,000 base / 200,000 job EXP, Ancient Grudge.
4. **The village chief** - (needs `malaya_bakona1 > 5`) "I'm on my way."
   (1); the missing person's father, friend, son and mother (`malaya
   269/267`, `265/274`, `270/278`, `265/284`) (2-5); the chief (6, Inside
   Out Shirts).
   `/navi malaya 283/265` | done when: `malaya_bakona2 >= 6`
5. **The young fortune teller** - (7, 8, Tikbalang Belts); the chief (9).
   `/navi malaya 289/364` | done when: `malaya_bakona2 >= 9`
6. **The search** - the spots `ma_fild01 54/244` (10), `ma_fild01
   242/116` (11), then `ma_scene01 179/85`, `138/122`, `171/174`
   (12-14).
   done when: `malaya_bakona2 >= 14`
7. **The chief** - (15).
   `/navi malaya 283/265` | done when: `malaya_bakona2 >= 15`
   Reward: 1,000,000 / 600,000 EXP, Lesser Agimat.
   Opens: the Bakonawa Lake memorial.

### The Nurse in Port Malaya
`re/quests/quests_malaya.txt` | `malaya_bang` 0->42 (1-20, then 30-36,
then 40-42), quests 11284-11309 | Lv 100 | needs: the Cautious Village at
20 | **Players: 1** (the last fight is in the Bangungot Hospital 2F
memorial, which needs a party, even of one).

1. **The nurse** - outside the hospital (1, 2, 3); the hospital door
   (`malaya 48/76`) (4); the nurse (5); the village woman (`malaya
   64/78`) (6); the nurse (7); the village man (`malaya 62/37`) (8); the
   nurse (9); Dr. Boon (`malaya 210/200`) (10); the nurse (11); the door
   (12); the nurse (13); the bushes (`malaya 53/68`) (14, 15); the nurse
   (16); the bent old lady (`malaya 114/183`) (17, 18); the nurse (19,
   into the hospital `ma_dun01`); the nurse inside (20).
   `/navi malaya 55/72` | done when: `malaya_bang >= 20`
2. **The wooden stick** - in the hospital (30); the memorial's nurse
   (`ma_dun01 147/10`) (31); the bent old lady (33), the bent shaman
   (`malaya 276/367`) (34); the nurse: "Tell her about the talisman."
   (35); the stick (36).
   `/navi ma_dun01 152/23` | done when: `malaya_bang >= 36`
3. **Bangungot** - the nurse: "Bangungot?" / "Nurse Maenne?" (42); in
   the Bangungot Hospital 2F memorial kill Bangungot (quest 11309); back
   to the nurse.
   `/navi ma_dun01 147/10` | done when: quest 11309 done
   Reward: 1,000,000 base EXP, 1 Old Purple Box, Ancient Grudge, Lesser
   Agimat.
   The values 32, 40 and 41 and the order of step 2 are **to verify**.

Excluded: the traders, the boss equipment upgrades and the Pintados
Festival (exchange).

## 23. The New World (Episode 13)

Most quests here check `ep13_ryu > 99 || ep13_start > 99`: Episode 13.1
done, or the Cat Paw passage (below). The Sapha and the Laphine quests also
want the Ring of the Ancient Wise King (2782) worn: The Otherworld
Language. The Teleport Cat in the camp (`mid_camp 207/234`) goes to Near
Splendide (`spl_fild02`) and Manuk Field (`man_fild02`).

Not quests: the strange devices on Nidhoggur's dungeon floor 2
(`nyd_dun02 139/274` turns on a path of panels for 70 seconds, `178/255`
takes you back to its start) are a map puzzle with no variable; the
two extra Cat Paw Agents (`spl_fild02 25/211`, `man_fild02 132/47`) give the
Trading Post's services by its credit (`ep13_yong1`).

### Finding a Fairy & Finding a Giant Tree
`quests/quests_13_1.txt` | quests 2158, 2159 | Lv 70 (both: `BaseLevel >
69`) | no 13.1 check of their own.

1. **The Small Fairy** - near Splendide; talk to her (2158).
   Why: a tiny winged girl speaks a tongue nobody in the camp knows.
   `/navi spl_fild02 34/223` | done when: quest 2158 started
2. **The Tree Giant** - in Manuk's fields (2159).
   `/navi man_fild03 236/105` | done when: quest 2159 started
3. **The report** - the Camp Guard Captain, once for each (2158 and 2159
   done).
   `/navi mid_camp 212/237` | done when: quests 2158 and 2159 done
   Reward: 90,000 base EXP for each.
   Note: without the ring their words are gibberish; the Otherworld
   Language (step 2) has you repeat them to the Linguist.

### The Otherworld Language
`quests/quests_13_2.txt` | `ep13_2_rhea` 0->12, 100 | Lv 70 (the fairy and
the giant) | guided `ep13_language` | needs: 13.1 or the Cat Paw passage |
opens: Episode 13.2 (Story), Monster Suppression, the Manuk and Splendide
dailies, Bazett.

1. **A translating device** - the Schwarzwald Mechanic (1), then the
   Arunafeltz Linguist inside the camp building (any answers) (2).
   Why: nobody in the camp understands the Laphine or the Sapha.
   `/navi mid_camp 197/237`, `/navi mid_campin 168/82` | done when:
   `ep13_2_rhea >= 2`
2. **Voices in the wild** - listen to the Small Fairy (`spl_fild02 34/223`)
   and the Tree Giant (`man_fild03 236/105`), then type their lines to the
   Linguist: the fairy `RLGHLRXLA TKANTLFDMS`, `WJACK TNAHRDNJSDMFH`,
   `WLSGHKWND !!`; the giant `TJDTMFJDNS CJFDI`, `TKADLFDMF QKATOS`,
   `EKDTLSDML DLFMADMS..` (a wrong line does not stop you) (3).
   `/navi mid_campin 168/82` | done when: `ep13_2_rhea >= 3`
3. **Mr. Dictionary** - the Linguist again (4); the Rune-Midgarts Magician:
   "Uh, Mr. Dictionary sent..." (5).
   `/navi mid_camp 147/256` | done when: `ep13_2_rhea >= 5`
4. **Two half-buried gems** - "Dig out the Gem" at `spl_fild02 27/218`
   (red) and `man_fild03 227/109` (blue): 1 try in 4, else 10 Thief Bugs jump
   out; bring the Red Jewel and the Blue Jewel to the Magician (6).
   `/navi mid_camp 147/256` | done when: `ep13_2_rhea >= 6`
5. **Back and forth** - the Linguist (7), the Mechanic (8), the Magician
   (9).
   `/navi mid_campin 168/82` | done when: `ep13_2_rhea >= 9`
6. **An unknown mineral** - 1 Unidentified Mineral from a Mysterious Rock
   (`man_fild01 180/170`, `147/157`, `114/174`, `man_fild03 82/134`, ...:
   10 seconds of digging, 1 in 5) to the Magician (10); talk to him until
   the gem is cut (1 in 5) (11).
   `/navi man_fild01 180/170` | done when: `ep13_2_rhea >= 11`
   Fails: the rocks give nothing while the Cat Paw mining wait (quest
   12062) runs.
7. **The Wise King's ring** - the Mechanic: "Give him the Gem" (12); one
   hour of play time later, talk again (100).
   `/navi mid_camp 197/237` | done when: `ep13_2_rhea >= 100`
   Reward: Ring of the Ancient Wise King, 200,000 base EXP (guide).

### Monster Suppression
`quests/quests_13_2.txt` | `ep13_2_days01` 0->2, quests 7074-7075 | Lv
none | needs: the Otherworld Language (100), the ring worn, and 13.2 past 5
(`ep13_mdrama > 5`). Once: nothing resets `ep13_2_days01`.

1. **Manuk Galtun** - "Keep the peace." (1; quests 7074 Rata Hunt and 7075
   Duneyrr Hunt).
   Why: the Manuk guard wants the beasts around the town thinned.
   `/navi manuk 252/116` | done when: `ep13_2_days01 >= 1`
2. **The hunt** - kill 1 Rata and 1 Duneyrr (quest_db counts 1 each), then
   back to him (2).
   `/navi manuk 252/116` | done when: `ep13_2_days01 >= 2`
   Reward: 50,000 base / 30,000 job EXP, 10 Manuk Coin.

### Manuk and Splendide dailies
`quests/quests_13_2.txt` | `ep13_2_dayegg`, `ep13_2_wanted`, quests
7076-7082 | Lv none | every NPC but the Pet Breeder wants the ring worn
and the Otherworld Language (100); the craftsman, the breeder and the sign
also 13.2 past 5 (`ep13_mdrama > 5`). Cooldowns end at the next 4:00
server time (quest_db `TimeLimit: 4h`, a clock time).

1. **Refined Bradium** - the Manuk Engineer: "About collecting stones.",
   "Sure, I don't mind." (7079); bring 20 Refined Bradium (Bradium Golem
   Lv 133, 2.5%; Elusive Bradium Golem 12.5%; Dolomedes) (taken).
   `/navi man_in01 378/276` | done when: quest 7080 (the wait) started
   Reward: 40,000 / 40,000 EXP, 3 Manuk Coin. Again after 4:00.
2. **The Laphine Craftsman** - "May I help you?", "Yes." (7081); bring 15
   Fluorescent Liquid and 15 Crystalized Teardrop (Aqua Elemental Lv 121)
   (taken).
   `/navi spl_in01 97/313` | done when: quest 7082 started
   Reward: 30,000 / 30,000 EXP, 3 Splendide Coin. Again after 4:00.
3. **Draco eggs** - the Pet Breeder: "Cute pet investigation.", "Yes."
   (`ep13_2_dayegg` 1, quest 7077); pick 10 Draco's Egg from the Dragon
   Eggs in Nidhoggur's dungeon (`nyd_dun01 258/134`, `100/210`, `74/68`,
   `98/142`, `244/157`, `59/185`; `nyd_dun02 68/256`, `202/166`,
   `201/166`, ...; each egg comes back after 4 or 7 minutes) and bring them
   (2).
   `/navi mid_camp 146/306` | done when: `ep13_2_dayegg >= 2`
   Reward: 40,000 / 40,000 EXP, 1 Splendide Coin, 1 Manuk Coin. After 4:00
   the breeder asks again ("Sure.").
4. **Wanted: Dandelion** (once) - the Wanted Sign: "I accept that
   request." (`ep13_2_wanted` 1, quest 7076); kill the wanted Dandelion
   member (1); the Pet Breeder: "Notice for criminal report" (2).
   `/navi mid_camp 192/239` | done when: `ep13_2_wanted >= 2`
   Reward: 1 Treasure Box.

### Midgard Ore and Alfheim Perfume
`quests/quests_13_2.txt` | `ep13_2_tre` (Dr. Lifeguard), `ep13_2_tre1`
(Grenouille), quests 2179-2186 | Lv none | needs: the Otherworld Language
(100) and the ring worn | repeatable: each 18 hours after you finish
(quests 2182, 2186, `+18h`).

1. **Dr. Lifeguard's minerals** - the scientist in Manuk: "A chronic
   disease?" (1); talk again: he names a place and lends you a Portable
   Toolbox (2 Mt. Mjolnir: 10 Rough Mineral; 3 Abyss Lake: 5; 4 Thor
   Volcano: 5). Walk the area until "Check current location." finds a
   spot, then "Mine minerals." (1 in 2: 1, 2 or 5 Rough Mineral, else Stone
   Fragments; the spot then rests). Spots: `mjolnir_01 32/309`, `217/34`,
   `mjolnir_02 90/195`, `206/187`, `mjolnir_04 125/380`, `220/130`,
   `mjolnir_09 229/214`, `mjolnir_10 188/260`; `hu_fild05 251/345`,
   `134/322`, `72/104`, `323/84`; `ve_fild03 152/134`, `256/228`,
   `85/189`, `282/268`. Back to him (100).
   `/navi man_in01 372/221` | done when: `ep13_2_tre == 100`
   Reward: 3 Manuk Coin.
2. **Grenouille's flower** - the High Laphine (1); the Middle-Ranked
   Laphine (2, a Sprout); hold the Sprout to a Purifier in Splendide
   (`splendide 160/265`, `262/262`, `262/187`, `164/82`, `171/116`,
   `134/280`) (3, Flower of Alfheim); the High Laphine (4); again (5, 5
   Spirit of Alfheim); give one to each of five Exhausted Soldiers
   (`splendide 205/139`, `181/135`, `139/178`, `164/188`, `177/257`,
   `124/212`, `196/153`); the High Laphine (6).
   `/navi spl_in01 30/324`, `/navi spl_in02 139/65` | done when:
   `ep13_2_tre1 == 6`
   Reward: 3 Splendide Coin.

### Secret Note of Bazett
`quests/quests_13_2.txt` | `ep13_2_busut` 0->7, `ep13_2_bs1`, quests
11101-11105 | Lv none | needs: the Otherworld Language (100) and the ring
worn. Once: the script never resets `ep13_2_busut` after 7.

1. **Bazett Teablack** - "Sure.", "OK, so what can I do for you?" (2);
   talk again (3, Bazett's Order).
   Why: the camp's monster scholar has a secret order for Manuk.
   `/navi mid_camp 283/198` | done when: `ep13_2_busut >= 3`
2. **The Manuk worker** - (`ep13_2_bs1` 2, quest 11105); bring 30 Horn of
   Hillslion (Hillthrion Lv 123, 15%) (taken) (`ep13_2_busut` 4).
   `/navi manuk 193/135` | done when: `ep13_2_busut >= 4`
3. **Report** - Bazett: "Yes." (7).
   `/navi mid_camp 283/198` | done when: `ep13_2_busut >= 7`
   Reward: 1 Manuk Coin.

### Sapha's Visit
`re/quests/quests_dicastes.txt` | `ep13_3_invite` 0->6, quests 7182-7197 |
Lv none | guided `ep13_sapha` | needs: 13.1 or the Cat Paw passage, the
ring worn | opens: Episode 13.3 (Story), Frede's Request, the El Dicastes
requests.

1. **A Sapha in the camp** - Guard Aello (1).
   `/navi mid_campin 93/114` | done when: `ep13_3_invite >= 1`
2. **Vyhannus's invitation** - the Soldier: "I have authorization."; talk
   to the Sapha from Manuk (`mid_campin 168/128`) or his Hound
   (`168/125`) three times (2, 3, 4).
   Why: an envoy of the Sapha king invites you to their capital.
   `/navi mid_campin 111/120` | done when: `ep13_3_invite >= 4`
3. **Captain Avalanche** - in Manuk: "I've come with Vyhannus's
   invitation." (5).
   `/navi man_in01 315/52` | done when: `ep13_3_invite >= 5`
4. **Into El Dicastes** - a Capital City Guard at the gate: "Yes.";
   inside, the Adventurer Clerk: "Register as an adventurer." (6).
   `/navi dic_fild01 146/281`, `/navi dic_in01 42/264` | done when:
   `ep13_3_invite >= 6`
   Reward: the Light Of El Discastes.
   Opens: the Entrance Manager in Manuk (`manuk 321/182`) lets you into
   the tunnel under Kamidal Mountain (`dic_dun01`).

### Frede's Request
`re/quests/quests_dicastes.txt` | `ep13_3_bra` 0->9, quests 11159-11176 |
Lv none | needs: Sapha's Visit (`ep13_3_invite > 5`) and the ring worn.
The six miners are in the Bradium mine (`dic_dun01`, Rose in `dic_dun02`).

1. **Frede** - walk up to him in the city (1).
   Why: a young Sapha worries about the miners his father sent away.
   `/navi dicastes01 117/262` | done when: `ep13_3_bra >= 1`
2. **Inside** - Frede at home (2, a Banana); talk again: "Will do." (4).
   "No can't do." (3) only delays it.
   `/navi dic_in01 165/104` | done when: `ep13_3_bra >= 4`
3. **Six stories** - hear every miner (quests 11159-11164): Brian
   `dic_dun01 205/43`, Tyler `153/107`, John `235/243`, Bain `64/107`, Lash
   `58/225`, Rose `dic_dun02 110/127`; then Frede (5).
   `/navi dic_dun01 205/43` | done when: `ep13_3_bra >= 5`
4. **Bouy** - (6); bring 30 Small Bradium (Dolomedes Lv 132, 15%;
   Dolomedes Ringleader 75%) (taken) (7).
   `/navi dic_in01 349/129` | done when: `ep13_3_bra >= 7`
5. **Wait** - two hours (quest 11175, `+2h`), then Bouy (8).
   `/navi dic_in01 349/129` | done when: `ep13_3_bra >= 8`
6. **Deliveries** - each miner: "You give Bradium to ..." (quests
   11165-11170).
   `/navi dic_dun01 205/43` | done when: quests 11165-11170 started
7. **Frede** - (9).
   `/navi dic_in01 165/104` | done when: `ep13_3_bra >= 9`
   Reward: Bradium Earring.

### El Dicastes requests (the departments)
`re/quests/quests_dicastes.txt` | quests 12099-12158 (requests), 12159-12164
(the day's record) | Lv 80 (Hunting 1: 97, Hunting 2: 100) | needs:
Sapha's Visit at 6 and the ring worn | repeatable: one request from each
citizen a day (until 4:00 server time).

1. **Take a request** - a citizen in the city: "Please give me a request."
   (a random one): Laponte (Hunting 1, kill 1-15 of a New World monster),
   Kalipo (Hunting 2), Pura and Tragis (Supply 1 and 2: Midgard and New
   World items, 1-27), Calyon and Moltuka (Transport 1 and 2: gems,
   monster loot, 2-100 food items).
   `/navi dicastes01 187/230` (Laponte), `175/217` (Kalipo), `208/230`
   (Pura), `225/211` (Tragis), `223/190` (Calyon), `211/178` (Moltuka) |
   done when: the request quest started
2. **Hand it in** - the department manager on the civil service floor: "I
   completed the request." (items taken).
   `/navi dic_in01 48/263` (Hunting 1), `51/266` (Hunting 2), `51/270`,
   `48/273` (Supply), `43/273`, `40/270` (Transport) | done when: the
   request quest erased
   Reward: 4,000-82,800 base EXP by request, 1 Proof Of Sapha's Honor.

### Unknown Relics (the document packages)
`re/quests/quests_dicastes.txt` | quests 12165 (wait), 12166-12215 (one
per relic) | Lv 80 | needs: Sapha's Visit at 6, the ring worn | repeatable.

1. **A document** - open a Document Package in the archive (`dic_in01
   31/192` or `31/187`): 1 time in 7 a dizzy spell (6 hours, quest 12165),
   2 in 7 nothing, else a record of a Midgard item to look for (a quest
   12166-12215).
   `/navi dic_in01 31/192` | done when: a relic quest started
2. **The relic** - search its spot in Midgard (Tree Roots `pay_fild03
   144/95`, Jellopy `prt_fild08 299/332`, Sticky Mucus `prt_fild02 102/97`,
   ... 50 spots, named by the record): 1-4 of that item, and 1 time in 2 an
   Unidentified Relic.
   `/navi pay_fild03 144/95` (one example) | done when: the relic quest
   erased
3. **Papyrus** - the archive keeper trades 3 Unidentified Relic for 1
   Proof Of Sapha's Honor, or 30 for 11.
   `/navi dic_in01 40/193` | done when: (an exchange, no variable)

### Removing Traces (Ahat's daily)
`re/quests/quests_dicastes.txt` | `ep13_3_ahtdayq` 1-2, quests 7200-7201 |
Lv none | needs: Episode 13.3 past 18 (`ep13_3_secret > 18`) | repeatable
(until 4:00 server time, quest 7200).

1. **The Secret Adjutant** - (`ep13_3_ahtdayq` 1, quest 7201).
   Why: Minister Ahat wants the traces of the rift's intruders gone.
   `/navi dic_in01 294/276` | done when: `ep13_3_ahtdayq >= 1`
2. **The traces** - search the Rock Piles, Dirt Piles and Split Earth in
   `dic_fild02` (`269/55`, `215/85`, `194/86`, ... 30 spots) for 10 Solid
   Bloodstain, 10 Frozen Piece Of Skin and 10 Cursed Magical Stone; bring
   them (taken) (2).
   `/navi dic_fild02 215/85` | done when: `ep13_3_ahtdayq == 2`
   Reward: 70,000 base / 30,000 job EXP, 1 Proof Of Sapha's Honor.

### Cat Paw Agent (the passage to the New World)
`re/quests/quests_dicastes.txt` | `ep13_start` 0->100 | Lv 70 (`BaseLevel <
70` refuses) | opens a place: the New World without Episode 13.1;
`ep13_start = 100` counts as 13.1 for most quests here.

1. **Agent Geck** - in the Eden Group's building: "Why don't you collect
   it yourself?", "I also want to go and help the merchants.", type any
   name, "Pay 50,000 zeny." (100; you land on `moc_fild20`).
   Why: the Cat Paw Merchants sneak sponsors across the rift for fish
   money.
   `/navi moc_para01 44/19` | done when: `ep13_start == 100`
2. **The cats** - the Cat on `moc_fild20`: "Let's do this!" (to
   `moc_fild22b`); Tat: "To the other world!" (to the Allied camp).
   `/navi moc_fild20 368/197`, `/navi moc_fild22b 182/179` | done when:
   (a warp, no variable)
   Opens: Agent Geck's "Send me back" any time.

### New Surroundings
`quests/quests_13_1.txt` | `ep13_newbs` 0->24, 100, quests 11084-11100 |
Lv none | needs: 13.1 or the Cat Paw passage. Keep 1,000 weight free.
Diego stands at `mid_camp 266/263` on Renewal (`re/quests/quests_13_1.txt`).

1. **Marian** - "Yes." (1).
   Why: the camp's guide shows newcomers around.
   `/navi mid_camp 222/283` | done when: `ep13_newbs >= 1`
2. **The Instructor** - "Yes." (3). "No." (2) and "Yes." next time.
   `/navi mid_camp 261/284` | done when: `ep13_newbs >= 3`
3. **Register** - Receptionist Brink: "I am here to register." (4); the
   Instructor (5).
   `/navi mid_campin 106/122` | done when: `ep13_newbs >= 5`
4. **Diego's post** - "Help him.", "So how can I help you." (6); bring 20
   Ordinary Branch (the trees on `spl_fild02` `348/76`, `232/145`,
   `380/197`, `304/151`, `183/235`: about 1 click in 9) and 20 Strong Vine
   (Nepenthes Lv 114, 15%; Solid Nepenthes 75%) (taken) (7).
   `/navi mid_camp 266/263` | done when: `ep13_newbs >= 7`
5. **Tie the posts** - the first post: "Tie it with the vines." (1 in 5),
   "Knot it." (8); the second the same (9).
   `/navi mid_camp 267/263`, `/navi mid_camp 267/258` | done when:
   `ep13_newbs >= 9`
6. **Diego** - (10, 5 Chocolate Pie; you are moved inside); walk onto the
   spot you land on (11); Lucas: "Dangerous way?" (12).
   `/navi mid_campin 295/128` | done when: `ep13_newbs >= 12`
7. **Supplies** - the Instructor (13); Marian (14, 3 Supply Box); the
   Instructor (15); one box each to Jan (16), the Instructor (17), Gerard
   (18), the Instructor (19), Alberto in Manuk's field (20), the Instructor
   (21). Lost a box: Marian gives another.
   `/navi mid_camp 160/298` (Jan), `/navi mid_camp 30/168` (Gerard),
   `/navi man_fild01 80/248` (Alberto) | done when: `ep13_newbs >= 21`
8. **The Instructor's friend** - talk until he sighs (1 in 3): "Help." (23,
   Letter from Lugen). "Just listen." (22): "Help him." next time.
   `/navi mid_camp 261/284` | done when: `ep13_newbs >= 23`
9. **Otto** - takes the letter (24, Letter from Otto).
   `/navi mid_camp 123/290` | done when: `ep13_newbs >= 24`
10. **The Instructor** - with Otto's letter (taken) (100).
    `/navi mid_camp 261/284` | done when: `ep13_newbs >= 100`
    Reward: 1 Old Purple Box, 5 Chocolate Pie, 100,000 base / 10,000 job
    EXP.

### Attitude to the New
`quests/quests_13_1.txt` | `ep13_animal` 0->15, 100, quests 2147-2157 | Lv
none | needs: 13.1 or the Cat Paw passage.

1. **The Monster Scholar** - "Who are you?", "How did you get here?", "When
   do you go back?" (1).
   Why: a scared scholar wants to know this world's monsters.
   `/navi mid_camp 188/254` | done when: `ep13_animal >= 1`
2. **Out of the camp** - the Camp Guard at the east gate: "I want to enter
   the next area." (2).
   `/navi mid_camp 336/171` | done when: `ep13_animal >= 2`
3. **Proof** - the scholar with 1 Strong Vine (taken): "Show loot from
   Nepentheses." (3); then 1 Empty Bottle, 5 Holy Water, 30 Sticky Mucus
   (taken) (4).
   `/navi mid_camp 188/254` | done when: `ep13_animal >= 4`
4. **The Botanist** - (5; kill 30 Pinguicula, quest 2150); back (6; kill
   10 Cornus, 2151); back (7, Decaying Stem).
   `/navi mid_camp 240/270` | done when: `ep13_animal >= 7`
5. **Plant it** - walk to `mid_camp 49/154` (8): the Botanist appears;
   plant the stem in the Dirt (9, Sprout); the Botanist (10).
   `/navi mid_camp 52/148` | done when: `ep13_animal >= 10`
6. **Escort** - the scholar: "Okay." (11); walk to `man_fild01 59/261` and
   talk to the Frozen Tree he climbed (12); bring him 5 Horn of Hillslion
   (Hillthrion Lv 123, 15%) (13).
   `/navi man_fild01 92/230` | done when: `ep13_animal >= 13`
7. **Over the bridge** - the scholar (14; kill 10 Tatacho, 2157); type
   `Tatacho`, then anything (15).
   `/navi mid_camp 188/254` | done when: `ep13_animal >= 15`
   Reward: 100,000 base EXP.
8. **A horn** - 1 Horn of Tendrilion (Tendrillion Lv 126, 45%) (100).
   `/navi mid_camp 188/254` | done when: `ep13_animal >= 100`
   Reward: 50,000 base EXP.

### The Tripartite Union's Feud
`quests/quests_13_1.txt` | `ep13_1_rhea` 0->26, 100, quests 8196-8210 | Lv
none | needs: 13.1 or the Cat Paw passage. Keep 3,500 weight free.

1. **The meeting room** - walk up to the Research Official (1).
   Why: the camp's three nations cannot even agree to meet.
   `/navi mid_campin 376/120` | done when: `ep13_1_rhea >= 1`
2. **Ryosen** - talk (2), (3), "Alright." (4, Meeting Invitation).
   `/navi mid_camp 165/245` | done when: `ep13_1_rhea >= 4`
3. **Hue** - "I came to show you this." (5); talk until he agrees (1 in 4):
   "Please sign the invitation." (6).
   `/navi mid_camp 247/255` | done when: `ep13_1_rhea >= 6`
4. **Hansenne** - "Come and look at this." (7); talk until he agrees (2 in
   5): "Hey, just sign this thing." (8).
   `/navi mid_camp 222/218` | done when: `ep13_1_rhea >= 8`
5. **Ryosen** - takes it (9); again (10, the invitation back); the
   Research Official takes it (11).
   `/navi mid_camp 165/245` | done when: `ep13_1_rhea >= 11`
6. **The lost file** - Ryosen: "Can I help you with anything?" (12);
   Hansenne: "I came to pick up the requested document." (13).
   `/navi mid_camp 222/218` | done when: `ep13_1_rhea >= 13`
7. **Fish it out** - at any School of Fish 1 cast in 20 brings the Messy
   File (14): `mid_camp 75/135`, `spl_fild02 314/165`, `spl_fild03
   226/151`, `spl_fild01 41/118`, ... (not while 20 Piece of Fish are
   carried or the Cat Paw fishing wait runs).
   `/navi mid_camp 75/135` | done when: `ep13_1_rhea >= 14`
8. **Hansenne** - (15); Hue (16); bring Hue 1 Folding Fan of Cat Ghost (Mao
   Guai), 1 Old Frying Pan (Magnolia), 1 Flame Stone (the Amatsu Trader
   `prontera 178/244` sells it), 1 Squid Ink (Marse) with the file (taken)
   (17); talk until the report is clean (1 in 4) (18, Neat Report).
   `/navi mid_camp 247/255` | done when: `ep13_1_rhea >= 18`
9. **The meeting** - Ryosen takes the report (19); the Research Official
   (20, you are moved out), (21), (22).
   `/navi mid_campin 376/120` | done when: `ep13_1_rhea >= 22`
10. **Thanks all round** - Hansenne (23), (24, Arunafeltz Desert
    Sandwich); Hue (25, Neat Report, Schwarzwald Pine Jubilee); Ryosen with
    the report (26, Rune Strawberry Cake); the Research Official (100).
    `/navi mid_campin 376/120` | done when: `ep13_1_rhea >= 100`
    Reward: 80,000 base / 3,000 job EXP, 1 First Aid Kit. After it the
    three trade their food for Mystic Horn, Fur or Peaked Hat (an
    exchange).

### Part Time Work
`quests/quests_13_1.txt` | `ep13_alba` 0->6, quests 7042-7047 | Lv none |
needs: 13.1 or the Cat Paw passage | repeatable (5 hours after you finish,
quest 7047 `+5h`).

1. **Breeder Taab** - only while he is hiring: every 130 minutes he calls
   for 10 minutes, 5 places for the whole server. "I'm here for a job." (1-5
   by your place: the first gets job 1).
   Why: his New World beasts need feed.
   `/navi mid_camp 143/306` | done when: `ep13_alba >= 1`
2. **The job** - bring (taken): 1 = 50 Fresh Fish; 2 = 30 Huge Leaf,
   30 Brown Root; 3 = 20 Monster's Feed, 30 Pet Food; 4 = 50 Meat, 30 Pet
   Food; 5 = 30 Fur (6).
   `/navi mid_camp 143/306` | done when: `ep13_alba >= 6`
   Reward: 8,000 base / 3,000 job EXP (job 2: 9,000 / 4,000).
   Note: alone on the server you always get job 1.

### The Cat Paw Trading Post
`quests/quests_13_1.txt` | `ep13_yong1` 0->10, then credit points | Lv none
(the guide's 118+ is a range, not a check) | guided `ep13_catpaw` |
repeatable (fish and minerals once a day, until 4:00 server time) | opens a
place: save point at 3, storage at 20, the Cat Warp to Midgard at 40,
Jotunheim warps at 100.

1. **Cat Paw services** - the Cat Paw Agent: "Tell me more about your
   services." (1); Fluffy Gyaruk: "Yes.", "What do you guys do?", "Yes.",
   "What services do you offer?", "Credit?", "Sure." (2).
   `/navi mid_camp 62/125`, `/navi mid_camp 72/94` | done when:
   `ep13_yong1 >= 2`
2. **The first errand** - the Agent (3, save point); Gyaruk: "What kind
   of things?", "Sure." (4); Ferocious Gorurug: "Gyaruk has sent me.",
   "What should I do?" (5).
   `/navi mid_camp 69/144` | done when: `ep13_yong1 >= 5`
3. **Ten Pieces of Fish** - fish at a School of Fish (`mid_camp 75/135`;
   15 seconds, 1 cast in 4) and bring 10 Piece of Fish (10).
   `/navi mid_camp 69/144` | done when: `ep13_yong1 >= 10`
   Reward: 20,000 base EXP.
4. **More credit** - +1 for 10 Piece of Fish to Gorurug (quest 12060), +1
   for 3 Unidentified Mineral to the Cat Paw Mining Agent (quest 12062),
   each once a day; +2 for each Marlin to Henry Clifford (no wait).
   `/navi mid_camp 88/100` (mining), `/navi mid_camp 66/122` (Henry) |
   done when: `ep13_yong1 >= 40` (the Cat Warp)
   Note: storage costs 60 zeny; the warps 5,500 zeny at 40 credit down to
   3,970 at 300, more towns as the credit grows.

### Report from the New World
`quests/quests_13_1.txt` | `ep13_1_edq` 0->14 (61/62, 71/72, 101-123 on
the way), quests 3085-3094 | Lv none | needs: `ep13_newbs + ep13_ryu +
mao_morocc2 + ep13_1_rhea + ep13_animal + ep13_start > 115` (13.1 or the
passage at 100, plus 16 from the camp quests, e.g. New Surroundings at 16).
Its part from 15 on goes into Nidhoggur's Nest (Story).

1. **Hibba Agip** - (1); Staff Officer Abidal (2); Hibba (3, Expedition
   Report).
   Why: the expedition's report must reach Midgard.
   `/navi mid_campin 90/121`, `/navi mid_campin 94/118` | done when:
   `ep13_1_edq >= 3`
2. **The messenger** - the Expedition Messenger: "Give the report." (4) or
   "Protect the report." (5): either way it is lost; Hibba (61 or 62);
   Abidal (71 or 72).
   `/navi mid_camp 206/286` | done when: `ep13_1_edq >= 71`
3. **The scattered pages** - collect Part of a Report: 1 for each of the
   special monsters on `spl_fild02`, `spl_fild03`, `man_fild01`,
   `man_fild03` (Luciola Vespa, Pinguicula, ...), and 0-5 from an
   Expedition Scout every 30 minutes ("Ask about search results.":
   `man_fild01 315/95`, `man_fild03 202/251`, `spl_fild02 295/368`,
   `spl_fild03 172/71`). Abidal: "Submit found pages." takes 10 for one
   random volume (a wrong roll wastes them, to verify); with Vol 1-4,
   "Check the report's resoration status." (8, Expedition Report).
   `/navi mid_campin 94/118` | done when: `ep13_1_edq >= 8`
4. **Three copies** - Hibba takes it and gives 3 copies (9); deliver one
   each, in any order, to the scout at `spl_fild03 172/71`, Nuria
   (`ra_temple 122/174`) and Gerhart (`lhz_in01 110/174`) (13).
   `/navi ra_temple 122/174` | done when: `ep13_1_edq >= 13`
5. **Hibba** - (14).
   `/navi mid_campin 90/121` | done when: `ep13_1_edq >= 14`
   Reward: 300,000 base EXP, 3 First Aid Kit.

### Pursuing Rayan Moore
`quests/quests_13_1.txt` | `mao_morocc2` 0->31, 100 (then 101-108 for the
sweet potatoes), quests 7012-7041 | Lv none | needs: 13.1 or the passage
(`== 100`). The thieves' hideout `que_job01` is entered at `morocc 45/110`;
the Dandelion hideout `que_dan02` from `yuno_fild09 234/133`.

1. **The pursuit party** - the leader: "Hey, excuse me." (1).
   Why: Rayan Moore, Satan Morroc's follower, fled into the New World.
   `/navi mid_campin 68/185` | done when: `mao_morocc2 >= 1`
2. **Mr. Kidd** - "Echinacea...", "No, I don't mind at all." (4). "Yes."
   (2) sends you to the leader (3) and back to him (4).
   `/navi mid_camp 199/311` | done when: `mao_morocc2 >= 4`
3. **The bar in Morroc** - the Bar Master: "About the mission", "I'm here
   for Rin!" (5); go through the hideout to Rin.
   `/navi que_job01 82/95` | done when: `mao_morocc2 >= 5`
4. **Rin** - "Mr. Kidd sent me." (6), (7); on `hu_fild04` the Heap of
   Earth: "Take a careful look." (8, Crystal Of Feardom); Rin (9, Morocc
   Tracing Log).
   `/navi que_job01 84/17`, `/navi hu_fild04 235/103` | done when:
   `mao_morocc2 >= 9`
5. **Mr. Kidd** - log and crystal (taken) (10); he sends you on; the Corpse:
   "Check his pockets." (11, Sealed Scroll; back to Morroc); walk past
   `mid_camp 205/312` (12); Mr. Kidd (13).
   `/navi que_dan01 49/36` | done when: `mao_morocc2 >= 13`
   Reward (at 10): 20,000 base / 1,000 job EXP.
6. **Defaria's seal** - the leader: "Who?" (14); Defaria: "Got it." (15);
   bring 30 Holy Water, 30 Rune of Darkness (Skogul, Frus), 30 Bloody Rune,
   the scroll (taken) (16); talk until the spell is undone (1 in 3) (17,
   Unsealed Magic Spell).
   `/navi mid_camp 256/272` | done when: `mao_morocc2 >= 17`
7. **The Dandelion hideout** - Mr. Kidd; at the gate: "Enter." (18); Mr.
   Kidd (19); the gate again, then the Man: "Rayan?!" (20, sent to your
   save point).
   `/navi que_dan02 21/37`, `/navi que_dan02 115/53` | done when:
   `mao_morocc2 >= 20`
8. **Rin again** - Mr. Kidd (21, a new crystal and log); in the hideout,
   Rin with both (taken): "Who is this?", then any of the three blows
   (22); she shows you a code (23, 24 or 25).
   `/navi que_job01 144/54` | done when: `mao_morocc2 >= 23`
9. **The code** - the leader: type the code exactly (`SDHF92F-SDF`,
   `VWNM94GVWN90` or `CM3-TRDFGHE0`, the one Rin showed) (29). A wrong code
   (26-28): Rin shows it again.
   `/navi mid_campin 68/185` | done when: `mao_morocc2 >= 29`
10. **Case closed?** - talk to the leader until he moves (1 in 3) (30); the
    Manager (31); the leader (100).
    `/navi mid_camp 191/206` | done when: `mao_morocc2 >= 100`
    Reward: 120,000 base / 20,000 job EXP, 1 Old Purple Box.
11. **Baked sweet potatoes** (optional) - the leader: "Something is
    bothering me..." (101); Defaria: type `Dandelion`, "Just tell me what
    you know.", "I'll do anything for you.", "Yes!", "Sure thing. How
    many?" (102); bring 20 Potato and 30 Log (taken) (103), (104, 2 Yam);
    Mr. Kidd: 2 Yam (105); Defaria (106, 2 Yam); the leader: 2 Yam (107);
    Defaria (108).
    `/navi mid_camp 256/272` | done when: `mao_morocc2 >= 108`
    Reward: 5 Sweet Potato.

Excluded: the Magic Books (skill books), Cat Paw's enchantment.

## 24. Mora and Bifrost (Episode 14.1)

Every quest here is in `re/quests/quests_mora.txt`. The Mistwood Maze
(the Hazy Forest instance, `re/instances/HazyForest.txt`) is entered by the
Laphine Soldier at `bif_fild01 158/340`: "Venture into the Hazy Forest.",
for a party leader (a party of one is enough), again 2 h 30 after each
entry (quest 7211, `+2h30mn`); no level check.

### Helping Lope and Euridi
`ep14_1_rope` 0->11, quests 1109-1117 | Lv 100 (Euridi: `BaseLevel < 100`
refuses) | opens: Knights of the Neighborhood. Bring 30 Lope's Clue: only
Parus (Lv 142, 15% in three drop slots) drops it, and Parus lives in the
Mistwood Maze.

1. **Euridi** - "Yes, I did.", "I'll help you!" (1).
   Why: her beloved Lope never came back from the misty forest.
   `/navi mora 117/66` | done when: `ep14_1_rope >= 1`
2. **Pitt** - (2); Euridi (3).
   `/navi mora 65/145` | done when: `ep14_1_rope >= 3`
3. **The clues** - Pitt with 30 Lope's Clue: "Give it to him." (5 taken)
   (4); Euridi takes the rest (up to 30) (5).
   `/navi mora 65/145` | done when: `ep14_1_rope >= 5`
4. **The ring** - Pitt (6, Lope's Ring); Euridi's Friend (7).
   `/navi mora 115/68` | done when: `ep14_1_rope >= 7`
5. **Lope** - walk up to him on Bifrost's field: "Talk to him." (8); talk
   again (9).
   Why: Lope lives, but the forest has taken his memory.
   `/navi bif_fild01 132/338` | done when: `ep14_1_rope >= 9`
6. **The answer** - Euridi: "Tell her he is dead." (10, the ring taken).
   `/navi mora 117/66` | done when: `ep14_1_rope >= 10`
7. **Her friend** - (11).
   `/navi mora 115/68` | done when: `ep14_1_rope >= 11`
   Reward: 1,000,000 base / 2,000,000 job EXP, 10 Mora Coin.

### Knights of the Neighborhood
`ep14_1_rope` 11->13, quests 1118-1119 | Lv none | needs: Helping Lope and
Euridi (`ep14_1_rope == 11`).

1. **The Knights Head** - "Yes, sir!" (12, quest 1118).
   Why: Mora's self-made knights want to find more of Lope's trail.
   `/navi mora 114/163` | done when: `ep14_1_rope >= 12`
2. **More clues** - 30 Lope's Clue (Parus, the Mistwood Maze) (taken)
   (13).
   `/navi mora 114/163` | done when: `ep14_1_rope >= 13`
   Reward: 1,000,000 base / 1,000,000 job EXP, 2 Mora Coin.
   Opens: the Knights Boss (`mora 116/165`) takes 200 Mysterious Seed for
   1 Mora Coin once a day (until 4:00, quest 1119): an exchange.

### Theore's Request
`ep14_1_bs` 0->19, `ep14_1_bs2` (which fairy), quests 11182-11208 | Lv 100
(Theore) | the Laphines and the fairies want the ring worn. Keep 3,500
weight free for step 10.

1. **Theore** - walk up to him at the camp: "Try talking to him.", "Listen
   to him more.", "Help." (2; quest 11182, a minute).
   Why: a researcher of fairies needs someone the fairies do not flee.
   `/navi mid_camp 148/222` | done when: `ep14_1_bs >= 2`
2. **A minute later** - Theore: "Banned?" (3).
   `/navi mid_camp 148/222` | done when: `ep14_1_bs >= 3`
3. **The bushes** - on `spl_fild02` search the bushes (`79/104`,
   `103/344`, `261/323`, `137/305`, `23/196`, `186/260`): 1 time in 5 a
   fairy jumps out and runs (4-9 by bush). **Note how she looks**. Walk
   over the spot she dropped her pouch (1 in 5): a Small Pocket.
   `/navi spl_fild02 186/260` | done when: `ep14_1_bs >= 4` and the pouch
   held
4. **Theore** - shows him the pouch (quest 11186).
   `/navi mid_camp 148/222` | done when: quest 11186 started
5. **Who was she?** - the Tired-looking Fairy in Splendide: "Show the
   pouch.", "I found it in the bushes.", "I think I saw a fairy that might
   be the owner.", then describe her:
   - Kusmi: "Blonde hair", "Light-skinned", "Grape clothing", "Two pairs
     of wings".
   - Theodore: "Grassy-green hair", "Dark-skinned", "Snow-white clothing",
     "Round wings".
   - Pauchon: "Sea-blue hair", "Dark-skinned", "Grassy-green clothing",
     "Characteristic Wings".
   `/navi splendide 183/117` | done when: `ep14_1_bs2 >= 10` (10 Kusmi, 11
   Theodore, 12 Pauchon)
   Fails: a wrong description only gets "Hmm...": try again.
6. **The owner** - give her the pouch (10); talk again (11); "Supply route
   from the mainland?", "Yes." (12).
   `/navi splendide 119/138` (Kusmi), `304/295` (Theodore), `168/301`
   (Pauchon) | done when: `ep14_1_bs >= 12`
7. **The Laphine Soldier** - (13); the fairy again (14).
   `/navi splendide 262/376` | done when: `ep14_1_bs >= 14`
8. **Mora's warehouse** - the Warehouse Manager: "Supplies for Laphine?"
   (15).
   `/navi mora 185/163` | done when: `ep14_1_bs >= 15`
9. **Jones** - "Yes." (16); again (17, Splendid Supply Kit).
   `/navi mora 55/124` | done when: `ep14_1_bs >= 17`
10. **Daphrer** - the kit (taken) (18).
    `/navi splendide 121/260` | done when: `ep14_1_bs >= 18`
    Reward: 500,000 job EXP, 5 Mora Coin (without the kit: 200,000, 2).
11. **Theore** - (19).
    `/navi mid_camp 148/222` | done when: `ep14_1_bs >= 19`
    Reward: 200,000 job EXP, 5 Mora Coin.

### Find the Research Tools
`ep14_1_muk` 0->15, `ep14_1_goki` (fights), quests 5016-5034 | Lv 100 | the
Raffle Researcher is away from 0:00 to 5:00 server time. The waits run in
real time.

1. **The Raffle Researcher** - "What is your business here?", "... ...",
   then any "Help ..." line (1, quest 5016).
   Why: a creature stole the researcher's tools.
   `/navi mora 31/138` | done when: `ep14_1_muk >= 1`
2. **The Black Shadow** - beat the creature in its menu fight, then "Look
   for the research tools." (Research Tool Bag; a 1-hour wait, quest 5029).
   `/navi mora 114/79` | done when: the bag held
3. **Back** - the bag (taken) (2, 1 Mora Coin; quest 5017); after the hour,
   the Researcher (3).
   `/navi mora 31/138` | done when: `ep14_1_muk >= 3`
4. **Revenge** - beat the Black Shadow three times, an hour apart (4, 5,
   6). The fight's choices: **to verify**.
   `/navi mora 114/79` | done when: `ep14_1_muk >= 6`
5. **Bath water** - the Researcher (7, 10 Empty Test Tube); at the bath
   spots ("Collect samples.": `mora 108/86`, `107/82`, `113/84`, `116/81`,
   `118/86`) fill 10 Bath Water Sample; bring them (8, 1 Mora Coin; quest
   5020, a day).
   `/navi mora 108/86` | done when: `ep14_1_muk >= 8`
6. **A day later** - the Researcher asks for teeth or scales (9, quest 5021
   or 5022); "Look further." at the same spots (1 in 3) for 10 Teeth Sample
   or 10 Scale Sample; bring them (1 Mora Coin; quest 5023, 6 hours); then
   (10, 1 Empty Test Tube).
   `/navi mora 31/138` | done when: `ep14_1_muk >= 10`
7. **The four pools** - on `bif_fild02` "Collect a sample." at a Puddle
   and bring each Sample Of Puddle Research: east `315/285` (11), then
   `65/109` (12), `223/71` (13), `113/340` (14, 4 Mora Coin; quest 5028, 12
   hours). Which puddle is which side: **to verify**.
   `/navi bif_fild02 315/285` | done when: `ep14_1_muk >= 14`
8. **The results** - after 12 hours: "Look at the results." (15).
   `/navi mora 31/138` | done when: `ep14_1_muk >= 15`
   Reward: 1,000,000 base / 4,000,000 job EXP, 30 Mora Coin.
   Extra: after 30 fights the Black Shadow asks you to find its family
   (quests 5030-5034, a fish on Bifrost) for a Fish Pin.

### Chesire's New Day
quests 7206-7210 | Lv none | needs: Episode 13.3 past 22
(`ep13_3_secret > 22`, Story) | repeatable (the box once a day, until 4:00,
quest 7208).

1. **Cheshire** - walk into El Dicastes's 5th floor corridor (`dic_in01
   262/191`), or talk to Cheshire on Bifrost: "Huh? Cheshire?", "Nothing,
   it's just the hood...", "I guess I have no choice." (7206).
   Why: the Cat Paw spy needs a box carried out of the Sapha mine.
   `/navi bif_fild01 335/168` | done when: quest 7206 started
2. **The box** - the Stacked Boxes of Goods in the mine (7207, Bradium
   Box).
   `/navi dic_dun01 274/114` | done when: quest 7207 started
3. **Deliver** - Cheshire: "Why don't you do it yourself?" (box taken)
   (7208).
   `/navi bif_fild01 335/168` | done when: quest 7208 started
   Reward: 1 Proof Of Sapha's Honor.
   Daily: after 4:00 "Move the box." at the boxes (7210) and back to
   Cheshire, 1 certificate. Lost the box: "I lost it..." and bring her 20
   Refined Bradium instead (7209).

### Mora daily quests
quests 12225-12253 | Lv 97 (Elephantine 135) | needs: Episode 14.1 at 10
(`ep14_1_mistwoods >= 10`, Story) | repeatable: one task from each giver a
day (until 4:00 server time).

1. **Hunting** - Elephantine: "Tell me about today's task." gives one hunt
   (3 Pom Spider, 4 Angra Mantis, 5 Parus, 6 Little Fatum or 7 Miming);
   Hotcha: "I have completed a task.".
   `/navi mora 133/80`, `/navi mora 115/98` | done when: the hunt quest
   erased
   Reward: job EXP by job level (none from Job 50 at Lv 100+), 3 Mora Coin.
2. **Items 1** - Bow-wow gives one: 4 Insect Feeler, 5 Immortal Heart, 1
   Rotten Bandage, 3 Orcish Voucher or 3 Skel-Bone; the General Goods
   Dealer takes it: "I have completed a task.".
   `/navi mora 119/103`, `/navi mora 119/118` | done when: the request
   erased
   Reward: job EXP by job level, 1 Mora Coin.
3. **Items 2** - Woof-grrr: 2 Memento, 3 Shell, 3 Scale Shell, 2 Venom
   Canine or 5 Sticky Mucus; the Commodities Dealer takes it.
   `/navi mora 124/108`, `/navi mora 127/112` | done when: the request
   erased
   Reward: job EXP by job level, 1 Mora Coin.
4. **Missing people** - the Soul Guide names one of ten lost villagers;
   find their remains in the Mistwood Maze (`1@mist`: Tazaar `132/100`,
   Naizar `102/242`, Meshir `145/245`, Noirit `196/276`, Pajama God
   `304/327`, Mendel `334/287`, Milebit `330/177`, Kunmun `284/84`,
   Tsaihokin `170/54`, Tuar `118/43`).
   `/navi mora 170/101` | done when: the search quest erased
   Reward: 2-7 Mora Coin and a random item from the remains.

## 25. Eclage (Episode 14.2)

Every quest here is in `re/quests/quests_eclage.txt`. Light and Darkness
and Encounter in a Strange Land are Episode 14.2 (Story). Not a quest: the
Teleport Cats (Cat Paw Addition 14.2) carry you along the New World for
Malangdo Canned Specialties or zeny, no condition (see "Entrances without
a quest").

### Eclage's Entrance
`ep14_2_oliver` 0->3, quests 11310-11311 | Lv none | guided `ep14_eclage`
| opens a place: Eclage.

1. **The forms** - a Security Guard at the gate: "Fill out the forms.",
   type anything in each of the three boxes (1).
   Why: the Laphine city lets no stranger in without paperwork.
   `/navi ecl_fild01 94/322` | done when: `ep14_2_oliver >= 1`
2. **Immigration** - wait half a minute, then the Immigration Officer (2).
   `/navi ecl_fild01 111/320` | done when: `ep14_2_oliver >= 2`
   Fails: too soon and he only cries: talk again a little later.
3. **Through the gate** - the Security Guard (3, into Eclage).
   `/navi ecl_fild01 94/322` | done when: `ep14_2_oliver >= 3`

### Oliver Wolf Hood (Dreaming Time)
`ep14_2_oliver` 3->30, quests 11312-11337 | Lv 120 (the Fairy Carpenter) |
needs: Eclage's Entrance | opens: Laphines That Love the Land (at 5).

1. **The broken bridge** - the Fairy Carpenter at the city's entrance:
   "Give help." (4).
   Why: the bridge into Eclage is broken and the carpenter is stuck.
   `/navi eclage 102/32` | done when: `ep14_2_oliver >= 4`
2. **His sum** - "What if you use magic to repair it?", then type `002`
   (what the script accepts) (5).
   `/navi eclage 102/32` | done when: `ep14_2_oliver >= 5`
3. **Leaf wood** - Golie by the keepers' tower (6, 2 Leaf Made Wood); the
   carpenter takes them (7).
   `/navi ecl_fild01 192/94` | done when: `ep14_2_oliver >= 7`
4. **Glaces' birthday** - Glaces (8); Yube: "Share Glaces' story." (9);
   Glaces: "Then what's Glaces' age?" (10); Murah (11); Shul (12); Tato:
   "What's Tato's age?" (13).
   `/navi eclage 283/275` (Glaces), `191/200` (Yube), `/navi ecl_in01
   73/51` (Murah), `/navi eclage 265/166` (Shul), `137/169` (Tato) | done
   when: `ep14_2_oliver >= 13`
5. **The riddle** - Yube: type `128` (14).
   `/navi eclage 191/200` | done when: `ep14_2_oliver >= 14`
6. **Candles** - bring Yube 128 Dustball (Cenere Lv 146, 12.5%; Solid
   Cenere 62.5%; Green Cenere 50%) (15, 128 Birthday Candle; "Make the
   candles." makes fewer if you lost some); Glaces takes the 128 candles
   (16).
   `/navi eclage 191/200`, `/navi eclage 283/275` | done when:
   `ep14_2_oliver >= 16`
7. **The feather** - Moreng: "Yes, I am." (17), (18); the Old Man: "Yes, I
   have." (19); the Traveler at the gate (20); the Sack Merchant: "Talk
   about the feather." (21); Moreng (22); Glaces (23).
   `/navi eclage 266/216`, `/navi ecl_in01 60/71`, `/navi ecl_fild01
   97/315`, `/navi ecl_in01 70/88` | done when: `ep14_2_oliver >= 23`
8. **Yube's house** - door at `eclage 292/265`; Yube inside (24, 25); the
   Delivery Man (26); Yube (27).
   `/navi ecl_in04 182/224`, `/navi ecl_in01 44/53` | done when:
   `ep14_2_oliver >= 27`
9. **Oliver** - 1 Pile Of Acorn (Petal Lv 141, 30%) (taken) (28).
   `/navi ecl_in04 179/226` | done when: `ep14_2_oliver >= 28`
10. **Du Lian** - walk back in through Yube's door (29); Du Lian (30).
    `/navi ecl_in04 226/231` | done when: `ep14_2_oliver >= 30`
    Reward: Oliver Wolf Hood.

### Laphines That Love the Land (Lost Adventurers)
`ep14_2_nines` 0->6, quests 13050-13066 | Lv 100 (Fili: `BaseLevel < 100`)
| guided `ep14_nines` (steps 1-3) | needs: Oliver Wolf Hood past 4
(`ep14_2_oliver > 4`, Fili checks it before he starts) | repeatable: Fili's
two rounds and New Oz's three errands once a day after 3 and 6 (until 4:00
server time).

1. **Fili** - "See what kind of work it is." (1).
   Why: the Laphine by the keepers' tower worries about everyone.
   `/navi ecl_fild01 190/93` | done when: `ep14_2_nines >= 1`
2. **The four gardeners** - the Singing (`222/290`), Watering (`83/263`),
   Dancing (`163/196`) and Cute (`237/181`) Laphines, one answer each; Fili
   (2).
   `/navi ecl_fild01 222/290` | done when: `ep14_2_nines >= 2`
   Reward: 300,000 base / 300,000 job EXP, 1 Splendide Coin.
3. **Lost adventurers** - Fili: "I'll do it! I'm an adventurer, too!";
   Euncheong (`ecl_tdun01 11/62`), Rosi (`ecl_tdun02 99/63`), New Oz
   (`ecl_tdun03 68/80`: "I'm here to see if you're doing okay."); Fili:
   "The adventurer on the third floor is starving!" (3).
   `/navi ecl_fild01 190/93` | done when: `ep14_2_nines >= 3`
   Reward: 300,000 / 300,000 EXP, 10 Meat, 1 Splendide Coin.
4. **New Oz's food** - 10 Meat and 10 Pile Of Acorn (taken) (4).
   `/navi ecl_tdun03 68/80` | done when: `ep14_2_nines >= 4`
5. **Dusting off** - kill 20 Cenere (quest 13063); New Oz: "Loots from
   local monsters" at each question (5).
   `/navi ecl_tdun03 68/80` | done when: `ep14_2_nines >= 5`
6. **Souvenirs** - 20 Leaf Bookmark (Antique Book Lv 148, 12.5%) (taken)
   (6).
   `/navi ecl_tdun03 68/80` | done when: `ep14_2_nines >= 6`
   Reward each of steps 4-6: 300,000 / 300,000 EXP, 1 Splendide Coin.

### Wanted to Be Big and Beautiful
`ep14_2_big` 0->26, quests 14118-14141 | Lv 120 (Wuhari).

1. **Wuhari** - "Of course!", "Sure.", "Just because." (1); talk again (2,
   Younger Bro Letter).
   Why: a small Laphine wants to grow big, like her brother promised.
   `/navi eclage 282/255` | done when: `ep14_2_big >= 2`
2. **Wuhuru** - talk until he takes the letter (3, 4, 5, 6), then (7).
   `/navi ecl_in02 149/117` | done when: `ep14_2_big >= 7`
3. **Wuhari** - "Do you have any complaints?", "Sure thing." (8); "Well, I
   can help you." (9).
   `/navi eclage 282/255` | done when: `ep14_2_big >= 9`
4. **Asking around** - Masione: "Um, about Wuhuru..." (10); Goatie: "I came
   after talking with Masione...", "I wanted to ask you about Wuhuru." ...
   (11); Svery: "I was wondering about the paper that Wuhuru was
   holding.", "Wuhari asked me a favor." (14, Stained Research Book).
   `/navi eclage 200/272`, `163/228`, `170/195` | done when:
   `ep14_2_big >= 14`
5. **The book** - Wuhari: "They told me to give this to you." (taken)
   (15); five minutes later (quest 14131): "Your brother's physique
   was...", "Shall I look for that Laphine?" (17). "That's seems too
   uncertain." (16), then "It's important to help others." (17).
   `/navi eclage 282/255` | done when: `ep14_2_big >= 17`
6. **The high-level Laphine** - Svery: "Who's the high-level Laphine?"
   (18); Goatie (19); Pompe: "I was sent by Goatie...", "A corpse?" (20).
   `/navi eclage 170/195`, `163/228`, `126/151` | done when:
   `ep14_2_big >= 20`
7. **Giranni** - in the fields (21); the Laphine corpse (22, Piece Of
   Lapine Wing); Giranni takes the wing (23).
   `/navi ecl_fild01 70/285`, `/navi ecl_fild01 269/165` | done when:
   `ep14_2_big >= 23`
   Reward: 100,000 base EXP, 1 Old Purple Box.
8. **Wuhuru** - "I saw a dead corpse of a Laphine in the field.", "Did you
   murder him out of anger?" (24); Wuhari (25).
   `/navi ecl_in02 149/117` | done when: `ep14_2_big >= 25`
9. **The ingredients** - Giranni: "I need a piece of your father's wing."
   (Piece Of Lapine Wing); the corpse again (Firm Hair); bring Wuhari 1 each
   of Piece Of Lapine Wing, Firm Hair, Karvodailnirol (Remover Lv 121,
   0.5%), Refined Bradium, Rune of Darkness, Bloody Rune: "I brought them
   all." (taken) (26).
   `/navi eclage 282/255` | done when: `ep14_2_big >= 26`
   Reward: 300,000 base EXP, 5 Splendide Coin.

### The Mystery Burglary
`ep14_2_detect` 0->15, quests 9225-9262 | Lv 120 (`BaseLevel >= 120` at
the house). Daughter Luen's house: door `eclage 156/56`, inside `ecl_in04`.

1. **A noise** - walk past `eclage 156/51` (1); inside, walk up to the
   family (2); Mother Rosa (3); the spot again (4).
   Why: Luen's family was robbed while they slept.
   `/navi ecl_in04 81/106`, `/navi ecl_in04 77/104` | done when:
   `ep14_2_detect >= 4`
2. **Clues** - search the house (Poppy `85/104`, the Messy Bookshelves
   `80/112`, the Damaged book `78/111`, the Soda can container `83/111`,
   the messed up table `76/107`, the foreign substance `80/105`); Luen
   (5).
   `/navi ecl_in04 78/108` | done when: `ep14_2_detect >= 5`
3. **The suspects** - Cruyan (6, a Center Potion); Balumin at the gate (7);
   the Wandering Merchant (8); Luen (9: everyone meets in the house).
   `/navi eclage 164/102`, `/navi ecl_fild01 98/299`, `/navi eclage
   222/131` | done when: `ep14_2_detect >= 9`
4. **Name the robber** - Luen in the meeting room: "Now I will track down
   the robber.", "Cruyan", "To gain permission to date Luen", "I'm afraid
   that's not true.", "According to Balumin's statements...", "Look
   through his possessions." (10).
   `/navi ecl_in04 208/194` | done when: `ep14_2_detect >= 10`
   Fails: a wrong suspect or reason: "I must have gotten something wrong."
   and start over.
5. **Thanks** - Luen (11), Father Dames (12), Mother Rosa (13), Cruyan
   (14), Balumin (15).
   `/navi ecl_in04 78/108`, `85/110`, `77/104`, `/navi eclage 164/102`,
   `/navi ecl_fild01 98/299` | done when: `ep14_2_detect >= 15`
   Reward: 300,000 base / 150,000 job EXP from each, and 1 Splendide Coin
   (Luen), 1 Yggdrasil Berry (Dames), 1 Splendide Coin and 1 Yggdrasil
   Berry (Rosa), 1 Yggdrasil Seed (Cruyan), 20 Pile Of Acorn (Balumin).

### Troublesome Fairies (Prankster of Eclage)
quests 4254-4265 (no variable) | Lv 120 (each fairy).

1. **Eirinn's stomach** - "Sure!" (4254); "Give Herbs": 10 Green Herb
   (taken).
   `/navi ecl_in02 160/36` | done when: quest 4254 done
   Reward: 100,000 base EXP, Snow Flip, Peony Mamy, Slapping Herb,
   Yggdrasil Dust.
2. **Bourbon's revenge** - "Sure!" (4255: kill 20 Menblatt); back to him.
   `/navi ecl_in03 175/69` | done when: quest 4255 done
   Reward: 100,000 base EXP, 2 Splendide Coin.
3. **Cecilia** - "What are you doing?", "Fine." (4256); 10 Pile Of Acorn,
   10 Worn Out Page, 10 Mould Powder (taken).
   `/navi ecl_in01 26/88` | done when: quest 4256 done
   Reward: 300,000 base EXP.
4. **The conspiracy** - with 4254 and 4255 done: Cecilia (4257); Eirinn
   and Bourbon (4258, 4259); Cecilia (50,000 base EXP).
   `/navi ecl_in01 26/88` | done when: quest 4257 done
5. **Dominic** - walk up to him: "Cecilia says..." (4260); Cecilia: "Tell
   Cecilia about Dominic." (100,000 base EXP; the bookshelves open, 4265).
   `/navi ecl_in01 80/77` | done when: quest 4260 done
6. **Counterattack** - Eirinn: "Sure!", 1 Stem and 1 Green Herb (Weeds);
   the spot by Dominic's desk: "Do it." (300,000 base EXP).
   `/navi ecl_in01 79/84` | done when: quest 4262 done
7. **Counteroffensive** - Bourbon: "Sure!", 2 Rat Tail (Tiny Mouse Tail);
   Dominic: "Yes." (300,000 base EXP).
   `/navi ecl_in01 80/77` | done when: quest 4264 done

### Memory of Professor Worm
`ep14_2_profe` 0->12, quests 1214-1228 | Lv 120 | **dead end** at step 3,
see guide-deferred.md.

1. **Professor Worm** - in the tower's top floor: "What are you doing
   here?", "I want to know about the tower.", then "Why should I!" (1).
   Menu path: **to verify**.
   Why: a professor turned into a worm has lost his memory.
   `/navi ecl_tdun04 26/39` | done when: `ep14_2_profe >= 1`
2. **Around him** - walk near `ecl_tdun04 21/41` until something comes
   back to him (2).
   `/navi ecl_tdun04 21/41` | done when: `ep14_2_profe >= 2`
3. **His memories** - "I'll bring them back for you." (3); he wants 20
   Star Shape Mushroom: no monster drops it and no shop sells it in
   rathena-pin. Dead end, see guide-deferred.md. (After it: the Diary Frogs
   No. 3, 6 and 30 and 1,100,000 base / 700,000 job EXP.)
   `/navi ecl_tdun04 26/39` | done when: `ep14_2_profe >= 3`

## 26. Flame Basin (Episode 14.3)

Every quest here is in `re/quests/quests_14_3_bis.txt`, at the allied base
in `moro_vol`; Dimensional Travel (`ep14_3_newerabs`) is Episode 14.3
(Story). The Temple of the Demon God (`re/instances/TempleOfDemonGod.txt`)
is entered by Guardian Nidhogg at `moro_cav 41/73` as a party leader (a
party of one counts). Every daily below ends at the next 4:00 server time
(quest_db `TimeLimit: 4h`).

### Flame Basin dailies (Instructor Igrid and Adjutant Abidal)
quests 7581-7582, 7594, 7599 | Lv 140 (Igrid), 160 (Abidal) | repeatable.

1. **Eliminating Risks** - Instructor Igrid: "Sure." (7581): kill the three
   Morroc vassals that appear in the basin (Morocc Twisted Vassal near
   `moro_vol 278/238`, Fire Vassal near `292/131`, Cold Vassal near
   `216/245`); back to him (7582).
   `/navi moro_vol 111/87` | done when: quest 7582 started
   Reward: 1,000,000 base / 800,000 job EXP.
2. **Frost Spider and Fire Wolf** - with Demon God Subjugation taken:
   Adjutant Abidal: "Accept." (7594): kill 1 Brinaranea and 1 Muspellskoll
   in the Temple of the Demon God; back to him (7599).
   `/navi moro_vol 110/90` | done when: quest 7599 started
   Reward: 1 Expedition Award Box.

### Magic Scholar and Hishieh
quests 7583-7584, 7595, 7600 | Lv 140 (the scholar), 160 (Hishieh) | needs:
Episode 14.2 at 33 (`ep14_2_mylord`), and for the scholar Eliminating
Risks taken | repeatable.

1. **The scholar's apology** - at `ep14_2_mylord == 33`: "Why are you
   here?" (34).
   `/navi moro_vol 98/107` | done when: `ep14_2_mylord >= 34`
2. **Collecting Mana** - the Magic Scholar (7583): 3 Mana Crystal from the
   basin's monsters (quest drop); back to him (7584).
   `/navi moro_vol 98/107` | done when: quest 7584 started
   Reward: 350,000 base / 350,000 job EXP.
3. **Wandering Orb Magic** - with Demon God Subjugation taken: Hishieh:
   "Gladly." (7595): kill 3 each of the white, red and yellow mana in the
   Temple of the Demon God; back (7600).
   `/navi moro_vol 95/108` | done when: quest 7600 started
   Reward: 1 Expedition Award Box, 1,000,000 base / 500,000 job EXP.

### Jeruth Hesranta
`ep13_3_secret` 24->27, quests 7578-7580 | Lv 140 (from 25) | needs:
Episode 13.3 at 24 (Story) | closes: Removing Traces (Ahat's daily, region
23): his first talk sets `ep13_3_ahtdayq` to 0 | repeatable from 27.

1. **The Sapha envoy** - "Why are you here?" (25).
   `/navi moro_vol 136/84` | done when: `ep13_3_secret >= 25`
   Reward: 1 Proof Of Sapha's Honor.
2. **Rampaging Box** - "What suspicion?", "You're concerned?", "And
   retrieve the stolen Bradiums as well." (26; 7578: kill 1 Angry Mimic,
   it drops a Bradium Box); bring the box: "When do I start?" (27).
   `/navi moro_vol 136/84` | done when: `ep13_3_secret >= 27`
   Reward: 300,000 base / 300,000 job EXP.
3. **Collecting Bradiums** (daily) - "I'll get on with it." (7579): 10
   Angry Mimic and 10 Bradium Box (taken) (7580).
   `/navi moro_vol 136/84` | done when: quest 7580 started
   Reward: 800,000 / 800,000 EXP, 1 Proof Of Sapha's Honor.

### Demon God Subjugation / Fall of the False God / Caged God
quests 7593, 7596-7598 | Lv 160 | needs: Morse's Cave done
(`ep14_3_mors01`, the memorial `re/instances/MorseCave.txt`, which needs
`ep14_3_isle`) | opens a place: the Temple of the Demon God (instance) |
repeatable.

1. **Commander Hibba Agip** - "I'll do it." (7593: defeat the Demon God's
   apostle in the Temple).
   Why: Satan Morroc's last body waits in a hidden temple.
   `/navi moro_vol 108/88` | done when: quest 7593 started
2. **The Temple** - Guardian Nidhogg at the cave enters it; beat the
   Demon God (7597 Fall of the False God).
   `/navi moro_cav 41/73` | done when: quest 7597 started
3. **Report** - Hibba Agip (7598, the wait; first time also
   `ep4_3_mockill` 1).
   `/navi moro_vol 108/88` | done when: quest 7598 started
   Reward: 1 Expedition Award Box, 1,000,000 base / 500,000 job EXP; the
   first time also a Darklord Soulpiece.
4. **Nidhogg's gift** (once) - Guardian Nidhogg in the base: "Give the Soul
   Shard." (`ep4_3_mockill` 2): an EXP blessing for everyone on the server
   for an hour.
   `/navi moro_vol 94/110` | done when: `ep4_3_mockill >= 2`

### Flaming Basin and Doom Prayers
`ep14_3_fall_bless` 0->13, quests 1264-1275, 1297 | Lv 150 (the
investigator).

1. **The Base Investigator** - "Do you want me to do it?", "Do you want me
   to hunt Fire Condors?", "Got it." (1); bring 15 Burning Feather (Fire
   Condor Lv 141, 20%) (taken) (2).
   Why: something blesses the basin's monsters, and nobody knows what.
   `/navi moro_vol 131/103` | done when: `ep14_3_fall_bless >= 2`
2. **The scout** - "Let's go back with me.", "It does." (3); bring 20
   Patrol Log (Fire Sandman, 20% while quest 1266 runs) (4).
   `/navi moro_vol 234/301` | done when: `ep14_3_fall_bless >= 4`
   Fails: walking onto the camp spots around `moro_vol 227/294` with logs
   takes 2-3 of them and calls 3 Fire Sandmen.
3. **Hunt** - the investigator: "I'll do my best." (5; kill 20 Fire
   Sandman and 20 Fire Frilldora); back (6).
   `/navi moro_vol 131/103` | done when: `ep14_3_fall_bless >= 6`
   Reward: 100,000 job EXP.
4. **The Doom Prayers** - their leader: "What god do you serve?", ... "I'll
   collect the stones." (7); 40 Stone Of Blessing (Fire Golem Lv 148, 20%)
   (8); "I'll collect Monster Bloods." (9); 30 Monster Blood (Fire Sandman,
   Fire Frilldora, 15%) (10).
   `/navi moro_vol 91/197` | done when: `ep14_3_fall_bless >= 10`
5. **The second-in-command** - "I'll bring them." (11); 30 Golem's Fiery
   Stone Tooth and 30 Frilldora's Fiery Nape (taken) (12).
   `/navi moro_vol 95/195` | done when: `ep14_3_fall_bless >= 12`
6. **The leader** - (13).
   `/navi moro_vol 91/197` | done when: `ep14_3_fall_bless >= 13`
   Reward: 2,000,000 base EXP.

## 27. Verus and the Phantasmagorika (Episode 15)

Story: Episode 15 (`ep15_1_atnad`, the Atnad excavation). Every daily here
ends at the next 4:00 server time (quest_db `TimeLimit: 4h`). Not quests:
the Reward Coordinator (`morocc 54/190`) and the Doom Prayers event on
`verus04`.

### The Wandering Bard
`re/quests/quests_15_1.txt` | quests 4295-4302 | Lv 99 | guided `ver_bard`
| needs (one story each): the Cursed Spirit (`lhz_curse >= 31`), the
President (`lhz_boss >= 43`), Juperos Ruins History (`yuno_hist >= 10`),
Metto (`metto_q >= 9`), the Biological Weapon (`hg_bio >= 9`), the Odin
Temple Excavation (`hg_odin >= 60`); his own quest (4295) wants all six.

1. **A song for a story** - he tells one of the six (quest 4297-4302:
   Some Corporation, The President, a Scholar in Juno, a Mad Scientist,
   Hugel, Odin Temple).
   `/navi verus03 129/21` | done when: one of 4297-4302 started
2. **The ending** - with that quest done, talk to him (its quest done;
   quest 4296 Take a Break, until 4:00). Not done yet: "Return the
   quest." and talk again for another (Some Corporation also costs the
   wait).
   `/navi verus03 129/21` | done when: that story's quest done
3. **All six** - the sixth story ends his own quest (4295).
   `/navi verus03 129/21` | done when: quest 4295 done
   Reward: 5 Field Manual.
   Note: Juperos Ruins History needs the four Transparent Plates (very
   rare drops, see guide-deferred.md).

### The Verus Police
`re/quests/quests_15_1.txt` | `ep15_1_mang` (counts), quests 5304-5318 | Lv
140 (Kesler) | repeatable (once a day, quest 5318).

1. **Police Chief Kesler** - "Is there anything I can do to help?",
   "Sure." (5309).
   Why: four officers have more trouble than they can handle.
   `/navi verus04 133/212` | done when: quest 5309 started
2. **The four officers** - talk to each (5310-5313); each offers a
   request:
   - Salgran (`verus03 36/113`): kill 10 Illegal Promotion (5314).
   - Gerev (`verus03 116/36`): "Examine." 10 cracks in the old city
     (`verus03 127/36`, `119/17`, `163/33`, ...; 1 time in 2) (5315).
   - Seiden (`verus03 81/241`): "Pick it up." 10 Stone at the same cracks
     (5316).
   - Piffs (`verus04 202/258`): 10 Collected Medicinal Herbs from the
     Thickets (`verus04 187/219`, ...) (5317).
   `/navi verus03 36/113` | done when: quests 5310-5313 started
3. **Report** - Kesler (5318).
   `/navi verus04 133/212` | done when: quest 5318 started
   Reward: 200,000 base EXP, plus 200,000 for each request done.
   Exchange: Token Of Destruction for Packed Envelopes (not a quest).

### New Power Source
`re/quests/quests_15_1.txt` | quests 7628-7629 | Lv none | needs: Episode
15 past 16 (`ep15_1_atnad > 16`, Story) | repeatable (until 4:00, 7629).

1. **Machinist Lloyd** - "Sure." (7628).
   Why: the cat machinist needs energy for his machines.
   `/navi verus03 103/177` | done when: quest 7628 started
2. **Condensed energy** - at the Machine Remnant, 1 Empty Bottle gives 1
   Condensed Energy; bring 10 (taken) (7629).
   `/navi verus03 127/145` | done when: quest 7629 started
   Reward: 150,000 base / 1,000,000 job EXP.

### To Phantasmagorika! / Looking for the Traces
`re/quests/quests_15_1.txt` | `ep15_1_elb` 0->15, quests 11363-11376 | Lv
none | needs: Episode 15 at 4 (`ep15_1_atnad >= 4`) | opens: Vestige (at
15).

1. **Guide Elisha** - at the excavation camp on `yuno_fild07`: "Ask for
   directions." (1, 11363).
   Why: the Phantasmagorika troupe wants to see the old city of Verus.
   `/navi yuno_fild07 216/157` | done when: `ep15_1_elb >= 1`
2. **Leitner** - in Lighthalzen: "Ask about the registration process." (2,
   11364).
   `/navi lhz_in01 75/209` | done when: `ep15_1_elb >= 2`
3. **Elisha** - "Say your name." and "Yes." (3, 11365).
   `/navi yuno_fild07 216/157` | done when: `ep15_1_elb >= 3`
4. **Guide Scarlet** - in Verus (4, 11366); bring 30 Used Iron Plate (Old
   Stove Lv 92, 19%; Dimik 10%): "Push in Used Iron Plates." (5); then
   "Say your name.", "Yes" (6, 11367).
   `/navi verus04 119/220` | done when: `ep15_1_elb >= 6`
5. **The troupe's traces** - follow them through `verus04`: the Fountain
   (`116/226`, 7), the Sundries (`95/238`, 8), the Tree (`79/249`, 9), the
   Signboard (`62/255`, 10); then in `verus03`: Du (`46/23`, 11), the
   Fountain (`44/65`, 12), Mark (`88/237`, 13), Tamarin (`51/256`, 14),
   Maggi (`35/254`, 15).
   `/navi verus04 116/226` | done when: `ep15_1_elb >= 15`
   Reward: 1,000,000 base EXP.

### Monthly Brigan
`re/quests/quests_15_2.txt` | `ep15_2_brigan` 0->8, quests 13195-13205 | Lv
none | needs: Episode 15 at 19 (`ep15_1_atnad >= 19`) | repeatable from 8.

1. **Krotzel** - (1); "Look for Probationary reporter" (2).
   Why: the Brigan's journalists went missing in the ruins.
   `/navi verus02 79/31` | done when: `ep15_2_brigan >= 2`
2. **The three journalists** - the Lame Journalist (3), Krotzel (4), the
   Photo Journalist (5), Krotzel (6), the Exhausted Journalist (7),
   Krotzel (8).
   `/navi verus01 172/146`, `/navi verus02 134/169`, `/navi verus01
   41/103` | done when: `ep15_2_brigan >= 8`
   Reward: 1,500,000 base / 1,000,000 job EXP.
3. **Dailies** - each until 4:00: Krotzel "Look for team members" (13198);
   Trapp (the Lame Journalist): "Help Rookie reporter Trapp", kill 30
   Green Cenere (13200); Sunny Kim (the Photo Journalist): kill 30 Repair
   Robot Turbo (13202); Grylls (the Exhausted Journalist): 30 Iron Worm
   (13204).
   `/navi verus02 79/31` | done when: the "Complete" quest started
   Reward: 1,000,000 base / 500,000 job EXP each.

### The Bunker: Restriction on the Journey
`re/quests/quests_15_2.txt` | `ep15_2_memory`, quests 5341-5370 | Lv none |
needs: **to verify** (the bunker `un_bunker` is reached from Verus) |
repeatable: each of the five jobs again 22 hours after you take it.

1. **The Mysterious Device** - in the bunker: "Pull it" takes you into a
   memory of the bunker (`un_bk_q`) for the job that is running: the head
   count (Bunker Sayhu `un_bk_q 103/147`, 5341), the air purifiers
   (Mechanician Mugeosi `56/286`, 5351: Air Cleaner Boxes to zones C-0,
   F-1, F-2, I-0, Z-0), the grape harvest (Bioengineer Ebrik `220/350`,
   5358: Fresh Grapes), the hysterical patients (Nurse Lapplad `276/243`,
   5363), the transport (Executive Ernon `279/294`, 5366).
   `/navi un_bunker 103/95` | done when: the job's quest done
   How a job is started, its menus and rewards: **to verify**.

### Vestige / The Final Room
`re/quests/quests_15_2.txt` | `ep15_2_bslast` 0->9, `ep15_2_bsmemo` 0->16,
quests 11380-11389 | Lv none | needs: Episode 15 at 19 and To
Phantasmagorika! at 15 (`ep15_1_elb >= 15`).

1. **Du** - in Verus (1, 11381); the Fruit (2, 11382).
   Why: the troupe's Du remembers a bunker under the city.
   `/navi verus01 221/65`, `/navi verus01 151/173` | done when:
   `ep15_2_bslast >= 2`
2. **The bunker** - Mark at its entrance (3), Alph (`un_bunker 363/171`,
   4), Alph again (`388/86`, 5).
   `/navi un_bunker 100/96` | done when: `ep15_2_bslast >= 5`
3. **The mystery** - Verity (`un_myst 27/208`, 6); the hall: Du
   (`100/190`, 7); (8).
   `/navi un_myst 27/208` | done when: `ep15_2_bslast >= 8`
4. **The weird pieces** - the three pieces (`un_myst 333/206`, `182/137`,
   `214/86`) in order (`ep15_2_bsmemo` 1->16), then Tamarin at the last
   room's door (9, 11389).
   `/navi un_myst 209/42` | done when: `ep15_2_bslast >= 9`
   The pieces' menus and the final room: **to verify**.

## 28. Rock Ridge

Every quest here is in `re/quests/quests_rockridge.txt`. Standalone: no
episode variable. The town's quests all wait for the main line
(`rock_main_quest == 22`) and are dailies (until 4:00 server time, quest_db
`TimeLimit: 4h`); most pay Rock Ridge Coins.

### Rock Ridge, Land of Opportunities (main line)
`rock_main_quest` 0->22, quests 7790-7809 | Lv 100 (Karam Pucci) | opens a
place: Rock Ridge (`harboro1`). The ship back and forth costs 10,000 zeny
(Karam Pucci, both ends).

1. **Karam Pucci** - in Alberta: "What can I do for you?", "I'm in! I'm
   in!", "Why are you looking for adventurers?", "So this is a mission.",
   "Got it.", "Off we go to Rock Ridge!" (1).
   Why: a frontier town across the sea needs settlers and a sheriff.
   `/navi alberta 240/103` | done when: `rock_main_quest >= 1`
2. **Mayor Costello** - "Mr. Karam Pucci sent me.", "Was it unoccupied
   until you arrived?", "Who's the sheriff?" (2).
   `/navi harboro1 80/218` | done when: `rock_main_quest >= 2`
3. **Sheriff Wyatt Warp** - "I know about the Buffalo Bandits.", "What can
   I do?", "We should talk to Mayor Costello first." (3); Costello: "You."
   ... (4); Wyatt (5).
   `/navi har_in01 20/30` | done when: `rock_main_quest >= 5`
4. **The freight train** - the Unmoving Freight Train on the plain: "I'm
   from Headquarters." (6); Wyatt: "He could just tell us where the ores
   are, and walk out of here free." (7).
   `/navi rockrdg1 156/312` | done when: `rock_main_quest >= 7`
5. **The jail** - Ivoka Skudi (8); the prisoner Johnny James: "Albert is
   the new leader of your gang now.", "He said he'd sell the ores to us
   for a million Zeny.", ..., "Deal." (9); Wyatt (10).
   `/navi har_in01 14/24`, `/navi har_in01 89/26`, `/navi har_in01
   20/30` | done when: `rock_main_quest >= 10`
6. **Shawn McCurdy** - in town: "What would that be?", "So the mine is
   useless at the moment.", "Then what are you waiting for?" (11); at the
   mine (`rockrdg2 347/216`): "Let's do that." (12, into `rockmi2`), (13).
   `/navi harboro1 288/193` | done when: `rock_main_quest >= 13`
7. **Albert Ford** - the Concaved Rock first: "Knock, knock, knock." (the
   signal); Albert: "I came to negotiate with you.", "I'm here to tell you
   that Johnny is about to betray you.", ..., "Sorry, but can I have a lock
   of your mane?" (14, Buffalo Bandit Mane).
   `/navi rockrdg2 279/313`, `/navi rockrdg2 295/309` | done when:
   `rock_main_quest >= 14`
8. **Back to the jail** - Johnny: "Show him his mane." (15); Wyatt (16).
   `/navi har_in01 89/26` | done when: `rock_main_quest >= 16`
9. **The mine** - Shawn in the mine (17); the Broken Elevator: kill the 3
   Buffalo Bandits (18), then search it (19, Purple Ore Crate); Shawn (20).
   `/navi rockmi2 97/120` | done when: `rock_main_quest >= 20`
10. **Albert** - "Did something happen inside the mine?", ..., "Your threat
    is not going to work." (21).
    `/navi rockrdg2 295/309` | done when: `rock_main_quest >= 21`
11. **Wyatt** - the crate (taken); pick a Vigilante Badge (L or R),
    "Yes." (22).
    `/navi har_in01 20/30` | done when: `rock_main_quest >= 22`
    Reward: 2,500,000 base / 1,200,000 job EXP, 200 Rock Ridge Coin, the
    badge you chose.

### Cacturon (the Cactus family)
quests 16078-16088 | Lv none | needs: the main line at 22 | repeatable (the
coyote hunt, 16079).

1. **Mrs. Cacturon** - "Hello. Is there a problem?", "Sure, I can do
   that." (16078: kill 30 Coyote); back to her.
   `/navi rockrdg1 341/133` | done when: quest 16078 done
   Reward: 55,560 base / 52,710 job EXP, 2 Rock Ridge Coin.
2. **The juice mix** (once) - Little Lecter's lost juice mix packages:
   search the Suspicious Sand Mounds (`rockrdg1 182/124`, `286/247`) and
   ask the Wasteland Cactuten ("Ask if he's seen a juice mix package.",
   "Persuade him."), the Curious Coyote (`195/183`), the Cactus Girl
   (`305/200`) and the Absorbed Coyote (`266/219`) (16082-16088).
   `/navi rockrdg1 339/134` | done when: **to verify** (`rrrem*`
   variables)
3. **Again** - after 4:00, "Hunting Coyotes Again" (16080), same reward.

### Collecting Ore Fragments
quests 9460-9461 | needs: the main line at 22 | repeatable.

1. **The Crouched Horse** - "Sure thing. I'll be right back." (9460); 10
   Fragment of Purple Ore (from the mine, **to verify** the source) (9461).
   `/navi rockrdg1 262/90` | done when: quest 9461 started
   Reward: 25,000 base / 20,000 job EXP, 1 Rock Ridge Coin.

### The town's jobs (food, vigilantes, water, the merchant)
quests 12381-12411 | Lv 100 (the Steel Vigilante #2: 140) | needs: **to
verify** (no `rock_main_quest` check found) | repeatable (each until 4:00).

1. **The Exotic Merchant** - "What kinds of things?", "Nothing. Go on."
   (12410): 5 of the item he names (taken) (12411).
   `/navi harboro1 231/254` | done when: quest 12411 started
   Reward: 20,000 base / 18,000 job EXP, 2 Rock Ridge Coin.
2. **The Food Distributer** - "I'll stand in line.", "What missing
   shipment?", "Why don't you procure some ingredients from the
   outside?", "I can help.", "You need food ingredients, don't you?",
   "Sure thing." (12381): one of six deliveries (sweet potato, meat,
   carrot, banana, pumpkin, mushroom) (12382).
   `/navi harboro1 357/163` | done when: quest 12382 started
   Reward: 16,000 base / 12,800 job EXP, 1 Rock Ridge Coin.
3. **The Steel Vigilantes** - #1: "No. I'm just a tourist.", "Alright, let
   me hear it.", "Okay." (12389): one hunt (15 Buffalo Bandits of one gang,
   20 Coyote, 10 Arclouze, 10 Rat) (12390); #2 (Lv 140): "Sure, why
   not?": 10 of an elite gang or 10 Gaster (12398).
   `/navi harboro1 357/155`, `/navi harboro1 357/152` | done when: quest
   12390 / 12398 started
   Reward: 6,810-37,040 base EXP by hunt and 2 coins (#1); 50,800-95,970
   and 3 coins (#2).
4. **The Desalination Facility** - the manager: "Tell me what this job
   entails.", "Yes." (12403): maintain the red, blue, yellow and white
   pipes through the Underground Passage (`harboro1 332/144`, "Move.")
   (12405-12409) (12404).
   `/navi harboro1 334/135` | done when: quest 12404 started
   Reward: 35,000 base / 27,000 job EXP, 2 Rock Ridge Coin.

### Pipe Cleaning
quests 9458-9459 | needs: the main line at 22 | repeatable.

1. **Donovan** - "I can do that." (9458: kill 20 Sea Anemone in the
   pipes); back (9459).
   `/navi harboro1 138/157` | done when: quest 9459 started
   Reward: 25,000 base / 20,000 job EXP, 1 Rock Ridge Coin.

### Midnight
quests 14672-14673 | Lv 130 (the Demon), 140 for the daily | needs: the
main line at 22 | repeatable.

1. **Midnight and the Demon** - in the underground of `harboro2`: "Mister,
   what are you doing here?", "What business?", "Rob the mine?", "Why did
   you go to jail?", "So, what can I do to help?" (14672: kill 15 Gaster);
   bring 10 Deadly Poison Powder (Gaster Lv 141, 25%) and 1 Explosive
   Powder (taken) (14673).
   `/navi harboro2 167/82`, `/navi harboro2 164/80` | done when: quest
   14673 started
   Reward: 76,200 base / 70,740 job EXP, 3 Rock Ridge Coin.

### Gas! Gas!
quests 1298-1299 | needs: the main line at 22 | repeatable.

1. **The Frail Ghast** - "Help.", "Yes." (1298: kill 20 Gaster); back
   (1299).
   `/navi rockrdg2 295/328` | done when: quest 1299 started
   Reward: 101,600 base / 94,320 job EXP, 3 Rock Ridge Coin.

### Mrs. McPhy and Spotty
quests 1321-1330 | Lv 100 | repeatable (after the dream, quest 1329).

1. **Spotty and her ring** - Mrs. McPhy (1321); Mr. McPhy outside town
   (`rockrdg1 36/250`); the holes Spotty dug (`rockrdg1 170/233`,
   `43/145`, ...: "Spotty, No!", 1322-1328); back to Mrs. McPhy (1329).
   `/navi harboro1 347/65` | done when: quest 1329 started
   Menus and rewards: **to verify**.

### Mr. McPhy: Avenging Spotty
quests 1331-1332 | Lv none found | repeatable.

1. **Mr. McPhy** - in town (1331: kill 3 of each Buffalo Bandit gang);
   back (1332).
   `/navi harboro1 344/61` | done when: quest 1332 started
   Reward: **to verify**.

Not quests: the Prison (Johnny James and the jail are the main line's),
the townsfolk (`harboro1` misc NPCs).

## 29. Quests from other mods (World Sync Extras 2.1.5)

Source of truth here is the mod itself, World Sync Extras 2.1.5, installed at
`%APPDATA%\Ragnarok Offline\state\mods\world-sync-extras`. File paths below
are relative to its `npc/when/` (the folder name is the mod's block, which
the player can switch off in the mod's settings); quest titles and cooldowns
come from its `db/quest_db.yml` and `db/when/<block>/quest_db.yml`, items
and monsters from rathena-pin (`db/re/mob_db.yml` and `mob_db_world.yml`).
Every quest here: **needs a mod** (World Sync Extras, block named). A
cooldown of `TimeLimit: 4h` ends at the next 4:00 server time, as in RO.

### Criminal Activities
`criminal_activities/criminal_activities.txt` | `iq_crim` 0->13, quests
40001-40026 | Lv 70 (Agent York) | guided `wse_criminal`.

1. **Agent York** - in the Geffen inn: "I'll talk to Vince." (1).
   Why: an agent of the Rune-Midgarts investigation office hunts the crime
   lord Jymmy the Thumb; nobody talks, but a musician's friends are in deep
   with Jymmy, and not by choice.
   `/navi geffen_in 77/57` | done when: `iq_crim >= 1`
2. **Vince Noir** - by the Geffen fountain; he gives you a Raccoon Doll for
   his bandmate (2).
   `/navi geffen 107/48` | done when: `iq_crim >= 2`
3. **Ling Mynmei** - give her the Raccoon Doll (taken) (3).
   Why: she owes her contract to Old Lady Kroot next door.
   `/navi geffen_in 30/131` | done when: `iq_crim >= 3`
4. **Old Lady Kroot** - get Ling's contract (4): "Arm wrestle you for it
   (5,000 zeny)" (you win 3 times in 10, each try 5,000 zeny), or "Buy the
   contract (100,000 zeny)". "Offer her a Bomber Steak" (taken) first brings
   the price down to 50,000. Then back to Ling (5).
   `/navi geffen_in 33/131`, `/navi geffen_in 30/131` | done when:
   `iq_crim >= 5`
5. **Howard Moon's floods** - talk to Howard Moon (6), turn off the four
   Flood Controls in Geffen ("Turn it off": `geffen 33/138`, `75/43`,
   `194/183`, `139/166`, any order; quests 40012-40015 count them), then
   tell him (7).
   Why: Jymmy floods his storage room to keep him working.
   `/navi geffen 183/80` | done when: `iq_crim >= 7`
6. **The casino airship** - on the domestic airship (from the airports of
   Juno, Einbroch, Lighthalzen and Hugel, 1,200 zeny), Naota (8). Cooked
   Chicken (`airplane 44/61`): "Add Naota's 'seasoning'"; Slot Machine
   (`46/79`), Roulette Wheel (`24/70`), Slot Machine (`44/45`): "Install a
   cheat detector"; then the Dealer (`32/52`) (9) and Naota (10).
   `/navi airplane 102/62` | done when: `iq_crim >= 10`
   Fails: the Dealer waits until all four are done.
7. **Bringing the ship down** - the Switch ("Pull it", 11) takes you below;
   the Cannon Switch: "Aim at the engines and fire" (12). Six Mobsters
   (Lv 58) jump out and stay 3 minutes. The Stairs (`airplane 91/196`, "Go
   up") lead back.
   `/navi airplane 18/62`, `/navi airplane 95/202` | done when: `iq_crim >= 12`
8. **Jymmy the Thumb** - in his quarters; the ship goes down and you
   parachute into the fields south of Izlude (`prt_fild08 347/213`); the
   Guard there (`prt_fild08 347/216`) sends you on.
   `/navi airplane 232/157` | done when: `iq_crim_land == 1`
9. **Agent York in Izlude** - at the armory (13).
   `/navi izlude_in 67/113` | done when: `iq_crim >= 13`
   Reward: 1,000,000 base / 700,000 job EXP, 1 Old Purple Box.

### Eye of the Beholder
`eye_of_the_beholder/eye_of_the_beholder.txt` | `iq_beho` 0 -> 61001-61029
-> 1 (done), quests 61001-61029 | Lv 50 (the Beholder) | guided `wse_beholder`.

1. **The Beholder** - on the international airship's deck, or by Rachel's
   temple (`ra_temple 104/185`): "Sure, send me to Beho." (61001; he warps
   you into the temple).
   Why: his friend Beho, a gentle beholder, is hopelessly in love.
   `/navi airplane_01 238/57` | done when: `iq_beho >= 61001`
2. **Beho** - talk to him twice (61003); Bianca, who is terrified of
   beholders (61004); Beho twice again (61006).
   `/navi ra_temin 268/321`, `/navi ra_temin 301/112` | done when:
   `iq_beho >= 61006`
3. **White Chocolate** - Kyara: "White Chocolate" (the other three answers
   are wrong; you get 1 White Chocolate, 61007); Kyara again: "Beho is
   gentle and honest." or "He's harmless, really." (61008); Beho takes the
   chocolate (61009).
   `/navi ra_temin 31/70` | done when: `iq_beho >= 61009`
4. **A song** - Doina (61010): the song is about "Eyes", "Heart" or "Tears"
   (not "Hunger") and feels "Strong" or "Itchy" (not "Sleepy" or "Loud");
   she gives a Blank Scroll (61011); Beho takes it (61012).
   `/navi ra_temin 165/101` | done when: `iq_beho >= 61012`
   Fails: a wrong answer ends the talk; ask her again.
5. **The necklace** - Lilla (61013), then in this order: the Flowerpot
   (`ra_in01 374/123`), the Flowerpot in the street (`rachel 106/168`), the
   Flowerpot (`ra_in01 308/37`), the Sofa (`ra_in01 388/68`) (61017); Lilla
   lends you the Necklace of Wisdom for 3 days (61018).
   `/navi ra_in01 343/130` | done when: `iq_beho >= 61018`
   Fails: the necklace vanishes after 3 days; finish before then.
6. **The bouquet** - Kees (61019), then his four Flowerbeds in order
   (`rachel 123/201`, `126/201`, `123/184`, `112/190`) (61023); Kees makes a
   Bouquet (61024).
   `/navi rachel 122/196` | done when: `iq_beho >= 61024`
7. **The Pope's blessing** - Beho gives you back the chocolate and the
   scroll (61025); the Pope on the temple's first floor blesses the
   courtship (61026).
   `/navi ra_temin 268/321`, `/navi ra_temin 169/147` | done when:
   `iq_beho >= 61026`
8. **Bianca's answer** - bring Bianca the White Chocolate, Blank Scroll,
   Necklace of Wisdom and Bouquet (all taken) and sing: "When I look in your
   eyes", "I feel my heart beat strong.", "I cried those nights", "million of
   tears as in this song..." (the two lines of each pair come in random
   order) (61027); talk to her again (61028).
   `/navi ra_temin 301/112` | done when: `iq_beho >= 61028`
   Fails: a wrong line ends the talk; sing again.
9. **Beho in the gardens** - outside the temple, west of the entrance:
   talk to him (61029), then again (1).
   `/navi ra_temple 68/158` | done when: `iq_beho == 1`
   Reward: 500,000 base / 375,000 job EXP, 5 Yggdrasil Berry, 1 Eden Merit
   Badge.

### Seoyeon's Trial
`varmundt/seoyeon_trial.txt` | `wsv_sy` 0->5 (the trace: `wsv_sys` 1-5),
quests 3519-3523 | Lv 70 (Seoyeon) | guided `wse_seoyeon`.

1. **Seoyeon** - in Amatsu: "I'll take your trial." (1).
   Why: a soul that refuses to rest stirs in the old battlefields under the
   castle.
   `/navi amatsu 82/118` | done when: `wsv_sy >= 1`
2. **Three floors** - kill 100 monsters on each floor of the Amatsu Dungeon
   (`ama_dun01`, `ama_dun02`, `ama_dun03`; quests 3519-3521 count them),
   then back to Seoyeon (2).
   Needs: the Amatsu Dungeon Quest (region 14), which opens the dungeon
   (Seoyeon: the soldier on the castle's fifth floor lets you in once the
   Feudal Lord has given you his permit).
   `/navi amatsu 82/118` | done when: `wsv_sy >= 2`
3. **Traces of Yeongwi** - on the Battlefield in the Underground Forest
   (`ama_dun02`): one of five traces is his, chosen at random (`wsv_sys`):
   `52/163`, `67/97`, `122/12`, `154/140`, `162/36` (3).
   `/navi ama_dun02 52/163` | done when: `wsv_sy >= 3`
4. **Yeongwi** - his shadow stands by the trace: "Draw your weapon." and
   defeat him (Lv 99, 60,000 HP) (4).
   done when: `wsv_sy >= 4`
5. **Seoyeon's verdict** - she comes running to the same place: talk to her
   (5).
   done when: `wsv_sy >= 5`
   Reward: half of the EXP your next base level needs (at most 2,000,000)
   and half of the next job level's (at most 1,000,000).

### Fantasy Book "Dungeon Food"
`varmundt/fantasy_dungeon_food.txt` | `wsv_df` 0->15 then 0 (bit `wsv_dfb`
8 = the bet won), quests 16667-16690 | Lv 100 | repeatable (cooldown 16668,
until 4:00).

A Virtual Record Book: you step into the story of Seyren, Margaretha and
Kathryne at a beach lodge (`vr_bob`) and cook them lunch. Ink the fairy
keeps the table of contents; the Magical Stones (`vr_bob 291/201`,
`288/183`, `82/388`) move you between "The lodge." and "The beach.".

1. **The new wing** - the Fantasy Series Manager in the Prontera East
   Library: "Take me to the new wing."; the book "Dungeon Food...": "Open the
   book." (1, you land in the lodge).
   `/navi prt_in 176/57`, `/navi prt_elib 59/45` | done when: `wsv_df >= 1`
2. **Ink** - talk to her (2).
   `/navi vr_bob 293/202` | done when: `wsv_df >= 2`
3. **Seyren** - "Why not just ask them?" (3).
   `/navi vr_bob 296/200` | done when: `wsv_df >= 3`
4. **Lunch orders** - on the beach, Margaretha: "Seyren sent me to ask
   about lunch." (4); then hear both her and Kathryne (5).
   `/navi vr_bob 146/293`, `/navi vr_bob 149/290` | done when: `wsv_df >= 5`
5. **The verdict** - Seyren comes down to the beach: "Margaretha wants
   something warm to share. Kathryne wants it fresh." (6).
   `/navi vr_bob 144/289` | done when: `wsv_df >= 6`
6. **The bet** - Kathryne: "You're on." (7): 5 Crab and 10 Shellfish on the
   beach (quest 16676), then back to her (8).
   `/navi vr_bob 149/290` | done when: `wsv_df >= 8`
   Branches: back within 7 minutes, you win the bet (`wsv_dfb` bit 8) and
   get one more Shamrock Flower Ring at the end; slower costs nothing else.
7. **The oven** - Seyren in the lodge's kitchen (9); at the Oven, three
   batches: "Leave them a little longer." until the shells are "bright red
   and smell sweet", then "Take them out now." (10; burnt or raw batches
   still count).
   `/navi vr_bob 295/209`, `/navi vr_bob 289/209` | done when: `wsv_df >= 10`
8. **The seasoning** - Seyren (11); in the Cupboard take the jar labelled
   "T. paste" and the tin labelled "Paprika" (quest 16683); Seyren (12).
   `/navi vr_bob 302/210` | done when: `wsv_df >= 12`
   Fails: any other jar (16684-16686): Seyren sends you back to the
   cupboard.
9. **Lunch** - at the table outside: Kathryne (13), Margaretha (14), Seyren
   (15); then Ink sees you out (back to 0).
   `/navi vr_bob 291/195`, `/navi vr_bob 294/196`, `/navi vr_bob 290/198`,
   `/navi vr_bob 293/202` | done when: quest 16690 done (`wsv_df` back to 0)
   Reward: 1 Fantasy Book Bookmark, 1 Fantasy Book Completion Card, 1
   Shamrock Flower Ring (2 after a won bet), and base EXP: a tenth of your
   next level (a fiftieth from Lv 200), times 1 below Lv 150, 2 from Lv 150,
   5 from Lv 170. From Lv 130 you may take that many Fantasy Growth Potions
   instead (1/2/5).
   Note: "Close the book for today." (at the book or at Ink) drops the
   story; the next reading starts over. The Commemorative Card Exchange
   (`prt_elib 22/50`) trades the cards (exchange, not a quest).

### Overlook Water Dungeon
`overlook_water_dungeon/overlook_water_dungeon.txt` | `iq_owd` 0->5 (then
`iq_owd_card`), quests 50531-50535 | Lv 30-85 (both ends checked) | opens a
place: the Overlook Water Dungeon (`iz_dun00t`-`iz_dun04t`), a flooded twin
of the Byalan caves with Aged monsters (Lv 34-61).

1. **The Sign** - west of Geffen: "Enter the dungeon".
   `/navi gef_fild07 264/286` | done when: you stand in `iz_dun00t`
2. **Floor 1** - the Sign Board: "Take the notice": 20 Aged Plankton and 20
   Aged Marina; back to the board: "Guard [1]" or "Buckler [1]" (1).
   `/navi iz_dun00t 174/169` | done when: `iq_owd >= 1`
   Reward: 60,660 base / 68,040 job EXP and the shield you chose.
3. **Floor 2** - down at `iz_dun00t 39/41`; 40 Aged Vadon and 40 Aged Kukre;
   "Muffler [1]" or "Manteau [1]" (2).
   `/navi iz_dun01t 122/147` | done when: `iq_owd >= 2`
   Reward: 88,695 base / 99,900 job EXP and the garment you chose.
4. **Floor 3** - down at `iz_dun01t 118/170`; 60 Aged Obeaune and 60 Aged
   Marse (3).
   `/navi iz_dun02t 236/214` | done when: `iq_owd >= 3`
   Reward: 155,700 base / 174,960 job EXP, 2 Elunium.
5. **Floor 4** - down at `iz_dun02t 339/331`; 80 Aged Marc and 80 Aged Phen
   (4).
   `/navi iz_dun03t 42/59` | done when: `iq_owd >= 4`
   Reward: 218,475 base / 245,925 job EXP, 1 Rosary.
6. **Floor 5** - down at `iz_dun03t 264/245`; 100 Aged Strouf and 100 Aged
   Merman (5).
   `/navi iz_dun04t 25/37` | done when: `iq_owd >= 5`
   Reward: 335,340 base / 377,190 job EXP, 1 Rosary, 2 Elunium.
7. **The final reward** - any Sign Board: pick one card, once (Kukre, Vadon,
   Plankton, Hydra, Marina, Cornutus, Marse, Obeaune, Merman, Marc, Phen,
   Swordfish, Marine Sphere, Strouf or Deviace Card), "Yes, this one.".
   done when: `iq_owd_card == 1`
   Fails: each board takes only the next floor's notice; a level outside
   30-85 shuts the dungeon and the boards.

### 2021 town quests

Block `town_quests_2021`: kRO's 2021 town quests as iRO runs them, one
storyline per town. Each hunt is a story step the first time; after that the
same NPC offers it as a daily ("Sure"; cooldown until 4:00, quest_db
`TimeLimit: 4h`). The mod says the dailies share quest ids with the Eden
Group's mission boards (mod eden-rework-2021): a daily done at either place
counts for both. The dungeon-mission givers in `dungeon_dailies.txt` are the
Eden Group's own missions and are left out (Excluded files in the catalog).

#### Morroc: the old scholar's apprentice
`town_quests_2021/morroc.txt` | `iq_moc21` 0->14, quests 21201-21220 | Lv 40.

1. **The Elderly Scholar** - "I'll find him." (1).
   Why: his apprentice went after the pyramid's secrets and has not come
   back.
   `/navi morocc 151/86` | done when: `iq_moc21 >= 1`
2. **The Wandering Boy** - in the desert (2): kill 10 Sandman and bring 5
   Grit (taken) (3).
   `/navi moc_fild17 358/277` | done when: `iq_moc21 >= 3`
   Reward: 10,800 base / 9,600 job EXP.
3. **The scholar at the ruins** - (4): a Field Shovel (Verit and Minorous
   drop it, 10%, while quest 21204 is open) (5).
   `/navi moc_ruins 104/122` | done when: `iq_moc21 >= 5`
   Reward: 12,000 base / 12,800 job EXP.
4. **Lumin** - (6): kill 10 Verit and 10 Minorous (7).
   `/navi moc_ruins 105/124` | done when: `iq_moc21 >= 7`
   Reward: 12,000 base / 12,800 job EXP.
5. **Ernest and Leader Maxim** - Ernest (8); in the pyramid, Leader Maxim
   (9): 1 Memento (taken) (10).
   `/navi moc_ruins 101/124`, `/navi moc_pryd01 20/192` | done when:
   `iq_moc21 >= 10`
   Reward: 7,200 base / 7,800 job EXP.
6. **The Sphinx** - Ernest (11): 1 Rotten Bandage from Isis (30% while
   quest 21210 is open) (12, 16,740 / 17,880); kill 15 Zerom and 15 Requiem
   (13, 19,450 / 20,090); 1 Old Papyrus from Marduk (30% while quest 21212
   is open) (14, 25,640 / 24,210).
   `/navi moc_ruins 101/124` | done when: `iq_moc21 >= 14`

Dailies: the Wandering Boy (10 Sandman + 5 Grit, Lv 50), Lumin (10 Verit +
10 Minorous, Lv 50), Leader Maxim (10 Mummy + 1 Memento, Lv 40; from 10),
Ernest (from 14, Lv 60): "Defeat Isis (daily)" (20 Isis), "The Sphinx's
workers (daily)" (15 Zerom + 15 Requiem), "Secrets of the Sphinx (daily)"
(15 Marduk + 15 Pasana + 10 Old Papyrus). Each pays like its story step.

#### Prontera: the playground, the Orc and Goblin subjugation, Glast Heim
`town_quests_2021/prontera.txt` | `iq_prt21` bits (1 Hornets, 2 Rockers, 4
Ambernite, 8 Leader, 16 Deputy, 32 Claude), quests 21040-21045, 21246-21275 |
Lv none for the playground, 40 for the subjugation, 70 for Glast Heim.

1. **The playground** - Paul outside the west gate: "Sure": kill 10 Hornet
   (bit 1, 1,200 / 1,000); Paul again: 10 Rocker (bit 2, 1,600 / 1,400);
   Ann: 10 Ambernite (bit 4, 2,000 / 2,000).
   `/navi prt_fild05 353/221`, `/navi prt_fild05 351/220` | done when:
   `iq_prt21 & 4`
2. **The Knights' supplies** - the Mon. Hunt Corp Notice gives the hint
   (Lv 40); the Knight's Office Staff: "I'll carry them" (2 Knight Supply);
   the Extermination Commander in the Orc fields takes one (bit 8); his
   Deputy Leader at the Goblin settlement takes the other (bit 16).
   `/navi prontera 62/339`, `/navi gef_fild10 78/340`, `/navi gef_fild11
   128/351` | done when: `iq_prt21 & 16`
   Reward: 8,000 base / 8,000 job EXP (Deputy). The supply run is a daily
   too (cooldown 21268).
3. **Glast Heim** - Priest Leader Lars (Lv 70): "I'll find him"; find
   Claude at Glast Heim (bit 32).
   `/navi prontera 235/311`, `/navi glast_01 205/131` | done when:
   `iq_prt21 & 32`
   Reward: 37,640 base / 37,050 job EXP.

Dailies: Paul (10 Hornet; 10 Rocker), Ann (10 Ambernite), Lv 10. The
Extermination Commander (Lv 40): 15 Orc Warrior + 15 Orc Lady + 10 Orc Baby
(23,520 / 24,300); 20 Orc Skeleton + 20 Orc Zombie (28,700 / 27,400); 20
Zenorc (16,000 / 12,000). The Deputy Leader: two kinds of Goblin, 10 each
(13,000 base, Lv 40, twice); 10 Goblin + 10 Goblin Archer (11,800 / 11,900,
Lv 50). Claude: 15 Wraith + 15 Evil Druid (37,640 / 37,050, Lv 70); 10 Dark
Priest + 1 Furious Dark Priest (96,220 / 91,630, Lv 90). While one of
Claude's dailies is open, Tatiana (`gl_church 175/72`) and Marylin
(`gl_chyard 144/119`) heal you and cast Blessing and Increase AGI, once
every 5 minutes. At the castle gate, no story needed: Exhausted Priest
Charon (`glast_01 206/291`, Lv 85: 10 Zombie Prisoner + 10 Skeleton
Prisoner) and Sprawling Mage Nadir (`glast_01 204/291`: 10 Rybio, Lv 90; 20
Injustice, Lv 85), 72,000 / 72,000 each.

#### Payon: the well, the grandson and the fox spirit
`town_quests_2021/payon.txt` | `iq_pay21` 0->8, quests 21011-21025 | Lv none
for the story (60 for the fox hunt). Side requests: `iq_pay_dd` 0->4, and
`iq_pay_side` bits 1, 2, 4.

1. **The Village Grandfather** - "Sure" (1); the Well beside him: "Pull it
   up" (2); back to him (3).
   Why: his liquor is chilling in the well, and his grandson ran off to the
   Archer Village.
   `/navi payon 192/109`, `/navi payon 195/108` | done when: `iq_pay21 >= 3`
   Reward: 800 base / 800 job EXP.
2. **The Archer Village guard** - (4); Reno in Payon Cave (5): kill 5
   Zombie, back to Reno (6); the guard (7).
   `/navi pay_arche 41/131`, `/navi pay_dun00 155/174` | done when:
   `iq_pay21 >= 7`
   Reward: 3,200 base / 3,000 job EXP.
3. **Elder Payon** - the story of the Moonlight Flower (8).
   `/navi pay_arche 139/33` | done when: `iq_pay21 >= 8`
   Reward: 3,200 base / 3,000 job EXP.
4. **The fox hunt** (daily) - the Notice at the abandoned village's gate
   (Lv 60): "Sign up for the hunt"; the Moonlight Flower drops a Fox Bead
   (100% while quest 21023 is open); Elder Payon takes it.
   `/navi pay_dun03 121/65` | done when: quest 21024 started
   Reward: 20,000 base / 20,000 job EXP.

Side requests in Payon: Dong Dong (the Anxious Middle-Aged Man, `payon
173/77`): "I'll look", the Relaxed Man (`pay_fild01 328/351`): 3 Willow + 2
Barren Trunk, back (800 / 800). The Worried Young Lady (`payon 217/94`):
"Sure", 5 Boa (1,600 / 1,400, 5 Strawberry). The Worried Grandma (`payon
237/64`): "I'll check", 1 Wormtail (1,600 / 1,400). The Worried Grandpa
(`payon 239/64`): "Sure", 5 Spore (3,000 / 2,000). Each becomes a daily (5
Willow + 3 Barren Trunk; 5 Boa; 5 Wormtail; 10 Spore).
Dailies from 7: the Guard: 10 Zombie + 20 Skeleton (Lv 15, 3,200 / 3,000);
15 Munak + 15 Bongun + 15 Amulet (Lv 50, 13,200 / 12,300; Amulet is rare:
Munak 0.1%, Bongun 0.08%, Yao Jun 0.5%). Any time, Lv 50: the Wandering
Monk (`pay_dun02 134/123` or `payon 203/113`): 10 Last Breath, poured from
the Ha Soju the Grandfather gives at the 16 Ghost Fires of `pay_dun03`
("Pour a cup") (9,600 / 9,600); the Young Apprentice (`payon 198/111`): 12
Sohee + 3 Girl's Handkerchief (Sohee, 30% while open) (10,480 / 12,400).

#### Geffen: the tower dungeon
`town_quests_2021/geffen.txt` | `iq_gef21` bits 1-32, quests 21101-21118 |
Lv 55-80 by hunt. Each first hunt is a story step, then a daily.

1. **The Apprentice Mage** - choose a floor: "Hunterflies, 1F" (10 Hunter
   Fly, Lv 55, 8,000 / 6,800); "Ghouls and Jakks, 2F" (10 each, Lv 55,
   14,800 / 13,660); "Marionettes and Deviruchis, 3F" (10 each, Lv 80,
   37,520 / 41,740).
   `/navi geffen 126/113` | done when: `iq_gef21 & 4`
2. **The Tired Man** - in Geffen Tower: 10 Nightmare (Lv 80, 42,000 /
   38,000).
   `/navi gef_tower 48/140` | done when: `iq_gef21 & 8`
3. **The Petit Boy** - "Sky Petites" (10, Lv 75, 9,900 / 10,120) or "Ground
   Petites" (10, Lv 75, 12,860 / 13,160).
   `/navi geffen 40/113` | done when: `iq_gef21 & 32`

#### Izlude: Instructor Pontes, Byalan and Leader Maxim
`town_quests_2021/izlude.txt` | `iq_izl21` bits 1-256, quests 21221-21244 |
Lv 20 (Pontes), 40 (Byalan), 50 (the tunnel).

1. **Instructor Pontes** - "I'll do it": 10 Peco Peco + 10 Muka (bit 1,
   4,800 / 4,200); from Lv 40: 10 Magnolia + 10 Metaller (bit 2, 8,400 /
   8,380), and he sends you to Byalan.
   `/navi izlude 132/207` | done when: `iq_izl21 & 2`
2. **Student Helden** - on Byalan Island (bit 4); his daily: 10 Marina + 10
   Plankton + 10 Single Cell (9,600 / 8,380).
   `/navi izlu2dun 105/68` | done when: `iq_izl21 & 4`
3. **The Wandering Store Owner** - 5 Nipper (taken) (bit 8, 7,800 / 8,380).
   `/navi izlu2dun 108/68` | done when: `iq_izl21 & 8`
4. **Jowon Ernest** - injured in the undersea tunnel (Lv 50): "I'll find
   them"; Leader Maxim on the floor below (bit 16).
   `/navi iz_dun01 121/158`, `/navi iz_dun02 229/231` | done when:
   `iq_izl21 & 16`
5. **The team** - Kusekili: 10 Squid Ink (bit 32, 10,640 / 10,240);
   Ankana: kill 10 Obeaune and bring 1 Heart of Mermaid (bit 64, 9,600 /
   9,600); with both done, take the soup to Ernest (bit 128, 12,400 /
   14,380).
   `/navi iz_dun02 228/229`, `/navi iz_dun02 231/230` | done when:
   `iq_izl21 & 128`
6. **Maxim's proof** - 1 Fin + 1 Ancient Lips (taken) (bit 256, 17,200 /
   15,600).
   `/navi iz_dun02 229/231` | done when: `iq_izl21 & 256`

Dailies: Pontes (10 Peco Peco + 10 Muka; 10 Magnolia + 10 Metaller), Helden,
the Store Owner (10 Vadon + 5 Nipper), Ernest (10 Swordfish + 10 Marc),
Kusekili (20 Marse + 10 Squid Ink), Ankana (10 Obeaune + 1 Heart of
Mermaid), Maxim (10 Strouf + 10 Merman); each pays like its step.

#### Alberta: the shipwreck and Turtle Island
`town_quests_2021/alberta.txt` | `iq_alb21` 0->12 (shipwreck), `iq_alb21t`
0->6 (Turtle Island), quests 21120-21161 | Lv 40 (shipwreck), 90 (Turtle
Island).

1. **Timothy** - "I'll find him" (1); in the wreck, kill 10 Pirate
   Skeleton and find Kale (3).
   Why: a Zonda promoter talked Kale into exploring the shipwreck.
   `/navi alberta 154/224`, `/navi treasure01 162/143` | done when:
   `iq_alb21 >= 3`
   Reward: 8,600 base / 9,600 job EXP.
2. **The Zonda Promoter** - Timothy (4); Mulberry in Alberta (5): kill 10
   Kukre (6, 6,500 / 6,500); she gives 10 Antique Coin: hide 2 in each of
   the five Old Crates of the wreck ("Hide the coins": `treasure01 21/163`,
   `69/110`, `71/30`, `94/164`, `173/50`), back to her (7, 7,000 / 7,000).
   `/navi alberta_in 71/182` | done when: `iq_alb21 >= 7`
3. **Drake's ship** - the Shipwreck Researcher (8); the Rotten Chest in the
   wreck (9); the Researcher (10, 7,000 / 7,000); Mulberry (11): wait until
   4:00 (quest 21134), talk to her again, then Drake's Ghost in her office
   (12).
   `/navi alb2trea 94/77`, `/navi treasure01 165/140`, `/navi alberta_in
   70/185` | done when: `iq_alb21 >= 12`
   Reward: 9,600 base / 8,280 job EXP.
4. **Knight Tybalt** - (Lv 90) "I'll go": on Turtle Island, 10 Dragon Tail +
   10 Spring Rabbit (2, 76,000 / 72,000); 10 Solider + 10 Permeter and 10
   Freezer + 10 Heater (3, 102,000 / 104,000).
   Needs: the boat to Turtle Island, which wants the Turtle Island Quest
   started (region 5).
   `/navi alberta 210/120` | done when: `iq_alb21t >= 3`
5. **The Knight Commander** - in the Turtle Island dungeon (4): 10 Assaulter
   (5, 52,000 / 67,000); back to Tybalt (6, 52,000 / 67,000).
   `/navi tur_dun03 108/74` | done when: `iq_alb21t >= 6`

Dailies: Timothy (20 Pirate Skeleton), Mulberry (10 Kukre; hiding the
coins; from 12, the wreck's 1F: 10 Hydra, 9,600 / 8,280; 2F: 10 Whisper + 1
Swift Sailor Skeleton, 11,800 / 9,600), Tybalt (the island; the turtle
horde), the Knight Commander (10 Assaulter).

#### Comodo: Que Sera, Sera
`town_quests_2021/comodo.txt` | `iq_cmd21` 0->9, quests 21401-21421 | Lv 30
(the hunters: 60).

1. **Chef Bobby Q** - "I'll get them" (1): kill 10 Thara Frog and bring 5
   Sticky Webfoot (2, 5,500 / 5,500).
   Why: he wants a new sauce from the herb Serabi grows.
   `/navi comodo 206/304` | done when: `iq_cmd21 >= 2`
2. **Serabi** - (3): 10 Megalodon (4, 5,500 / 5,500); Bobby Q (5); Bunny Q
   (6); Serabi (7).
   `/navi comodo 166/137`, `/navi comodo 249/300` | done when: `iq_cmd21 >= 7`
3. **Bunny Q** - 10 Hydra + 5 Tentacle (8, 5,500 / 5,500); Bobby Q: 10
   Sticky Webfoot (9, 5,500 / 5,500).
   `/navi comodo 249/300`, `/navi comodo 206/304` | done when: `iq_cmd21 >= 9`

Dailies from 9: Bobby Q (10 Thara Frog + 10 Sticky Webfoot), Bunny Q (10
Hydra + 5 Tentacle), Serabi (10 Megalodon), 5,500 / 5,500 each. Without the
story (Lv 60): the Vigilante (`comodo 326/215`: 10 Seal + 10 Sea Otter,
10,000 / 10,000), the Vigilante (`comodo 170/347`: 10 Stalactic Golem + 5
Tri Joint + 5 Megalith, 20,000 / 20,000), the Explorer (`cmd_fild01 40/320`:
15 Grove + 10 Alligator, 15,000 / 15,000); the first one turned in at
each pays the EXP twice.

#### Aldebaran and the Juno fields
`town_quests_2021/aldebaran.txt` | `iq_ald21` bits 1, 2, quests 21276-21293,
21300 | Lv 70 (the Clock Tower's lower floors: 80).

1. **A mother's lunch** - the Middle-Aged Woman: "I'll take it"; the
   Checkpoint Guard (bit 1, 5,000 / 5,000; again daily, cooldown 21300).
   `/navi aldebaran 114/180`, `/navi yuno_fild01 196/154` | done when:
   `iq_ald21 & 1`
2. **Soft and fluffy** - the Kiel Hyre Academy Student at the checkpoint:
   "Sure"; 5 Antelope Skin + 5 Peco Peco Feather to the student at the
   academy (bit 2, 14,200 / 14,200).
   `/navi yuno_fild01 189/154`, `/navi yuno_fild08 179/200` | done when:
   `iq_ald21 & 2`

Dailies: Checkpoint Manager Cesare (`yuno_fild01 193/158`: 10 Geographer +
10 Mantis, 19,760 / 15,150); after step 2, the academy student (20 Goat + 20
Grand Peco, 42,960 / 43,880), the Cat Paw Merchant (`yuno_fild08 172/198`:
10 Antelope Skin + 10 Peco Peco Feather, 14,200 / 14,200), the Academy Guard
(`yuno_fild08 198/200`: 15 Harpy + 15 Sleeper, 36,840 / 40,200). The Clock
Tower Manager (`aldebaran 143/132`): 20 Rideword + 15 Punk (33,820 /
40,650); from Lv 80: 15 Clock, 20 Alarm, 20 Bathory (20,310-28,320 base),
each paying 1 Key of Clock Tower and 1 Key of Underground too.

#### Einbroch, Einbech and Lighthalzen
`town_quests_2021/einbroch.txt` | `iq_ein21` bits 1-8, quests 21301-21325 |
Lv 80 (Einbech: 85).

1. **Ernst's letter** - Ernst Schumacher at the Kiel Hyre Academy: "I'll
   take it"; his brother Friedrich in the factory district (bit 1, 10,000 /
   10,000).
   `/navi yuno_fild08 172/194`, `/navi ein_fild06 163/173` | done when:
   `iq_ein21 & 1`
2. **The commuter pass** - Friedrich: "Use the commuter pass to Einbech"
   (warps you); Guard Artin (bit 2).
   `/navi einbech 156/200` | done when: `iq_ein21 & 2`
3. **Karl's shift** - Guard Eisen: "Anything else?"; Guard Karl at the
   airport (bit 8, 10,000 / 10,000).
   `/navi einbroch 220/254`, `/navi airport 133/42` | done when:
   `iq_ein21 & 8`

Dailies: Friedrich (20 Metaling + 10 Holden, 40,920 / 38,220); Guard Artin (Lv
85: 20 Pitman; 15 Old Stove; 15 Mineral + 5 Obsidian; 72,040-77,500 base);
Guard Eisen (20 Venomous; 20 Noxious; 15 Teddy Bear; 38,200-48,600 base);
Theodore in Lighthalzen (`lighthalzen 200/314`: 20 Rafflesia; 20 Stem Worm;
about 50,000 base); Reno (`lighthalzen 208/314`: 20 Breeze, 84,392 /
79,024).

#### Hugel: Abyss Lake and the fishermen
`town_quests_2021/hugel.txt` | `iq_hu21` 0->3, quests 21294-21299,
21638-21647 | Lv 40-80 (the dailies), 120 (Abyss Lake).

1. **Nahadan** - "I'll go" (1): kill 30 Ferus (the red ones) at Abyss
   Lake, then find him on the field outside (2).
   Needs: the lake opens for 30 seconds when you put one Dragon Canine,
   Dragon Scale and Dragon Tail in the Column (`hu_fild05 168/304`).
   `/navi hugel 69/121`, `/navi hu_fild05 185/36` | done when: `iq_hu21 >= 2`
   Reward: 500,000 base / 500,000 job EXP.
2. **Myungkyung** - tell him about the injured traveler (3).
   `/navi hugel 67/119` | done when: `iq_hu21 >= 3`

Dailies: Nahadan (from 3): 30 of each Ferus (both kinds), 30 of each Acidus
(both kinds), 1 Hydrolancer; 500,000 / 500,000 and 2, 2 or 1 Eden Group
Coin. No story: Fisherman Ein (`hugel 97/149`, Lv 40: 10 Aster + 10 Crab;
10 Shellfish + 5 Clam Flesh; 8,400 / 8,380) and Blacksmith Dry (`hugel
91/142`, Lv 80: 10 of each Novus, 43,080 / 40,160).

#### Juperos: Leader Maxim's camp
`town_quests_2021/juperos.txt` | quests 21350-21358 | Lv 110 | dailies only.

1. **Leader Maxim and Ernest** - by the Juperos ruins; Maxim: Colorful
   Dimiks 1 and 2 (10 + 10 Dimik each); Ernest: Iron Ants 1 and 2 (20 + 20
   Venatu each); 300,000 / 250,000 and 1 Eden Group Coin each.
   `/navi yuno_fild07 228/172`, `/navi yuno_fild07 232/176` | done when:
   quest 21356, 21358, 21352 or 21354 started

#### Rachel and Veins
`town_quests_2021/rachel.txt` | `iq_ra21` bits 1, 2, 4, quests 21140-21148 |
Lv 90. Each first hunt is a story step, then a daily.

1. **The pilgrims' road** - the Airport Security Guard: 30 Roween (bit 1,
   86,000 / 82,000).
   `/navi ra_fild12 296/200` | done when: `iq_ra21 & 1`
2. **Leonard** - 30 Siroma in the Ice Cave (bit 2, 92,000 / 82,000).
   `/navi rachel 192/138` | done when: `iq_ra21 & 2`
3. **Craven** - in Veins: 30 Stapo (bit 4, 86,000 / 82,000).
   `/navi veins 182/130` | done when: `iq_ra21 & 4`

### City Investment (the City Merchant Union)
`city_investment/city_investment.txt` | quest 12370 (member), 12371 (the
day's investment), `iq_ci_city[1..9]`, `iq_ci_jobs` | Lv none | repeatable.

1. **Join the Union** - the City Merchant Union Manager at the Eden Group
   HQ: "Join the Union" (quest 12370). While you are a member, monsters
   outside instances drop a Union Insignia 1 time in 5.
   `/navi moc_para01 53/34` | done when: quest 12370 started
2. **Invest** - any city's Investment Manager: "Invest Union Insignias", up
   to 250 a day in one city (each Insignia = 5.5 points; until 4:00).
   Standing: Town Newbie 3,000, Neighbor 9,000, Notable 21,000, City Power
   41,000, Ruler 42,000.
   `/navi prontera 142/67` (also `geffen 103/70`, `payon 156/61`, `morocc
   184/94`, `yuno 151/127`, `einbroch 84/257`, `lighthalzen 263/79`,
   `rachel 267/131`, `veins 194/116`) | done when: `iq_ci_city[N] >= 3000`
3. **Union gear** - the city's Merchant Union next to its manager sells the
   city's weapon (and Rachel's/Veins' shield) from Town Newbie, shoes from
   Neighbor, armor from Notable, a garment from City Power (100,000 to
   250,000 zeny, account bound).
   `/navi prontera 146/67` | done when: you bought one
   Note: the Union's Bulletin Board (`moc_para01 53/36`) posts deliveries
   (C/B/A, 20/30/50 Insignias, one of each a day; B after 10 requests, A
   after 30) and a weekly Wanted boss (100-300 Insignias, new Wednesday
   4:00), paid by the Secretary Governor (`moc_para01 53/32`). It is a
   board: excluded with the other boards, as an Insignia source only.

### Devil in the Box
`iro_systems/devil_in_the_box.txt` | quests 5961-5971 | Lv 200 (the
basement) | repeatable (meals: 20 hours after each; special meal: weekly,
Monday 4:00; snack and Mimic: 20 hours).

1. **The Mysterious Box** - in the Clock Tower: talk to it (quest 5971
   done).
   Why: a devil locked in a box by a clockmaker is starving for the soul
   dregs of the monsters in the forgotten Unknown Basement.
   `/navi c_tower1 243/202` | done when: quest 5971 done
2. **The Unknown Basement** - "Go down to the Unknown Basement", "Send me
   down" (Lv 200). Monsters there are Lv 253-255 (Extra Joker, Erzsebet,
   Jennifer, General Orc, Sieglouse; the Goblin King boss).
   done when: you stand in `clock_01`
3. **Today's meal** - one a day: "Breakfast: 100 monsters", "Lunch: 300
   monsters" or "Dinner: 1000 monsters" in the basement.
   Reward: 30,000,000 / 20,000,000; 90,000,000 / 60,000,000; 300,000,000 /
   200,000,000 base / job EXP.
4. **This week's special meal** - "I'll do it": 5,000 monsters.
   Reward: 1,500,000,000 base / 1,000,000,000 job EXP.
5. **A snack** - 100 each of Jokers Wild (Extra Joker, 25%), Cute Broom
   (Erzsebet, 22%), Colorful Coral (Jennifer, 21%) and Shiny Round Shell
   (Sieglouse, 20%): "Give her the trinkets".
   Reward: 100,000,000 base / 70,000,000 job EXP.
6. **Your pet Mimic** - "I'll feed your Mimic": among the ten Pet Mimics in
   the basement, the one with a red collar (chosen at random,
   `wsi_mimic`); the wild ones point the way ("prints lead north..."). Then
   back to the box.
   `/navi clock_01 136/143` | done when: quest 5970 started
   Reward: 50,000,000 base / 35,000,000 job EXP.

## Entrances without a quest

- **Nightmare Clock Tower** - Belljamin Button in the Clock Tower: "Go to 2nd
  floor of warped tower" or "Go to 3rd floor of warped tower", then "Pay
  10,000z". Lv 150 (`BaseLevel < 150` turns you away). His twins inside
  take you back ("Get me out of here!").
  `/navi c_tower1 232/222` (back: `c_tower2_ 274/26`, `c_tower3_ 59/148`)
  `re/quests/quests_aldebaran.txt`
- **Nightmare Glast Heim** - Hugin's follower at Glast Heim's gate: "That is
  interesting, please tell me more", "I really want to explore!", then
  "Monastery Cemetery (Lv100~130) - 5000z" or "2nd floor Corridor (Over
  Lv140) - 10000z". No level check (the levels are advice). Her fellows
  inside take you back ("Please get me out of here").
  `/navi glast_01 195/273` (back: `gl_chyard_ 148/149`, `gl_cas02_ 104/36`)
  `re/quests/quests_glastheim.txt`
- **Nightmare Pyramid** - the Suspicious Cat in the Pyramid's basement:
  "Mummy? What happened?", "Strong mummies? Where are they?", "I would like
  to go, too.", "Pay 5,000 zeny and set out." No level check. The cat inside
  takes you back ("Go back to Thief Guild") and gives the hunts (region 4).
  `/navi moc_prydb1 103/54` (inside: `moc_prydn1 94/98`)
  `re/quests/quests_morocc.txt`
- **Teleport Cats** (Cat Paw Addition 14.2) - six cats along the New World,
  each to its neighbours: Allied camp mid_camp 207/234 (Near Splendide,
  Manuk Field), spl_fild02 53/242 (Entrance to Mora, Allied camp),
  man_fild02 135/49 (Allied camp, Near El Dicastes), dic_fild01 161/266,
  bif_fild02 293/325, ecl_fild01 118/311. 10-55 Malangdo Canned
  Specialties or 1,000 zeny for each can. No condition.
  `re/quests/quests_eclage.txt`
- **Cat Paw Agents** of the New World (mid_camp 62/125, spl_fild02 25/211,
  man_fild02 132/47): save point, storage and the Cat Warp by the Cat Paw
  Trading Post's credit (region 23).
  `quests/quests_13_1.txt`, `quests/quests_13_2.txt`
