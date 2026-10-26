# RO side quests on Renewal: the steps

Step 2 of the Renewal Side Quests tab: the steps of every quest in
`ro-quest-catalog.md`, same regions, same numbers, same order. Batch 1
(2026-10-26): regions 1-6 and "Entrances without a quest". Batch 2
(2026-10-26): regions 7-13, the Party Relay and the Unlucky Emerald's jewel
part. Regions 14-31 follow in later batches.

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
2292 "Mummy Hunting (Nightmare)", cooldowns 2290 / 2291 (4h) | Lv none |
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
   200,000 job EXP. Each again after 4 hours.

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
- Eclage's Teleport Cats (27) and the New World's Cat Paw teleports (25)
  stay candidates for their own batches.
