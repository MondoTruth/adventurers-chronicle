# Adventurer's Chronicle: RO quest guides.
# build.ps1 reads this next to story.ps1 and side.ps1. Edit here, then run build.ps1.
#
# A guide walks the player through one of Rune-Midgard's own quests on the
# road. The Chronicle adds nothing to it: no NPC, no quest-window entry, no id
# and no reward of its own. RO's quest is the record (its variables and quest
# log), its own NPCs give its rewards, and the Chronicle only stamps the
# Adventurer's Passport when it is done (CHRON_G_<key> = 1).
#
# key = a short name (a-z, 0-9, _), also the stamp's variable CHRON_G_<key>.
# Never rename a key: the stamps players have are stored under it.
# era = the only era whose route has the guide (none: both).
# hook = the id of the step in story.ps1 after which the guide opens; the
# Journal lists it under the chapter that follows.
# needs = a unique NPC name ("Name#id") that must exist on the server, for a
# quest another mod adds: without it the guide is left out.
# reward = what RO's own quest gives (checked in rathena-pin), for the Journal.
# A step is done when its cond (rAthena script) is true, and the conds of a
# guide must follow each other (a later one true means the earlier ones are).
# var = the RO variable the step's parts (at) and spots (ro) compare with.
# items are counted in the Journal, never taken. ASCII only.

