# RO side quests on Renewal: the steps

Step 2 of the Renewal Side Quests tab: the steps of every quest in
`ro-quest-catalog.md`, same regions, same numbers, same order. Batch 1
(2026-10-26): regions 1-6 and "Entrances without a quest". Regions 7-31
follow in later batches.

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
| **needs a party** of 2+ online members, all Lv 30-80
(`instance_check_party(.@party_id,2,30,80)`, line 43): dead end on a solo
server unless the app's Companions count as party members (see
guide-deferred.md). Side 5 tells the memory from Wendel's notes instead.

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
`quests/partyrelay.txt` | `party_relay`, `party_relay_lv` | Lv 40
(`BaseLevel > 39`). **Dead end at step 1**: Ledrion in Payon
(`/navi payon 103/113`) starts it only for a party leader who is in a guild
and has more than 5 party members (lines 204 and 348); every later check
(lines 39, 114, 163) asks the same. No steps. See guide-deferred.md.

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
BaseLevel > 65`, Ibrahim) | **dead end at step 7**: the treasure chest opens
only for a party of 2 or more (`getpartymember`, line 9909; offline members
count). See guide-deferred.md.

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
7. **The chest opens** - **blocker**: at the chest type the whole spell as one
   word; it only works with 2 or more members in your party. Note the
   script's own swap: at 9 the answer is `OpenSesame`, at 10 `UnlockTreasure`
   (the opposite of the halves you hold).
   You would get: Unlucky Emerald, Dead Branch, Two-Handed Sword, and a curse.
   `/navi moc_fild18 108/116` | done when: `treasure_nd` 11 or 12
   Dead end, see guide-deferred.md.

After the blocker (not written out yet): the jewel part (`jewel_nd`) starts at
Ibrahim (Broken Diamond done, `treasure_nd > 10`, Lv 66) and runs through
jewellers in Alberta, Payon and Geffen, a scholar in Comodo, a shaman in
Alberta (200,000 and 100,000 zeny), an archeologist in Juno, a wanderer's
ghost in a Geffen field and an old soldier in Prontera; reward Old Blue Box
plus EXP or items by level.

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
