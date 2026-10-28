# Adventurer's Chronicle: the whole story in one place.
# build.ps1 reads this and writes db/quest_db.yml, System/OngoingQuestInfoList.lub,
# npc/chronicle_data.txt and client/data.js. Edit here, then run build.ps1.
#
# Step types: talk (speak to the chapter NPC), hunt (quest-window kill counts),
# deliver (bring items to the NPC), boss (reach a map; a named boss appears),
# report (back to the NPC: chapter reward and a costume of your choice).
# lv = the level the step expects; finishing a step fills EXP toward the next
# step's lv (times the "Quest EXP" setting). 'now' = what to do (journal,
# quest window), 'done' = what happened (journal recap). 'say' = NPC lines.
# ASCII only: the client reads quest text in its own codepage.
#
# id = the step's fixed id: its quest id is 77000 + id, and a character's
# progress remembers it (CHRON_SID), so a step put in before it later doesn't
# move anyone. Never change or reuse an id. Pre-renewal's steps are 1-40 (their
# old positions); new Renewal-only steps get ids from 901 up (77100-77899 are
# for the Side Quests: 77100 + n*10 + k, see side.ps1).
#
# Two eras: build.ps1 writes the mod's files from this story as it is
# (Pre-renewal), and a second set into renewal/ with every 're' applied: a
# step's or a chapter's re = @{ key = value } replaces those keys on Renewal
# (levels, monsters, maps, items, text). Renewal's monsters are far higher
# level and drop about half as often (rAthena db/re), so its steps differ.
# A chapter with era = 'renewal' is only in the Renewal route; its costumes
# take three new item ids from its costumeId (50900 on; the Side Quests'
# costumes have ids from 50125, see side.ps1). Chapters are numbered
# by their place in each era's route (n below is the Pre-renewal number).
# Renewal has no chapters since 2026-10-28 (concept v3): its Story is
# $episodes, Ragnarok's own episodes (below the chapters). Renewal-only
# chapters and their costumes (50900-50917) went then; never reuse those ids.

$final = 115   # the level the last step fills toward
$finalRe = 175 # the same on Renewal (its level cap)
# Renewal: where the route stops for now (the Journal, after the finale).
$soonRe = 'Episodes 16 to 21 are in development, coming soon.'

# The way home from Odin's Temple (Chapter 8's Hugel steps): only its Boatman
# sails back, so Navigation can't route out.
$odinHome = @(
  @{ map = 'odin_tem03'; x = 121; y = 49; name = 'Way down to the second floor' }
  @{ map = 'odin_tem02'; x = 21; y = 180; name = 'Way down to the first floor' }
  @{ map = 'odin_tem01'; x = 93; y = 146; name = 'Boatman: sail back to Hugel' }
)
$odinHomeHint = 'In Odin''s Temple? Go down to the first floor (odin_tem01) and ask the Boatman there (93, 146) to sail you back to Hugel.'