$guides = @(
  # ---- The Schwarzwald ---------------------------------------------------------
  # rAthena quests_ein.txt, Factory Quest (EinFactory 1-16). Each one finished
  # adds 1 to $EinPolution; at 10 the Einbroch Smog Alert fills the town with
  # Toxic Fogs for 10 minutes (its Kafras and train staff hide meanwhile).
  @{ key = 'ein_factory'; era = 'renewal'; hook = 901; title = 'The Factory of Einbroch'; range = '90+'
     where = 'Einbroch'
     intro = 'Foreman Gustav: "The smoke over Einbroch gets worse every year. The factory there is short of hands, I hear: they would take anyone who can turn a valve. See it for yourself, it is a short train ride."'
     reward = 'about 29,000 base EXP.'
     steps = @(
       @{ title = 'Short of Hands'; cond = 'EinFactory >= 1'
          route = @('ein_in01', 67, 242, 'Zelmeto')
          now = 'RO quest: in the Einbroch factory, ask the overseer Zelmeto (ein_in01, 67, 242) about his work: choose You''re understaffed?, then I can help you.'
          hint = @(
            'From Einbech, the Train Station Staff (39, 215) takes you to Einbroch (200 zeny). The factory is indoors: the Route link draws the way in.'
            'If a smog alarm is on (Einbroch full of Toxic Fogs), Zelmeto sends you out: wait the 10 minutes it lasts.'
          )
          spots = @(@{ map = 'ein_in01'; x = 67; y = 242; name = 'Zelmeto' })
          done = 'Zelmeto took you on: the factory is so short of workers that the machines run unwatched.' }
       @{ title = 'The Rounds'; cond = 'EinFactory >= 12'; var = 'EinFactory'
          parts = @(
            @{ at = 2; name = 'Check the 2nd Control Panel (49, 232)' }
            @{ at = 3; name = 'Report to Zelmeto' }
            @{ at = 4; name = 'Check the 3rd Pressure Governor (108, 217)' }
            @{ at = 5; name = 'Report to Zelmeto' }
            @{ at = 6; name = 'Check the Main Control Panel (62, 258)' }
            @{ at = 7; name = 'Report to Zelmeto' }
            @{ at = 8; name = 'Check the Conveyor (46, 197)' }
            @{ at = 9; name = 'Report to Zelmeto' }
            @{ at = 10; name = 'Check the Pipe (100, 266)' }
            @{ at = 11; name = 'Report to Zelmeto' }
            @{ at = 12; name = 'Check the other Conveyor (95, 239)' }
          )
          route = @('ein_in01', 67, 242, 'Zelmeto')
          now = 'RO quest: make the rounds of the factory floor: click each machine Zelmeto names, then report back to him, six times in all.'
          hint = @('The Journal ticks each machine and marks the next one on your map while you are in the factory.')
          spots = @(
            @{ map = 'ein_in01'; x = 49; y = 232; name = '2nd Control Panel'; ro = 1 }
            @{ map = 'ein_in01'; x = 67; y = 242; name = 'Zelmeto'; ro = 2 }
            @{ map = 'ein_in01'; x = 108; y = 217; name = '3rd Pressure Governor'; ro = 3 }
            @{ map = 'ein_in01'; x = 67; y = 242; name = 'Zelmeto'; ro = 4 }
            @{ map = 'ein_in01'; x = 62; y = 258; name = 'Main Control Panel'; ro = 5 }
            @{ map = 'ein_in01'; x = 67; y = 242; name = 'Zelmeto'; ro = 6 }
            @{ map = 'ein_in01'; x = 46; y = 197; name = 'Conveyor'; ro = 7 }
            @{ map = 'ein_in01'; x = 67; y = 242; name = 'Zelmeto'; ro = 8 }
            @{ map = 'ein_in01'; x = 100; y = 266; name = 'Pipe'; ro = 9 }
            @{ map = 'ein_in01'; x = 67; y = 242; name = 'Zelmeto'; ro = 10 }
            @{ map = 'ein_in01'; x = 95; y = 239; name = 'Conveyor'; ro = 11 }
          )
          done = 'You checked every machine on the floor. Half of them were held together with rust and hope.' }
       @{ title = 'Liotzburg'; cond = 'EinFactory >= 14'; var = 'EinFactory'
          parts = @(
            @{ at = 13; name = 'Report to Zelmeto'; route = @('ein_in01', 67, 242, 'Zelmeto') }
            @{ at = 14; name = 'Talk to Liotzburg outside (einbroch 132, 84)'; route = @('einbroch', 132, 84, 'Liotzburg') }
          )
          route = @('ein_in01', 67, 242, 'Zelmeto')
          now = 'RO quest: report to Zelmeto once more, then find Liotzburg, who stands in the streets of Einbroch (132, 84).'
          spots = @(
            @{ map = 'ein_in01'; x = 67; y = 242; name = 'Zelmeto' }
            @{ map = 'einbroch'; x = 132; y = 84; name = 'Liotzburg' }
          )
          done = 'Liotzburg, out in the smoke of Einbroch, had his say about the factory, and Zelmeto needs parts.' }
       @{ title = 'Spare Parts'; cond = 'EinFactory >= 16'; var = 'EinFactory'
          items = @(@(7325, 'Flexible Tube', 20), @(7317, 'Rusty Screw', 10), @(7319, 'Used Iron Plate', 10))
          parts = @(
            @{ at = 15; name = 'Tell Zelmeto what Liotzburg said' }
            @{ at = 16; name = 'Bring him the parts (Give him materials.)' }
          )
          route = @('ein_in01', 67, 242, 'Zelmeto')
          now = 'RO quest: tell Zelmeto what Liotzburg said, then bring him 20 Flexible Tubes, 10 Rusty Screws and 10 Used Iron Plates: choose Give him materials.'
          hint = @(
            '20 Flexible Tubes: Metalings, about 1 in 5, on the fields around Einbroch (ein_fild06 to ein_fild09, Lv 81).'
            '10 Rusty Screws: Teddy Bears, about 1 in 5, on ein_fild03 (Lv 91) or in the second level of the Einbech mine.'
            '10 Used Iron Plates: Old Stoves, about 1 in 5, on the second level of the Einbech mine (ein_dun02, Lv 92).'
            'The odds are RO''s normal drop rates: your server''s drop rate setting makes them better.'
          )
          spots = @(@{ map = 'ein_in01'; x = 67; y = 242; name = 'Zelmeto' })
          done = 'The machines run again on your spare parts, and the factory sends a little less smoke over Einbroch, for now.' }
     ) }

  # rAthena quests_yuno.txt, Metto Quest (metto_q 1-9): talks only, Juno's
  # houses. Not for a Novice. One of the Wandering Bard's stories (Verus).
  @{ key = 'yuno_metto'; era = 'renewal'; hook = 26; title = 'The Scientist Who Trusts Fate'; range = '105+'
     where = 'Juno'
     intro = 'Sage Elisha: "Juno has its own troubles, I am afraid. A scholar named Wagan keeps asking travellers for help with a colleague, Metto, whose experiments frighten the whole district."'
     reward = '5 Blue Gemstones (10 Yellow Gemstones for a Sage).'
     steps = @(
       @{ title = 'Wagan''s Plan'; cond = 'metto_q >= 1'
          route = @('yuno_in01', 17, 30, 'Wagan')
          now = 'RO quest: talk to Wagan, indoors in Juno (yuno_in01, 17, 30): choose Leave it to me.'
          hint = @('Wagan does not trust a Novice with it: change jobs first.', 'Every Juno house in this quest is indoors: the Route links draw the way in.')
          spots = @(@{ map = 'yuno_in01'; x = 17; y = 30; name = 'Wagan' })
          done = 'Wagan wants Metto to give up his experiments, and has a plan: Metto believes in fate, so fate must seem to be against him.' }
       @{ title = 'Three Warnings'; cond = 'metto_q >= 8'; var = 'metto_q'
          parts = @(
            @{ at = 2; name = 'Hear Metto out (yuno_in03 26, 39)'; route = @('yuno_in03', 26, 39, 'Metto') }
            @{ at = 3; name = 'Stangckle (yuno_in01 17, 95): I''m here to stop your research.'; route = @('yuno_in01', 17, 95, 'Stangckle') }
            @{ at = 4; name = 'Back to Metto'; route = @('yuno_in03', 26, 39, 'Metto') }
            @{ at = 5; name = 'Kato (yuno_in01 19, 183): I want to stop you from making a mistake.'; route = @('yuno_in01', 19, 183, 'Kato') }
            @{ at = 6; name = 'Back to Metto'; route = @('yuno_in03', 26, 39, 'Metto') }
            @{ at = 7; name = 'CiCi (yuno_in03 178, 43): I want to warn you.'; route = @('yuno_in03', 178, 43, 'CiCi') }
            @{ at = 8; name = 'Back to Metto'; route = @('yuno_in03', 26, 39, 'Metto') }
          )
          route = @('yuno_in03', 26, 39, 'Metto')
          now = 'RO quest: go back and forth between Metto (yuno_in03, 26, 39) and the three scientists whose research is just like his, warning each of them.'
          hint = @('The other answer at each scientist only ends the talk: nothing is lost, ask again.')
          spots = @(
            @{ map = 'yuno_in03'; x = 26; y = 39; name = 'Metto' }
            @{ map = 'yuno_in01'; x = 17; y = 95; name = 'Stangckle' }
            @{ map = 'yuno_in01'; x = 19; y = 183; name = 'Kato' }
            @{ map = 'yuno_in03'; x = 178; y = 43; name = 'CiCi' }
          )
          done = 'One by one, Metto heard that three others had tried his experiment and failed. He began to believe it was fate.' }
       @{ title = 'Fate Decides'; cond = 'metto_q >= 9'
          route = @('yuno_in01', 17, 30, 'Wagan')
          now = 'RO quest: tell Wagan (yuno_in01, 17, 30) that Metto has given up.'
          hint = @('Keep a little room in your bag for the reward.')
          spots = @(@{ map = 'yuno_in01'; x = 17; y = 30; name = 'Wagan' })
          done = 'Metto gave up his experiments, convinced fate was against them, and the district breathes easier. Wandering bards love a story like that.' }
     ) }

  # ---- The New World (Episode 13) ---------------------------------------------
  # rAthena quests_13_2.txt, Otherworld language (ep13_2_rhea, 1-12, 100): needs
  # ep13_start = 100 (Agent Geck's passage, Chapter 8's first step) and the
  # Small Fairy and the Tree Giant met (quests 2158, 2159; Lv 70+, quests_13_1.txt).
  @{ key = 'ep13_language'; era = 'renewal'; hook = 906; title = 'The Otherworld Language'; range = '70+'
     where = 'the Allied camp'
     intro = 'Captain Varrick: "Nobody here understands a word the Laphine or the Sapha say. Our mechanic swears he can build a device that translates them. Help him, and you will be the first human who can talk to this world."'
     reward = 'the Ring of the Ancient Wise King, the translator: wear it to understand the Laphine and the Sapha (and 200,000 base EXP).'
     steps = @(
       @{ title = 'A Translating Device'; cond = 'ep13_2_rhea >= 2'; var = 'ep13_2_rhea'
          route = @('mid_camp', 197, 237, 'Schwarzwald Mechanic')
          parts = @(
            @{ at = 1; name = 'Hear out the Schwarzwald Mechanic (mid_camp 197, 237)'; route = @('mid_camp', 197, 237, 'Schwarzwald Mechanic') }
            @{ at = 2; name = 'Meet the Arunafeltz Linguist (mid_campin 168, 82)'; route = @('mid_campin', 168, 82, 'Arunafeltz Linguist') }
          )
          now = 'RO quest: talk to the Schwarzwald Mechanic in the Allied camp (197, 237), who dreams of a translating device, then to the Arunafeltz Linguist inside the camp building (168, 82).'
          hint = @(
            'The Mechanic only talks to those who came through the rift the RO way: Agent Geck''s passage counts.'
            'The Linguist asks your name and what you were doing: any answer will do.'
          )
          spots = @(
            @{ map = 'mid_camp'; x = 197; y = 237; name = 'Schwarzwald Mechanic' }
            @{ map = 'mid_campin'; x = 168; y = 82; name = 'Arunafeltz Linguist' }
          )
          done = 'The Mechanic wants to build a translator, and the Linguist, nicknamed Mr. Dictionary, is the one who must teach it the words.' }
       @{ title = 'Voices in the Wild'; cond = 'ep13_2_rhea >= 3'; var = 'ep13_2_rhea'
          route = @('mid_camp', 207, 234, 'Teleport Cat')
          now = 'RO quest: find the Small Fairy near Splendide (spl_fild02, 34, 223) and the Tree Giant in Manuk''s fields (man_fild03, 236, 105), listen to them, and repeat their words to the Linguist (mid_campin, 168, 82).'
          hint = @(
            'Both only speak to Lv 70 or higher. The Teleport Cat in the camp (207, 234) goes to Near Splendide (spl_fild02), where the fairy is close to where you land. For the giant, walk out of the camp''s east side onto man_fild01 and take its south exit (103, 55) to man_fild03.'
            'The Linguist then asks you to type what you heard, line by line. The fairy said: RLGHLRXLA TKANTLFDMS, then WJACK TNAHRDNJSDMFH, then WLSGHKWND !!'
            'The giant said: TJDTMFJDNS CJFDI, then TKADLFDMF QKATOS, then EKDTLSDML DLFMADMS..'
            'A wrong line is not held against you: the quest moves on either way.'
            'Extra, for EXP: tell the Camp Guard Captain (mid_camp, 212, 237) about each of them (90,000 base EXP each).'
          )
          spots = @(
            @{ map = 'spl_fild02'; x = 34; y = 223; name = 'Small Fairy' }
            @{ map = 'man_fild03'; x = 236; y = 105; name = 'Tree Giant' }
            @{ map = 'mid_camp'; x = 212; y = 237; name = 'Camp Guard Captain (EXP for the report)' }
            @{ map = 'mid_campin'; x = 168; y = 82; name = 'Arunafeltz Linguist' }
          )
          done = 'You met a fairy and a giant half made of wood, and repeated their strange words to the Linguist, who wrote down every one.' }
       @{ title = 'Mr. Dictionary'; cond = 'ep13_2_rhea >= 5'; var = 'ep13_2_rhea'
          route = @('mid_campin', 168, 82, 'Arunafeltz Linguist')
          parts = @(
            @{ at = 4; name = 'Talk to the Linguist once more'; route = @('mid_campin', 168, 82, 'Arunafeltz Linguist') }
            @{ at = 5; name = 'Ask the Rune-Midgarts Magician (mid_camp 147, 256)'; route = @('mid_camp', 147, 256, 'Rune-Midgarts Magician') }
          )
          now = 'RO quest: talk to the Linguist again (any answers), then to the Rune-Midgarts Magician in the camp (147, 256): choose Uh, Mr. Dictionary sent...'
          spots = @(
            @{ map = 'mid_campin'; x = 168; y = 82; name = 'Arunafeltz Linguist' }
            @{ map = 'mid_camp'; x = 147; y = 256; name = 'Rune-Midgarts Magician' }
          )
          done = 'The Magician can store the words in a gem, but he needs gems from this world to do it.' }
       @{ title = 'Two Half-buried Gems'; cond = 'ep13_2_rhea >= 6'; var = 'ep13_2_rhea'
          items = @(@(7575, 'Red Jewel', 1), @(7576, 'Blue Jewel', 1))
          route = @('mid_camp', 147, 256, 'Rune-Midgarts Magician')
          now = 'RO quest: dig out the Red Jewel near Splendide (spl_fild02, 27, 218) and the Blue Jewel in Manuk''s fields (man_fild03, 227, 109), then bring both to the Magician (147, 256).'
          hint = @(
            'Click the Half-buried Gem and choose Dig out the Gem. It works 1 time in 4. Otherwise 10 Thief Bugs jump out and the gem hides until they are all dead (or for 5 minutes): kill them and try again.'
            'The red one is right next to the Small Fairy, the blue one next to the Tree Giant.'
          )
          spots = @(
            @{ map = 'spl_fild02'; x = 27; y = 218; name = 'Half-buried Gem (red)' }
            @{ map = 'man_fild03'; x = 227; y = 109; name = 'Half-buried Gem (blue)' }
            @{ map = 'mid_camp'; x = 147; y = 256; name = 'Rune-Midgarts Magician' }
          )
          done = 'You dug a red and a blue gem out of the earth of this world, and the Magician took them to hold the words.' }
       @{ title = 'Back and Forth'; cond = 'ep13_2_rhea >= 9'; var = 'ep13_2_rhea'
          parts = @(
            @{ at = 7; name = 'The Linguist (mid_campin 168, 82)'; route = @('mid_campin', 168, 82, 'Arunafeltz Linguist') }
            @{ at = 8; name = 'The Mechanic (mid_camp 197, 237)'; route = @('mid_camp', 197, 237, 'Schwarzwald Mechanic') }
            @{ at = 9; name = 'The Magician (mid_camp 147, 256)'; route = @('mid_camp', 147, 256, 'Rune-Midgarts Magician') }
          )
          route = @('mid_campin', 168, 82, 'Arunafeltz Linguist')
          now = 'RO quest: carry the news between the three of them: the Linguist, then the Mechanic, then the Magician.'
          spots = @(
            @{ map = 'mid_campin'; x = 168; y = 82; name = 'Arunafeltz Linguist' }
            @{ map = 'mid_camp'; x = 197; y = 237; name = 'Schwarzwald Mechanic' }
            @{ map = 'mid_camp'; x = 147; y = 256; name = 'Rune-Midgarts Magician' }
          )
          done = 'The words are in the gems. The Magician only needs a mineral of this world to bind them.' }
       @{ title = 'An Unknown Mineral'; cond = 'ep13_2_rhea >= 11'; var = 'ep13_2_rhea'
          items = @(, @(6048, 'Unidentified Mineral', 1))
          parts = @(
            @{ at = 10; name = 'Bring the Magician 1 Unidentified Mineral' }
            @{ at = 11; name = 'Keep asking him until the gem is cut (1 in 5)' }
          )
          route = @('mid_camp', 207, 234, 'Teleport Cat')
          now = 'RO quest: mine 1 Unidentified Mineral from a Mysterious Rock in Manuk''s fields and bring it to the Magician (147, 256). Then keep talking to him until the gem is ready.'
          hint = @(
            'Mysterious Rocks stand on man_fild01 and man_fild03 (for example man_fild01 180, 170 or man_fild03 82, 134). Click one: 10 seconds of digging, and about 1 time in 5 it gives an Unidentified Mineral. A rock you used rests for 2 minutes.'
            'The rocks do not work for a few hours after you deliver minerals to the Cat Paw Mining Agent: do this first.'
            'Then talk to the Magician again and again: about 1 time in 5 he finishes the gem.'
          )
          spots = @(
            @{ map = 'man_fild01'; x = 180; y = 170; name = 'Mysterious Rock' }
            @{ map = 'man_fild01'; x = 147; y = 157; name = 'Mysterious Rock' }
            @{ map = 'man_fild01'; x = 114; y = 174; name = 'Mysterious Rock' }
            @{ map = 'man_fild03'; x = 82; y = 134; name = 'Mysterious Rock' }
            @{ map = 'man_fild03'; x = 67; y = 160; name = 'Mysterious Rock' }
            @{ map = 'mid_camp'; x = 147; y = 256; name = 'Rune-Midgarts Magician' }
          )
          done = 'The Magician bound the words into a gem with the mineral, and sent it to the Mechanic.' }
       @{ title = 'The Wise King''s Ring'; cond = 'ep13_2_rhea >= 100'; var = 'ep13_2_rhea'
          parts = @(
            @{ at = 12; name = 'Give the gem to the Mechanic' }
            @{ at = 100; name = 'Come back after an hour for the ring' }
          )
          route = @('mid_camp', 197, 237, 'Schwarzwald Mechanic')
          now = 'RO quest: give the gem to the Schwarzwald Mechanic (197, 237): choose Give him the Gem. He needs an hour of your play time to build the device; then talk to him again.'
          spots = @(@{ map = 'mid_camp'; x = 197; y = 237; name = 'Schwarzwald Mechanic' })
          done = 'The Mechanic set the gem in an old ring: the Ring of the Ancient Wise King. Wearing it, you understand the Laphine and the Sapha.' }
     ) }

  # rAthena quests_13_1.txt, Cat Paw Agent (ep13_yong1 1-10): the Cat Paw
  # Merchants' credit, up to its first points. More points (10 Pieces of Fish
  # a day, quest 12060 is the 4-hour wait) open storage at 20 and the Cat Warp
  # to Midgard at 40: dailies, not guided.
  @{ key = 'ep13_catpaw'; era = 'renewal'; hook = 906; title = 'Cat Trading'; range = '118+'
     where = 'the Allied camp'
     intro = 'Captain Varrick: "Those cats who sent you through the rift keep a trading post at the west end of our camp. They do favours for those with credit. Earn some, it is worth it out here."'
     reward = 'Cat Paw credit: a save point at the camp now, and with more credit later their storage and their Cat Warp to Midgard (and 20,000 base EXP).'
     steps = @(
       @{ title = 'Cat Paw Services'; cond = 'ep13_yong1 >= 2'; var = 'ep13_yong1'
          parts = @(
            @{ at = 1; name = 'Ask the Cat Paw Agent about his services (mid_camp 62, 125)'; route = @('mid_camp', 62, 125, 'Cat Paw Agent') }
            @{ at = 2; name = 'Talk to Fluffy Gyaruk (72, 94)'; route = @('mid_camp', 72, 94, 'Fluffy Gyaruk') }
          )
          route = @('mid_camp', 62, 125, 'Cat Paw Agent')
          now = 'RO quest: ask the Cat Paw Agent at the west end of the camp (62, 125) about his services, then talk to Fluffy Gyaruk (72, 94).'
          hint = @(
            'Agent: choose Tell me more about your services.'
            'Gyaruk: choose Yes., What do you guys do?, Yes., What services do you offer?, Credit?, then Sure. (I need to think it over. only ends the talk.)'
          )
          spots = @(
            @{ map = 'mid_camp'; x = 62; y = 125; name = 'Cat Paw Agent' }
            @{ map = 'mid_camp'; x = 72; y = 94; name = 'Fluffy Gyaruk' }
          )
          done = 'The Cat Paw Merchants work on credit: help them, and their services open to you one by one.' }
       @{ title = 'The First Errand'; cond = 'ep13_yong1 >= 5'; var = 'ep13_yong1'
          parts = @(
            @{ at = 3; name = 'Back to the Cat Paw Agent (save point)'; route = @('mid_camp', 62, 125, 'Cat Paw Agent') }
            @{ at = 4; name = 'Fluffy Gyaruk: What kind of things?, then Sure.'; route = @('mid_camp', 72, 94, 'Fluffy Gyaruk') }
            @{ at = 5; name = 'Ferocious Gorurug (69, 144): Gyaruk has sent me.'; route = @('mid_camp', 69, 144, 'Ferocious Gorurug') }
          )
          route = @('mid_camp', 62, 125, 'Cat Paw Agent')
          now = 'RO quest: go back to the Cat Paw Agent (he can now save your location in the camp), then to Gyaruk for an errand, and to Ferocious Gorurug (69, 144), who gives it.'
          hint = @('Gorurug: choose Gyaruk has sent me., then What should I do?')
          spots = @(
            @{ map = 'mid_camp'; x = 62; y = 125; name = 'Cat Paw Agent' }
            @{ map = 'mid_camp'; x = 72; y = 94; name = 'Fluffy Gyaruk' }
            @{ map = 'mid_camp'; x = 69; y = 144; name = 'Ferocious Gorurug' }
          )
          done = 'Gorurug feeds the post''s cats, and the cats are hungry. Your first errand: fish.' }
       @{ title = 'Ten Pieces of Fish'; cond = 'ep13_yong1 >= 10'
          items = @(, @(6039, 'Piece of Fish', 10))
          route = @('mid_camp', 69, 134, 'By the School of Fish')
          now = 'RO quest: catch 10 Pieces of Fish at a School of Fish and bring them to Ferocious Gorurug (69, 144).'
          hint = @(
            'A School of Fish ripples in the camp''s own pond (mid_camp, 75, 135), right by Gorurug; more lie near Splendide (spl_fild02, 314, 165). Click it: 15 seconds of fishing (less with a fishing rod), and about 1 cast in 4 brings a Piece of Fish.'
            'Fishing works only while you carry fewer than 20 Pieces of Fish, and not during the 4 hours after you hand fish to Gorurug.'
          )
          spots = @(
            @{ map = 'mid_camp'; x = 75; y = 135; name = 'School of Fish' }
            @{ map = 'mid_camp'; x = 69; y = 144; name = 'Ferocious Gorurug' }
          )
          done = 'Gorurug''s cats ate well, and the Cat Paw Merchants wrote your name in their credit book.' }
     ) }

  # rAthena quests_dicastes.txt, Sapha's Visit (ep13_3_invite 1-6): the way
  # into El Dicastes. Every Sapha wants the Wise King's ring worn.
  @{ key = 'ep13_sapha'; era = 'renewal'; hook = 910; title = 'Sapha''s Visit'; range = '118+'
     where = 'the Allied camp and Manuk'
     intro = 'Warden Kahlis: "The law keeps the gate shut to humans. But the law also says a guest invited by the Sapha may enter. A Sapha is waiting in your camp, they tell me. Go and see what he wants, and wear something that lets you understand him."'
     reward = 'entry to El Dicastes, the Sapha capital, and the Light of El Dicastes.'
     steps = @(
       @{ title = 'A Sapha in the Camp'; cond = 'ep13_3_invite >= 1'
          route = @('mid_campin', 93, 114, 'Guard Aello')
          now = 'RO quest: talk to Guard Aello inside the camp building (mid_campin, 93, 114). A Sapha from Manuk is asking for you.'
          hint = @('First finish The Otherworld Language: every Sapha on this road wants the Ring of the Ancient Wise King worn (equipped), or you understand nothing.')
          spots = @(@{ map = 'mid_campin'; x = 93; y = 114; name = 'Guard Aello' })
          done = 'Guard Aello told you a Sapha from Manuk had come to the camp and asked for you by name.' }
       @{ title = 'Vyhannus''s Invitation'; cond = 'ep13_3_invite >= 4'; var = 'ep13_3_invite'
          parts = @(
            @{ at = 2; name = 'Hear the Sapha and his hound out' }
            @{ at = 3; name = 'Talk to them again' }
            @{ at = 4; name = 'And once more, for the invitation' }
          )
          route = @('mid_campin', 111, 120, 'Soldier')
          now = 'RO quest: wearing the ring, pass the Soldier in the camp building (111, 120: choose I have authorization.) and talk to the Sapha from Manuk (168, 128) or his Hound (168, 125) three times.'
          hint = @('Every answer they offer is fine. On the third talk the Sapha gives you Vyhannus''s invitation to El Dicastes.')
          spots = @(
            @{ map = 'mid_campin'; x = 111; y = 120; name = 'Soldier: the way to the Sapha' }
            @{ map = 'mid_campin'; x = 168; y = 128; name = 'Sapha from Manuk' }
          )
          done = 'The Sapha, an envoy of Vyhannus, invited you to visit El Dicastes. Hibba Agip will want to hear about that.' }
       @{ title = 'The Guard Captain of Manuk'; cond = 'ep13_3_invite >= 5'
          route = @('man_in01', 315, 52, 'Guard Captain Avalanche')
          now = 'RO quest: show the invitation to Guard Captain Avalanche in Manuk (man_in01, 315, 52): choose I''ve come with Vyhannus''s invitation.'
          hint = @(
            'The Teleport Cat in the camp (207, 234) goes to Manuk Field (man_fild02); the way into Manuk is just south of where you land (139, 41). Wear the ring.'
            'Avalanche is indoors: the Route link draws the way in.'
          )
          spots = @(@{ map = 'man_in01'; x = 315; y = 52; name = 'Guard Captain Avalanche' })
          done = 'Captain Avalanche read the invitation and sent word to the capital: the guards will let you in.' }
       @{ title = 'Into El Dicastes'; cond = 'ep13_3_invite >= 6'
          route = @('dic_fild01', 147, 280, 'Capital City Guards')
          now = 'RO quest: wearing the ring, talk to a Capital City Guard at the gate of El Dicastes (dic_fild01, 146, 281 or 153, 281), choose Yes., and register at the Adventurer Clerk inside the city (dic_in01, 42, 264): choose Register as an adventurer.'
          hint = @(
            'The gate is right by Warden Kahlis (156, 270). The guards take you into the city (dicastes01).'
            'From Manuk, the Entrance Manager (manuk, 321, 182) also lets you into the tunnel under Kamidal Mountain (dic_dun01); a Curious Sapha inside (266, 113) takes you up to the city.'
          )
          spots = @(
            @{ map = 'dic_fild01'; x = 146; y = 281; name = 'Capital City Guard' }
            @{ map = 'dic_in01'; x = 42; y = 264; name = 'Adventurer Clerk' }
          )
          done = 'You are the first human registered in El Dicastes, with the Light of El Dicastes as your pass.' }
     ) }

  # ---- Arunafeltz and Hugel ----------------------------------------------------
  # rAthena quests_rachel.txt, Lost Child (lost_boy 1-13, Lv 60+). The inner
  # temple is open: the Temple Entrance only locks once the server's 10,000
  # donations of the Sanctuary Quest are in.
  @{ key = 'ra_lostchild'; era = 'renewal'; hook = 31; title = 'The Stolen Gem'; range = '60+'
     where = 'Rachel'
     intro = 'Sister Ilyana: "Something is wrong in the house of High Priest Zhed. His steward, Vincent, has been asking every traveller for help, and begging them to keep quiet about it."'
     reward = 'an Old Violet Box from Vincent and 90,000 base EXP from High Priest Zhed.'
     steps = @(
       @{ title = 'The Steward''s Secret'; cond = 'lost_boy >= 1'
          route = @('ra_in01', 384, 246, 'Vincent')
          now = 'RO quest: talk to Vincent, steward of High Priest Zhed''s mansion in Rachel (ra_in01, 384, 246): choose Sure, why not?'
          hint = @('He only asks those of Lv 60 or more. The mansion is indoors: the Route link draws the way in.')
          spots = @(@{ map = 'ra_in01'; x = 384; y = 246; name = 'Vincent' })
          done = 'A gem the Pope gave High Priest Zhed has been stolen, and the servant Phobe ran off the same night. Vincent wants both found before his master returns.' }
       @{ title = 'Asking the Servants'; cond = 'lost_boy >= 6'; var = 'lost_boy'
          parts = @(
            @{ at = 2; name = 'Logan, in the streets (rachel 114, 232)'; route = @('rachel', 114, 232, 'Logan') }
            @{ at = 3; name = 'Manson, in the mansion (ra_in01 372, 200)'; route = @('ra_in01', 372, 200, 'Manson') }
            @{ at = 4; name = 'Jenny (rachel 48, 237)'; route = @('rachel', 48, 237, 'Jenny') }
            @{ at = 5; name = 'An idle merchant (rachel 138, 73)'; route = @('rachel', 138, 73, 'Idle Merchant') }
            @{ at = 6; name = 'Another idle merchant (rachel 120, 47)'; route = @('rachel', 120, 47, 'Idle Merchant') }
          )
          route = @('rachel', 114, 232, 'Logan')
          now = 'RO quest: follow Phobe''s trail through Rachel: the servants Logan and Manson, then Jenny, then two idle merchants in the south of the city. Each points you to the next.'
          spots = @(
            @{ map = 'rachel'; x = 114; y = 232; name = 'Logan'; ro = 1 }
            @{ map = 'ra_in01'; x = 372; y = 200; name = 'Manson'; ro = 2 }
            @{ map = 'rachel'; x = 48; y = 237; name = 'Jenny'; ro = 3 }
            @{ map = 'rachel'; x = 138; y = 73; name = 'Idle Merchant'; ro = 4 }
            @{ map = 'rachel'; x = 120; y = 47; name = 'Idle Merchant'; ro = 5 }
          )
          done = 'The trail of Phobe led from servant to servant, and out of the city to the south.' }
       @{ title = 'The Suspicious Man'; cond = 'lost_boy >= 7'
          route = @('ra_fild01', 245, 325, 'Suspicious Man')
          now = 'RO quest: find the Suspicious Man in the field south of Rachel (ra_fild01, 245, 325).'
          hint = @('Careful: he strikes you for half your HP before he talks. Come with your HP full.')
          spots = @(@{ map = 'ra_fild01'; x = 245; y = 325; name = 'Suspicious Man' })
          done = 'The Suspicious Man in the field had his own story to tell, and it sent you back to Vincent.' }
       @{ title = 'The Truth in the Mansion'; cond = 'lost_boy >= 12'; var = 'lost_boy'
          parts = @(
            @{ at = 8; name = 'Back to Vincent (ra_in01 384, 246)'; route = @('ra_in01', 384, 246, 'Vincent') }
            @{ at = 9; name = 'A kid in the south-east of Rachel (rachel 263, 32)'; route = @('rachel', 263, 32, 'Kid') }
            @{ at = 10; name = 'Back to Vincent'; route = @('ra_in01', 384, 246, 'Vincent') }
            @{ at = 11; name = 'Jenny again (rachel 48, 237)'; route = @('rachel', 48, 237, 'Jenny') }
            @{ at = 12; name = 'Vincent, one last time'; route = @('ra_in01', 384, 246, 'Vincent') }
          )
          route = @('ra_in01', 384, 246, 'Vincent')
          now = 'RO quest: back and forth between Vincent, a kid in the south-east of Rachel and Jenny, until the steward tells you the whole story.'
          spots = @(
            @{ map = 'ra_in01'; x = 384; y = 246; name = 'Vincent' }
            @{ map = 'rachel'; x = 263; y = 32; name = 'Kid'; ro = 8 }
            @{ map = 'rachel'; x = 48; y = 237; name = 'Jenny'; ro = 10 }
          )
          done = 'You followed the trail to its end, and Vincent sent you to his master with the news.' }
       @{ title = 'The High Priest'; cond = 'lost_boy >= 13'
          route = @('ra_temin', 277, 159, 'High Priest Zhed')
          now = 'RO quest: tell High Priest Zhed in the inner temple (ra_temin, 277, 159) what happened: choose I''m here on Vincent''s behalf, then Actually... I was just curious., then Tell him your name.'
          hint = @('The temple is the great building in the north of Rachel; its entrance lets you into the inner halls. The Route link draws the way.')
          spots = @(@{ map = 'ra_temin'; x = 277; y = 159; name = 'High Priest Zhed' })
          done = 'High Priest Zhed heard the whole story and thanked you for keeping his house''s secret.' }
     ) }

  # rAthena quests_hugel.txt, Odin Temple Excavation (hg_odin 1-60, Lv 60+):
  # two ways to join the dig, Alex's team (2-6) or Laura's (12-16), then one
  # road on (17-60). One of the Wandering Bard's stories (Verus).
  @{ key = 'hg_odin'; era = 'renewal'; hook = 36; title = 'The Odin Temple Excavation'; range = '60+'
     where = 'Hugel'
     intro = 'Brynjar the Herald: "Two teams of excavators are digging in Odin''s Temple, and they post notices for hired hands. Join one. What they dig up there is the gods'' business, and so, I think, is yours."'
     reward = 'an Old Blue Box for the runes, and 100,000 base EXP at the end.'
     steps = @(
       @{ title = 'The Recruitment Notice'; cond = 'hg_odin >= 1'
          route = @('hugel', 91, 152, 'Sign')
          now = 'RO quest: read the recruitment notice on the sign in Hugel (91, 152).'
          spots = @(@{ map = 'hugel'; x = 91; y = 152; name = 'Sign' })
          done = 'Two teams of the Odin Temple excavation are hiring: Alex''s and Laura''s.' }
       @{ title = 'Joining a Team'; cond = 'hg_odin >= 2'
          route = @('hu_in01', 19, 161, 'Alex')
          now = 'RO quest: join one of the two excavation teams, indoors in Hugel: Alex (hu_in01, 19, 161) or Laura (hu_in01, 14, 11).'
          hint = @(
            'Alex: choose I saw the recruitment notice and... (Excuse me... only ends the talk).'
            'Laura: choose Yes, I''ll do it! (or Nah, forget it., then Alright, I''ll do it.).'
            'Both need Lv 60. Pick either: the two roads meet again later.'
          )
          spots = @(
            @{ map = 'hu_in01'; x = 19; y = 161; name = 'Alex' }
            @{ map = 'hu_in01'; x = 14; y = 11; name = 'Laura' }
          )
          done = 'You signed on with the excavation.' }
       @{ title = 'Runes from the Temple'; cond = 'hg_odin >= 17'; var = 'hg_odin'
          items = @(, @(7511, 'Rune of Darkness', 5))
          route = @('hugel', 209, 109, 'Boatman to Odin''s Temple')
          now = 'RO quest: sail to Odin''s Temple and back with the Boatman, take your team leader''s order, and bring 5 Runes of Darkness. Then talk to Laura.'
          hint = @(
            'Each trip counts: the Boatman (hugel, 209, 109, choose Sure!) moves the dig on when he sails you out. Sail out, come back (the Boatman on odin_tem01, 93, 146) and talk to your leader, twice.'
            'Alex''s team: after the first trip choose Yes, I do., after the second There you go! with the runes. Laura''s team: after the first trip any answers, then Yes!, after the second Right here! with the runes.'
            'Runes of Darkness drop from the Skogul and Frus in Odin''s Temple. Chapter 11 asks Brynjar for 5 of them too: bring 10 if you want both.'
            'Then talk to Laura (hu_in01, 14, 11): any answer.'
          )
          spots = @(
            @{ map = 'hugel'; x = 209; y = 109; name = 'Boatman to Odin''s Temple' }
            @{ map = 'odin_tem01'; x = 93; y = 146; name = 'Boatman back to Hugel' }
            @{ map = 'hu_in01'; x = 19; y = 161; name = 'Alex' }
            @{ map = 'hu_in01'; x = 14; y = 11; name = 'Laura' }
          )
          done = 'Your team took the runes, and Laura took you into her confidence: the dig is after something called Ymir''s Heart.' }
       @{ title = 'Ymir''s Heart'; cond = 'hg_odin >= 20'
          route = @('hu_in01', 15, 108, 'Door to Alex''s room')
          now = 'RO quest: walk through the door to Alex''s room (hu_in01, 15, 108), then talk to Laura (14, 11): choose Ymir''s Heart, and any answer after.'
          spots = @(
            @{ map = 'hu_in01'; x = 15; y = 108; name = 'Door to Alex''s room' }
            @{ map = 'hu_in01'; x = 14; y = 11; name = 'Laura' }
          )
          done = 'Laura told you what the dig is really after: Ymir''s Heart.' }
       @{ title = 'The Hidden Way'; cond = 'hg_odin >= 23'; var = 'hg_odin'
          parts = @(
            @{ at = 21; name = 'Find the hidden way on the top floor of Odin''s Temple' }
            @{ at = 22; name = 'Explore the strange object (que_hugel 35, 29)' }
            @{ at = 23; name = 'Walk onto the way back (que_hugel 163, 178)' }
          )
          route = @('hugel', 209, 109, 'Boatman to Odin''s Temple')
          now = 'RO quest: on the top floor of Odin''s Temple (odin_tem03) find the hidden way into the sealed hall, search it, and come back out.'
          hint = @(
            'The way is invisible: one of five spots on odin_tem03 pulls you in, and it moves to another after use. Walk over them in turn: (266, 302), (288, 271), (283, 241), (179, 275), (320, 264).'
            'Inside (que_hugel), click the object at (35, 29) and choose Explore. About 1 time in 3 you find something: choose Pick it up. Then walk onto the spot at (163, 178) to go back.'
            'The way up: Hugel''s Boatman, then odin_tem01''s east end to odin_tem02, and odin_tem02''s north to odin_tem03 (Chapter 11 walked it).'
          )
          spots = @(
            @{ map = 'odin_tem03'; x = 266; y = 302; name = 'Hidden way (maybe)'; ro = 20 }
            @{ map = 'odin_tem03'; x = 288; y = 271; name = 'Hidden way (maybe)'; ro = 20 }
            @{ map = 'odin_tem03'; x = 283; y = 241; name = 'Hidden way (maybe)'; ro = 20 }
            @{ map = 'odin_tem03'; x = 179; y = 275; name = 'Hidden way (maybe)'; ro = 20 }
            @{ map = 'odin_tem03'; x = 320; y = 264; name = 'Hidden way (maybe)'; ro = 20 }
            @{ map = 'que_hugel'; x = 35; y = 29; name = 'Strange object'; ro = 21 }
            @{ map = 'que_hugel'; x = 163; y = 178; name = 'The way back'; ro = 22 }
          )
          done = 'You found the hidden hall on the top floor of the temple, searched it, and came back out.' }
       @{ title = 'Back at the Dig House'; cond = 'hg_odin >= 59'; var = 'hg_odin'
          parts = @(
            @{ at = 25; name = 'Laura (hu_in01 159, 84)' }
            @{ at = 59; name = 'Ashe (hu_in01 162, 85)' }
          )
          route = @('hugel', 52, 91, 'Door of the dig house')
          now = 'RO quest: back in Hugel, walk into the dig house (hugel, 52, 90): it takes you to the team''s new room. Talk to Laura (hu_in01, 159, 84), then to Ashe (162, 85).'
          hint = @('The way home from the temple: down to odin_tem01 and its Boatman (93, 146).')
          spots = @(
            @{ map = 'hugel'; x = 52; y = 90; name = 'Door of the dig house' }
            @{ map = 'hu_in01'; x = 159; y = 84; name = 'Laura' }
            @{ map = 'hu_in01'; x = 162; y = 85; name = 'Ashe' }
          )
          done = 'Back at the dig house, Ashe asked you to meet far to the south, in the Sograt Desert.' }
       @{ title = 'Ashe in the Desert'; cond = 'hg_odin >= 60'
          route = @('moc_fild12', 160, 365, 'Ashe')
          now = 'RO quest: meet Ashe in the Sograt Desert (moc_fild12, 160, 365): walk to the spot and choose either question.'
          spots = @(@{ map = 'moc_fild12'; x = 160; y = 365; name = 'Ashe' })
          done = 'Ashe told you how the excavation ended. Wandering bards would pay to hear a story like this one.' }
     ) }

  # ---- Eclage (Episode 14.2) ---------------------------------------------------
  # rAthena quests_eclage.txt, Eclage's Entrance (ep14_2_oliver 1-3).
  @{ key = 'ep14_eclage'; era = 'renewal'; hook = 920; title = 'Eclage''s Entrance'; range = '151+'
     where = 'the gate of Eclage'
     intro = 'Captain Sylwen: "The council lets no stranger in. Unless, of course, the stranger fills in the forms. Every form. In order."'
     reward = 'entry to Eclage, the Laphine city on the World Tree.'
     steps = @(
       @{ title = 'The Forms'; cond = 'ep14_2_oliver >= 1'
          route = @('ecl_fild01', 94, 322, 'Security Guard')
          now = 'RO quest: ask a Security Guard at the gate of Eclage (ecl_fild01, 94, 322 or 100, 323) to let you in: choose Fill out the forms. and type anything in each of the three boxes.'
          spots = @(@{ map = 'ecl_fild01'; x = 94; y = 322; name = 'Security Guard' })
          done = 'You filled out the immigration forms, three of them.' }
       @{ title = 'Immigration'; cond = 'ep14_2_oliver >= 2'
          route = @('ecl_fild01', 111, 320, 'Immigration Officer')
          now = 'RO quest: wait half a minute while your forms are read, then talk to the Immigration Officer (ecl_fild01, 111, 320).'
          hint = @('Talked too soon? He only cries. Wait a little and talk again.')
          spots = @(@{ map = 'ecl_fild01'; x = 111; y = 320; name = 'Immigration Officer' })
          done = 'The Immigration Officer stamped your documents, after a long speech about the stamp.' }
       @{ title = 'Through the Gate'; cond = 'ep14_2_oliver >= 3'
          route = @('ecl_fild01', 94, 322, 'Security Guard')
          now = 'RO quest: show your stamped documents to the Security Guard (ecl_fild01, 94, 322). He lets you into Eclage.'
          spots = @(@{ map = 'ecl_fild01'; x = 94; y = 322; name = 'Security Guard' })
          done = 'The Security Guard waved you through: you may walk the streets of Eclage now.' }
     ) }

  # rAthena quests_eclage.txt, Laphines That Love the Land and Lost Adventurers
  # (ep14_2_nines 1-3, Lv 100+): all outside the city gate, and in the
  # keepers' tower of Chapter 13. New Oz's own errands go on after (4 and up).
  @{ key = 'ep14_nines'; era = 'renewal'; hook = 921; title = 'Fili and the Lost Adventurers'; range = '100+'
     where = 'the fields of Eclage'
     intro = 'Captain Sylwen: "Fili, by the keepers'' tower, worries about everyone: the gardeners in the fields, and the humans who went into the tower and never came out. Help him, if you have the time."'
     reward = '600,000 base and 600,000 job EXP in all, 2 Splendide Coins and 10 Meat.'
     steps = @(
       @{ title = 'Fili'; cond = 'ep14_2_nines >= 1'
          route = @('ecl_fild01', 190, 93, 'Fili')
          now = 'RO quest: talk to Fili, the Laphine by the keepers'' tower (ecl_fild01, 190, 93): choose See what kind of work it is.'
          spots = @(@{ map = 'ecl_fild01'; x = 190; y = 93; name = 'Fili' })
          done = 'Fili asked you to look in on four Laphines who tend the fields around the tower.' }
       @{ title = 'Laphines That Love the Land'; cond = 'ep14_2_nines >= 2'
          route = @('ecl_fild01', 222, 290, 'Singing Laphine')
          now = 'RO quest: visit the four Laphines in the fields of Eclage, the singing, the watering, the dancing and the cute one, then tell Fili.'
          hint = @(
            'Singing Laphine (222, 290), Watering Laphine (83, 263), Dancing Laphine (163, 196), Cute Laphine (237, 181). Their answers each have one choice: just pick it.'
            'The quest window (Alt+U) crosses off each one you have visited.'
          )
          spots = @(
            @{ map = 'ecl_fild01'; x = 222; y = 290; name = 'Singing Laphine' }
            @{ map = 'ecl_fild01'; x = 83; y = 263; name = 'Watering Laphine' }
            @{ map = 'ecl_fild01'; x = 163; y = 196; name = 'Dancing Laphine' }
            @{ map = 'ecl_fild01'; x = 237; y = 181; name = 'Cute Laphine' }
            @{ map = 'ecl_fild01'; x = 190; y = 93; name = 'Fili' }
          )
          done = 'The four gardeners were well, singing, watering and dancing for the earth. Fili was relieved, and worried at once about someone else.' }
       @{ title = 'Lost Adventurers'; cond = 'ep14_2_nines >= 3'
          route = @('ecl_fild01', 190, 93, 'Fili')
          now = 'RO quest: Fili asks after three adventurers lost in the keepers'' tower. Accept (I''ll do it! I''m an adventurer, too!), find Euncheong on floor 1, Rosi on floor 2 and New Oz on floor 3, then tell Fili.'
          hint = @(
            'Euncheong (ecl_tdun01, 11, 62), Rosi (ecl_tdun02, 99, 63), New Oz (ecl_tdun03, 68, 80). The tower''s door and stairs are the ones of Chapter 13.'
            'New Oz: choose I''m here to see if you''re doing okay. Back at Fili: The adventurer on the third floor is starving!'
          )
          spots = @(
            @{ map = 'ecl_fild01'; x = 190; y = 93; name = 'Fili' }
            @{ map = 'ecl_fild01'; x = 182; y = 82; name = 'Door of the keepers'' tower' }
            @{ map = 'ecl_tdun01'; x = 11; y = 62; name = 'Euncheong' }
            @{ map = 'ecl_tdun01'; x = 67; y = 106; name = 'Stairs up to the second floor' }
            @{ map = 'ecl_tdun02'; x = 99; y = 63; name = 'Rosi' }
            @{ map = 'ecl_tdun02'; x = 52; y = 9; name = 'Stairs up to the third floor' }
            @{ map = 'ecl_tdun03'; x = 68; y = 80; name = 'New Oz' }
          )
          done = 'All three adventurers were alive. New Oz, on the third floor, was starving: Fili sent him meat, and New Oz has errands of his own now.' }
     ) }

  # ---- Verus (Episode 15) ------------------------------------------------------
  # rAthena quests_15_1.txt, Wandering Bard (Lv 99+): he tells a story (one of
  # quests 4297-4302) and wants to hear it lived. A story's quest done: Cursed
  # Spirit (lhz_curse 31), President (lhz_boss 43), Juperos Ruins History
  # (yuno_hist 10), Metto (metto_q 9), Biological Weapon (hg_bio 9), Odin
  # Temple Excavation (hg_odin 60). His own quest (4295) wants all six.
  @{ key = 'ver_bard'; era = 'renewal'; hook = 926; title = 'The Wandering Bard'; range = '99+'
     where = 'Verus'
     intro = 'Professor Hendrik: "A bard wanders the old city, trading songs for stories. He has heard of you. I would not keep him waiting: he leaves when he runs out of tales."'
     reward = 'a song of your own; when he has heard all six of his stories, 5 Battle Manuals.'
     steps = @(
       @{ title = 'A Song for a Story'; cond = 'isbegin_quest(4295) || isbegin_quest(4297) || isbegin_quest(4298) || isbegin_quest(4299) || isbegin_quest(4300) || isbegin_quest(4301) || isbegin_quest(4302)'
          route = @('verus03', 129, 21, 'Wandering Bard')
          now = 'RO quest: listen to the Wandering Bard in the old city of Verus (verus03, 129, 21). He tells you a story, and wants to hear how it ended.'
          spots = @(@{ map = 'verus03'; x = 129; y = 21; name = 'Wandering Bard' })
          done = 'The Bard sang you a story of the Republic, and asked you to bring him its ending.' }
       @{ title = 'A Story You Lived'; cond = 'isbegin_quest(4295) == 2 || isbegin_quest(4297) == 2 || isbegin_quest(4298) == 2 || isbegin_quest(4299) == 2 || isbegin_quest(4300) == 2 || isbegin_quest(4301) == 2 || isbegin_quest(4302) == 2'
          route = @('verus03', 129, 21, 'Wandering Bard')
          now = 'RO quest: tell the Bard the ending of a story you lived. If his story is one you have not lived yet, give it back and ask for another.'
          hint = @(
            'His stories are RO quests: A Mad Scientist is The Scientist Who Trusts Fate (Juno), Odin Temple is The Odin Temple Excavation (Hugel); both are guided in this Journal. The others: Some Corporation (Lighthalzen''s Cursed Spirit quest), The President (Lighthalzen''s President quest), a Scholar in Juno (the Juperos Ruins History quest), Hugel (the Biological Weapon quest).'
            'If he tells one you have not finished, talk to him again and choose Return the quest.; then talk once more and he tells another. Only Some Corporation makes him rest for 4 hours when you give it back.'
            'After each story he rests for 4 hours of your play time before the next.'
          )
          spots = @(@{ map = 'verus03'; x = 129; y = 21; name = 'Wandering Bard' })
          done = 'You told the Bard a story he had only ever sung, and he swore to make a new song of it.' }
     ) }
)

return @{ guides = $guides }