$chapters = @(
  @{ n = 1; title = 'A New Adventurer'; range = '1-15'
     town = 'prontera'; townName = 'Prontera'; npc = 'Sir Leonhart'; sprite = '4_M_KNIGHT_SILVER'; x = 157; y = 190
     costumes = @(5035, 2214, 2213); gift = @(,@(501, 30)); zeny = 3000
     intro = 'Prontera is the capital of the Rune-Midgard Kingdom, seat of King Tristan III and the Prontera Knights. Every adventurer''s road starts somewhere, and yours starts here.'
     steps = @(
       @{ id = 1; type = 'talk'; lv = 1; title = 'The Knight at the Fountain'
          now = 'The Prontera Knights are looking for adventurers. Find Sir Leonhart near the central fountain of Prontera (157, 190).'
          done = 'You met Sir Leonhart of the Prontera Knights. He saw promise in you and offered you work: the fields around the capital are overrun.'
          say = @('An adventurer, fresh on the road? Good. The kingdom needs every sword it can get.', 'Monsters around Prontera have grown bold these past weeks, and my knights cannot be everywhere at once.', 'Clear the fields south of the city and I will see that you are paid. Here, take this journal. Write down what you see.') }
       @{ id = 2; type = 'hunt'; lv = 2; title = 'Clearing the Southern Fields'; where = 'prt_fild08'
          mobs = @(@(1002, 'Poring', 20), @(1063, 'Lunatic', 15))
          now = 'Monsters around Prontera have grown bold. Hunt 20 Porings and 15 Lunatics in the fields south of Prontera (prt_fild08). Track the count in the quest window (Alt+U).'
          done = 'You thinned the Porings and Lunatics south of the capital. The farmers noticed, and so did Leonhart.' }
       @{ id = 3; type = 'deliver'; lv = 6; title = 'Proof for the Knights'
          items = @(@(909, 'Jellopy', 10), @(705, 'Clover', 5))
          now = 'Leonhart needs proof for the Knight Captain. Bring him 10 Jellopy and 5 Clover in Prontera (157, 190).'
          done = 'You brought Leonhart his proof. He confided that the monsters are not only multiplying: they are coming up from below the city, out of the Culvert.'
          say = @('Good work. This will quiet the Captain for a while.', 'But listen. The guards found Thief Bugs in the cellars near the walls, far too many of them. They are coming up from the Culvert, the old waterways under the city.', 'The Culvert is sealed by royal decree. Sign up with the Recruiter in the north-west of the city, then go down to its second level and find out what is breeding them.', 'One warning. The old guards speak of a golden beetle, far larger than any Thief Bug, on the fourth and deepest level of the Culvert. The Golden Thief Bug. Do not go looking for it. Not yet.') }
       # The Culvert Guardian only lets in volunteers (rAthena quests_prontera.txt,
       # MISC_QUEST & 8), so the route leads to the Recruiter first.
       @{ id = 4; type = 'boss'; lv = 10; title = 'Into the Culvert'; map = 'prt_sewb2'; mob = 1054; boss = 'Culvert Brood Lord'; hp = 8
          route = @('prt_in', 88, 105, 'Culvert Recruiter: prt_in')
          now = 'Volunteer with the Recruiter in Prontera, then enter the Prontera Culvert and reach its second level (prt_sewb2). Whatever is driving the Thief Bugs waits there.'
          hint = @(
            'Prontera: go into the north-west building (door at 45, 346). The Recruiter stands inside (88, 105).'
            'Talk to the Recruiter and choose Volunteer. You get a few potions, and the Recruiter can send you straight to the Culvert entrance (now and any time later).'
            'Field west of Prontera (prt_fild05): the Culvert Guardian (270, 212) lets volunteers in.'
            'Culvert level 1: take the stairs in the east (188, 247) down to level 2. The Culvert Brood Lord appears a few seconds after you arrive.'
          )
          spots = @(
            @{ map = 'prontera'; x = 45; y = 346; name = 'Door to the Recruiter (north-west)' }
            @{ map = 'prt_in'; x = 88; y = 105; name = 'Recruiter: choose Volunteer' }
            @{ map = 'prt_fild05'; x = 270; y = 212; name = 'Culvert Guardian (the way in)' }
            @{ map = 'prt_sewb1'; x = 188; y = 247; name = 'Stairs down to level 2' }
          )
          done = 'Deep in the Culvert you slew the Culvert Brood Lord, a Thief Bug swollen far beyond its kind. Its body reeked of something old and wrong.' }
       @{ id = 5; type = 'report'; lv = 13; title = 'Report to Leonhart'
          # Renewal: Byalan's caves are Lv 34-48 (side.ps1), so Leonhart says it is for later.
          re = @{ say = @('A Brood Lord... beneath the capital. I would not have believed it from anyone else.', 'You are not the first to bring such news. From every corner of the kingdom, monsters are waking where they have slept for centuries.', 'The archers of Payon have asked the crown for help. Their cave of the dead is restless. Go south, my friend. Captain Hwarang will be waiting.', 'One more thing, for when your sword arm is stronger. The Culvert drains into the sea at Izlude, and the harbour master there writes that sea creatures have been attacking boats near Byalan Island since the same week the bugs appeared. Those caves are no place for a beginner, but one day he could use a sword like yours.') }
          now = 'Tell Sir Leonhart in Prontera (157, 190) what you found in the Culvert.'
          done = 'Leonhart listened in silence. Reports like yours are arriving from all over Rune-Midgard: monsters stirring where they slept for centuries. He sent you south to Payon, whose archers asked the crown for help.'
          say = @('A Brood Lord... beneath the capital. I would not have believed it from anyone else.', 'You are not the first to bring such news. From every corner of the kingdom, monsters are waking where they have slept for centuries.', 'The archers of Payon have asked the crown for help. Their cave of the dead is restless. Go south, my friend. Captain Hwarang will be waiting.', 'One more thing, if you have a day to spare before Payon. The Culvert drains into the sea at Izlude, and the harbour master there writes that sea creatures have been attacking boats near Byalan Island since the same week the bugs appeared. He could use a sword.') }
     ) }

  @{ n = 2; title = 'Whispers of Payon'; range = '15-30'
     re = @{ range = '15-35' }
     town = 'payon'; townName = 'Payon'; npc = 'Captain Hwarang'; sprite = '4_M_ARCHER'; x = 154; y = 182
     costumes = @(5046, 2264, 5214); gift = @(,@(502, 30)); zeny = 8000
     intro = 'Payon is a village of archers in the forested mountains, built beside a cave where its ancestors were laid to rest.'
     steps = @(
       @{ id = 6; type = 'talk'; lv = 15; title = 'The Archer Captain'
          now = 'Travel south to Payon, the mountain village of archers, and find Captain Hwarang (154, 182).'
          done = 'Captain Hwarang told you of the Payon Cave, a sacred burial ground. For weeks the dead have been walking out of it at night.'
          say = @('So the knights sent you. Good. My archers cannot be everywhere at once.', 'North of the Archer Village lies the Payon Cave, where our ancestors rest. For weeks now, they have not been resting.', 'The dead walk out of it at night. Thin their numbers on the first level, and I will tell the elders the crown keeps its word.', 'Two warnings I give every newcomer. The deepest level of the cave belongs to the Moonlight Flower, a fox spirit who plays cruel tricks on the living. And in the forest south of the village hunts Eddga, a great tiger. Leave both alone until you have grown.') }
       @{ id = 7; type = 'hunt'; lv = 16; title = 'The Restless Dead'; where = 'pay_dun00'
          re = @{ lv = 17 }
          mobs = @(@(1015, 'Zombie', 25), @(1076, 'Skeleton', 20))
          now = 'Hunt 25 Zombies and 20 Skeletons on the first level of the Payon Cave (pay_dun00), north of the Archer Village.'
          done = 'You put the restless dead of the cave''s first level back to rest, for now.' }
       @{ id = 8; type = 'deliver'; lv = 20; title = 'Bones and Nails'
          re = @{ lv = 22 }
          items = @(@(957, 'Decayed Nail', 10), @(932, 'Skel-Bone', 5))
          now = 'The village shaman wants to study what raises the dead. Bring Captain Hwarang 10 Decayed Nails and 5 Skel-Bones in Payon (154, 182).'
          done = 'The shaman found traces of an old binding on the bones: a seal laid long ago to keep the cave''s spirits asleep. It is fraying.'
          say = @('The shaman will want these. Wait here.', '...She says there was a binding on these bones. An old seal, laid by our ancestors to keep the cave asleep. It is coming apart.', 'Our soldiers of old were buried on the second level, with their captain. If he has risen, he must fall again. Go carefully.', 'The shaman needs time to prepare her wards before anyone goes down to the captain, so go when you are ready. Strange... a merchant from Alberta came begging this morning. The old wreck off his coast walks at night, drowned sailors on its deck. It sounds like our sickness.') }
       @{ id = 9; type = 'boss'; lv = 24; title = 'The Captain Below'; map = 'pay_dun01'; mob = 1028; boss = 'Restless Cave Captain'; hp = 8
          re = @{ lv = 28 }
          now = 'Descend to the second level of the Payon Cave (pay_dun01). The soldiers buried there once had a commander; if he has risen, he must fall again.'
          done = 'You defeated the Restless Cave Captain, an ancient soldier still loyal to a war long forgotten. As he crumbled, he whispered of the seals breaking in the desert.' }
       @{ id = 10; type = 'report'; lv = 27; title = 'Words of the Dead'
          # Renewal: Satan Morroc has already broken loose and left Morroc in ruins.
          re = @{ lv = 32
             done = 'Hwarang paled. Payon''s elders remember the great seal beneath Morroc, where a demon king was bound long ago, until he tore free and left the city in ruins. He sent you across the desert to Morroc.'
             say = @('The seals breaking in the desert... that is what he said?', 'Our elders tell a story of Morroc. Long ago, a demon king was bound beneath the desert city. Not long ago he tore free of his seal, and the city has lain in ruins ever since.', 'If the dead are whispering about seals again, someone must go. There is a seer in Morroc, Nafisa. She reads the sands better than anyone.', 'The desert roads are closed by the Continental Guard, so do not try to walk. Ask a Kafra Employee here in Payon to send you to Morroc.') }
          now = 'Tell Captain Hwarang in Payon (154, 182) what the dead soldier said.'
          done = 'Hwarang paled. Payon''s elders remember the great seal beneath Morroc, where a demon king was bound long ago. He sent you across the desert to Morroc.'
          say = @('The seals breaking in the desert... that is what he said?', 'Our elders tell a story of Morroc. Long ago, a demon king was bound beneath the desert city, and the seal has held ever since.', 'If the dead are whispering about it, someone must go. There is a seer in Morroc, Nafisa. She reads the sands better than anyone.', 'The desert roads are closed by the Continental Guard, so do not try to walk. Ask a Kafra Employee here in Payon to send you to Morroc.') }
     ) }

  @{ n = 3; title = 'Sands of Morroc'; range = '30-45'
     re = @{ range = '35-55'; intro = 'Morroc was the desert city of the Sograt, home to thieves and merchants. When the demon king bound beneath it broke free, the city fell into ruin; its people still live among the rubble.' }
     town = 'morocc'; townName = 'Morroc'; npc = 'Nafisa the Seer'; sprite = '1_F_GYPSY'; x = 156; y = 286
     costumes = @(5053, 2222, 5080); gift = @(,@(503, 30)); zeny = 15000
     intro = 'Morroc is the desert city of the Sograt, home to thieves and merchants, built on sand that hides older things.'
     # No open road leads into Morroc on this server: the Continental Guard
     # closes the desert around it (moc_fild20 has no exits but its guards),
     # so Navigation can't route there. Every Chapter 3 step shows the way back
     # in when you are in Payon, Prontera or the closed desert (after a death
     # or a Butterfly Wing, say).
     spots = @(
       @{ map = 'payon'; x = 175; y = 226; name = 'Kafra: Teleport to Morocc (1,200 zeny)' }
       @{ map = 'prontera'; x = 146; y = 89; name = 'Kafra: Teleport to Morocc (1,200 zeny)' }
       @{ map = 'moc_fild20'; x = 203; y = 336; name = 'Continental Guard: a free ride to Morroc' }
     )
     away = 'Away from Morroc? No open road leads back in: a Kafra Employee in Payon (175, 226) or Prontera (146, 89) can teleport you to Morocc (1,200 zeny).'
     steps = @(
       # rAthena kafras/functions_kafras.txt: Payon's Kafras teleport to Morocc.
       @{ id = 11; type = 'talk'; lv = 30; title = 'The Desert Seer'
          re = @{ lv = 35
             now = 'Travel to Morroc, now a city in ruins (a Kafra Employee in Payon can teleport you there), and find Nafisa the seer in the north of the city (156, 286).' }
          route = @('payon', 175, 226, 'Kafra in Payon: Teleport to Morocc')
          now = 'Travel to Morroc (a Kafra Employee in Payon can teleport you there) and find Nafisa the seer in the north of the city (156, 286).'
          hint = @(
            'No open road leads into Morroc: the Continental Guard has closed the desert around it. Talk to a Kafra Employee in Payon (175, 226), choose Teleport Service, then Morocc (1,200 zeny). The Kafras in Prontera can send you too.'
            'In Morroc, Nafisa stands in the north of the city (156, 286). She is marked on your minimap when you arrive.'
            'Walked into the closed desert (moc_fild20) anyway? Talk to a Continental Guard at its edge and choose Ask What Happened, then Ask About Guard''s Location, then Please do. He sends you to Morroc for free.'
          )
          spots = @(
            @{ map = 'morocc'; x = 156; y = 286; name = 'Nafisa the Seer' }
          )
          done = 'Nafisa read your fortune and frowned: your thread is knotted around the old seals of Rune-Midgard. She would say no more, but agreed to help, because the desert has been trembling.'
          say = @('Sit. Give me your hand. ...How strange.', 'Every soul in Midgard is a thread in the great weave. Yours is knotted around something old. The seals our ancestors laid.', 'Never mind that. The desert has been trembling for weeks, and the creatures of the sand flee from something. Find out what drives them.') }
       @{ id = 12; type = 'hunt'; lv = 31; title = 'Restless Sands'; where = 'moc_fild16'
          # Renewal: Sandmen and Hodes are level 61-63 here; the Sphinx's first
          # level, a walk west of Morroc, has Drainliars (47) and Matyrs (58),
          # with aggressive Requiems and Zeroms (70-71) around them.
          re = @{ lv = 40; title = 'Beneath the Sphinx'; where = 'in_sphinx1'
             mobs = @(@(1111, 'Drainliar', 30), @(1146, 'Matyr', 10))
             now = 'Hunt 30 Drainliars and 10 Matyrs on the first level of the Sphinx (in_sphinx1), a short walk west of Morroc.'
             hint = @(
               'Leave Morroc by its west gate (24, 164). In the desert beyond (moc_fild19), the entrance to the Sphinx stands near the middle of the map (98, 99).'
               'Requiems and Zeroms (level 70) roam the same level and attack on sight. Bring potions, and keep close to the entrance if they swarm you.'
             )
             spots = @(
               @{ map = 'morocc'; x = 26; y = 164; name = 'West gate: the way to the Sphinx' }
               @{ map = 'moc_fild19'; x = 100; y = 99; name = 'Entrance to the Sphinx' }
             )
             done = 'The creatures of the sand were fleeing the Sphinx, and the things inside it were restless too. You thinned them out.' }
          mobs = @(@(1165, 'Sandman', 25), @(1127, 'Hode', 25))
          now = 'Hunt 25 Sandmen and 25 Hodes in the Sograt Desert (moc_fild16).'
          done = 'The desert creatures were fleeing something deeper in the sand. You turned them back.' }
       @{ id = 13; type = 'deliver'; lv = 35; title = 'Grains of Truth'
          re = @{ lv = 44; title = 'Omens of the Desert'
             items = @(@(7006, 'Wing of Red Bat', 8), @(919, 'Animal Skin', 5))
             now = 'Nafisa reads omens in what the Sphinx''s creatures carry. Bring her 8 Wings of Red Bat and 5 Animal Skins in Morroc (156, 286).'
             done = 'The omens spoke of the Pyramids, the tomb of Osiris, whose priests sealed the desert''s evils. The priests are awake again.'
             say = @('Let me lay these out... yes. Yes, I see it.', 'The Pyramids, northwest of the city. The priests of Osiris sealed the evils of the desert there long ago.', 'They are awake again, and they chant a ritual that no longer works. Go to the third level and silence them. No deeper: Osiris himself sleeps on the fourth, and he does not forgive those who wake him.', 'The sands show me the Sphinx again, deeper than you went. The same hands that built the Pyramids built it, and whatever wakes in one stirs the other.') }
          items = @(@(1056, 'Grit', 10), @(1055, 'Earthworm Peeling', 10))
          now = 'Nafisa reads omens in sand. Bring her 10 Grit and 10 Earthworm Peelings in Morroc (156, 286).'
          done = 'The sand spoke of the Pyramids, the tomb of Osiris, whose priests sealed the desert''s evils. The priests are awake again.'
          say = @('Let me pour these out... yes. Yes, I see it.', 'The Pyramids, northwest of the city. The priests of Osiris sealed the evils of the desert there long ago.', 'They are awake again, and they chant a ritual that no longer works. Go to the third level and silence them. No deeper: Osiris himself sleeps on the fourth, and he does not forgive those who wake him.', 'The sands show me something else too. A face of stone, west of the city. The same hands that built the Pyramids built the Sphinx, and whatever wakes in one stirs the other.') }
       @{ id = 14; type = 'boss'; lv = 38; title = 'The Pyramid''s Priest'; map = 'moc_pryd03'; mob = 1041; boss = 'Bound Priest of Osiris'; hp = 9
          re = @{ lv = 50 }
          now = 'Enter the Pyramids northwest of Morroc and reach the third level (moc_pryd03).'
          done = 'You struck down the Bound Priest of Osiris, a mummy still chanting the ritual of a seal it could no longer hold.' }
       @{ id = 15; type = 'report'; lv = 42; title = 'The Seer''s Warning'
          re = @{ lv = 53 }
          now = 'Return to Nafisa in Morroc (156, 286) and tell her about the priest.'
          done = 'Nafisa confirmed it: the seals across Rune-Midgard are weakening together. The oldest of them stands beneath the tower of Geffen, the city of magic. She sent you there with a letter for the magisters.'
          say = @('So the priests failed. Then it is as I feared.', 'Not one seal is weakening. All of them are, together, as if something is pulling at every knot at once.', 'The oldest seal of all lies beneath the tower of Geffen. Take this letter to the magisters there. Our Kafra can send you to Prontera; Geffen is a short walk west from there.', 'And adventurer... the sands say your road has only begun. Beneath the Pyramids lies an older tomb still, where Amon Ra waits. That is a road for another year.', 'One more vision before you go. Across the sea, in a land of temples, a tiger spirit stirs in an old shrine. It guarded a seal like ours, and the shrine has an older keeper still, Lady Tanee. My courier sails ahead of you with a pouch: the sands show me a shaman asking for what is in it.') }
     ) }

  @{ n = 4; title = 'Tower of Geffen'; range = '45-60'
     re = @{ range = '55-75' }
     town = 'geffen'; townName = 'Geffen'; npc = 'Magister Ivo'; sprite = '1_M_WIZARD'; x = 206; y = 116
     costumes = @(5045, 5094, 2252); gift = @(@(504, 30), @(505, 10)); zeny = 25000
     intro = 'Geffen, the city of magic, is built around a great tower. Every mage in the kingdom studied there.'
     # No open road leads out of Morroc either: its Kafras teleport to
     # Prontera, and the Route to Geffen works from there. Shown on every
     # Chapter 4 step, for anyone whose save point is still in Morroc.
     spots = @(
       @{ map = 'morocc'; x = 160; y = 258; name = 'Kafra: Teleport to Prontera (1,200 zeny)' }
       @{ map = 'morocc'; x = 156; y = 97; name = 'Kafra (south): Teleport to Prontera (1,200 zeny)' }
       @{ map = 'moc_fild20'; x = 203; y = 336; name = 'Continental Guard: back to Morroc (then the Kafra)' }
     )
     away = 'Still in Morroc? No open road leads out: its Kafra Employee (160, 258) can teleport you to Prontera (1,200 zeny), and Geffen is a walk west from there.'
     steps = @(
       @{ id = 16; type = 'talk'; lv = 45; title = 'A Letter for the Magister'
          re = @{ lv = 55
             say = @('A letter from the desert seer? She never writes. ...Oh. Oh, dear.', 'What I tell you now, few outside the Magic Academy know. Beneath our tower lies the gate to Geffenia, the realm where demons were sealed away.', 'The orcs to the west have turned savage, and their shamans draw power from the ground. Go down into their dungeon, break their warband and bring me proof.', 'And mind the Orc Hero. He walks the fields east of their village now and then, and he is no common orc. If you see him, go around.') }
          now = 'Bring Nafisa''s letter to Magister Ivo in Geffen (206, 116). From Morroc, a Kafra Employee can teleport you to Prontera; Geffen is a walk west from there.'
          hint = @(
            'No open road leads out of Morroc. Talk to the Kafra Employee in the north of Morroc (160, 258), choose Teleport Service, then Prontera (1,200 zeny).'
            'From Prontera, the Route link leads west to Geffen. Magister Ivo stands near the east gate (206, 116) and is marked on your minimap when you arrive.'
          )
          done = 'Ivo read the letter twice. Beneath Geffen''s tower lies the gate to Geffenia, the sealed realm of demons. The orcs to the west have grown savage, and Ivo suspects why.'
          say = @('A letter from the desert seer? She never writes. ...Oh. Oh, dear.', 'What I tell you now, few outside the Magic Academy know. Beneath our tower lies the gate to Geffenia, the realm where demons were sealed away.', 'The orcs to the west have turned savage, and their shamans draw power from the ground. Break their warband and bring me proof.', 'And mind the Orc Hero. He walks those lands now and then, and he is no common orc. If you see him, go around.') }
       @{ id = 17; type = 'hunt'; lv = 46; title = 'The Orc Warband'; where = 'gef_fild14'
          # Renewal: gef_fild14 has no monsters at all; the Orc Dungeon's second level
          # has Zenorcs (54) and Orc Skeletons (53).
          re = @{ lv = 56; where = 'orcsdun02'
             mobs = @(@(1177, 'Zenorc', 30), @(1152, 'Orc Skeleton', 20))
             now = 'Hunt 30 Zenorcs and 20 Orc Skeletons on the second level of the Orc Dungeon (orcsdun02), beneath the orc village west of Geffen.'
             hint = @(, 'The Kafra Employees in Geffen can teleport you to the Orc Dungeon (1,700 zeny), or the Route link walks you there.') }
          mobs = @(@(1213, 'High Orc', 30), @(1189, 'Orc Archer', 20))
          now = 'Hunt 30 High Orcs and 20 Orc Archers in the orc lands west of Geffen (gef_fild14).'
          done = 'You broke the orc warband. Its shamans had been drawing power from something below the ground.' }
       @{ id = 18; type = 'deliver'; lv = 50; title = 'Trophies of War'
          re = @{ lv = 60
             items = @(@(1044, 'Zenorc''s Fang', 10), @(922, 'Orc''s Fang', 6))
             now = 'Bring Magister Ivo 10 Zenorc''s Fangs and 6 Orc''s Fangs from the orcs, in Geffen (206, 116).' }
          items = @(@(7002, 'Ogre Tooth', 10), @(1063, 'Fang', 10))
          now = 'Bring Magister Ivo 10 Ogre Teeth and 10 Fangs from the orcs, in Geffen (206, 116).'
          done = 'The trophies hummed with dark mana, the same mana that leaks from Geffenia. The seal under the tower is cracking.'
          say = @('Let me feel... yes. Dark mana, soaked into the bone.', 'It is the same mana that leaks from Geffenia. The seal under the tower is cracking, and the orcs drink from the cracks.', 'One more thing about the orcs. A man we expelled from the Academy lives in their village, with a machine he swears shows the past. My scholar Wendel watches him. If you pass that way, help Wendel.', 'Something has already slipped through. Go down into the Geffen Dungeon, to its second level, and stop it before it reaches the city.', 'Dracula himself is said to haunt that same level, and the Doppelganger the one below. The Nightmare is your quarry, not them.') }
       @{ id = 19; type = 'boss'; lv = 54; title = 'Beneath the Tower'; map = 'gef_dun01'; mob = 1061; boss = 'Nightmare of the Tower'; hp = 10
          re = @{ lv = 65 }
          now = 'Enter the Geffen Dungeon beneath the tower and reach its second level (gef_dun01).'
          done = 'You defeated the Nightmare of the Tower, a demon-touched steed that had slipped through the cracks of the seal.' }
       @{ id = 20; type = 'report'; lv = 57; title = 'The Fallen Kingdom'
          re = @{ lv = 70 }
          now = 'Report to Magister Ivo in Geffen (206, 116).'
          done = 'Ivo will reinforce the seal, but he warned that Geffen''s wards were built with knowledge from Glast Heim, the fallen kingdom. He sent you to the knights of Al De Baran to learn what happened there.'
          say = @('You did it. The Academy will reinforce the seal tonight.', 'Two letters came this week, from opposite ends of the sea. In Amatsu, a fox spirit haunts the lord''s mother. In Kunlun, the chief''s ancestral sword was stolen. I sent Lise to Amatsu, and Kunlun''s scribe waits for you. If you have time to sail, go.', 'But I must confess something. Our wards were built with knowledge taken from Glast Heim, the kingdom that fell into darkness.', 'If the wards fail, the answer is there. A knight in Al De Baran still guards its memory. Find Sir Aldric.') }
     ) }

  @{ n = 5; title = 'Ghosts of Glast Heim'; range = '60-75'
     re = @{ range = '75-90' }
     town = 'aldebaran'; townName = 'Al De Baran'; npc = 'Sir Aldric'; sprite = '4_M_KNIGHT_BLACK'; x = 142; y = 63
     costumes = @(5181, 5017, 5363); gift = @(@(504, 40), @(505, 20)); zeny = 40000
     intro = 'Al De Baran is the city of canals and the great Clock Tower, north of Prontera and close to the ruins of Glast Heim.'
     steps = @(
       @{ id = 21; type = 'talk'; lv = 60; title = 'The Last Knight'
          re = @{ lv = 75 }
          now = 'Go to Al De Baran, the city of the Clock Tower, and find Sir Aldric near the south gate (142, 63).'
          done = 'Sir Aldric is the last of an order that once guarded Glast Heim. He told you how the kingdom fell: its king bargained with darkness, and the Dark Lord answered.'
          say = @('Ivo sent you? Then you already know more than most.', 'I am the last of the order that guarded Glast Heim. Our king bargained with darkness for power, and the Dark Lord answered. The kingdom fell in a single night.', 'Lately the Clock Tower here has been wrong. It was built to keep time with the old seals. Clear its first floor and we will see.', 'The great gears above and below are slipping too. The fourth floor and the fourth basement are sealed by the old alchemists'' gates, and their Gatekeepers want a key. That can wait until you are ready.') }
       @{ id = 22; type = 'hunt'; lv = 61; title = 'Time Out of Joint'; where = 'c_tower1'
          re = @{ lv = 76 }
          mobs = @(@(1195, 'Rideword', 30), @(1199, 'Punk', 30))
          now = 'Strange things walk the Clock Tower. Hunt 30 Ridewords and 30 Punks on its first floor (c_tower1).'
          done = 'The Clock Tower''s haunted books and spores fell silent. Aldric said the tower was built to keep time with the seals.' }
       @{ id = 23; type = 'deliver'; lv = 65; title = 'Pages of the Past'
          re = @{ lv = 80
             items = @(@(1097, 'Worn Out Page', 5), @(7001, 'Mould Powder', 5))
             now = 'Bring Sir Aldric 5 Worn Out Pages and 5 Mould Powder in Al De Baran (142, 63); he can piece together the old records.' }
          items = @(@(1097, 'Worn Out Page', 10), @(7001, 'Mould Powder', 10))
          now = 'Bring Sir Aldric 10 Worn Out Pages and 10 Mould Powder in Al De Baran (142, 63); he can piece together the old records.'
          done = 'The pages spoke of Glast Heim''s knights, cursed to guard their ruined halls forever.'
          say = @('These pages... I know this hand. These are records from Glast Heim.', 'My brothers of the order. Cursed to guard the ruined halls forever, the records say. Even in death they keep their posts.', 'And this one is no Glast Heim page. A ship''s voyage log, about an island where turtles march like soldiers under a general. The old sailors of Alberta still tell of it.', 'One of them walks the churchyard. If anyone can tell us what is happening to the seals, it is him. Go to Glast Heim, west of Geffen.', 'Beware: the Dark Lord himself walks that churchyard at times. If the air turns cold and the dead start to gather, leave.') }
       @{ id = 24; type = 'boss'; lv = 68; title = 'The Churchyard'; map = 'gl_chyard'; mob = 1192; boss = 'Wraith of the Fallen Order'; hp = 10
          re = @{ lv = 84 }
          now = 'Travel to Glast Heim, west of Geffen, and enter its churchyard (gl_chyard).'
          done = 'You laid to rest the Wraith of the Fallen Order, once a knight of Aldric''s own order. Before it faded, it spoke of the machines beneath the floating city.' }
       @{ id = 25; type = 'report'; lv = 72; title = 'A Knight''s Salute'
          now = 'Tell Sir Aldric in Al De Baran (142, 63) what the wraith said.'
          done = 'Aldric saluted you as a knight would. The floating city is Juno, capital of the Schwarzwald Republic. He wrote to the Sages there on your behalf.'
          say = @('He is at peace, then. Thank you. I could never have raised my sword against him.', 'The machines beneath the floating city... he means Juno, the capital of the Schwarzwald Republic, and the ruins of Juperos below it.', 'I have written to the Sages of Juno. Ask for Sage Elisha. And... it was an honor, friend.')
          # Renewal: Chapter 6 (Einbech) comes first.
          re = @{ lv = 88
             done = 'Aldric saluted you as a knight would. The machines the wraith spoke of lie in the Schwarzwald Republic, and an old friend of his, the foreman of the Einbech mine, has written of crystals that hum in the dark. Aldric sent you to him.'
             say = @('He is at peace, then. Thank you. I could never have raised my sword against him.', 'The machines beneath the floating city... that is the Schwarzwald Republic. Juno, and the ruins of Juperos below it.', 'But there is a closer road. An old friend of mine, Gustav, is foreman of the mine in Einbech. His last letter spoke of black crystals that hum in the dark, and of dead miners walking.', 'Go to him first. I have written to the Sages of Juno as well. And... it was an honor, friend.') } }
     ) }

  @{ n = 6; title = 'The Floating City'; range = '75-90'
     re = @{ range = '105-120' }
     town = 'yuno'; townName = 'Juno'; npc = 'Sage Elisha'; sprite = '4_M_SAGE_C'; x = 156; y = 47
     costumes = @(5170, 2246, 2258); gift = @(@(607, 3), @(504, 50)); zeny = 60000
     intro = 'Juno floats above the clouds as the capital of the Schwarzwald Republic, a land of sages and machines.'
     steps = @(
       @{ id = 26; type = 'talk'; lv = 75; title = 'The Sage of Juno'
          now = 'Travel to Juno, the floating capital of the Schwarzwald Republic, and meet Sage Elisha near the southern entrance (156, 47).'
          done = 'Elisha studies Juperos, the ruins of an ancient civilization beneath the Republic. Its machines have begun to wake on their own.'
          re = @{ lv = 105
             hint = @(
               'From Einbech, the Train Station Staff (39, 215) takes you back to Einbroch (200 zeny).'
               'In Einbroch, enter the airport (64, 207), pay the Airport Staff (1,200 zeny) and ride the airship until it lands in Juno. Sage Elisha stands near Juno''s southern entrance (156, 47).'
             )
             say = @('Aldric wrote to me, and Gustav''s message came on the morning airship. Welcome to Juno.', 'Beneath the Republic lie the ruins of Juperos, a civilization older than any kingdom. Their machines have slept for ages.', 'Now they are waking on their own. Thin them out in the ruins, and I will learn what I can from what they leave behind.') }
          say = @('Aldric''s letter arrived yesterday. Welcome to Juno.', 'Beneath the Republic lie the ruins of Juperos, a civilization older than any kingdom. Their machines have slept for ages.', 'Now they are waking on their own. Thin them out in the ruins, and I will learn what I can from what they leave behind.') }
       @{ id = 27; type = 'hunt'; lv = 76; title = 'The Waking Machines'; where = 'juperos_01'
          re = @{ lv = 107 }
          mobs = @(,@(1676, 'Venatu', 40))
          now = 'Hunt 40 Venatu in the Juperos ruins (juperos_01).'
          done = 'You stopped the patrol of waking Venatu machines in the upper ruins.' }
       @{ id = 28; type = 'deliver'; lv = 80; title = 'Salvage'
          # Renewal: these Venatu drop no Steel; the other kind on the map (1677) does.
          re = @{ lv = 110
             items = @(@(7317, 'Rusty Screw', 8), @(999, 'Steel', 1))
             now = 'Bring Sage Elisha 8 Rusty Screws and 1 Steel from the machines, in Juno (156, 47).' }
          items = @(@(7317, 'Rusty Screw', 15), @(999, 'Steel', 2))
          now = 'Bring Sage Elisha 15 Rusty Screws and 2 Steel from the machines, in Juno (156, 47).'
          done = 'The machines ran on a crystal energy older than the seals themselves, the same energy the seals were made from.'
          say = @('Fascinating. Look at the wear on these screws. These machines have been running for days.', 'And their power source... it is the same crystal energy the old seals are made from. The machines and the seals were built by the same hands.', 'At the heart of the ruins sits the Core. Whatever is waking them answers to it. Go and put it to sleep.') }
       # Navigation can't route into jupe_core: the way down is the Juperos
       # elevator (rAthena quests_juperos.txt), all scripted warps. The route
       # leads to its first step, and the hint walks through the rest.
       @{ id = 29; type = 'boss'; lv = 83; title = 'The Core'; map = 'jupe_core'; mob = 1670; boss = 'Awakened Core Guardian'; hp = 10
          re = @{ lv = 114 }
          items = @(@(7356, 'Crest Piece (Purple)', 1), @(7357, 'Crest Piece (Green)', 1), @(7358, 'Crest Piece (Orange)', 1), @(7359, 'Crest Piece (Blue)', 1))
          route = @('juperos_01', 100, 91, 'The way down: juperos_01')
          now = 'Reach the heart of the ruins, the Juperos Core (jupe_core), through the old elevator beneath Juperos. Bring 4 Crest Pieces from Venatu.'
          hint = @(
            'Collect the 4 Crest Pieces (Purple, Green, Orange, Blue). Only Venatu drop them, in the Juperos ruins. The elevator lever needs all 4.'
            'Juperos 1: step on the strange spot at (100, 91) and agree, or wait 10 seconds. You drop down to Juperos 2.'
            'Juperos 2: destroy the 3 Gate Switches on the outer islands, at (24, 275), (240, 29) and (282, 183). The ground shakes, and a portal opens in the centre (130, 149) for about 10 minutes. Broken switches come back after 20 minutes.'
            'Security halls: each pedestal checks one Crest Piece (it is not taken). Then an alarm sends Venatu and Dimik at you. Survive, and a portal takes you on.'
            'Elevator room: put all 4 Crest Pieces in the lever (they are used up) and pull it. Defeat the 9 guards within 2 minutes, or you are thrown out.'
            'Elevator ride: 4 waves of 8 guards, a new wave every 30 seconds. Kill all 32 within about 2 minutes, or you are thrown out to the gate hall (the 4 pieces are lost). When the last one falls, step on the portal at (41, 33), or wait and you are moved to the Core anyway. The Awakened Core Guardian rises a few seconds later.'
            'If you fall in the elevator, the lever has kept your 4 pieces. Bring a new set of 4 and start again from Juperos 1. The elevator rooms only work while the lever is running, so no Warper or teleport can take you there.'
          )
          # Clickable spots per map: the Journal shows the ones of the map you
          # are on (Navigation draws a path inside your own map even where it
          # can't route between maps). sw = a watched monster (see watch).
          spots = @(
            @{ map = 'juperos_01'; x = 100; y = 91; name = 'Strange spot: the way down to Juperos 2' }
            @{ map = 'juperos_02'; x = 24; y = 275; name = '1st Gate Switch'; sw = 1 }
            @{ map = 'juperos_02'; x = 240; y = 29; name = '2nd Gate Switch'; sw = 2 }
            @{ map = 'juperos_02'; x = 282; y = 183; name = '3rd Gate Switch'; sw = 3 }
            @{ map = 'juperos_02'; x = 130; y = 149; name = 'Centre portal'; sw = 0 }
            @{ map = 'jupe_gate'; x = 28; y = 145; name = 'Left hall gate' }
            @{ map = 'jupe_gate'; x = 71; y = 145; name = 'Right hall gate' }
            @{ map = 'jupe_gate'; x = 49; y = 55; name = 'Elevator gate (after a hall''s lever)' }
            @{ map = 'jupe_area1'; x = 88; y = 224; name = 'Pedestal 1 (Purple)' }
            @{ map = 'jupe_area1'; x = 25; y = 238; name = 'Pedestal 2 (Green)' }
            @{ map = 'jupe_area1'; x = 36; y = 146; name = 'Pedestal 3 (Orange)' }
            @{ map = 'jupe_area1'; x = 50; y = 49; name = 'Pedestal 4 (Blue)' }
            @{ map = 'jupe_area1'; x = 112; y = 162; name = 'Hall lever (back to the gate)' }
            @{ map = 'jupe_area2'; x = 74; y = 224; name = 'Pedestal 1 (Purple)' }
            @{ map = 'jupe_area2'; x = 138; y = 238; name = 'Pedestal 2 (Green)' }
            @{ map = 'jupe_area2'; x = 127; y = 146; name = 'Pedestal 3 (Orange)' }
            @{ map = 'jupe_area2'; x = 113; y = 49; name = 'Pedestal 4 (Blue)' }
            @{ map = 'jupe_area2'; x = 51; y = 162; name = 'Hall lever (back to the gate)' }
            @{ map = 'jupe_ele_r'; x = 51; y = 98; name = 'Elevator lever (uses all 4 Crest Pieces)' }
            @{ map = 'jupe_ele'; x = 41; y = 33; name = 'Portal to the Core (after the 4th wave)' }
          )
          # The Gate Switches are monsters of rAthena's "3F Gate Switch#jupe";
          # the server tells the Journal which are still standing.
          watch = @{ map = 'juperos_02'; event = '3F Gate Switch#jupe::OnMyMobDead'; names = @('1st Gate Switch', '2nd Gate Switch', '3rd Gate Switch') }
          done = 'You destroyed the Awakened Core Guardian. Its last broadcast was a map of Arunafeltz, far to the north.' }
       @{ id = 30; type = 'report'; lv = 87; title = 'The Guardians'' Purpose'
          now = 'Report to Sage Elisha in Juno (156, 47).'
          done = 'Elisha believes the guardians were built to watch over the seals. With them failing, the seals'' last line is gone. She sent you to the Church of Freya in Rachel.'
          say = @('A map of Arunafeltz? Then I was right.', 'The guardians were built to watch over the seals. They woke because the seals are failing, and now they are failing too.', 'The Church of Freya in Rachel has watched the north for a thousand years. Find Sister Ilyana. Tell her a sage of Juno sent you.')
          # Renewal: the New World chapters come first.
          re = @{ lv = 117
             done = 'Elisha believes the guardians were built to watch over the seals. The Core''s last broadcast showed two places: Arunafeltz, and the rift that opened when Morroc fell. The three kingdoms are sending an expedition through the rift, so she sent you to join it first.'
             say = @('A map of Arunafeltz? And this one... the rift beneath Morroc. Then I was right.', 'The guardians were built to watch over the seals. They woke because the seals are failing, and the deepest wound of all is the rift that opened when Morroc fell.', 'Rune-Midgard, the Republic and Arunafeltz have formed an Alliance to send an expedition through it. Their Recruiter for the Brave is in Prontera Castle. Join them. Rachel can wait until you return.', 'The Eden Group''s Cat Paw Merchants smuggle adventurers across too, for a fee. Their agent Geck can send you, if you would rather not wait for the Alliance.') } }
     ) }

  @{ n = 7; title = 'Fire and Faith'; range = '90-99'
     re = @{ range = '130-140' }
     town = 'rachel'; townName = 'Rachel'; npc = 'Sister Ilyana'; sprite = '4_F_SISTER'; x = 141; y = 146
     costumes = @(5306, 2282, 5414); gift = @(,@(607, 5)); zeny = 90000
     intro = 'Rachel is the holy city of the Arunafeltz States, seat of the Church of the goddess Freya.'
     steps = @(
       @{ id = 31; type = 'talk'; lv = 90; title = 'The Church of Freya'
          # Renewal: you come home from El Dicastes, through the rift.
          re = @{ lv = 130
             hint = @(
               'From El Dicastes: on dic_fild01, the way south (69, 23) leads to dic_fild02. Its Dimensional Transporter (241, 31) takes you into the Dimensional Gap.'
               'In the Gap, the way south (122, 48) leads to the rift gorge (moc_fild22b). The Rift Guard there (37, 196) walks you out to Morroc''s fields (moc_fild20).'
               'From there, follow the Route link to Rachel, holy city of Arunafeltz. Sister Ilyana is at (141, 146).'
             )
             spots = @(
               @{ map = 'dic_fild01'; x = 69; y = 23; name = 'Way south to dic_fild02' }
               @{ map = 'dic_fild02'; x = 241; y = 31; name = 'Dimensional Transporter: into the Gap' }
               @{ map = 'dali'; x = 122; y = 48; name = 'Way to the rift gorge' }
               @{ map = 'moc_fild22b'; x = 37; y = 196; name = 'Rift Guard: out to Morroc''s fields' }
             )
             say = @('May Freya''s light guide you. Elisha wrote that you would come, and a letter from beyond the rift came after hers.', 'A shard of seal crystal, from the Sapha? Then the songs on both sides of the rift tell the same story.', 'Our oracles see fire under Thor''s Volcano, south of Veins. And in the cities of the kingdom, an old mark has begun to appear. We call it the Sign.', 'Go to the volcano. Its creatures are restless, and we must know why.') }
          now = 'Travel to Rachel, holy city of Arunafeltz, and find Sister Ilyana (141, 146).'
          done = 'Ilyana serves the goddess Freya. The church''s oracles have seen fire under Thor''s Volcano, and an old mark appearing in the cities: the Sign.'
          say = @('May Freya''s light guide you. Elisha wrote that you would come.', 'Our oracles see fire under Thor''s Volcano, south of Veins. And in the cities of the kingdom, an old mark has begun to appear. We call it the Sign.', 'Go to the volcano. Its creatures are restless, and we must know why.') }
       @{ id = 32; type = 'hunt'; lv = 91; title = 'Under the Mountain'; where = 'thor_v01'
          re = @{ lv = 131 }
          mobs = @(@(1837, 'Fire Imp', 30), @(1833, 'Kasa', 15))
          now = 'Hunt 30 Fire Imps and 15 Kasa in Thor''s Volcano (thor_v01), south of Veins.'
          done = 'You drove back the fire creatures of the volcano''s first level.' }
       @{ id = 33; type = 'deliver'; lv = 93; title = 'Embers for the Oracles'
          re = @{ lv = 133
             items = @(@(7097, 'Burning Heart', 3), @(7122, 'Burning Hair', 5))
             now = 'Bring Sister Ilyana 3 Burning Hearts and 5 Burning Hair, in Rachel (141, 146).' }
          items = @(@(7097, 'Burning Heart', 5), @(7122, 'Burning Hair', 10))
          now = 'Bring Sister Ilyana 5 Burning Hearts and 10 Burning Hair, in Rachel (141, 146).'
          done = 'The embers were demon fire, Geffenia''s breath, leaking all the way to Arunafeltz.'
          say = @('Give them here... careful, they still burn.', 'This is not the volcano''s fire. It is demon fire. Geffenia''s breath, leaking all the way to Arunafeltz.', 'Something on the second level of the volcano is carrying it. The oracles saw it with the Sign on its brow. End it.') }
       @{ id = 34; type = 'boss'; lv = 95; title = 'The Ember Herald'; map = 'thor_v02'; mob = 1833; boss = 'Ember Herald'; hp = 10
          re = @{ lv = 136 }
          now = 'Descend to the second level of Thor''s Volcano (thor_v02).'
          done = 'You quenched the Ember Herald, a fire spirit bearing the Sign on its brow.' }
       @{ id = 35; type = 'report'; lv = 97; title = 'The Sign'
          re = @{ lv = 138 }
          now = 'Return to Sister Ilyana in Rachel (141, 146).'
          done = 'Ilyana understood at last: the Sign calls the hero who will stand at Geffenia''s gate. Look for the mysterious Sign near Prontera''s north gate (147, 305) to begin The Sign, Rune-Midgard''s own legend. When you are ready, a Valkyrie''s herald waits in Hugel.'
          say = @('The Herald bore the Sign? Then the prophecy is true.', 'The Sign calls a hero to stand at the gate of Geffenia. Freya has watched your road since Prontera, I think. It was no accident that it led you here.', 'Look for the Sign near Prontera''s north gate, and follow where it leads. And when you are ready, go to Hugel. A Valkyrie''s herald has been asking for you.') }
     ) }

  @{ n = 8; title = 'Twilight of the Gods'; range = '99+'
     re = @{ range = '140-146' }
     town = 'hugel'; townName = 'Hugel'; npc = 'Brynjar the Herald'; sprite = '4_M_KNIGHT_GOLD'; x = 101; y = 56
     costumes = @(5171, 5292, 5584); gift = @(@(616, 1), @(607, 10)); zeny = 150000
     intro = 'Hugel is a quiet seaside village in the far north, where boats leave for the temple of Odin.'
     steps = @(
       @{ id = 36; type = 'talk'; lv = 99; title = 'The Valkyrie''s Herald'
          re = @{ lv = 140 }
          now = 'Go to Hugel, the seaside village in the far north, and find Brynjar the Herald (101, 56).'
          done = 'Brynjar speaks for the Valkyries of Odin''s Temple. The seals were forged with divine power, and as the Twilight of the Gods, Ragnarok, draws near, that power is ebbing.'
          say = @('So you are the one the Sign has been calling. The Valkyries have watched you since Prontera.', 'Hear the truth. Every seal in Midgard was forged with the power of the gods. As the Twilight of the Gods draws near, that power ebbs, and the seals fail.', 'Odin''s Temple lies across the sea. Its fallen warrior-spirits no longer serve. Cut them down.', 'The Boatman by the eastern pier of Hugel sails there for a few coins.') }
       # Odin's Temple is reached only by the Boatman (rAthena quests_hugel.txt,
       # Boatman#hugel: 800 zeny, no quest), so Navigation can't route there.
       @{ id = 37; type = 'hunt'; lv = 100; title = 'Fallen Spirits'; where = 'odin_tem02'
          re = @{ lv = 141 }
          mobs = @(@(1752, 'Skogul', 30), @(1753, 'Frus', 30))
          route = @('hugel', 209, 109, 'Boatman to Odin''s Temple: hugel')
          now = 'Hunt 30 Skogul and 30 Frus on the second floor of Odin''s Temple (odin_tem02). The Boatman in Hugel (209, 109) sails there.'
          hint = @(
            'Hugel: talk to the Boatman (209, 109) and choose Sure! (800 zeny). He sails you to the first floor of Odin''s Temple (odin_tem01).'
            'First floor: walk to the east end. The paths at (378, 182) and (383, 334) lead up to the second floor (odin_tem02), the hunting ground.'
            'To go home, the Boatman on the first floor (93, 146) sails you back to Hugel.'
          )
          spots = @(
            @{ map = 'odin_tem01'; x = 378; y = 182; name = 'Way up to the second floor' }
            @{ map = 'odin_tem01'; x = 383; y = 334; name = 'Way up to the second floor (north)' }
          )
          done = 'You cut down the fallen warrior-spirits that once served the Valkyries.' }
       @{ id = 38; type = 'deliver'; lv = 103; title = 'Runes of the Gods'
          re = @{ lv = 142
             items = @(,@(7511, 'Rune of Darkness', 5))
             now = 'Bring Brynjar 5 Runes of Darkness in Hugel (101, 56).' }
          items = @(,@(7511, 'Rune of Darkness', 10))
          now = 'Bring Brynjar 10 Runes of Darkness in Hugel (101, 56).'
          hint = @(, $odinHomeHint)
          spots = $odinHome
          done = 'With the runes, Brynjar could read the gods'' own seal-craft: the seals hold only while heroes stand for them.'
          say = @('Runes of the gods, darkened. Let me read them.', 'It is written plainly. The seals were never meant to hold forever. They hold only while heroes stand for them.', 'One last shade haunts the temple''s upper hall, a Valkyrie who lost her way. Free her.') }
       @{ id = 39; type = 'boss'; lv = 106; title = 'The Fallen Valkyrie'; map = 'odin_tem03'; mob = 1752; boss = 'Fallen Valkyrie''s Shade'; hp = 12
          re = @{ lv = 144 }
          route = @('hugel', 209, 109, 'Boatman to Odin''s Temple: hugel')
          now = 'Ascend to the upper hall of Odin''s Temple (odin_tem03). The Boatman in Hugel (209, 109) sails there.'
          hint = @(
            'Hugel: talk to the Boatman (209, 109) and choose Sure! (800 zeny). He sails you to the first floor of Odin''s Temple (odin_tem01).'
            'First floor: walk to the east end. The paths at (378, 182) and (383, 334) lead up to the second floor (odin_tem02).'
            'Second floor: the ways up at (153, 349) and (261, 377) lead to the upper hall (odin_tem03). The Fallen Valkyrie''s Shade appears a few seconds after you arrive.'
          )
          spots = @(
            @{ map = 'odin_tem01'; x = 378; y = 182; name = 'Way up to the second floor' }
            @{ map = 'odin_tem01'; x = 383; y = 334; name = 'Way up to the second floor (north)' }
            @{ map = 'odin_tem02'; x = 153; y = 349; name = 'Way up to the upper hall' }
            @{ map = 'odin_tem02'; x = 261; y = 377; name = 'Way up to the upper hall (east)' }
          )
          done = 'You defeated the Fallen Valkyrie''s Shade, and the temple fell quiet for the first time in years.' }
       @{ id = 40; type = 'report'; lv = 110; title = 'Champion of Rune-Midgard'
          now = 'Return to Brynjar the Herald in Hugel (101, 56).'
          hint = @(, $odinHomeHint)
          spots = $odinHome
          done = 'Brynjar knelt. The Norns weave every fate in Midgard, but a hero who stands where the seals fail can change what was written. Your Chronicle is complete: you are a Champion of Rune-Midgard. Legends still wait: The Sign and Geffenia, Thanatos Tower, the Abyss Lakes and the Endless Tower.'
          say = @('The temple is quiet. The Valkyries thank you.', 'The Norns weave every fate in Midgard. But a hero who stands where the seals fail can change what was written. That is what you have done.', 'Rise, Champion of Rune-Midgard. Your Chronicle is complete, but legends still wait: the Sign, Thanatos Tower, the Abyss Lakes, the Endless Tower.')
          # Renewal: not the end yet. On to Mora, beyond the rift.
          re = @{ lv = 146; title = 'The Light of Bifrost'
             done = 'Brynjar thanked you in the Valkyries'' name, but the temple had shown them one more failing light: Bifrost, the rainbow bridge beyond the rift, where the Laphine of Mora live. He sent you there.'
             say = @('The temple is quiet. The Valkyries thank you.', 'But from the upper hall they saw one more light failing. Bifrost, the rainbow bridge of the gods, stands beyond the rift you crossed, in the land of the Laphine.', 'The Laphine village of Mora lies at its foot. Its elder, Mirrel, has kept the bridge''s light for longer than any human has lived. Go to him.', 'The Cat Paw Merchants will take you back through the rift: their agent Geck in the Eden Group, or the cat by the wall east of Morroc.') } }
     ) }

)

# Renewal's Story (concept v3, MondoTruth 2026-10-26 and 2026-10-28): Ragnarok's
# own episodes, each open as soon as a character reaches the minimum level RO
# itself checks (lv), none waiting for another. Where RO itself asks for
# another quest first, 'needs' says what ("Ragnarok asks first"). The Chronicle
# adds no NPC, quest-window entry or reward: each step is a part of RO's quest,
# done when its cond holds (RO's own variables; 'var' is the one whose value
# ticks the step's parts and spots). An episode is done when 'end' holds (by
# default the last step's cond). An episode whose later steps are not written
# yet ('more') shows its first ones; past them it is "under way" until 'end'.
# Levels and starts: rathena-pin, checked 2026-10-28.
$episodes = @(
  # quests/quests_morocc.txt (loaded on Renewal too): rebirth_moc_edq 0 -> 8.
  # The messengers (Lv 80) only tell the story; the Official signs you up.
  @{ episode = '12'; title = 'Rebirth of Satan Morocc'; lv = 80
     intro = 'Satan Morocc, the demon sealed under Morroc for centuries, has broken free. His rising tore Morroc apart and twisted the Sograt Desert around it, and the Continental Guard of Prontera has closed the desert. Its messengers are asking renowned adventurers to join the fight. This is Ragnarok''s own story: the Chronicle only shows the way, and RO gives its rewards.'
     party = 'Facing Satan Morocc (step 5) needs a party of at least 2 people online.'
     steps = @(
       @{ title = 'The Continental Guard'
          cond = 'rebirth_moc_edq >= 1'
          route = @('morocc', 176, 101, 'Continental Official')
          now = 'RO quest: the Continental Guard is recruiting against Satan Morocc. In ruined Morroc, volunteer with the Continental Official (176, 101): choose I''m here to volunteer.'
          hint = @(
            'No open road leads into Morroc: a Kafra Employee in Payon (175, 226) or Prontera (146, 89) teleports you there (Teleport Service, then Morocc, 1,200 zeny).'
            'The Continental Messengers in Prontera (164, 304), Geffen (128, 90), Payon (200, 113), Alberta (127, 64) and Al De Baran (135, 128) tell the story first. Talking to them is not needed.'
          )
          spots = @(
            @{ map = 'payon'; x = 175; y = 226; name = 'Kafra: Teleport to Morocc (1,200 zeny)' }
            @{ map = 'prontera'; x = 146; y = 89; name = 'Kafra: Teleport to Morocc (1,200 zeny)' }
            @{ map = 'morocc'; x = 176; y = 101; name = 'Continental Official' }
          )
          done = 'In ruined Morroc you volunteered for the Continental Guard, and the Official sent you to its chief, Balrog.' }
       @{ title = 'Chief Balrog'
          cond = 'rebirth_moc_edq >= 2'
          route = @('morocc', 159, 113, 'Chief Balrog')
          now = 'RO quest: Chief Balrog (morocc, 159, 113) leads the Continental Guard. Ask to join, and do not take no for an answer.'
          hint = @(
            'Choose I want to join the Continental Guard., then Ask Again, You''ve just got to let me join!, Give me a chance to prove myself! and No problem.'
          )
          spots = @(
            @{ map = 'morocc'; x = 159; y = 113; name = 'Chief Balrog' }
          )
          done = 'Balrog turned you away three times, then gave you a test: the Guard''s bonfires are short of firewood, and the monsters of the Magma Dungeon carry flames that never go out.' }
       @{ title = 'Everlasting Flames'
          cond = 'rebirth_moc_edq >= 3'
          items = @(, @(7098, 'Live Coal', 30))
          route = @('yuno_fild03', 32, 139, 'Entrance to the Magma Dungeon')
          now = 'RO quest: bring Chief Balrog in Morroc (159, 113) 30 Live Coals for the Guard''s bonfires.'
          hint = @(
            'Live Coals drop from Blazers (level 101) on both floors of the Magma Dungeon (mag_dun01 and mag_dun02). Its entrance is on the field south of Juno (yuno_fild03, 32, 139).'
            'Then back to Morroc: a Kafra Employee in Payon (175, 226) or Prontera (146, 89) teleports you there.'
          )
          spots = @(
            @{ map = 'yuno_fild03'; x = 32; y = 139; name = 'Entrance to the Magma Dungeon' }
            @{ map = 'payon'; x = 175; y = 226; name = 'Kafra: Teleport to Morocc (1,200 zeny)' }
            @{ map = 'prontera'; x = 146; y = 89; name = 'Kafra: Teleport to Morocc (1,200 zeny)' }
            @{ map = 'morocc'; x = 159; y = 113; name = 'Chief Balrog' }
          )
          done = 'Balrog counted all thirty coals and was still not satisfied: the Republic''s mercenaries in the Guard are wilting in the desert heat.' }
       @{ title = 'Hearts of Ice'
          cond = 'rebirth_moc_edq >= 4'
          items = @(, @(7561, 'Glacial Heart', 50))
          route = @('ra_fild01', 233, 333, 'Entrance to the Ice Cave')
          now = 'RO quest: bring Chief Balrog in Morroc (159, 113) 50 Glacial Hearts to cool the Republic''s mercenaries.'
          hint = @(
            'Glacial Hearts drop from the monsters of the Ice Cave near Rachel: Siromas (level 98), Snowiers (103), Gazetis (106) and Ice Titans (110). Its entrance is on the field east of Rachel (ra_fild01, 233, 333).'
            'Then back to Morroc: a Kafra Employee in Payon (175, 226) or Prontera (146, 89) teleports you there.'
          )
          spots = @(
            @{ map = 'ra_fild01'; x = 233; y = 333; name = 'Entrance to the Ice Cave' }
            @{ map = 'payon'; x = 175; y = 226; name = 'Kafra: Teleport to Morocc (1,200 zeny)' }
            @{ map = 'prontera'; x = 146; y = 89; name = 'Kafra: Teleport to Morocc (1,200 zeny)' }
            @{ map = 'morocc'; x = 159; y = 113; name = 'Chief Balrog' }
          )
          done = 'Balrog made you a member of the Continental Guard and gave you its Certificate. Your mission: Satan Morocc himself, on the desert field he has claimed.' }
       # moc_fild21's event (quests_morocc.txt 894-2085): the Guard lets in a
       # party of 2+ online with the Certificate (7826); the Group of Evil
       # calls Satan Morocc (1916) for 90 min; after his death the Time-Space
       # Gap gives the skin (7820) for 30 min, and the field is shut for 6 h
       # ($@re_moc, a server variable: a restart opens it again).
       @{ title = 'Satan Morocc'
          cond = 'rebirth_moc_edq >= 6'
          route = @('moc_fild20', 38, 183, 'Continental Guard: Enter the Field to Investigate')
          now = 'RO quest: with your party, face Satan Morocc on the desert field he has claimed (moc_fild21), and bring back proof of his defeat.'
          hint = @(
            'Leave Morroc by its east gate (299, 207). A Continental Guard there (moc_fild20, 38, 183) sends members of the Guard onto the field: choose Enter the Field to Investigate. Keep the Continental Guard Certificate in your bag and come in a party of at least 2 people online. Whether party bots count here has not been tested.'
            'On moc_fild21, the Group of Evil (178, 239) calls up Satan Morocc: level 151, 7,000,000 HP. If he is not defeated within 90 minutes, he leaves.'
            'When he falls, touch the Time-Space Gap (177, 239) within 30 minutes: you pick up a Piece of Morocc Skin. After that the field stays shut for 6 hours; restarting the game opens it again.'
          )
          spots = @(
            @{ map = 'morocc'; x = 299; y = 207; name = 'East gate of Morroc' }
            @{ map = 'moc_fild20'; x = 38; y = 183; name = 'Continental Guard: Enter the Field to Investigate' }
            @{ map = 'moc_fild21'; x = 178; y = 239; name = 'Group of Evil (calls Satan Morocc)' }
            @{ map = 'moc_fild21'; x = 177; y = 239; name = 'Time-Space Gap (after his defeat)' }
          )
          done = 'Your party drove Satan Morocc back into the time-space gap, and you took a piece of his skin as proof.' }
       @{ title = 'Proof of Victory'
          cond = 'rebirth_moc_edq >= 8'
          items = @(, @(7820, 'Piece of Morocc Skin', 1))
          route = @('morocc', 159, 113, 'Chief Balrog')
          now = 'RO quest: bring the Piece of Morocc Skin to Chief Balrog in Morroc (159, 113) and choose your reward: the Seal of the Continental Guard, a Morocc Charm Stone or a Morocc Ring.'
          hint = @(
            'From moc_fild21, the warp at the field''s entrance leads back. Morroc is through its east gate.'
          )
          spots = @(
            @{ map = 'morocc'; x = 159; y = 113; name = 'Chief Balrog' }
          )
          done = 'Balrog took the proof, and the Continental Guard paid you with EXP and a reward of your choice. Satan Morocc is not gone, but he is held back.' }
     ) }

  # quests/quests_13_1.txt, Onward to the Other World: ep13_ryu 0 -> 100 (Lv
  # 70: the Promotional Staff in Izlude). RO's other way in, the Cat Paw
  # Agent (Agent Geck in the Eden Group, ep13_start = 100), counts for the
  # whole episode. Renewal's Chapter 8 from 2026-10-26 to 2026-10-28.
  @{ episode = '13.1'; title = 'Onward to the Other World'; lv = 70
     intro = 'When Morroc fell, a rift opened in its ruins, and beyond it lies a world no map of Rune-Midgard shows. Rune-Midgard, the Schwarzwald Republic and Arunafeltz have joined in an Alliance to send an expedition through it, and its recruiters are looking for adventurers. This is Ragnarok''s own story: the Chronicle only shows the way, and RO gives its rewards.'
     steps = @(
       @{ title = 'The Recruiter for the Brave'
          cond = 'ep13_ryu >= 1 || ep13_start >= 100'
          route = @('prontera', 156, 358, 'Gate of Prontera Castle')
          now = 'RO quest: in Prontera Castle, the Recruiter for the Brave (prt_cas, 207, 165) signs up adventurers for the expedition through the rift. Talk to him and choose Yes, I am interested.'
          hint = @(
            'The castle gate is at the north end of Prontera (156, 358). The Recruiter stands a few steps inside, to the north-west.'
            'The quest window (Alt+U) follows it as Onward to the Other World.'
          )
          spots = @(
            @{ map = 'prontera'; x = 156; y = 358; name = 'Gate of Prontera Castle' }
            @{ map = 'prt_cas'; x = 207; y = 165; name = 'Recruiter for the Brave' }
          )
          done = 'In Prontera Castle you signed up for the Alliance''s expedition to the other world. First, the Alliance wanted its word spread.' }
       @{ title = 'The Promotional Staff'
          cond = 'ep13_ryu >= 8 || ep13_start >= 100'; var = 'ep13_ryu'
          items = @(@(909, 'Jellopy', 300), @(721, 'Emerald', 1), @(723, 'Ruby', 1))
          parts = @(
            @{ at = 2; name = 'Promotional Staff in Al De Baran (127, 138), answer I have something for you'; route = @('aldebaran', 127, 138, 'Promotional Staff') }
            @{ at = 3; name = 'Bring her 300 Jellopy'; route = @('aldebaran', 127, 138, 'Promotional Staff') }
            @{ at = 4; name = 'Promotional Staff in Geffen (90, 67), answer The Staff in Aldebaran sent me'; route = @('geffen', 90, 67, 'Promotional Staff') }
            @{ at = 5; name = 'Bring him an Emerald'; route = @('geffen', 90, 67, 'Promotional Staff') }
            @{ at = 6; name = 'Bring him a Ruby'; route = @('geffen', 90, 67, 'Promotional Staff') }
            @{ at = 8; name = 'Promotional Staff in Izlude (102, 171), answer I have something for you'; route = @('izlude', 102, 171, 'Promotional Staff') }
          )
          route = @('aldebaran', 127, 138, 'Promotional Staff')
          now = 'RO quest: the Alliance''s Promotional Staff spread the word in three towns. Visit each in turn and bring what they ask for.'
          hint = @(
            'Emerald and Ruby: the Jewelers of Morroc (154, 55 and 166, 54) and of Lighthalzen sell them. Jellopy drops from Porings and most small monsters.'
            'The Staff in Izlude only lets level 70 and up go on; under 70, come back when you get there.'
            'The Journal counts the items in your bag; the Staff take them.'
          )
          spots = @(
            @{ map = 'aldebaran'; x = 127; y = 138; name = 'Promotional Staff'; ro = 1 }
            @{ map = 'aldebaran'; x = 127; y = 138; name = 'Promotional Staff'; ro = 2 }
            @{ map = 'geffen'; x = 90; y = 67; name = 'Promotional Staff'; ro = 3 }
            @{ map = 'geffen'; x = 90; y = 67; name = 'Promotional Staff'; ro = 4 }
            @{ map = 'geffen'; x = 90; y = 67; name = 'Promotional Staff'; ro = 5 }
            @{ map = 'izlude'; x = 102; y = 171; name = 'Promotional Staff'; ro = 6 }
            @{ map = 'izlude'; x = 102; y = 171; name = 'Promotional Staff'; ro = 7 }
          )
          done = 'You carried the Alliance''s word to Al De Baran, Geffen and Izlude, with 300 Jellopy, an Emerald and a Ruby for its staff.' }
       @{ title = 'Sikaiz of the Alliance'
          cond = 'ep13_ryu >= 12 || ep13_start >= 100'; var = 'ep13_ryu'
          parts = @(
            @{ at = 9; name = 'Back to the Recruiter in Prontera Castle, answer Ash-Vacuum?'; route = @('prt_cas', 207, 165, 'Recruiter for the Brave') }
            @{ at = 10; name = 'Sikaiz in Lighthalzen (lhz_in01, 132, 259)'; route = @('lhz_in01', 132, 259, 'Sikaiz') }
            @{ at = 11; name = 'Sikaiz again, answer Sure'; route = @('lhz_in01', 132, 259, 'Sikaiz') }
            @{ at = 12; name = 'Sikaiz again, answer The three kingdoms'; route = @('lhz_in01', 132, 259, 'Sikaiz') }
          )
          route = @('prt_cas', 207, 165, 'Recruiter for the Brave')
          now = 'RO quest: report back to the Recruiter in Prontera Castle, then meet Sikaiz, who leads the Alliance from the Rekenber building in Lighthalzen. Talk to him until he has told you everything.'
          hint = @(
            'Prontera Castle: the gate is at the north end of Prontera (156, 358).'
            'Lighthalzen: the Rekenber building is in the north-west of the city (door at 101, 248); RO''s Guide says Sikaiz is on its 2nd floor. The Route link draws the way through the building.'
          )
          spots = @(
            @{ map = 'prontera'; x = 156; y = 358; name = 'Gate of Prontera Castle'; ro = 8 }
            @{ map = 'prt_cas'; x = 207; y = 165; name = 'Recruiter for the Brave'; ro = 8 }
            @{ map = 'lighthalzen'; x = 101; y = 248; name = 'Door of the Rekenber building'; ro = 9 }
            @{ map = 'lhz_in01'; x = 132; y = 259; name = 'Sikaiz'; ro = 9 }
            @{ map = 'lhz_in01'; x = 132; y = 259; name = 'Sikaiz'; ro = 10 }
            @{ map = 'lhz_in01'; x = 132; y = 259; name = 'Sikaiz'; ro = 11 }
          )
          done = 'The Recruiter signed you up for good, and RO paid you for it. In Lighthalzen, Sikaiz told you of the three kingdoms and their one mission beyond the rift.' }
       @{ title = 'Errands of the Alliance'
          cond = 'ep13_ryu >= 18 || ep13_start >= 100'; var = 'ep13_ryu'
          parts = @(
            @{ at = 13; name = 'Alliance Manager in Prontera Castle (prt_cas, 19, 98)'; route = @('prt_cas', 19, 98, 'Alliance Manager') }
            @{ at = 14; name = 'Sikaiz in Lighthalzen'; route = @('lhz_in01', 132, 259, 'Sikaiz') }
            @{ at = 15; name = 'Sikaiz again'; route = @('lhz_in01', 132, 259, 'Sikaiz') }
            @{ at = 16; name = 'Alliance Manager in the temple of Rachel (ra_temple, 119, 113)'; route = @('ra_temple', 119, 113, 'Alliance Manager') }
            @{ at = 17; name = 'Sikaiz in Lighthalzen'; route = @('lhz_in01', 132, 259, 'Sikaiz') }
            @{ at = 18; name = 'Sikaiz: type your character''s name'; route = @('lhz_in01', 132, 259, 'Sikaiz') }
          )
          route = @('prt_cas', 19, 98, 'Alliance Manager')
          now = 'RO quest: carry the Alliance''s messages between its seats: Prontera Castle, Sikaiz in Lighthalzen, and the temple of Rachel.'
          hint = @(
            'In Prontera Castle, the Alliance Manager is in the west of the castle (19, 98): the Route link draws the way from the gate.'
            'Rachel: the Airship from Juno or Izlude. The Alliance Manager is inside the great temple (ra_temple, 119, 113; door at rachel 150, 249).'
            'At the end Sikaiz asks for your name: type your character''s name exactly as it is spelled, capitals too. A wrong one only ends the talk; ask him again.'
          )
          spots = @(
            @{ map = 'prt_cas'; x = 19; y = 98; name = 'Alliance Manager'; ro = 12 }
            @{ map = 'lhz_in01'; x = 132; y = 259; name = 'Sikaiz'; ro = 13 }
            @{ map = 'lhz_in01'; x = 132; y = 259; name = 'Sikaiz'; ro = 14 }
            @{ map = 'ra_temple'; x = 119; y = 113; name = 'Alliance Manager'; ro = 15 }
            @{ map = 'lhz_in01'; x = 132; y = 259; name = 'Sikaiz'; ro = 16 }
            @{ map = 'lhz_in01'; x = 132; y = 259; name = 'Sikaiz'; ro = 17 }
          )
          done = 'You ran the Alliance''s errands from Prontera to Rachel, and Sikaiz put your name on the expedition''s roll.' }
       @{ title = 'Through the Rift'
          cond = 'ep13_ryu >= 100 || ep13_start >= 100'; var = 'ep13_ryu'
          parts = @(
            @{ at = 19; name = 'Officer A or B in Lighthalzen (lhz_in01, 32, 22)'; route = @('lhz_in01', 32, 22, 'Officer A') }
            @{ at = 20; name = 'The officers again'; route = @('lhz_in01', 32, 22, 'Officer A') }
            @{ at = 21; name = 'Munkenro at the rift (moc_fild22b, 230, 197)'; route = @('lhz_in01', 130, 232, 'Guard: Send me there.') }
            @{ at = 22; name = 'Munkenro: Ready!!, and watch what happens'; route = @('lhz_in01', 130, 232, 'Guard: Send me there.') }
            @{ at = 100; name = 'Munkenro once more, when it is over'; route = @('lhz_in01', 130, 232, 'Guard: Send me there.') }
          )
          route = @('lhz_in01', 32, 22, 'Officer A')
          now = 'RO quest: two officers of the Alliance argue about Sikaiz. Hear them out, then go to the rift itself, where Munkenro waits with the expedition.'
          hint = @(
            'The officers are in a side room of the Rekenber building (lhz_in01, 32, 22): the Route link draws the way.'
            'To the rift: the Guard in the Rekenber hall (lhz_in01, 130, 232) sends you there (Send me there.). By the rift (moc_fild20), the Rift Guard (349, 179) lets you through (Yes, sure.). Munkenro stands at 230, 197.'
            'After Ready!! the head of the Alliance arrives and speaks. When it is over, talk to Munkenro again: RO pays you, and he can send you through to the Allied camp (Yes, of course!).'
          )
          spots = @(
            @{ map = 'lhz_in01'; x = 32; y = 22; name = 'Officer A'; ro = 18 }
            @{ map = 'lhz_in01'; x = 32; y = 22; name = 'Officer A'; ro = 19 }
            @{ map = 'lhz_in01'; x = 130; y = 232; name = 'Guard: Send me there.'; ro = 20 }
            @{ map = 'moc_fild20'; x = 349; y = 179; name = 'Rift Guard: Yes, sure.'; ro = 20 }
            @{ map = 'moc_fild22b'; x = 230; y = 197; name = 'Munkenro'; ro = 20 }
            @{ map = 'moc_fild22b'; x = 230; y = 197; name = 'Munkenro'; ro = 21 }
            @{ map = 'moc_fild22b'; x = 230; y = 197; name = 'Munkenro'; ro = 22 }
          )
          done = 'The head of the Alliance sent the expedition through the rift, and you with it. Beyond lies the Allied Forces Post, and a world of Laphine and Sapha who never asked for visitors.' }
     ) }

  # quests/quests_13_2.txt, Two Tribes: ep13_mdrama 0 -> 28. No level check of
  # its own; Arc only understands you with the Ring of the Wise King (2782)
  # worn and the Otherworld Language done (ep13_2_rhea > 99, Lv 70).
  # Every Laphine and Sapha here talks only to a wearer of the ring (2782).
  @{ episode = '13.2'; title = 'Two Tribes'; lv = 70
     end = 'ep13_mdrama >= 28'
     needs = 'the Otherworld Language: the Laphine and Sapha tongues, and the Ring of the Wise King worn (Side Quests, The New World).'
     intro = 'Beyond the rift live two peoples who have never trusted each other: the Laphine of Splendide and the Sapha of Manuk. Their quarrel is older than the rift, and the humans who came through it are caught in the middle. This is Ragnarok''s own story: the Chronicle only shows the way, and RO gives its rewards.'
     steps = @(
       @{ title = 'Arc of the Splendide Guard'
          cond = 'ep13_mdrama >= 1'
          route = @('splendide', 228, 164, 'Door to the Splendide Guard')
          now = 'RO quest: wearing the Ring of the Wise King, talk to Arc of the Splendide Guard (spl_in01, 32, 306) and answer Yes.'
          hint = @(
            'To Splendide: the Teleport Cat in the Allied camp (mid_camp, 207, 234) goes to Near Splendide (spl_fild02); the town is through the field''s west edge (6, 241). In Splendide, the door at 228, 164 leads into Arc''s room (spl_in01).'
            'Without the Otherworld Language and the ring, Arc does not understand you: learn it first (Side Quests, The New World). Keep the ring on for the whole episode: every Laphine and Sapha in it needs it.'
          )
          spots = @(
            @{ map = 'mid_camp'; x = 207; y = 234; name = 'Teleport Cat: Near Splendide' }
            @{ map = 'spl_fild02'; x = 6; y = 241; name = 'Way into Splendide' }
            @{ map = 'splendide'; x = 228; y = 164; name = 'Door to the Splendide Guard' }
            @{ map = 'spl_in01'; x = 32; y = 306; name = 'Arc of the Splendide Guard' }
          )
          done = 'Arc understood you. You told him how humans came through the rift, and he saw that you were not sent by the giants of Manuk.' }
       @{ title = 'A Favor for Arc'
          cond = 'ep13_mdrama >= 2'
          route = @('spl_in01', 32, 306, 'Arc of the Splendide Guard')
          now = 'RO quest: Arc has something on his mind. Talk to him again (spl_in01, 32, 306): pick your name, then What favor? and Sure, I will do it.'
          hint = @(
            'Make some room in your bag first: Arc and the Sapha refuse a full or heavy bag.'
          )
          spots = @(
            @{ map = 'spl_in01'; x = 32; y = 306; name = 'Arc of the Splendide Guard' }
          )
          done = 'Arc''s friend Terra left without leave to look at the humans'' camp and never came back. She knots plants to mark her way, and Arc asked you, quietly, to follow them.' }
       @{ title = 'Terra''s Trail'
          cond = 'ep13_mdrama >= 6'; var = 'ep13_mdrama'
          parts = @(
            @{ at = 3; name = 'A knotted weed near Splendide (spl_fild02, 45, 214)'; route = @('spl_fild02', 45, 214, 'Knotted weed') }
            @{ at = 4; name = 'Footprints in the south-east (spl_fild02, 328, 323)'; route = @('spl_fild02', 328, 323, 'Footprints') }
            @{ at = 5; name = 'Signs of a fight on the next field north (spl_fild01, 341, 109)'; route = @('spl_fild01', 341, 109, 'Signs of a fight') }
            @{ at = 6; name = 'The roots of a huge tree (spl_fild01, 375, 109): Follow the trace.'; route = @('spl_fild01', 375, 109, 'Roots of a huge tree') }
          )
          route = @('spl_fild02', 45, 214, 'Knotted weed')
          now = 'RO quest: follow Terra''s knotted plants and the footprints after them, from the field outside Splendide to the roots of a huge tree.'
          hint = @(
            'Near Splendide (spl_fild02): the knotted weed is close to the town (45, 214). Two more knots (122, 106 and 329, 191) only point the way. The footprints are at 328, 323.'
            'spl_fild01 is north of spl_fild02 (its exit at 293, 379). Step onto the roots at 375, 109 and choose Follow the trace.: you slip into a cave below and lose 30% of your HP.'
          )
          spots = @(
            @{ map = 'spl_fild02'; x = 45; y = 214; name = 'Knotted weed'; ro = 2 }
            @{ map = 'spl_fild02'; x = 328; y = 323; name = 'Footprints'; ro = 3 }
            @{ map = 'spl_fild02'; x = 293; y = 379; name = 'Way north to spl_fild01'; ro = 4 }
            @{ map = 'spl_fild01'; x = 341; y = 109; name = 'Signs of a fight'; ro = 4 }
            @{ map = 'spl_fild01'; x = 375; y = 109; name = 'Roots of a huge tree: Follow the trace.'; ro = 5 }
          )
          done = 'The knots and the footprints led you to the roots of a huge tree, and you slipped through them into a cave nobody had mapped.' }
       @{ title = 'The Petrified Sapha'
          cond = 'ep13_mdrama >= 7'
          route = @('nyd_dun01', 58, 223, 'Petrified Sapha')
          now = 'RO quest: in the cave under the roots (nyd_dun01), look at the statue where the sunlight falls (58, 223).'
          hint = @(
            'Back into the cave: the roots on spl_fild01 (375, 109), Go inside.'
            'The way out is the Trunk of a Tree beside the statue (62, 233): Climb up. It leaves you on spl_fild01 (376, 65).'
          )
          spots = @(
            @{ map = 'spl_fild01'; x = 375; y = 109; name = 'Roots of a huge tree (into the cave)' }
            @{ map = 'nyd_dun01'; x = 58; y = 223; name = 'Petrified Sapha' }
            @{ map = 'nyd_dun01'; x = 62; y = 233; name = 'Trunk of a Tree (the way out)' }
          )
          done = 'In the cave stood a scarred Sapha giant turned to stone, wearing a muffler and holding something in his arms. Terra''s trail ended there.' }
       @{ title = 'Terra Took the Bradium'
          cond = 'ep13_mdrama >= 10'; var = 'ep13_mdrama'
          parts = @(
            @{ at = 8; name = 'Arc (spl_in01, 32, 306): hear what happened'; route = @('spl_in01', 32, 306, 'Arc of the Splendide Guard') }
            @{ at = 9; name = 'Arc again: offer to go in his place'; route = @('spl_in01', 32, 306, 'Arc of the Splendide Guard') }
            @{ at = 10; name = 'The Petrified Sapha in the cave (nyd_dun01, 58, 223)'; route = @('nyd_dun01', 58, 223, 'Petrified Sapha') }
          )
          route = @('spl_in01', 32, 306, 'Arc of the Splendide Guard')
          now = 'RO quest: tell Arc what you found. Terra came back while you were away, and left again; go and look for her in the cave.'
          hint = @(
            'The cave: the roots on spl_fild01 (375, 109), Go inside. Out again by the Trunk of a Tree (62, 233).'
          )
          spots = @(
            @{ map = 'spl_in01'; x = 32; y = 306; name = 'Arc of the Splendide Guard'; ro = 7 }
            @{ map = 'spl_in01'; x = 32; y = 306; name = 'Arc of the Splendide Guard'; ro = 8 }
            @{ map = 'spl_fild01'; x = 375; y = 109; name = 'Roots of a huge tree (into the cave)'; ro = 9 }
            @{ map = 'nyd_dun01'; x = 58; y = 223; name = 'Petrified Sapha'; ro = 9 }
          )
          done = 'Terra had come back wounded, taken the Laphine''s Bradium and gone. In the cave you found Bradium powder around the stone giant, but no Terra.' }
       @{ title = 'The Sapha''s Prisoner'
          cond = 'ep13_mdrama >= 13'; var = 'ep13_mdrama'
          parts = @(
            @{ at = 11; name = 'Two villagers in Manuk (278, 177): listen'; route = @('manuk', 278, 177, 'Villagers') }
            @{ at = 12; name = 'Snorren by the prison (man_in01, 175, 59): About the Captured Fairy.'; route = @('man_in01', 175, 59, 'Snorren') }
            @{ at = 13; name = 'Snorren again'; route = @('man_in01', 175, 59, 'Snorren') }
          )
          route = @('manuk', 278, 177, 'Villagers')
          now = 'RO quest: go to Manuk, the Sapha''s town, and listen for news of a wounded Laphine. Then find Snorren, who wants a word with her.'
          hint = @(
            'To Manuk: the Teleport Cat in the Allied camp (mid_camp, 207, 234) goes to Manuk Field (man_fild02); the town is just south of where you land.'
            'At the villagers, either answer works. Snorren stands outside the prison (man_in01, 175, 59): the Route link draws the way in from the town.'
          )
          spots = @(
            @{ map = 'mid_camp'; x = 207; y = 234; name = 'Teleport Cat: Manuk Field' }
            @{ map = 'manuk'; x = 278; y = 177; name = 'Villagers'; ro = 10 }
            @{ map = 'man_in01'; x = 175; y = 59; name = 'Snorren'; ro = 11 }
            @{ map = 'man_in01'; x = 175; y = 59; name = 'Snorren'; ro = 12 }
          )
          done = 'A wounded Laphine is held in Manuk''s prison. Snorren''s friend Ogen is missing, and he wants to know what she has to do with it. Her jailer Luik needs something to treat her wounds, and you said you would find it.' }
       @{ title = 'Yggdrasil Berries'
          cond = 'ep13_mdrama >= 18'; var = 'ep13_mdrama'
          items = @(, @(607, 'Yggdrasil Berry', 6))
          parts = @(
            @{ at = 14; name = 'Arc (spl_in01, 32, 306): he gives you 3 Yggdrasil Berries'; route = @('spl_in01', 32, 306, 'Arc of the Splendide Guard') }
            @{ at = 15; name = 'A berry at the great root (spl_fild01, 357, 44)'; route = @('spl_fild01', 357, 44, 'Great root') }
            @{ at = 16; name = 'Another berry (spl_fild01, 312, 79)'; route = @('spl_fild01', 312, 79, 'Great root') }
            @{ at = 17; name = 'The third berry (spl_fild01, 329, 29)'; route = @('spl_fild01', 329, 29, 'Great root') }
            @{ at = 18; name = 'Snorren in Manuk (man_in01, 175, 59) takes the berries'; route = @('man_in01', 175, 59, 'Snorren') }
          )
          route = @('spl_in01', 32, 306, 'Arc of the Splendide Guard')
          now = 'RO quest: ask Arc what heals a Laphine: Yggdrasil Berries. He has 3; pick 3 more where the World Tree''s roots come up on spl_fild01, and bring all 6 to Snorren in Manuk.'
          hint = @(
            'The three berry spots open one after another, each from the last. Touching them again afterwards may cost you 30% of your HP.'
            'Snorren takes every Yggdrasil Berry in your bag, so keep your own elsewhere.'
          )
          spots = @(
            @{ map = 'spl_in01'; x = 32; y = 306; name = 'Arc of the Splendide Guard'; ro = 13 }
            @{ map = 'spl_fild01'; x = 357; y = 44; name = 'Great root: berry'; ro = 14 }
            @{ map = 'spl_fild01'; x = 312; y = 79; name = 'Great root: berry'; ro = 15 }
            @{ map = 'spl_fild01'; x = 329; y = 29; name = 'Great root: berry'; ro = 16 }
            @{ map = 'mid_camp'; x = 207; y = 234; name = 'Teleport Cat: Manuk Field'; ro = 17 }
            @{ map = 'man_in01'; x = 175; y = 59; name = 'Snorren'; ro = 17 }
          )
          done = 'Arc gave you his last Yggdrasil Berries, the World Tree''s roots gave you three more, and Snorren carried them to the prison.' }
       @{ title = 'The Captured Laphine'
          cond = 'ep13_mdrama >= 21'; var = 'ep13_mdrama'
          parts = @(
            @{ at = 19; name = 'Snorren inside the prison (man_in01, 17, 128): pick your name'; route = @('man_in01', 17, 128, 'Snorren') }
            @{ at = 20; name = 'The Captured Laphine (22, 126)'; route = @('man_in01', 22, 126, 'Captured Laphine') }
            @{ at = 21; name = 'Luik the jailer (19, 126)'; route = @('man_in01', 19, 126, 'Luik') }
          )
          route = @('man_in01', 183, 58, 'Prison door')
          now = 'RO quest: with Snorren, go into the prison and interpret between the Captured Laphine and her jailer, Luik.'
          hint = @(
            'The prison door is beside Snorren''s old spot (man_in01, 183, 58); it opens for you now.'
            'Luik does not believe that a Sapha is lying stone-dead in a Laphine cave. He wants proof.'
          )
          spots = @(
            @{ map = 'man_in01'; x = 183; y = 58; name = 'Prison door'; ro = 18 }
            @{ map = 'man_in01'; x = 17; y = 128; name = 'Snorren'; ro = 18 }
            @{ map = 'man_in01'; x = 22; y = 126; name = 'Captured Laphine'; ro = 19 }
            @{ map = 'man_in01'; x = 19; y = 126; name = 'Luik'; ro = 20 }
          )
          done = 'The prisoner was Terra. She had tried to save the Sapha in the cave with the Bradium she took. Luik would not believe it without proof.' }
       @{ title = 'Proof from the Cave'
          cond = 'ep13_mdrama >= 23'; var = 'ep13_mdrama'
          items = @(@(6085, 'Shaggy Muffler', 1), @(6084, 'Bradium Fragments', 1))
          parts = @(
            @{ at = 22; name = 'The Petrified Sapha (nyd_dun01, 58, 223): take the Muffler and a Fragment of Bradium'; route = @('nyd_dun01', 58, 223, 'Petrified Sapha') }
            @{ at = 23; name = 'Snorren or Luik in the prison (man_in01, 17, 128)'; route = @('man_in01', 17, 128, 'Snorren') }
          )
          route = @('spl_fild01', 375, 109, 'Roots of a huge tree (into the cave)')
          now = 'RO quest: bring Luik proof from the cave: take the stone giant''s muffler and a fragment of Bradium, and show them in Manuk''s prison.'
          hint = @(
            'At the statue, choose Muffler and Fragment of Bradium, in either order. Hair and Pants do not come off.'
            'The cave: the roots on spl_fild01 (375, 109), Go inside. The prison: man_in01, door at 183, 58.'
          )
          spots = @(
            @{ map = 'spl_fild01'; x = 375; y = 109; name = 'Roots of a huge tree (into the cave)'; ro = 21 }
            @{ map = 'nyd_dun01'; x = 58; y = 223; name = 'Petrified Sapha'; ro = 21 }
            @{ map = 'man_in01'; x = 183; y = 58; name = 'Prison door'; ro = 22 }
            @{ map = 'man_in01'; x = 17; y = 128; name = 'Snorren'; ro = 22 }
          )
          done = 'The muffler was Ogen''s. Snorren knew it at once and set out for the cave.' }
       @{ title = 'Ogen'
          cond = 'ep13_mdrama >= 25'; var = 'ep13_mdrama'
          parts = @(
            @{ at = 24; name = 'The Petrified Sapha, with Snorren (nyd_dun01, 58, 223)'; route = @('nyd_dun01', 58, 223, 'Petrified Sapha') }
            @{ at = 25; name = 'Snorren back in Manuk (man_in01, 175, 59)'; route = @('man_in01', 175, 59, 'Snorren') }
          )
          route = @('spl_fild01', 375, 109, 'Roots of a huge tree (into the cave)')
          now = 'RO quest: meet Snorren at the stone giant in the cave, then see him again in Manuk.'
          hint = @(
            'Wear the ring at the statue, or the scene does not start.'
            'Snorren pays you 15 Manuk Coins.'
          )
          spots = @(
            @{ map = 'spl_fild01'; x = 375; y = 109; name = 'Roots of a huge tree (into the cave)'; ro = 23 }
            @{ map = 'nyd_dun01'; x = 58; y = 223; name = 'Petrified Sapha'; ro = 23 }
            @{ map = 'man_in01'; x = 175; y = 59; name = 'Snorren'; ro = 24 }
          )
          done = 'Ogen had turned himself to stone shielding Terra. Snorren mourned him by the statue, Luik set Terra free, and Snorren gave you 15 Manuk Coins.' }
       @{ title = 'Terra''s Yai'
          cond = 'ep13_mdrama >= 28'; var = 'ep13_mdrama'
          parts = @(
            @{ at = 26; name = 'Arc (spl_in01, 32, 306): Terra is home'; route = @('spl_in01', 32, 306, 'Arc of the Splendide Guard') }
            @{ at = 27; name = 'Arc and Terra in Terra''s Yai (spl_in02, 236, 92)'; route = @('spl_in02', 236, 92, 'Arc') }
            @{ at = 28; name = 'Talk to them once more'; route = @('spl_in02', 236, 92, 'Arc') }
          )
          route = @('spl_in01', 32, 306, 'Arc of the Splendide Guard')
          now = 'RO quest: Terra is home. Tell Arc, then visit Terra''s Yai, her house in Splendide, and hear what happened.'
          hint = @(
            'Terra''s Yai: the door at splendide 287, 140, south-east of Arc''s room. It lets you in once Arc has sent you.'
            'RO pays you 25 Splendide Coins and 120,000 base and 10,000 job EXP.'
          )
          spots = @(
            @{ map = 'spl_in01'; x = 32; y = 306; name = 'Arc of the Splendide Guard'; ro = 25 }
            @{ map = 'splendide'; x = 287; y = 140; name = 'Door to Terra''s Yai'; ro = 26 }
            @{ map = 'spl_in02'; x = 236; y = 92; name = 'Arc and Terra'; ro = 26 }
            @{ map = 'spl_in02'; x = 236; y = 92; name = 'Arc and Terra'; ro = 27 }
          )
          done = 'Terra told how she and Ogen met, and how he gave his life for her. The Laphine, who keep strangers out, made you welcome in Splendide.' }
     ) }

  # re/quests/quests_dicastes.txt, Doha's Secret Orders: ep13_3_secret 0 -> 24
  # (25-27 come later, in the Flame Basin). It begins in the Invitation to
  # El Dicastes (ep13_3_invite 1 -> 2), which only opens after 13.1.
  # Shay and every Sapha after him want the invitation done (ep13_3_invite
  # 6: registered in El Dicastes) and the ring (2782) worn.
  @{ episode = '13.3'; title = 'Doha''s Secret Orders'; lv = 70
     end = 'ep13_3_secret >= 24'
     needs = 'Episode 13.1, Onward to the Other World (or the Cat Paw passage into the New World); from step 3 on, Sapha''s Visit done to the end (registered in El Dicastes) and the Ring of the Wise King worn (Side Quests, The New World).'
     intro = 'The Sapha of Manuk have sent a delegation to the Allied camp, and they want to meet the humans who helped them. Behind the delegation stands Inspector Doha of El Dicastes, and Doha has orders of his own. This is Ragnarok''s own story: the Chronicle only shows the way, and RO gives its rewards.'
     steps = @(
       @{ title = 'The Manuk Delegation'
          cond = 'ep13_3_secret >= 1'
          route = @('mid_campin', 93, 114, 'Guard Aello')
          now = 'RO quest: in the Allied camp''s command post, Guard Aello (mid_campin, 93, 114) says a delegation from Manuk wants to meet you. Go up to its room and hear the Sapha out.'
          hint = @(
            'The delegation waits in the room on the right of the second floor. Tell the guard at its door that you have authorization.'
            'This is also how the Invitation to El Dicastes begins (Side Quests, The New World).'
          )
          spots = @(
            @{ map = 'mid_campin'; x = 93; y = 114; name = 'Guard Aello' }
          )
          done = 'The Sapha delegation from Manuk called humans friends, and Hibba Agip sent you to meet Inspector Doha.' }
       @{ title = 'Inspector Doha'
          cond = 'ep13_3_secret >= 3'; var = 'ep13_3_secret'
          parts = @(
            @{ at = 2; name = 'Inspector Doha (mid_campin, 168, 170): Came to meet the inspector.'; route = @('mid_campin', 168, 170, 'Inspector Doha') }
            @{ at = 3; name = 'Doha again'; route = @('mid_campin', 168, 170, 'Inspector Doha') }
          )
          route = @('mid_campin', 168, 170, 'Inspector Doha')
          now = 'RO quest: in the camp''s command post, Inspector Doha of El Dicastes (mid_campin, 168, 170) has a case for you. Hear him out, twice.'
          hint = @(
            'Every answer in his talk leads on. Make some room in your bag first: Doha refuses a heavy one.'
          )
          spots = @(
            @{ map = 'mid_campin'; x = 168; y = 170; name = 'Inspector Doha'; ro = 1 }
            @{ map = 'mid_campin'; x = 168; y = 170; name = 'Inspector Doha'; ro = 2 }
          )
          done = 'Someone stole the expedition''s report, and a witness saw a man with animal ears. Doha took Manuk and Splendide and sent you to El Dicastes, the Sapha capital, to find him.' }
       @{ title = 'The Man with Cat Ears'
          cond = 'ep13_3_secret >= 5'; var = 'ep13_3_secret'
          parts = @(
            @{ at = 4; name = 'Shay in the pub (dic_in01, 245, 119): Talk., About other races, With cat ears.'; route = @('dic_in01', 245, 119, 'Shay') }
            @{ at = 5; name = 'Ask three Sapha in the city, then Shay again'; route = @('dic_in01', 245, 119, 'Shay') }
          )
          route = @('dic_in01', 245, 119, 'Shay')
          now = 'RO quest: in El Dicastes, ask Shay, who keeps the adventurers'' pub, about a man with cat ears. Then ask around the city, and tell Shay what you heard.'
          hint = @(
            'Shay only talks about it once Sapha''s Visit is done (you registered as an adventurer in El Dicastes, Side Quests). To El Dicastes: the Teleport Cat in the Allied camp (mid_camp, 207, 234) goes to Manuk Field, and the Teleport Cat there (man_fild02, 135, 49) on to Near El Dicastes (dic_fild01). The city gate is at the north end of that field.'
            'The three Sapha: Walking Knit by the square (dicastes01, 207, 210: Are there races other than humans?), Resting Piom (112, 248) and Training Galten (249, 140): About a human with cat ears.'
            'Shay''s new pie ends up in your face: it costs 30% of your HP.'
          )
          spots = @(
            @{ map = 'dic_in01'; x = 245; y = 119; name = 'Shay'; ro = 3 }
            @{ map = 'dicastes01'; x = 207; y = 210; name = 'Walking Knit'; ro = 4 }
            @{ map = 'dicastes01'; x = 112; y = 248; name = 'Resting Piom'; ro = 4 }
            @{ map = 'dicastes01'; x = 249; y = 140; name = 'Training Galten'; ro = 4 }
            @{ map = 'dic_in01'; x = 245; y = 119; name = 'Shay'; ro = 4 }
          )
          done = 'Every Sapha was talking about Ahat, the new minister. Shay, a retired Assassin, sent you to BK, the Cat Merchants'' information collector, with a password.' }
       @{ title = 'BK of the Cat Merchants'
          cond = 'ep13_3_secret >= 9'; var = 'ep13_3_secret'
          items = @(, @(6304, 'Proof Of Sapha''s Honor', 3))
          parts = @(
            @{ at = 6; name = 'BK outside the city (dic_fild01, 231, 174): type the password'; route = @('dic_fild01', 231, 174, 'BK') }
            @{ at = 7; name = 'BK: About other feline races, then Give. (a Proof Of Sapha''s Honor)'; route = @('dic_fild01', 231, 174, 'BK') }
            @{ at = 8; name = 'BK: Give a certification. (another one)'; route = @('dic_fild01', 231, 174, 'BK') }
            @{ at = 9; name = 'BK: a third Proof for the last of it'; route = @('dic_fild01', 231, 174, 'BK') }
          )
          route = @('dic_fild01', 231, 174, 'BK')
          now = 'RO quest: BK camps with the Cat Merchants outside El Dicastes (dic_fild01, 231, 174). Give him Shay''s password, then pay for his news with 3 Proofs Of Sapha''s Honor.'
          hint = @(
            'The password, typed exactly: Shay''s special drink will be delivered'
            'Proofs Of Sapha''s Honor: one for each El Dicastes request, or from Papyrus in the archive for 3 Unidentified Relics (Side Quests, The New World). The Clerk asks for 3 more later in this episode: 6 in all.'
          )
          spots = @(
            @{ map = 'dic_fild01'; x = 231; y = 174; name = 'BK'; ro = 5 }
            @{ map = 'dic_fild01'; x = 231; y = 174; name = 'BK'; ro = 6 }
            @{ map = 'dic_fild01'; x = 231; y = 174; name = 'BK'; ro = 7 }
            @{ map = 'dic_fild01'; x = 231; y = 174; name = 'BK'; ro = 8 }
          )
          done = 'BK talked, for a price: nobody knows where the new minister Ahat came from, and BK doubts he is a Sapha at all.' }
       @{ title = 'Traces at the Crack'
          cond = 'ep13_3_secret >= 12'; var = 'ep13_3_secret'
          parts = @(
            @{ at = 10; name = 'Shay in the pub (dic_in01, 245, 119)'; route = @('dic_in01', 245, 119, 'Shay') }
            @{ at = 11; name = 'A Rock Pile, Dirt Pile or Split Earth near the crack (dic_fild02, 215, 85)'; route = @('dic_fild02', 215, 85, 'Dirt Pile') }
            @{ at = 12; name = 'Shay again, with what you found'; route = @('dic_in01', 245, 119, 'Shay') }
          )
          route = @('dic_in01', 245, 119, 'Shay')
          now = 'RO quest: tell Shay what BK said, then search the ground around the dimensional crack (dic_fild02) for traces, and bring Shay what you find.'
          hint = @(
            'dic_fild02 lies south of El Dicastes: dic_fild01''s south-west exit (69, 23). Rock Piles, Dirt Piles and Split Earth are scattered around the crack, for example 269, 55, 215, 85 and 194, 86.'
            'At a pile, take the second choice (Study the pile closely. or Poke around in the dirt pile.). The first one only flattens it.'
          )
          spots = @(
            @{ map = 'dic_in01'; x = 245; y = 119; name = 'Shay'; ro = 9 }
            @{ map = 'dic_fild01'; x = 69; y = 23; name = 'Way south to dic_fild02'; ro = 10 }
            @{ map = 'dic_fild02'; x = 215; y = 85; name = 'Dirt Pile'; ro = 10 }
            @{ map = 'dic_fild02'; x = 269; y = 55; name = 'Rock Pile'; ro = 10 }
            @{ map = 'dic_fild02'; x = 194; y = 86; name = 'Split Earth'; ro = 10 }
            @{ map = 'dic_in01'; x = 245; y = 119; name = 'Shay'; ro = 11 }
          )
          done = 'Around the crack you found traces full of an evil energy. Shay told you the only way to Ahat is through the city''s officials, and they want proof of your service.' }
       @{ title = 'An Audience with Ahat'
          cond = 'ep13_3_secret >= 14'; var = 'ep13_3_secret'
          items = @(, @(6304, 'Proof Of Sapha''s Honor', 3))
          parts = @(
            @{ at = 13; name = 'Clerk Rhawyne (dic_in01, 42, 264): Talk., I want to meet the minister., Ahat'; route = @('dic_in01', 42, 264, 'Adventurer Clerk') }
            @{ at = 14; name = 'Diel Guard (dic_in01, 138, 225): I have permission., then up into the minister''s hall'; route = @('dic_in01', 138, 225, 'Diel Guard') }
          )
          route = @('dic_in01', 42, 264, 'Adventurer Clerk')
          now = 'RO quest: ask Clerk Rhawyne for an audience with Minister Ahat (3 Proofs Of Sapha''s Honor), then go up through the Diel Guards into his hall.'
          hint = @(
            'Clerk Rhawyne is the Adventurer Clerk who registered you. She takes 3 Proofs Of Sapha''s Honor.'
            'The Diel Guard at 138, 225 checks the list and takes you up; the guard at 263, 193 lets you on. Step into the hall (299, 268).'
          )
          spots = @(
            @{ map = 'dic_in01'; x = 42; y = 264; name = 'Clerk Rhawyne'; ro = 12 }
            @{ map = 'dic_in01'; x = 138; y = 225; name = 'Diel Guard: I have permission.'; ro = 13 }
            @{ map = 'dic_in01'; x = 263; y = 193; name = 'Diel Guard'; ro = 13 }
            @{ map = 'dic_in01'; x = 299; y = 268; name = 'Minister''s hall'; ro = 13 }
          )
          done = 'In the minister''s hall a ringing voice reached into your head. Ahat was waiting for you.' }
       @{ title = 'Under Ahat''s Spell'
          cond = 'ep13_3_secret >= 17'; var = 'ep13_3_secret'
          parts = @(
            @{ at = 15; name = 'Minister Ahat (dic_in01, 300, 280)'; route = @('dic_in01', 300, 280, 'Minister Ahat') }
            @{ at = 16; name = 'Ahat again'; route = @('dic_in01', 300, 280, 'Minister Ahat') }
            @{ at = 17; name = 'Cheshire, the Secret Adjutant (294, 276): Tail?, then Have you ever been near the triangle?'; route = @('dic_in01', 294, 276, 'Secret Adjutant') }
          )
          route = @('dic_in01', 300, 280, 'Minister Ahat')
          now = 'RO quest: Minister Ahat tries to charm you. Play along as his loyal servant, then meet his Secret Adjutant, Cheshire.'
          hint = @(
            'Whatever you answer Ahat, you end up pretending to be under his spell, and the story goes on.'
            'The way back up to the hall: the Diel Guards on the admin floor (dic_in01, 138, 225, then 263, 193).'
          )
          spots = @(
            @{ map = 'dic_in01'; x = 300; y = 280; name = 'Minister Ahat'; ro = 14 }
            @{ map = 'dic_in01'; x = 300; y = 280; name = 'Minister Ahat'; ro = 15 }
            @{ map = 'dic_in01'; x = 294; y = 276; name = 'Cheshire, the Secret Adjutant'; ro = 16 }
          )
          done = 'You pretended to be Ahat''s servant. His adjutant Cheshire, who hides a tail, gave you his first errand: wipe out the traces around the crack.' }
       @{ title = 'Cheshire''s Errand'
          cond = 'ep13_3_secret >= 18'
          items = @(@(6306, 'Hard Bloodstain', 11), @(6305, 'Frozen Piece Of Skin', 11), @(6307, 'Cursed Magical Stone', 11))
          route = @('dic_fild02', 215, 85, 'Dirt Pile')
          now = 'RO quest: around the crack (dic_fild02), gather 10 each of bloodstains (Dirt Piles), frozen skin (Split Earth) and cursed stones (Rock Piles) for Cheshire, plus one of each to keep as evidence for Doha. Bring them to Cheshire (dic_in01, 294, 276).'
          hint = @(
            'Each pile gives one, then rests a while. Rock Piles: 269, 55, 236, 29, 228, 55, 210, 75. Dirt Piles: 215, 85, 207, 41, 232, 41, 245, 68. Split Earth: 194, 86, 240, 51, 176, 65, 254, 45.'
            'Cheshire takes 10 of each; the 11th stays in your bag for Doha.'
          )
          spots = @(
            @{ map = 'dic_fild02'; x = 269; y = 55; name = 'Rock Pile' }
            @{ map = 'dic_fild02'; x = 215; y = 85; name = 'Dirt Pile' }
            @{ map = 'dic_fild02'; x = 194; y = 86; name = 'Split Earth' }
            @{ map = 'dic_in01'; x = 294; y = 276; name = 'Cheshire, the Secret Adjutant' }
          )
          done = 'You cleared the traces for Cheshire, and kept one of each for yourself.' }
       @{ title = 'Ahat''s Gift'
          cond = 'ep13_3_secret >= 19'
          route = @('dic_in01', 300, 280, 'Minister Ahat')
          now = 'RO quest: Minister Ahat (dic_in01, 300, 280) is pleased with his servant. Ask him What are those?'
          spots = @(
            @{ map = 'dic_in01'; x = 300; y = 280; name = 'Minister Ahat' }
          )
          done = 'Ahat gave you a Bradium Brooch for your service.' }
       @{ title = 'Jarute HesLanta'
          cond = 'ep13_3_secret >= 22'; var = 'ep13_3_secret'
          parts = @(
            @{ at = 20; name = 'On the admin floor, walk to the hall at 138, 188 and meet HesLanta (158, 188)'; route = @('dic_in01', 158, 188, 'Jarute HesLanta') }
            @{ at = 21; name = 'HesLanta again: tell him the truth about Ahat'; route = @('dic_in01', 158, 188, 'Jarute HesLanta') }
            @{ at = 22; name = 'HesLanta once more: piece it all together'; route = @('dic_in01', 158, 188, 'Jarute HesLanta') }
          )
          route = @('dic_in01', 138, 188, 'Jarute HesLanta''s hall')
          now = 'RO quest: Jarute HesLanta of El Dicastes also watches Ahat. Let him pull you aside on the admin floor, tell him what you know, and work out with him who stole the report.'
          hint = @(
            'Walking into the hall at dic_in01, 138, 188 takes you to him. Wear the ring.'
            'To piece it together: Cheshire; either answer; Ahat must be ordering him.; either answer; Content about evil lord Morocc.. A wrong one asks again.'
          )
          spots = @(
            @{ map = 'dic_in01'; x = 138; y = 188; name = 'Hall of Jarute HesLanta'; ro = 19 }
            @{ map = 'dic_in01'; x = 158; y = 188; name = 'Jarute HesLanta'; ro = 19 }
            @{ map = 'dic_in01'; x = 158; y = 188; name = 'Jarute HesLanta'; ro = 20 }
            @{ map = 'dic_in01'; x = 158; y = 188; name = 'Jarute HesLanta'; ro = 21 }
          )
          done = 'The thief was Cheshire, Ahat''s servant. Ahat came out of the crack that Satan Morocc tore open, and he is hiding something there. You had to tell Doha.' }
       @{ title = 'Back to Doha'
          cond = 'ep13_3_secret >= 24'; var = 'ep13_3_secret'
          items = @(@(6306, 'Hard Bloodstain', 1), @(6305, 'Frozen Piece Of Skin', 1), @(6307, 'Cursed Magical Stone', 1))
          parts = @(
            @{ at = 23; name = 'Inspector Doha (mid_campin, 168, 170), with the evidence'; route = @('mid_campin', 168, 170, 'Inspector Doha') }
            @{ at = 24; name = 'Outside in the camp, walk past the spot at mid_camp 216, 246'; route = @('mid_camp', 216, 246, 'A man in black') }
          )
          route = @('mid_campin', 168, 170, 'Inspector Doha')
          now = 'RO quest: report to Inspector Doha in the Allied camp and give him the evidence: a bloodstain, a frozen skin and a cursed stone. Then step outside.'
          hint = @(
            'If you have none of one left, the piles around the crack give more (dic_fild02).'
            'Doha gives you a Dragon Manteau.'
          )
          spots = @(
            @{ map = 'mid_campin'; x = 168; y = 170; name = 'Inspector Doha'; ro = 22 }
            @{ map = 'mid_camp'; x = 216; y = 246; name = 'A man in black'; ro = 23 }
          )
          done = 'Doha took your report and gave you a Dragon Manteau. Outside, a man in black asked what the new minister looks like, said you had found it at last, and vanished.' }
     ) }

  # re/instances/HazyForest.txt, the Mistwood Maze: ep14_1_mistwoods 0 -> 10.
  # Loki only talks from Lv 98 (1 = you turned back, 2 = on your way); the
  # maze is an instance for a party.
  @{ episode = '14.1'; title = 'Mistwood Maze'; lv = 98
     end = 'ep14_1_mistwoods >= 10'
     party = 'The Mistwood Maze lets in a party only (at least 2; party bots count as players).'
     intro = 'Beyond Bifrost, the rainbow bridge, lies the Mistwood: a forest that leads strangers in circles and does not let them go. Someone has gone missing in it, and an assassin is looking for her. This is Ragnarok''s own story: the Chronicle only shows the way, and RO gives its rewards.'
     steps = @(
       @{ title = 'The Young Man in the Mist'
          cond = 'ep14_1_mistwoods >= 2'
          route = @('bif_fild01', 158, 340, 'Laphine Soldier: the Mistwood Maze')
          now = 'RO quest: with your party, enter the Mistwood Maze through the Log Tunnel on Bifrost''s field (bif_fild01, 161, 355). Inside, a mysterious young man (97, 30) asks whether you mean to pass through: answer Yes, I do.'
          hint = @(
            'Your party''s leader asks the Laphine Soldier (bif_fild01, 158, 340) to open the maze. Then everyone enters through the Log Tunnel (161, 355).'
          )
          spots = @(
            @{ map = 'bif_fild01'; x = 158; y = 340; name = 'Laphine Soldier: the Mistwood Maze' }
            @{ map = 'bif_fild01'; x = 161; y = 355; name = 'Log Tunnel' }
            @{ map = '1@mist'; x = 97; y = 30; name = 'Mysterious Young Man' }
          )
          done = 'In the Mistwood you met Loki of the Assassin''s Guild. He asked about a purple-haired guard and left you to find your own way through the forest.' }
       # The Wandering Purple Dragon (Lost Dragon 2131) stands at one of six
       # spots; its death shows Loki and the Collapsed Girl (183, 304).
       @{ title = 'The Wandering Dragon'
          cond = 'ep14_1_mistwoods >= 3'
          route = @('1@mist', 183, 304, 'Loki')
          now = 'RO quest: somewhere in the maze a Wandering Purple Dragon roams. Defeat it, then find Loki beside the girl it leaves behind (1@mist, 183, 304) and talk to him.'
          hint = @(
            'Garden Trees block the paths of the maze. Defeat the gardener of a tree (a named monster nearby), then choose Chop down the garden tree.: the way on opens. A gardener still alive makes the tree cry out instead.'
            'The dragon (Lost Dragon, level 135) stands at one of six places, a different one each time: 77, 240, 147, 261, 182, 263, 194, 350, 268, 183 or 65, 278. When it falls, a voice asks you to save it.'
          )
          spots = @(
            @{ map = '1@mist'; x = 77; y = 240; name = 'Dragon? (one of six spots)' }
            @{ map = '1@mist'; x = 147; y = 261; name = 'Dragon? (one of six spots)' }
            @{ map = '1@mist'; x = 182; y = 263; name = 'Dragon? (one of six spots)' }
            @{ map = '1@mist'; x = 194; y = 350; name = 'Dragon? (one of six spots)' }
            @{ map = '1@mist'; x = 268; y = 183; name = 'Dragon? (one of six spots)' }
            @{ map = '1@mist'; x = 65; y = 278; name = 'Dragon? (one of six spots)' }
            @{ map = '1@mist'; x = 183; y = 304; name = 'Loki' }
          )
          done = 'The dragon fell and became a girl: Nydhogg, the Guardian of Yggdrasil, whom Loki had been looking for. He meant to carry her out himself and meet you in Mora.' }
       @{ title = 'Nydhogg in Mora'
          cond = 'ep14_1_mistwoods >= 10'; var = 'ep14_1_mistwoods'
          parts = @(
            @{ at = 4; name = 'The Flower Smelling Lady in Mora (46, 152)'; route = @('mora', 46, 152, 'Flower Smelling Lady') }
            @{ at = 10; name = 'The Sharp Eyed Man beside her (48, 152)'; route = @('mora', 48, 152, 'Sharp Eyed Man') }
          )
          route = @('mora', 46, 152, 'Flower Smelling Lady')
          now = 'RO quest: in Mora, the Laphine village, a lady smelling flowers (46, 152) and a sharp-eyed man (48, 152) are waiting for you. Talk to her first, then to him.'
          hint = @(
            'Out of the maze: chop down the last tree, the Gardeners'' Tree (1@mist, 345, 186), to reach Bifrost''s second field, or simply leave. Mora is reached through the Small Holes on bif_fild02 (285, 332, 95, 310 or 174, 162): choose Knock-knock.'
            'Make some room in your bag first. RO pays you Loki''s Muffler, a Pendant Of Guardian and 400,000 base and job EXP; either answer to Nydhogg works.'
          )
          spots = @(
            @{ map = '1@mist'; x = 345; y = 186; name = 'The Gardeners'' Tree (the way out)'; ro = 3 }
            @{ map = 'bif_fild02'; x = 285; y = 332; name = 'Small Hole into Mora'; ro = 3 }
            @{ map = 'mora'; x = 46; y = 152; name = 'Flower Smelling Lady'; ro = 3 }
            @{ map = 'mora'; x = 48; y = 152; name = 'Sharp Eyed Man'; ro = 4 }
          )
          done = 'The lady was Nydhogg and the man was Loki. Nydhogg had left her post as Guardian of Yggdrasil; you told her what it meant, and they paid you with Loki''s Muffler and the Pendant of the Guardian.' }
     ) }

  # re/quests/quests_eclage.txt, Encounter in a Strange Land: ep14_2_mylord
  # 0 -> 33 (Traveler Fome, Lv 99; 34 on is the Flame Basin's Magic Scholar).
  # Mayor Jun Kardui only gives the letter (13 -> 14) from Lv 120; the
  # Eclage Interior (29 -> 30) is an instance for a party.
  @{ episode = '14.2'; title = 'Encounter in a Strange Land'; lv = 99
     end = 'ep14_2_mylord >= 33'
     needs = 'a way into Eclage: its gate guards let in only visitors the Laphine have registered (Side Quests, Eclage).'
     party = 'The lighting room (step 14) lets in a party only; from step 8 on, the Mayor wants you at level 120.'
     intro = 'Eclage, the city of the Laphine, is built in the branches of the World Tree. Its king is young and its people doubt him, and a traveler from far away has seen more of the city than its guards would like. This is Ragnarok''s own story: the Chronicle only shows the way, and RO gives its rewards.'
     steps = @(
       @{ title = 'Traveler Fome'
          cond = 'ep14_2_mylord >= 1'
          route = @('eclage', 299, 309, 'Door to Traveler Fome')
          now = 'RO quest: in Eclage, three travelers like you are chatting (ecl_in01, 32, 52). Walk up to them and choose Join the group.'
          hint = @(
            'They are inside the building whose door is at 299, 309 in Eclage.'
          )
          spots = @(
            @{ map = 'eclage'; x = 299; y = 309; name = 'Door to Traveler Fome' }
            @{ map = 'ecl_in01'; x = 32; y = 52; name = 'Traveler Fome' }
          )
          done = 'You joined three travelers in Eclage: Fome, Litrip and Chiba, who had seen more of the city than most.' }
       @{ title = 'Travelers'' Tales'
          cond = 'ep14_2_mylord >= 4'; var = 'ep14_2_mylord'
          parts = @(
            @{ at = 2; name = 'Hear each of them: Fome (32, 52), Litrip (32, 51) and Chiba (35, 51)'; route = @('ecl_in01', 32, 52, 'Traveler Fome') }
            @{ at = 4; name = 'The guard who comes for you: Sure. Let''s go.'; route = @('ecl_in01', 31, 49, 'Eclage Guard') }
          )
          route = @('ecl_in01', 32, 52, 'Traveler Fome')
          now = 'RO quest: hear the three travelers'' stories one by one. When you have heard all three, an Eclage Guard comes to take you to the palace: go with him.'
          hint = @(
            'If you told the guard you had no time, Guard Minuel at the east gate (ecl_in01, 82, 70) takes you later: Sure. Let''s go.'
            'Make some room in your bag: the Laphine of this story refuse a full one.'
          )
          spots = @(
            @{ map = 'ecl_in01'; x = 32; y = 52; name = 'Traveler Fome'; ro = 1 }
            @{ map = 'ecl_in01'; x = 32; y = 51; name = 'Traveler Litrip'; ro = 1 }
            @{ map = 'ecl_in01'; x = 35; y = 51; name = 'Traveler Chiba'; ro = 1 }
            @{ map = 'ecl_in01'; x = 32; y = 52; name = 'Traveler Fome'; ro = 2 }
            @{ map = 'ecl_in01'; x = 82; y = 70; name = 'Guard Minuel: Sure. Let''s go.'; ro = 3 }
          )
          done = 'The travelers told you of Bifrost Tower and of a Laphine king nobody sees. Then a guard came: the palace wanted to see you.' }
       @{ title = 'The Chief of Staff'
          cond = 'ep14_2_mylord >= 5'
          route = @('ecl_in03', 245, 93, 'Chief of Staff')
          now = 'RO quest: in the palace, the Chief of Staff, Shenime (ecl_in03, 245, 93), wants a word. Promise to keep what you believe to yourself: Yes, I promise. (or Fine, I won''t tell anyone.).'
          spots = @(
            @{ map = 'ecl_in03'; x = 245; y = 93; name = 'Chief of Staff Shenime' }
          )
          done = 'Shenime asked you to keep quiet about what travelers say of the king, promised you an audience with Mayor Jun, and sent you out to wait.' }
       @{ title = 'Mayor Jun Kardui'
          cond = 'ep14_2_mylord >= 7'; var = 'ep14_2_mylord'
          parts = @(
            @{ at = 6; name = 'After 10 minutes, Guard Minuel at the east gate (ecl_in01, 82, 70): Yes, please.'; route = @('ecl_in01', 82, 70, 'Guard Minuel') }
            @{ at = 7; name = 'Mayor Jun Kardui (ecl_in03, 41, 90)'; route = @('ecl_in03', 41, 90, 'Mayor Jun Kardui') }
          )
          route = @('ecl_in01', 82, 70, 'Guard Minuel')
          now = 'RO quest: wait 10 minutes (the quest window counts them down), then Guard Minuel at the east gate takes you to Mayor Jun Kardui. Hear the Mayor out.'
          hint = @(
            'Either answer to the Mayor leads on.'
          )
          spots = @(
            @{ map = 'ecl_in01'; x = 82; y = 70; name = 'Guard Minuel'; ro = 5 }
            @{ map = 'ecl_in03'; x = 41; y = 90; name = 'Mayor Jun Kardui'; ro = 6 }
          )
          done = 'Kardui, the Mayor Jun of the Laphine, turned out to be a boy who carries the memories of every Mayor before him. He wanted outside help, and the city had jobs for you first.' }
       @{ title = 'For Eclage'
          cond = 'ep14_2_mylord >= 8'
          items = @(@(6032, 'Horn of Hillslion', 5), @(6023, 'Mystic Horn', 5), @(944, 'Horseshoe', 5), @(12344, 'Pinguicula''s Fruit Jam', 3), @(12345, 'Luciola''s Honey Jam', 3))
          route = @('ecl_in01', 82, 70, 'Guard Minuel')
          now = 'RO quest: do three jobs for Eclage. Guard Minuel (ecl_in01, 82, 70) wants horns and horseshoes, Guard Leo (eclage, 112, 40) wants jam, and Messenger Roy (ecl_fild01, 205, 86) a parcel fetched from Splendide.'
          hint = @(
            'Minuel: Do they have a job for me?, Sure.; bring 5 Horn of Hillslion, 5 Mystic Horn and 5 Horseshoe.'
            'Leo: Does he want something?, then any answer; bring 3 Pinguicula''s Fruit Jam and 3 Luciola''s Honey Jam.'
            'Roy: What is it?, Leave it to me!; the Contact Officer in Splendide (267, 368) hands you the Mail Package for him.'
            'Each job pays 200,000 base and job EXP. The step is done when the third one is handed in.'
          )
          spots = @(
            @{ map = 'ecl_in01'; x = 82; y = 70; name = 'Guard Minuel' }
            @{ map = 'eclage'; x = 112; y = 40; name = 'Guard Leo' }
            @{ map = 'ecl_fild01'; x = 205; y = 86; name = 'Messenger Roy' }
            @{ map = 'splendide'; x = 267; y = 368; name = 'Contact Officer: the Mail Package' }
          )
          done = 'You did three jobs for Eclage, and the city started to trust you.' }
       @{ title = 'The Mayor''s Story'
          cond = 'ep14_2_mylord >= 10'; var = 'ep14_2_mylord'
          parts = @(
            @{ at = 9; name = 'Mayor Jun Kardui (ecl_in03, 41, 90)'; route = @('ecl_in03', 41, 90, 'Mayor Jun Kardui') }
            @{ at = 10; name = 'Shenime (ecl_in03, 245, 93): I''m supposed to give you something..'; route = @('ecl_in03', 245, 93, 'Chief of Staff') }
          )
          route = @('ecl_in03', 41, 90, 'Mayor Jun Kardui')
          now = 'RO quest: report to Mayor Jun Kardui, hear his story, then take what he gives you to the Chief of Staff.'
          spots = @(
            @{ map = 'ecl_in03'; x = 41; y = 90; name = 'Mayor Jun Kardui'; ro = 8 }
            @{ map = 'ecl_in03'; x = 245; y = 93; name = 'Chief of Staff Shenime'; ro = 9 }
          )
          done = 'Kardui told you how his reign began, and RO paid you 200,000 base and job EXP. Shenime gave you a Fairy Wing.' }
       @{ title = 'Rumors of the King'
          cond = 'ep14_2_mylord >= 11'
          route = @('eclage', 112, 40, 'Guard Leo')
          now = 'RO quest: find out what people say about the Mayor. Hear four of them: Guard Leo (eclage, 112, 40), Traveler Fome (ecl_in01, 32, 52), two Laphine chatting in Eclage (274, 294) and a resting Laphine in the palace (ecl_in03, 244, 57).'
          hint = @(
            'Leo: You don''t like the king? The chatting Laphine and the resting one start talking when you walk up to them; with the chatting pair, either answer works.'
          )
          spots = @(
            @{ map = 'eclage'; x = 112; y = 40; name = 'Guard Leo' }
            @{ map = 'ecl_in01'; x = 32; y = 52; name = 'Traveler Fome' }
            @{ map = 'eclage'; x = 274; y = 294; name = 'Laphine chatting' }
            @{ map = 'ecl_in03'; x = 244; y = 57; name = 'Resting Laphine' }
          )
          done = 'The rumors called the young Mayor a tyrant and the cause of the Laphine''s misery.' }
       @{ title = 'The Mayor''s Brother'
          cond = 'ep14_2_mylord >= 15'; var = 'ep14_2_mylord'
          parts = @(
            @{ at = 12; name = 'Mayor Jun Kardui (ecl_in03, 41, 90): any answer'; route = @('ecl_in03', 41, 90, 'Mayor Jun Kardui') }
            @{ at = 13; name = 'Kardui again'; route = @('ecl_in03', 41, 90, 'Mayor Jun Kardui') }
            @{ at = 14; name = 'Kardui, from level 120: Yes, I have. (he gives you a letter)'; route = @('ecl_in03', 41, 90, 'Mayor Jun Kardui') }
            @{ at = 15; name = 'Hisie on the top floor of Bifrost Tower (ecl_tdun04, 32, 35)'; route = @('ecl_tdun04', 32, 35, 'Hisie') }
          )
          route = @('ecl_in03', 41, 90, 'Mayor Jun Kardui')
          now = 'RO quest: tell Kardui what the people say. He has a letter for his brother Hisie, on the top floor of Bifrost Tower.'
          hint = @(
            'Kardui only hands over the letter at level 120 or higher, and not if you answer No, I''ve never thought about it.'
            'Bifrost Tower: its door is on the field outside Eclage (ecl_fild01, 182, 82). From its top floor a warp (ecl_tdun04, 34, 17) leads back out, and the way in from the field''s top (183, 70) leads straight up to Hisie.'
          )
          spots = @(
            @{ map = 'ecl_in03'; x = 41; y = 90; name = 'Mayor Jun Kardui'; ro = 11 }
            @{ map = 'ecl_in03'; x = 41; y = 90; name = 'Mayor Jun Kardui'; ro = 12 }
            @{ map = 'ecl_in03'; x = 41; y = 90; name = 'Mayor Jun Kardui'; ro = 13 }
            @{ map = 'ecl_fild01'; x = 182; y = 82; name = 'Bifrost Tower'; ro = 14 }
            @{ map = 'ecl_tdun04'; x = 32; y = 35; name = 'Hisie'; ro = 14 }
          )
          done = 'Kardui laughed at the rumors and sent you with a letter to his brother Hisie, who lives at the top of Bifrost Tower.' }
       @{ title = 'Avant the Scholar'
          cond = 'ep14_2_mylord >= 16'
          route = @('ecl_tdun04', 32, 35, 'Hisie')
          now = 'RO quest: Hisie reads the letter (3 minutes, the quest window counts them down). Then talk to him again (ecl_tdun04, 32, 35).'
          hint = @(
            'Any answers lead on.'
          )
          spots = @(
            @{ map = 'ecl_tdun04'; x = 32; y = 35; name = 'Hisie' }
          )
          done = 'Hisie told you about Avant, a scholar of magics who vanished, and asked you to look for him.' }
       @{ title = 'Shenime''s Favor'
          cond = 'ep14_2_mylord >= 18'; var = 'ep14_2_mylord'
          items = @(@(6561, 'Dustball', 10), @(6560, 'Leaf Bookmark', 10))
          parts = @(
            @{ at = 17; name = 'Shenime (ecl_in03, 245, 93): Sure.'; route = @('ecl_in03', 245, 93, 'Chief of Staff') }
            @{ at = 18; name = 'Bring her 10 Dustballs and 10 Leaf Bookmarks'; route = @('ecl_in03', 245, 93, 'Chief of Staff') }
          )
          route = @('ecl_in03', 245, 93, 'Chief of Staff')
          now = 'RO quest: Shenime sponsors a scholar of magics who needs materials from Bifrost Tower. Bring her 10 Dustballs and 10 Leaf Bookmarks.'
          hint = @(
            'Dustballs drop from Cenere (level 146), Leaf Bookmarks from Antique Books (level 148), both in Bifrost Tower (12.5% each).'
            'Gather 20 of each: the next step needs 10 more. RO pays 150,000 base and job EXP.'
          )
          spots = @(
            @{ map = 'ecl_in03'; x = 245; y = 93; name = 'Chief of Staff Shenime'; ro = 16 }
            @{ map = 'ecl_fild01'; x = 182; y = 82; name = 'Bifrost Tower'; ro = 17 }
            @{ map = 'ecl_in03'; x = 245; y = 93; name = 'Chief of Staff Shenime'; ro = 17 }
          )
          done = 'Shenime took the materials but would not say who her scholar was, and said she had never heard of Avant.' }
       @{ title = 'The Yai in the East'
          cond = 'ep14_2_mylord >= 21'; var = 'ep14_2_mylord'
          items = @(@(6561, 'Dustball', 10), @(6560, 'Leaf Bookmark', 10))
          parts = @(
            @{ at = 19; name = 'Guard Minuel (ecl_in01, 82, 70): A scholar of magics sponsored by Shenime, then Hisie (ecl_tdun04, 32, 35)'; route = @('ecl_in01', 82, 70, 'Guard Minuel') }
            @{ at = 20; name = 'The Yai in eastern Eclage (307, 237): Delivery..., with 10 Dustballs and 10 Leaf Bookmarks'; route = @('eclage', 307, 237, 'Normal Yai') }
            @{ at = 21; name = 'Mayor Jun Kardui (ecl_in03, 41, 90)'; route = @('ecl_in03', 41, 90, 'Mayor Jun Kardui') }
          )
          route = @('ecl_in01', 82, 70, 'Guard Minuel')
          now = 'RO quest: ask Guard Minuel where Shenime goes after work, and tell Hisie. Then take another 10 Dustballs and 10 Leaf Bookmarks to the Yai in the east of Eclage, as if Shenime sent them, and report to Kardui.'
          spots = @(
            @{ map = 'ecl_in01'; x = 82; y = 70; name = 'Guard Minuel'; ro = 18 }
            @{ map = 'ecl_tdun04'; x = 32; y = 35; name = 'Hisie'; ro = 18 }
            @{ map = 'eclage'; x = 307; y = 237; name = 'Normal Yai'; ro = 19 }
            @{ map = 'ecl_in03'; x = 41; y = 90; name = 'Mayor Jun Kardui'; ro = 20 }
          )
          done = 'Shenime often went east after work, to an ordinary Yai. Someone inside took your delivery, and Kardui wanted to know what is in there.' }
       @{ title = 'Avant''s Laboratory'
          cond = 'ep14_2_mylord >= 24'; var = 'ep14_2_mylord'
          parts = @(
            @{ at = 22; name = 'The Yai (eclage, 307, 237): Go in right now., then search the desk (que_avan01, 18, 38)'; route = @('eclage', 307, 237, 'Normal Yai') }
            @{ at = 24; name = 'Kardui (ecl_in03, 41, 90), with the Avant Research Data'; route = @('ecl_in03', 41, 90, 'Mayor Jun Kardui') }
          )
          route = @('eclage', 307, 237, 'Normal Yai')
          now = 'RO quest: slip into the Yai in the east of Eclage, search the desk of the hidden laboratory for Avant''s research, and bring it to Kardui.'
          hint = @(
            'One person at a time, for about 6 minutes. At the desk: Look at the book on the bookshelf., Try rearranging the books., then Second, Fourth, First, Third, Fifth. Then Look at the hinged devices..., Input a number. and type 31425. Do not taste the reagent: it costs half your HP.'
            'When Avant appears: Let Hisie handle it. takes you out; I''m taking care of this place! means fighting his 5 Dark Priests first, for a little more EXP from Kardui (400,000 base and 300,000 job instead of 350,000 and 250,000).'
          )
          spots = @(
            @{ map = 'eclage'; x = 307; y = 237; name = 'Normal Yai'; ro = 21 }
            @{ map = 'que_avan01'; x = 18; y = 38; name = 'Desk'; ro = 21 }
            @{ map = 'ecl_in03'; x = 41; y = 90; name = 'Mayor Jun Kardui'; ro = 22 }
            @{ map = 'ecl_in03'; x = 41; y = 90; name = 'Mayor Jun Kardui'; ro = 23 }
          )
          done = 'In the hidden laboratory you found Avant''s research on Yggdrasil and the Orb, and Avant himself. Kardui read the data and asked you to help protect the Orb.' }
       @{ title = 'Shenime''s Secret'
          cond = 'ep14_2_mylord >= 27'; var = 'ep14_2_mylord'
          parts = @(
            @{ at = 25; name = 'Hisie (ecl_tdun04, 32, 35): About the Chief of Staff'; route = @('ecl_tdun04', 32, 35, 'Hisie') }
            @{ at = 26; name = 'Shenime (ecl_in03, 245, 93)'; route = @('ecl_in03', 245, 93, 'Chief of Staff') }
            @{ at = 27; name = 'Kardui (ecl_in03, 41, 90): I''m at your service.'; route = @('ecl_in03', 41, 90, 'Mayor Jun Kardui') }
          )
          route = @('ecl_tdun04', 32, 35, 'Hisie')
          now = 'RO quest: tell Hisie what you found, then question Shenime about her scholar, and report to Kardui.'
          hint = @(
            'With Shenime, any answers lead on.'
          )
          spots = @(
            @{ map = 'ecl_tdun04'; x = 32; y = 35; name = 'Hisie'; ro = 24 }
            @{ map = 'ecl_in03'; x = 245; y = 93; name = 'Chief of Staff Shenime'; ro = 25 }
            @{ map = 'ecl_in03'; x = 41; y = 90; name = 'Mayor Jun Kardui'; ro = 26 }
          )
          done = 'Shenime had sponsored Avant without even knowing his name, and seemed more interested in the Orb than in him. Kardui left Shenime in your hands.' }
       @{ title = 'The Lighting Room'
          cond = 'ep14_2_mylord >= 30'; var = 'ep14_2_mylord'
          parts = @(
            @{ at = 29; name = 'Shenime (ecl_in03, 245, 93): Hold his hand.'; route = @('ecl_in03', 245, 93, 'Chief of Staff') }
            @{ at = 30; name = 'With your party: the Chief of Staff (ecl_hub01, 132, 12), Enter it., and inside Shenime, Avant and Hisie'; route = @('ecl_hub01', 132, 12, 'Chief of Staff') }
          )
          route = @('ecl_in03', 245, 93, 'Chief of Staff')
          now = 'RO quest: Shenime takes you to the lighting room under the city. Go in with your party: the room fills with creatures of the king of demons.'
          hint = @(
            'Your party''s leader opens the Eclage Interior at the door where Shenime leaves you (ecl_hub01, 132, 12); the others enter there too. It stays open 20 minutes.'
            'Inside, step forward: 4 Suspicious Creatures, then 8 Incarnations of Morocc (level 100). Then talk to Shenime, to Avant (148, 97) and to Hisie (144, 27).'
          )
          spots = @(
            @{ map = 'ecl_in03'; x = 245; y = 93; name = 'Chief of Staff Shenime'; ro = 27 }
            @{ map = 'ecl_in03'; x = 245; y = 93; name = 'Chief of Staff Shenime'; ro = 28 }
            @{ map = 'ecl_hub01'; x = 132; y = 12; name = 'Lighting room: Enter it.'; ro = 29 }
            @{ map = '1@ecl'; x = 148; y = 97; name = 'Avant'; ro = 29 }
            @{ map = '1@ecl'; x = 144; y = 27; name = 'Hisie'; ro = 29 }
          )
          done = 'In the lighting room Shenime turned on you. Avant, who had served her, showed he had a conscience after all, and Hisie, with Loki and Nydhogg, healed you. Shenime and the Orb were gone.' }
       @{ title = 'The Chief of Staff''s Body'
          cond = 'ep14_2_mylord >= 33'; var = 'ep14_2_mylord'
          parts = @(
            @{ at = 31; name = 'Kardui (ecl_in03, 41, 90): I''ll go after Shenime!'; route = @('ecl_in03', 41, 90, 'Mayor Jun Kardui') }
            @{ at = 32; name = 'A dead Laphine on Bifrost''s field (bif_fild02, 311, 91)'; route = @('bif_fild02', 311, 91, 'Dead Laphine') }
            @{ at = 33; name = 'Kardui once more'; route = @('ecl_in03', 41, 90, 'Mayor Jun Kardui') }
          )
          route = @('ecl_in03', 41, 90, 'Mayor Jun Kardui')
          now = 'RO quest: tell Kardui what happened and go after Shenime. A clue lies somewhere in Bifrost; bring back what you find.'
          hint = @(
            'RO pays 500,000 base and 400,000 job EXP at the end. The story of the Laphine goes on with the Magic Scholar in the Flame Basin (Side Quests, Flame Basin).'
          )
          spots = @(
            @{ map = 'ecl_in03'; x = 41; y = 90; name = 'Mayor Jun Kardui'; ro = 30 }
            @{ map = 'bif_fild02'; x = 311; y = 91; name = 'Dead Laphine'; ro = 31 }
            @{ map = 'ecl_in03'; x = 41; y = 90; name = 'Mayor Jun Kardui'; ro = 32 }
          )
          done = 'On Bifrost''s field lay the real Chief of Staff, long dead: a creature of the king of demons had worn him as Shenime and fled to the rift. Kardui swore to stand against the king of demons, and blessed you as his friend.' }
     ) }

  # re/quests/quests_14_3_bis.txt, Dimensional Travel: ep14_3_newerabs 0 -> 24
  # (the Piled Rags in Morroc, Lv 140). Its start checks nothing else; 14.2's
  # own road goes on to the Flame Basin's Magic Scholar.
  @{ episode = '14.3'; title = 'Dimensional Travel'; lv = 140
     end = 'ep14_3_newerabs >= 24'
     intro = 'In the ruins of Morroc, something lies moaning under a pile of rags. Whoever it is has come a long way, and not only across the desert. This is Ragnarok''s own story: the Chronicle only shows the way, and RO gives its rewards.'
     steps = @(
       @{ title = 'The Piled Rags'
          cond = 'ep14_3_newerabs >= 1'
          route = @('morocc', 138, 238, 'Piled Rags')
          now = 'RO quest: in the ruins of Morroc, a pile of dirty rags lies at 138, 238. Choose Remove it., then Shake the rags.'
          hint = @(
            'No open road leads into Morroc: a Kafra Employee in Payon (175, 226) or Prontera (146, 89) teleports you there (Teleport Service, then Morocc, 1,200 zeny).'
            'Make some room in your bag first: the quest refuses a full bag.'
          )
          spots = @(
            @{ map = 'payon'; x = 175; y = 226; name = 'Kafra: Teleport to Morocc (1,200 zeny)' }
            @{ map = 'prontera'; x = 146; y = 89; name = 'Kafra: Teleport to Morocc (1,200 zeny)' }
            @{ map = 'morocc'; x = 138; y = 238; name = 'Piled Rags' }
          )
          done = 'Under the rags in Morroc lay a stranger, moaning, and with him your Dimensional Travel began.' }
       @{ title = 'Tamarin'
          cond = 'ep14_3_newerabs >= 5'; var = 'ep14_3_newerabs'
          items = @(, @(528, 'Monster''s Feed', 1))
          parts = @(
            @{ at = 2; name = 'Give him a Monster''s Feed'; route = @('morocc', 138, 238, 'Piled Rags') }
            @{ at = 5; name = 'Hear him out: Introduce yourself., Tell him the place., Accompany him.'; route = @('morocc', 138, 238, 'Piled Rags') }
          )
          route = @('morocc', 138, 238, 'Piled Rags')
          now = 'RO quest: the stranger under the rags is starving. Bring him a Monster''s Feed, then hear his story and go along with him.'
          hint = @(
            'Monster''s Feed: the Item Collector in Alberta (alberta_in, 165, 96), the Tool Dealer in Hugel (hu_in01, 252, 368) and a Merchant in Lighthalzen (lhz_in03, 249, 24) sell it.'
            'If you answer Say you don''t know. or Watch him., talk to him again.'
          )
          spots = @(
            @{ map = 'alberta_in'; x = 165; y = 96; name = 'Item Collector: Monster''s Feed'; ro = 1 }
            @{ map = 'morocc'; x = 138; y = 238; name = 'Piled Rags'; ro = 1 }
            @{ map = 'morocc'; x = 138; y = 238; name = 'Tamarin'; ro = 2 }
            @{ map = 'morocc'; x = 138; y = 238; name = 'Tamarin'; ro = 3 }
            @{ map = 'morocc'; x = 138; y = 238; name = 'Tamarin'; ro = 4 }
          )
          done = 'The stranger was Tamarin, an adventurer who fell through a strange hole, lost his party and his belongings, and came back half-starved.' }
       @{ title = 'Into the Dimensional Gap'
          cond = 'ep14_3_newerabs >= 9'; var = 'ep14_3_newerabs'
          parts = @(
            @{ at = 7; name = 'Tamarin by the ruins (moc_ruins, 106, 140): I''m listening., then Tell him you want to tag along.'; route = @('moc_ruins', 106, 140, 'Tamarin') }
            @{ at = 8; name = 'Tamarin in the Dimensional Gap (dali, 112, 69)'; route = @('dali', 112, 69, 'Tamarin') }
            @{ at = 9; name = 'The Sand Mound in the Gap''s lower floor (dali02, 90, 62): Enter.'; route = @('dali02', 90, 62, 'Sand Mound') }
          )
          route = @('moc_ruins', 106, 140, 'Tamarin')
          now = 'RO quest: Tamarin wants to go back where he fell. Tag along: meet him in the Dimensional Gap, then go down through the Sand Mound.'
          hint = @(
            'The Dimensional Gap (dali): a Transport Device at the rift (moc_fild22b, 222, 200) or in the Allied camp (mid_camp, 210, 292): Yes. Its lower floor (dali02) is through the passage at dali 64, 129.'
            'The Sand Mound drops you into the Flame Basin (moro_vol); the mound beside where you land (137, 136) takes you back.'
          )
          spots = @(
            @{ map = 'moc_ruins'; x = 106; y = 140; name = 'Tamarin'; ro = 5 }
            @{ map = 'moc_ruins'; x = 106; y = 140; name = 'Tamarin'; ro = 6 }
            @{ map = 'moc_fild22b'; x = 222; y = 200; name = 'Transport Device: Dimensional Gap'; ro = 7 }
            @{ map = 'dali'; x = 112; y = 69; name = 'Tamarin'; ro = 7 }
            @{ map = 'dali'; x = 64; y = 129; name = 'Way down to dali02'; ro = 8 }
            @{ map = 'dali02'; x = 90; y = 62; name = 'Sand Mound: Enter.'; ro = 8 }
          )
          done = 'You followed Tamarin into the Dimensional Gap and down through a mound of sand, into a burning land nobody had mapped: the Flame Basin.' }
       @{ title = 'Specimens for Barget'
          cond = 'ep14_3_newerabs >= 17'; var = 'ep14_3_newerabs'
          items = @(, @(6689, 'Burning Bug Skin', 50))
          parts = @(
            @{ at = 15; name = 'Tamarin in the Flame Basin (moro_vol, 132, 140)'; route = @('moro_vol', 132, 140, 'Tamarin') }
            @{ at = 16; name = 'Barget Tiblack (moro_vol, 142, 131)'; route = @('moro_vol', 142, 131, 'Barget Tiblack') }
            @{ at = 17; name = 'Kill 20 Fire Pits and bring Barget 50 Burning Bug Skins'; route = @('moro_vol', 142, 131, 'Barget Tiblack') }
          )
          route = @('moro_vol', 132, 140, 'Tamarin')
          now = 'RO quest: in the Flame Basin, Tamarin takes you to Dr. Barget Tiblack, who studies its new insects. Kill 20 Fire Pits and bring her 50 Burning Bug Skins.'
          hint = @(
            'Burning Bug Skins drop from Fire Bugs (level 150, 10%) in the Flame Basin. The quest window (Alt+U) counts the Fire Pits.'
          )
          spots = @(
            @{ map = 'moro_vol'; x = 132; y = 140; name = 'Tamarin'; ro = 9 }
            @{ map = 'moro_vol'; x = 142; y = 131; name = 'Barget Tiblack'; ro = 15 }
            @{ map = 'moro_vol'; x = 142; y = 131; name = 'Barget Tiblack'; ro = 16 }
          )
          done = 'Barget took her specimens. Next she wanted the stems of the Sonia that grow in the basin.' }
       @{ title = 'Sonia Stems'
          cond = 'ep14_3_newerabs >= 20'; var = 'ep14_3_newerabs'
          items = @(, @(6690, 'Yummy Stem', 25))
          parts = @(
            @{ at = 18; name = 'Tamarin (moro_vol, 132, 140)'; route = @('moro_vol', 132, 140, 'Tamarin') }
            @{ at = 19; name = 'Kill 25 Sonia, then meet Tamarin by the big rock (moro_vol, 198, 179)'; route = @('moro_vol', 198, 179, 'Tamarin') }
            @{ at = 20; name = 'Barget (moro_vol, 142, 131)'; route = @('moro_vol', 142, 131, 'Barget Tiblack') }
          )
          route = @('moro_vol', 132, 140, 'Tamarin')
          now = 'RO quest: with Tamarin, kill 25 Sonia and gather 25 Yummy Stems, meet him by the big rock in the middle of the basin, then show Barget the stems.'
          hint = @(
            'Yummy Stems drop from Sonia (10%). Keep all 25: the next step hands them over.'
          )
          spots = @(
            @{ map = 'moro_vol'; x = 132; y = 140; name = 'Tamarin'; ro = 17 }
            @{ map = 'moro_vol'; x = 198; y = 179; name = 'Tamarin by the big rock'; ro = 18 }
            @{ map = 'moro_vol'; x = 142; y = 131; name = 'Barget Tiblack'; ro = 19 }
          )
          done = 'Barget had forgotten to warn you: the gas from the big rock puts everyone into a coma. You came back unharmed because you had eaten a Sonia stem, and the stems could save the patients the gas had struck.' }
       @{ title = 'The Antidote'
          cond = 'ep14_3_newerabs >= 24'; var = 'ep14_3_newerabs'
          items = @(, @(6690, 'Yummy Stem', 25))
          parts = @(
            @{ at = 21; name = 'Instructor Rugen (moro_vol, 105, 71): Talk to him., Give Sonia stems.'; route = @('moro_vol', 105, 71, 'Instructor Rugen') }
            @{ at = 22; name = 'The Intoxicated Patient beside him (104, 70)'; route = @('moro_vol', 104, 70, 'Intoxicated Patient') }
            @{ at = 23; name = 'Instructor Rugen again'; route = @('moro_vol', 105, 71, 'Instructor Rugen') }
            @{ at = 24; name = 'Barget (moro_vol, 142, 131): What cave?'; route = @('moro_vol', 142, 131, 'Barget Tiblack') }
          )
          route = @('moro_vol', 105, 71, 'Instructor Rugen')
          now = 'RO quest: in the south of the Flame Basin, give Instructor Rugen the 25 Yummy Stems for the patients he looks after, see how one of them is doing, and take his report to Barget.'
          hint = @(
            'RO pays 1,500,000 job EXP at the end. Afterwards Tamarin by the big rock (198, 179) can take you into a newly found cave.'
          )
          spots = @(
            @{ map = 'moro_vol'; x = 105; y = 71; name = 'Instructor Rugen'; ro = 20 }
            @{ map = 'moro_vol'; x = 104; y = 70; name = 'Intoxicated Patient'; ro = 21 }
            @{ map = 'moro_vol'; x = 105; y = 71; name = 'Instructor Rugen'; ro = 22 }
            @{ map = 'moro_vol'; x = 142; y = 131; name = 'Barget Tiblack'; ro = 23 }
          )
          done = 'The Sonia stems brought the patients round. With them, Barget hopes to explore the cave the noxious gas comes from, and the first group has already gone in.' }
     ) }

  # re/quests/quests_15_1.txt and quests_15_2.txt, the Atnad excavation:
  # ep15_1_atnad 0 -> 34. Lime Evenor speaks from Lv 140, and only to members
  # of the Eden Group (item 6219 or 22508).
  # From 30 Ian waits for ep15_2_permit 6: four plays of the research
  # facilities' records (one a day, quests 7650/7654/7651) at Nile's camp.
  @{ episode = '15'; title = 'The Atnad Excavation'; lv = 140
     end = 'ep15_1_atnad >= 34'
     needs = 'membership of the Eden Group: any town''s Eden Teleport Officer takes you to its headquarters, where you can join.'
     intro = 'An ancient site has been found under Juperos, and the Rekenber Corporation is hiring adventurers to dig it out. The Eden Group has signed on, and beneath the ruins lies Verus, a city of the ancients, and something called Phantasmagorika. This is Ragnarok''s own story: the Chronicle only shows the way, and RO gives its rewards.'
     steps = @(
       @{ title = 'Word from the Eden Group'
          cond = 'ep15_1_atnad >= 1'
          route = @('moc_para01', 31, 14, 'Secretary Lime Evenor')
          now = 'RO quest: in the Eden Group''s headquarters, Secretary Lime Evenor greets you at the entrance to the central room (moc_para01, 31, 14): an ancient site was found in Juperos, and the Captain wants to see you.'
          hint = @(
            'Any town''s Eden Teleport Officer takes you to the Eden Group (moc_para01). Keep your Eden Group mark in your bag: without it Lime Evenor sends you to join first.'
          )
          spots = @(
            @{ map = 'moc_para01'; x = 31; y = 14; name = 'Secretary Lime Evenor' }
          )
          done = 'Lime Evenor told you of the ancient site under Juperos: the Eden Group has joined Rekenber''s excavation, and the Captain wants you on it.' }
       @{ title = 'Commander Arquien'
          cond = 'ep15_1_atnad >= 3'; var = 'ep15_1_atnad'
          parts = @(
            @{ at = 2; name = 'Commander Arquien (moc_para01, 133, 170): either answer, then Please continue.'; route = @('moc_para01', 133, 170, 'Commander Arquien') }
            @{ at = 3; name = 'If you asked her to stop, Arquien again: Yes'; route = @('moc_para01', 133, 170, 'Commander Arquien') }
          )
          route = @('moc_para01', 133, 170, 'Commander Arquien')
          now = 'RO quest: Commander Arquien of the Eden Group (moc_para01, 133, 170) has a job for you. Hear her out.'
          hint = @(
            'Make some room in your bag first: everyone in this episode refuses a full one.'
          )
          spots = @(
            @{ map = 'moc_para01'; x = 133; y = 170; name = 'Commander Arquien'; ro = 1 }
            @{ map = 'moc_para01'; x = 133; y = 170; name = 'Commander Arquien'; ro = 2 }
          )
          done = 'Arquien, who goes by Nile, signed you on to the Atnad Excavation Team: the Eden Group''s part in Rekenber''s dig under Juperos.' }
       @{ title = 'Registered Excavator'
          cond = 'ep15_1_atnad >= 5'; var = 'ep15_1_atnad'
          parts = @(
            @{ at = 4; name = 'Lime Evenor in the central room (moc_para01, 174, 165)'; route = @('moc_para01', 174, 165, 'Lime Evenor') }
            @{ at = 5; name = 'Receptionist Nara in Verus (verus04, 182, 168): I''m from the Eden Group., type Atnad'; route = @('verus04', 182, 168, 'Receptionist Nara') }
          )
          route = @('moc_para01', 174, 165, 'Lime Evenor')
          now = 'RO quest: meet the team in the Eden Group''s central room, then travel to the dig at Verus and register with Rekenber''s receptionist as a member of the Atnad Excavation Team.'
          hint = @(
            'To Verus: from Juno to Juperos; in its first level (juperos_01) the way at 245, 87 leads to the excavation''s elevator (ver_eju), then through the tunnel to Verus (verus04).'
            'Nara asks for your team''s name: type Atnad. RO pays 300,000 base and job EXP.'
          )
          spots = @(
            @{ map = 'moc_para01'; x = 174; y = 165; name = 'Lime Evenor'; ro = 3 }
            @{ map = 'juperos_01'; x = 245; y = 87; name = 'Way to the excavation'; ro = 4 }
            @{ map = 'verus04'; x = 182; y = 168; name = 'Receptionist Nara'; ro = 4 }
          )
          done = 'You met Archaeologist Aures and Luke Lapez of the team, and Rekenber registered you as an excavator of the Atnad team in Verus, the buried city of the ancients.' }
       @{ title = 'Dr. Ian Atnad'
          cond = 'ep15_1_atnad >= 8'; var = 'ep15_1_atnad'
          items = @(, @(6749, 'Operation Control Device', 20))
          parts = @(
            @{ at = 6; name = 'Aures (verus04, 141, 193): I came to help., or Ian beside him: Just here to help.'; route = @('verus04', 141, 193, 'Archaeologist Aures') }
            @{ at = 7; name = 'Dr. Ian Atnad (verus04, 144, 193)'; route = @('verus04', 144, 193, 'Ian Atnad') }
            @{ at = 8; name = 'Bring Ian 20 Operation Control Devices'; route = @('verus04', 144, 193, 'Ian Atnad') }
          )
          route = @('verus04', 141, 193, 'Archaeologist Aures')
          now = 'RO quest: report to the team''s camp in Verus. Its leader, Dr. Ian Atnad, wants to see what you can do: bring him 20 Operation Control Devices from the ancient machines.'
          hint = @(
            'While the quest is open, Recon Robots (level 165), Repair Robots (155) and Exploration Rovers (168) in the ruins of Verus drop Operation Control Devices (50%).'
            'RO pays 750,000 base and 500,000 job EXP.'
          )
          spots = @(
            @{ map = 'verus04'; x = 141; y = 193; name = 'Archaeologist Aures'; ro = 5 }
            @{ map = 'verus04'; x = 144; y = 193; name = 'Ian Atnad'; ro = 6 }
            @{ map = 'verus04'; x = 144; y = 193; name = 'Ian Atnad'; ro = 7 }
          )
          done = 'Dr. Ian Atnad tested you with the machines'' control devices, and you passed.' }
       @{ title = 'Lloyd''s Energy'
          cond = 'ep15_1_atnad >= 12'; var = 'ep15_1_atnad'
          items = @(, @(6756, 'Cohesive Energy', 10))
          parts = @(
            @{ at = 9; name = 'Aures (verus04, 141, 193)'; route = @('verus04', 141, 193, 'Archaeologist Aures') }
            @{ at = 10; name = 'Machinist Lloyd (verus03, 103, 177): Are you Lloyd?, Sure.'; route = @('verus03', 103, 177, 'Machinist Lloyd') }
            @{ at = 11; name = 'Bring Lloyd 10 Cohesive Energy'; route = @('verus03', 103, 177, 'Machinist Lloyd') }
            @{ at = 12; name = 'Aures (verus04, 141, 193): he gives you the team''s report'; route = @('verus04', 141, 193, 'Archaeologist Aures') }
          )
          route = @('verus04', 141, 193, 'Archaeologist Aures')
          now = 'RO quest: Aures sends you to Lloyd, a cat machinist in the old city (verus03). Fill bottles with the energy of a machine remnant for him, then go back to Aures.'
          hint = @(
            'verus03 is north of the camp (verus04, 121, 267). The Machine Remnant (verus03, 127, 145) fills 1 Empty Bottle with 1 Cohesive Energy each time: bring 10 Empty Bottles.'
          )
          spots = @(
            @{ map = 'verus04'; x = 141; y = 193; name = 'Archaeologist Aures'; ro = 8 }
            @{ map = 'verus03'; x = 103; y = 177; name = 'Machinist Lloyd'; ro = 9 }
            @{ map = 'verus03'; x = 127; y = 145; name = 'Machine Remnant (1 Empty Bottle each)'; ro = 10 }
            @{ map = 'verus03'; x = 103; y = 177; name = 'Machinist Lloyd'; ro = 10 }
            @{ map = 'verus04'; x = 141; y = 193; name = 'Archaeologist Aures'; ro = 11 }
          )
          done = 'With the energy you bottled, Lloyd hopes he and Ian can bring the robots of Verus back to life. Aures handed you the team''s report for Rekenber.' }
       @{ title = 'The Report'
          cond = 'ep15_1_atnad >= 14'; var = 'ep15_1_atnad'
          parts = @(
            @{ at = 13; name = 'Commander Louis (verus04, 179, 165): Report excavation results.'; route = @('verus04', 179, 165, 'Commander Louis') }
            @{ at = 14; name = 'Ian (verus04, 144, 193)'; route = @('verus04', 144, 193, 'Ian Atnad') }
          )
          route = @('verus04', 179, 165, 'Commander Louis')
          now = 'RO quest: hand the report to Rekenber''s Commander Louis by the entrance of Verus, then see what Ian wants.'
          hint = @(
            'Louis pays 300,000 base and job EXP.'
          )
          spots = @(
            @{ map = 'verus04'; x = 179; y = 165; name = 'Commander Louis'; ro = 12 }
            @{ map = 'verus04'; x = 144; y = 193; name = 'Ian Atnad'; ro = 13 }
          )
          done = 'Rekenber had its report. Ian, meanwhile, had something else on his mind.' }
       @{ title = 'A Delicacy for Ian'
          cond = 'ep15_1_atnad >= 17'; var = 'ep15_1_atnad'
          items = @(@(517, 'Meat', 2), @(11520, 'Mora Mandar', 1), @(513, 'Banana', 1))
          parts = @(
            @{ at = 15; name = 'Luke Lapez (verus03, 107, 177)'; route = @('verus03', 107, 177, 'Luke Lapez') }
            @{ at = 16; name = 'Bring Luke 2 Meat, 1 Mora Mandar and 1 Banana: he makes a Beef Toast'; route = @('verus03', 107, 177, 'Luke Lapez') }
            @{ at = 17; name = 'Give Ian the Beef Toast (verus04, 144, 193)'; route = @('verus04', 144, 193, 'Ian Atnad') }
          )
          route = @('verus03', 107, 177, 'Luke Lapez')
          now = 'RO quest: Ian will only talk over a good meal. Ask Luke Lapez to cook him a Beef Toast, and bring him the ingredients.'
          hint = @(
            'Meat and Banana: most towns'' food sellers. Mora Mandar: Pom Spiders (level 145, 5%), or the Eden Group''s market (Market Group Hustler, moc_para01, 106, 38) when in stock.'
          )
          spots = @(
            @{ map = 'verus03'; x = 107; y = 177; name = 'Luke Lapez'; ro = 14 }
            @{ map = 'verus03'; x = 107; y = 177; name = 'Luke Lapez'; ro = 15 }
            @{ map = 'verus04'; x = 144; y = 193; name = 'Ian Atnad'; ro = 16 }
          )
          done = 'Over Luke''s Beef Toast, Ian opened up: he wants to know about the Last Exploration, the ancients'' final expedition.' }
       @{ title = 'The Last Exploration'
          cond = 'ep15_1_atnad >= 21'; var = 'ep15_1_atnad'
          parts = @(
            @{ at = 18; name = 'Ian (verus04, 144, 193): Converse, What about the Last Exploration!'; route = @('verus04', 144, 193, 'Ian Atnad') }
            @{ at = 19; name = 'Ian again: Converse (you may now enter the research facilities)'; route = @('verus04', 144, 193, 'Ian Atnad') }
            @{ at = 20; name = 'A Strewn paper in the research facilities (verus02, 60, 30): Check adequately.'; route = @('verus02', 60, 30, 'Strewn paper') }
            @{ at = 21; name = 'Ian, with what you found'; route = @('verus04', 144, 193, 'Ian Atnad') }
          )
          route = @('verus04', 144, 193, 'Ian Atnad')
          now = 'RO quest: Ian gets you permission to explore the ancients'' research facilities (verus02). Search the strewn papers there and bring him what you find.'
          hint = @(
            'The research facilities are through the north-east of the old city (verus03, 169, 259); the guard there lets you through once Ian has. Strewn papers lie at 60, 30, 178, 32, 102, 135, 42, 37 and more.'
          )
          spots = @(
            @{ map = 'verus04'; x = 144; y = 193; name = 'Ian Atnad'; ro = 17 }
            @{ map = 'verus04'; x = 144; y = 193; name = 'Ian Atnad'; ro = 18 }
            @{ map = 'verus03'; x = 169; y = 259; name = 'Way to the research facilities'; ro = 19 }
            @{ map = 'verus02'; x = 60; y = 30; name = 'Strewn paper'; ro = 19 }
            @{ map = 'verus02'; x = 178; y = 32; name = 'Strewn paper'; ro = 19 }
            @{ map = 'verus04'; x = 144; y = 193; name = 'Ian Atnad'; ro = 20 }
          )
          done = 'Among the papers lay a strange piece, a Memory Record of the ancients. Ian looked at you as if you should know what plays it.' }
       @{ title = 'The Record Player'
          cond = 'ep15_1_atnad >= 23'; var = 'ep15_1_atnad'
          items = @(, @(6757, 'The Memory Recorder', 1))
          parts = @(
            @{ at = 22; name = 'Commander Arquien in the Eden Group (moc_para01, 133, 170): type Record Player'; route = @('moc_para01', 133, 170, 'Commander Arquien') }
            @{ at = 23; name = 'Arquien again, with the record'; route = @('moc_para01', 133, 170, 'Commander Arquien') }
          )
          route = @('moc_para01', 133, 170, 'Commander Arquien')
          now = 'RO quest: ask Commander Arquien at the Eden Group what could play the ancients'' record, and show it to her.'
          hint = @(
            'She asks what such a thing is called: type Record Player.'
          )
          spots = @(
            @{ map = 'moc_para01'; x = 133; y = 170; name = 'Commander Arquien'; ro = 21 }
            @{ map = 'moc_para01'; x = 133; y = 170; name = 'Commander Arquien'; ro = 22 }
          )
          done = 'Nile knew of a record player, but one piece was not enough: she wanted five.' }
       @{ title = 'Memory Records'
          cond = 'ep15_1_atnad >= 26'; var = 'ep15_1_atnad'
          items = @(, @(6757, 'The Memory Recorder', 5))
          parts = @(
            @{ at = 24; name = 'Bring Arquien at the camp (verus04, 172, 149) 5 records from the strewn papers'; route = @('verus04', 172, 149, 'Commander Arquien') }
            @{ at = 25; name = 'The record player beside her (verus04, 170, 150)'; route = @('verus04', 170, 150, 'Record player') }
            @{ at = 26; name = 'Arquien again'; route = @('verus04', 172, 149, 'Commander Arquien') }
          )
          route = @('verus02', 60, 30, 'Strewn paper')
          now = 'RO quest: gather 5 records from the strewn papers in the research facilities (verus02), bring them to Nile at the camp in Verus, and play them.'
          hint = @(
            'Each strewn paper gives one record, then rests a minute. RO pays 750,000 base and 500,000 job EXP.'
          )
          spots = @(
            @{ map = 'verus02'; x = 60; y = 30; name = 'Strewn paper'; ro = 23 }
            @{ map = 'verus02'; x = 178; y = 32; name = 'Strewn paper'; ro = 23 }
            @{ map = 'verus02'; x = 102; y = 135; name = 'Strewn paper'; ro = 23 }
            @{ map = 'verus04'; x = 172; y = 149; name = 'Commander Arquien'; ro = 23 }
            @{ map = 'verus04'; x = 170; y = 150; name = 'Record player'; ro = 24 }
            @{ map = 'verus04'; x = 172; y = 149; name = 'Commander Arquien'; ro = 25 }
          )
          done = 'The records spoke: voices of the people of Verus, from the days before their city was buried.' }
       @{ title = 'The Laboratories'
          cond = 'ep15_1_atnad >= 30'; var = 'ep15_1_atnad'
          items = @(, @(6824, 'Experimental Dong Memory Record', 5))
          parts = @(
            @{ at = 27; name = 'Ian (verus04, 144, 193): tell him what the records said'; route = @('verus04', 144, 193, 'Ian Atnad') }
            @{ at = 28; name = 'Bring Arquien 5 records from the laboratories (the bunker)'; route = @('verus04', 172, 149, 'Commander Arquien') }
            @{ at = 29; name = 'The record player (verus04, 170, 150)'; route = @('verus04', 170, 150, 'Record player') }
            @{ at = 30; name = 'Arquien: Show piece.'; route = @('verus04', 172, 149, 'Commander Arquien') }
          )
          route = @('verus04', 144, 193, 'Ian Atnad')
          now = 'RO quest: tell Ian what the records said. He wants the records of the ancients'' laboratories next: search the bunker under Verus for 5 of them and play them at Nile''s.'
          hint = @(
            'The bunker (un_bunker): Verity in verus01 (123, 181) takes you down: Yes. verus01 is through the north-west of the old city (verus03, 52, 254). Boxes, desks, machine remains, thickets, food trays and document piles each give one record.'
            'The record player leaves you a Record Fragment: show it to Nile. RO pays 750,000 base and 500,000 job EXP.'
          )
          spots = @(
            @{ map = 'verus04'; x = 144; y = 193; name = 'Ian Atnad'; ro = 26 }
            @{ map = 'verus03'; x = 52; y = 254; name = 'Way to verus01'; ro = 27 }
            @{ map = 'verus01'; x = 123; y = 181; name = 'Verity: down to the bunker'; ro = 27 }
            @{ map = 'un_bunker'; x = 382; y = 335; name = 'Box'; ro = 27 }
            @{ map = 'un_bunker'; x = 87; y = 167; name = 'Under desk'; ro = 27 }
            @{ map = 'verus04'; x = 172; y = 149; name = 'Commander Arquien'; ro = 27 }
            @{ map = 'verus04'; x = 170; y = 150; name = 'Record player'; ro = 28 }
            @{ map = 'verus04'; x = 172; y = 149; name = 'Commander Arquien: Show piece.'; ro = 29 }
          )
          done = 'The laboratories'' records told of the ancients'' experiments, and the record broke apart as they always do. Nile began to wonder who wanted them found.' }
       @{ title = 'A Record a Day'
          cond = 'ep15_1_atnad >= 31'
          items = @(, @(6757, 'The Memory Recorder', 5))
          route = @('verus04', 172, 149, 'Commander Arquien')
          now = 'RO quest: keep playing the research facilities'' records with Nile, one set a day, until someone comes to visit the team. Then talk to Ian (verus04, 144, 193).'
          hint = @(
            'Nile (verus04, 172, 149): Research facilities Memory Records, Accept.; gather 5 records from the strewn papers (verus02), give them to her, and play them at the record player (170, 150). Once a day: the next set waits until 4:00 server time.'
            'After the fourth day''s records Nile notices a visitor at the team''s tent. Ian then answers: Is there something wrong?, Chairman Rekenber''s secretary?, Me?'
            'Each play pays 1,500,000 base and 1,000,000 job EXP.'
          )
          spots = @(
            @{ map = 'verus04'; x = 172; y = 149; name = 'Commander Arquien' }
            @{ map = 'verus02'; x = 60; y = 30; name = 'Strewn paper' }
            @{ map = 'verus04'; x = 170; y = 150; name = 'Record player' }
            @{ map = 'verus04'; x = 144; y = 193; name = 'Ian Atnad' }
          )
          done = 'Day after day the records gave up the past of Verus, until Chairman Rekenber''s secretary came to the camp: the chairman wanted to see you.' }
       @{ title = 'Chairman Rekenber'
          cond = 'ep15_1_atnad >= 34'; var = 'ep15_1_atnad'
          parts = @(
            @{ at = 32; name = 'In the Rekenber building, past the guard (lhz_in01, 277, 234): the Chairman (270, 257)'; route = @('lhz_in01', 277, 234, 'Rekenber Guard') }
            @{ at = 33; name = 'Ian (272, 255) or Arquien (272, 251): Should the table be turned over?'; route = @('lhz_in01', 272, 255, 'Ian Atnad') }
            @{ at = 34; name = 'Chief Secretary Tatio (267, 257)'; route = @('lhz_in01', 267, 257, 'Chief Secretary') }
          )
          route = @('lhz_in01', 277, 234, 'Rekenber Guard')
          now = 'RO quest: go to the Rekenber building in Lighthalzen with the team and hear what the chairman wants from you.'
          hint = @(
            'The Rekenber building is in the north-west of Lighthalzen (door at 101, 248). The guard at lhz_in01, 277, 234 lets you through to the chairman''s room.'
            'RO pays 4,500,000 base and 3,000,000 job EXP at the end.'
          )
          spots = @(
            @{ map = 'lighthalzen'; x = 101; y = 248; name = 'Door of the Rekenber building'; ro = 31 }
            @{ map = 'lhz_in01'; x = 277; y = 234; name = 'Rekenber Guard'; ro = 31 }
            @{ map = 'lhz_in01'; x = 270; y = 257; name = 'Chairman Rekenber'; ro = 31 }
            @{ map = 'lhz_in01'; x = 272; y = 255; name = 'Ian Atnad'; ro = 32 }
            @{ map = 'lhz_in01'; x = 267; y = 257; name = 'Chief Secretary Tatio'; ro = 33 }
          )
          done = 'The chairman wanted the Memory Records kept quiet. Then his Chief Secretary showed who he is: Tatio, the last survivor of Verus, a machine made by Lasse Atnad, Ian''s great-grandfather, and the one who attacked Ian at the Juperos dig. The team keeps sole rights to the records, and the secret stays between them.' }
     ) }
)

# Passages the Chronicle opens: a Renewal NPC who lets a character through
# from step id 'from' on (the New World's own way in is quest-locked). Only
# built into a route that has that step.
# (Renewal's Allied Scout let Chronicle bearers into the New World until
# 2026-10-25; RO's own Cat Paw Agent quest is the way in now.)
$gates = @()

# Steps taken out of a route: a character still on one moves to step 'to'
# (its quest-window entry goes; RO's own quest picks up where it stands), and
# finished ones keep their quest-window entries (quest_db). Never reuse an id.
# (Renewal's own chapters and steps 901-935 went on 2026-10-28, with nobody
# on them: Renewal's Story is $episodes now.)
$retired = @()

return @{ chapters = $chapters; episodes = $episodes; final = $final; finalRe = $finalRe; soonRe = $soonRe; gates = $gates; retired = $retired }
