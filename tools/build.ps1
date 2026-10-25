# Builds the Adventurer's Chronicle mod files from story.ps1 + chronicle.template.txt.
# Run:  powershell -ExecutionPolicy Bypass -File build.ps1
# Writes: ../db/quest_db.yml, ../db/item_db.yml, ../System/OngoingQuestInfoList.lub,
#         ../System/itemInfo.lua, ../npc/chronicle.txt, ../client/data.js
# and the Renewal copies with every 're' of story.ps1 applied:
#         ../renewal/db/quest_db.yml, ../renewal/System/OngoingQuestInfoList.lub,
#         ../renewal/npc/chronicle.txt, ../renewal/client/data.js
# ("renewalFolder" in mod.json: on a Renewal server each replaces the file at
# the same path). The items are written once, in the mod's own db/ and System/,
# unless Renewal has chapters of its own (era = 'renewal' in story.ps1): then
# ../renewal/db/item_db.yml and ../renewal/System/itemInfo.lua hold every item
# with those chapters' costumes added.
$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
$mod = Split-Path $here -Parent
$latin1 = [Text.Encoding]::GetEncoding(28591)
$utf8 = New-Object Text.UTF8Encoding($false)

function Q([string]$s) { '"' + ($s -replace '\\', '\\' -replace '"', '\"') + '"' }
function Ascii([string]$s, [string]$where) {
    if ($s -match '[^\x20-\x7E]') { throw "Non-ASCII text in ${where}: $s" }
    $s
}
$typeNum = @{ talk = 1; hunt = 2; deliver = 3; boss = 4; report = 5; reach = 6; ro = 7 }

# Costume headgears: base item id -> (name, view, EUC-KR icon as hex), from the client's itemInfo.
$icons = @{}
foreach ($line in Get-Content (Join-Path $here 'costume_icons.tsv')) {
    $f = $line -split "`t"
    $icons[[int]$f[0]] = @{ name = $f[1]; hex = $f[2]; view = [int]$f[3] }
}
function HexToLatin1([string]$hex) {
    $chars = for ($i = 0; $i -lt $hex.Length; $i += 2) { [char][Convert]::ToInt32($hex.Substring($i, 2), 16) }
    -join $chars
}

foreach ($era in 'pre-renewal', 'renewal') {
# A fresh copy of the story for each era (the walk below writes into it).
$story = & (Join-Path $here 'story.ps1')
$chapters = $story.chapters
$side = & (Join-Path $here 'side.ps1')
$sides = $side.sides
$out = $mod
$final = $story.final
if ($era -eq 'renewal') {
    $out = Join-Path $mod 'renewal'
    $final = $story.finalRe
    # Side Quests, their steps, the MVP Ledger and the Passport ranks take
    # their 're' too (side.ps1).
    $all = @($chapters) + @($chapters | ForEach-Object { $_.steps }) + @($sides) + @($sides | ForEach-Object { $_.steps }) + @($side.mvps) + @($side.ranks)
    foreach ($h in $all) {
        if ($h.re) { foreach ($k in @($h.re.Keys)) { $h[$k] = $h.re[$k] } }
    }
}
# A chapter with an era is only in that era's route. Chapters are numbered by
# their place in the route.
$chapters = @($chapters | Where-Object { -not $_.era -or $_.era -eq $era })
$eraOnly = @($chapters | Where-Object { $_.era }).Count -gt 0
$n = 0
foreach ($c in $chapters) { $n++; $c.n = $n }
foreach ($dir in 'db', 'System', 'npc', 'client') { New-Item -ItemType Directory -Force (Join-Path $out $dir) | Out-Null }

# ---- walk the story ----
$steps = @()
$g = 0
$ids = @{}
foreach ($c in $chapters) {
    if ($c.steps.Count -ne 5) { throw "Chapter $($c.n) needs 5 steps" }
    foreach ($s in $c.steps) {
        $g++
        $s.g = $g; $s.ch = $c.n
        # The step's fixed id (quest id 77000 + id), see story.ps1.
        if (-not ($s.id -is [int]) -or $s.id -lt 1 -or $s.id -gt 999) { throw "Step $g ($($s.title)) needs an id from 1 to 999" }
        if ($ids[$s.id]) { throw "Step id $($s.id) is used twice" }
        $ids[$s.id] = $true
        # A chapter's spots (the way back in when you are somewhere Navigation
        # can't route from) go with each of its steps, after the step's own
        # (not with a step marked ownSpots); its 'away' line is the directions
        # of a step that has none.
        if ($c.spots -and -not $s.ownSpots) { $s.spots = @($s.spots | Where-Object { $_ }) + @($c.spots) }
        if ($c.away -and -not $s.hint) { $s.hint = @(, $c.away) }
        $steps += $s
    }
}
# A Side Quest's hook and an MVP's g name a step by its id (story.ps1); from
# here on they are its position in this era's route (on Pre-renewal, steps
# 1-40 have id = position).
$posOf = @{}
foreach ($s in $steps) { $posOf[$s.id] = $s.g }
foreach ($h in @($sides | Where-Object { $_.hook }) + @($side.mvps | Where-Object { $_.g })) {
    $key = $(if ($h.hook) { 'hook' } else { 'g' })
    $p = $posOf[[int]$h[$key]]
    if (-not $p) { throw "No step with id $($h[$key]) in the $era route ($key of $($h.title)$($h.name))" }
    $h[$key] = $p
}
# RO quest guides (guide.ps1): Rune-Midgard's own quests, shown on the way.
# The Chronicle only guides them: no quest-window entries or ids of its own,
# RO's own variables are the record. A guide opens once the main road passes
# its hook step (a step id, like a Side Quest's) and is labelled with the
# chapter that follows it.
$guides = @()
$guideFile = Join-Path $here 'guide.ps1'
if (Test-Path $guideFile) {
    $guides = @((& $guideFile).guides | Where-Object { -not $_.era -or $_.era -eq $era })
    if ($era -eq 'renewal') {
        foreach ($h in @($guides) + @($guides | ForEach-Object { $_.steps })) {
            if ($h.re) { foreach ($k in @($h.re.Keys)) { $h[$k] = $h.re[$k] } }
        }
    }
}
$keys = @{}
$gi = 0
foreach ($gd in $guides) {
    $gi++
    $gd.i = $gi
    if ($gd.key -notmatch '^[a-z0-9_]{1,20}$' -or $keys[$gd.key]) { throw "Guide key '$($gd.key)' must be unique, a-z 0-9 _ (it names the variable CHRON_G_<key>)" }
    $keys[$gd.key] = $true
    $p = $posOf[[int]$gd.hook]
    if (-not $p) { throw "No step with id $($gd.hook) in the $era route (hook of guide $($gd.key))" }
    $gd.hookPos = $p
    $gd.ch = $(if ($p -lt $steps.Count) { $steps[$p].ch } else { $chapters.Count })
    if ($gd.steps.Count -lt 1 -or $gd.steps.Count -gt 99) { throw "Guide $($gd.key) needs 1 to 99 steps" }
    $k = 0
    foreach ($s in $gd.steps) {
        $k++
        $s.k = $k
        $s.type = 'ro'
        if (-not $s.cond) { throw "Guide $($gd.key) step $k has no cond" }
    }
}

# Side Quest steps: step k of Side Quest n has the id n*10+k (quest 77100+id).
$sideSteps = @()
foreach ($sd in $sides) {
    if ($sd.steps.Count -gt 9) { throw "Side Quest $($sd.n) has more than 9 steps" }
    $k = 0
    foreach ($s in $sd.steps) {
        $k++
        $s.k = $k; $s.sid = $sd.n * 10 + $k; $s.sn = $sd.n
        $sideSteps += $s
    }
}

# ---- db/quest_db.yml ----
# Mob AegisNames for the targets (quest_db wants names).
$aegisOf = @{ 1002 = 'PORING'; 1063 = 'LUNATIC'; 1015 = 'ZOMBIE'; 1076 = 'SKELETON'; 1165 = 'SAND_MAN'; 1127 = 'HODE'; 1213 = 'HIGH_ORC'; 1189 = 'ORC_ARCHER'; 1195 = 'RIDEWORD'; 1199 = 'PUNK'; 1676 = 'VENATU_1'; 1837 = 'IMP'; 1833 = 'KASA'; 1752 = 'SKOGUL'; 1753 = 'FRUS'; 1111 = 'DRAINLIAR'; 1146 = 'MATYR'; 1616 = 'PITMAN'; 1620 = 'NOXIOUS'; 1177 = 'ZENORC'; 1152 = 'ORC_SKELETON'; 1993 = 'NAGA'; 1992 = 'CORNUS'; 1987 = 'CENTIPEDE'; 2092 = 'DOLOMEDES'; 2136 = 'LITTLE_FATUM'; 2137 = 'MIMING'; 2365 = 'CENERE'; 2366 = 'ANTIQUE_BOOK'; 3155 = 'REPAIR_ROBOT'; 3156 = 'EXPLORATION_ROVER'
    1161 = 'PLANKTON'; 1068 = 'HYDRA'; 1071 = 'PIRATE_SKEL'; 1178 = 'ZEROM'; 1269 = 'CLOCK'; 1193 = 'ALARM'; 1164 = 'REQUIEM' }
$q = @('# GENERATED by tools/build.ps1 from tools/story.ps1.', 'Header:', '  Type: QUEST_DB', '  Version: 3', '', 'Body:')
foreach ($s in $steps) {
    $q += "  - Id: $(77000 + $s.id)"
    $q += "    Title: $(Q (Ascii ('Chronicle ' + $s.ch + '-' + (($s.g - 1) % 5 + 1) + ': ' + $s.title) 'title'))"
    if ($s.type -eq 'hunt') {
        $q += '    Targets:'
        foreach ($mb in $s.mobs) {
            $name = $aegisOf[[int]$mb[0]]
            if (-not $name) { throw "No AegisName for mob $($mb[0])" }
            $q += "      - Mob: $name"
            $q += "        Count: $($mb[2])"
        }
    }
}
foreach ($s in $sideSteps) {
    $q += "  - Id: $(77100 + $s.sid)"
    $q += "    Title: $(Q (Ascii ('Side Quest ' + $s.sn + '-' + $s.k + ': ' + $s.title) 'side title'))"
    if ($s.type -eq 'hunt') {
        $q += '    Targets:'
        foreach ($mb in $s.mobs) {
            $name = $aegisOf[[int]$mb[0]]
            if (-not $name) { throw "No AegisName for mob $($mb[0])" }
            $q += "      - Mob: $name"
            $q += "        Count: $($mb[2])"
        }
    }
}
[IO.File]::WriteAllLines((Join-Path $out 'db\quest_db.yml'), $q, $utf8)

# ---- System/OngoingQuestInfoList.lub ----
# Each Description gets a <NAVI> link: clicking it in the quest window (Alt+U)
# opens the client's Navigation window with the route drawn. Hunt and boss maps
# point at an arrival spot taken from the client's navi_link table; a map the
# navigation tables don't know gets no link, since it can't route. (1.1.2: the
# client data of app 1.5.5 knows gef_fild14: entered from gef_fild10's west edge.)
$naviSpot = @{
    prt_fild08 = @(170, 375); prt_sewb2 = @(19, 19); pay_dun00 = @(21, 183); pay_dun01 = @(19, 33)
    moc_fild16 = @(124, 372); moc_pryd03 = @(100, 92); gef_fild14 = @(367, 219); gef_dun01 = @(115, 236); c_tower1 = @(199, 159)
    gl_chyard = @(147, 284); juperos_01 = @(54, 246); jupe_core = @(150, 286); thor_v01 = @(21, 229)
    thor_v02 = @(78, 203); odin_tem02 = @(27, 334); odin_tem03 = @(120, 54)
    # Renewal's hunts: in_sphinx1 (below, with the Side Quests) entered from moc_fild19,
    # orcsdun02 from the orc village (in_orcs01). Einbech's mine (Renewal's
    # Chapter 6): the arrival spots from Einbech and from its first level.
    orcsdun02 = @(180, 17); ein_dun01 = @(22, 14); ein_dun02 = @(291, 292)
    # Renewal's New World, Mora, Eclage and Verus chapters: arrival spots from
    # navi_link (the Teleport Cats' for man_fild02, dic_fild01 and bif_fild02).
    # verus03 has no link in from verus04, so its step names a route instead.
    spl_fild01 = @(289, 30); man_fild02 = @(133, 47); dic_fild01 = @(159, 264); dic_dun01 = @(366, 45)
    bif_fild02 = @(291, 323); ecl_tdun02 = @(60, 88); ecl_tdun03 = @(47, 13); ver_eju = @(13, 148)
    iz_dun00 = @(168, 168); iz_dun01 = @(253, 252); treasure01 = @(69, 24); in_sphinx1 = @(288, 9); in_sphinx3 = @(210, 54)
}
# Where a Side Quest step's route leads: its own route, else its giver (a new
# NPC, or the chapter NPC), else the arrival spot of its map.
function SideSpot($s) {
    $sd = $sides | Where-Object { $_.n -eq $s.sn }
    if ($s.route) { return [ordered]@{ map = $s.route[0]; x = $s.route[1]; y = $s.route[2]; name = $s.route[3] } }
    if ($s.type -in 'talk', 'report') {
        if ($sd.npc) { return [ordered]@{ map = $sd.town; x = $sd.x; y = $sd.y; name = $sd.npc } }
        $c = $chapters[$sd.ch - 1]
        return [ordered]@{ map = $c.town; x = $c.x; y = $c.y; name = $c.npc }
    }
    $m = $(if ($s.map) { $s.map } else { $s.where })
    $spot = $naviSpot[$m]
    if (-not $spot) { Write-Warning "No navigation spot for $m (Side Quest $($s.sn)-$($s.k)): no route link."; return $null }
    $name = $(if ($s.type -eq 'boss') { "$($s.boss): $m" } else { "$($s.title): $m" })
    [ordered]@{ map = $m; x = $spot[0]; y = $spot[1]; name = $name }
}
# Where a step's route leads (also the Journal's Route link, via data.js).
function NaviSpot($s) {
    $c = $chapters[$s.ch - 1]
    # A step whose map navigation can't reach names the nearest spot it can
    # (the Culvert Recruiter, the Kafra to Morroc, the Hugel Boatman).
    if ($s.route) { return [ordered]@{ map = $s.route[0]; x = $s.route[1]; y = $s.route[2]; name = $s.route[3] } }
    if ($s.type -in 'talk', 'deliver', 'report') { return [ordered]@{ map = $c.town; x = $c.x; y = $c.y; name = $c.npc } }
    $m = $(if ($s.map) { $s.map } else { $s.where })
    $spot = $naviSpot[$m]
    if (-not $spot) { Write-Warning "No navigation spot for $m (step $($s.g)): no route link."; return $null }
    $name = $(if ($s.type -eq 'boss') { "$($s.boss): $m" } else { "Hunting ground: $m" })
    [ordered]@{ map = $m; x = $spot[0]; y = $spot[1]; name = $name }
}
function NaviLink($s) {
    $r = NaviSpot $s
    if (-not $r) { return $null }
    "Route: <NAVI>[$($r.name)]<INFO>$($r.map),$($r.x),$($r.y),0,000,0</INFO></NAVI>"
}
$l = @('-- GENERATED by tools/build.ps1 from tools/story.ps1 (ASCII only).', 'QuestInfoList = {')
foreach ($s in $steps) {
    # One string: the client joins Description lines with commas. The quest
    # window writes it as HTML, so <br> breaks the line.
    $desc = $s.now
    if ($s.hint) {
        $n = 0
        $desc += '<br><br>How to get there:' + (($s.hint | ForEach-Object { $n++; "<br>$n. $_" }) -join '')
    }
    $link = NaviLink $s
    if ($link) { $desc += "<br><br>$link" }
    $l += "`t[$(77000 + $s.id)] = {"
    $l += "`t`tTitle = $(Q (Ascii ('Chronicle ' + $s.ch + '-' + (($s.g - 1) % 5 + 1) + ': ' + $s.title) 'title')),"
    $l += "`t`tSummary = $(Q (Ascii $s.now 'now')),"
    $l += "`t`tIconName = `"ico_nq.bmp`","
    $l += "`t`tDescription = { $(Q (Ascii $desc 'now')) },"
    $l += "`t},"
}
foreach ($s in $sideSteps) {
    $sd = $sides | Where-Object { $_.n -eq $s.sn }
    $desc = "Optional Side Quest: $($sd.title).<br>$($s.now)"
    if ($s.hint) {
        $n = 0
        $desc += '<br><br>How to get there:' + (($s.hint | ForEach-Object { $n++; "<br>$n. $_" }) -join '')
    }
    $r = SideSpot $s
    if ($r) { $desc += "<br><br>Route: <NAVI>[$($r.name)]<INFO>$($r.map),$($r.x),$($r.y),0,000,0</INFO></NAVI>" }
    $l += "`t[$(77100 + $s.sid)] = {"
    $l += "`t`tTitle = $(Q (Ascii ('Side Quest ' + $s.sn + '-' + $s.k + ': ' + $s.title) 'side title')),"
    $l += "`t`tSummary = $(Q (Ascii $s.now 'side now')),"
    $l += "`t`tIconName = `"ico_nq.bmp`","
    $l += "`t`tDescription = { $(Q (Ascii $desc 'side now')) },"
    $l += "`t},"
}
$l += '}'
[IO.File]::WriteAllLines((Join-Path $out 'System\OngoingQuestInfoList.lub'), $l, $utf8)

# ---- items: the Chronicle book (50100) and 3 costumes per chapter ----
# The 8 chapters of both eras have 50101-50124, in order; a chapter of one era
# names its first id (costumeId, from 50900 on), so ids never move when a
# chapter is put in between.
$items = @('# GENERATED by tools/build.ps1.', 'Header:', '  Type: ITEM_DB', '  Version: 3', '', 'Body:')
$items += '  - Id: 50100'
$items += '    AegisName: Adventurers_Chronicle'
$items += '    Name: Adventurer''s Chronicle'
$items += '    Type: Usable'
$items += '    Weight: 0'
$items += '    Flags:'
$items += '      NoConsume: true'
$items += '    Trade:'
$items += '      NoDrop: true'
$items += '      NoTrade: true'
$items += '      NoSell: true'
$items += '      NoCart: true'
$items += '      NoStorage: true'
$items += '      NoGuildStorage: true'
$items += '      NoMail: true'
$items += '      NoAuction: true'
$items += '    Script: |'
$items += '      dispbottom "@@event chronicle open";'
$info = @('mainTable = mainTable or tbl or {}', '')
$bookIcon = HexToLatin1 $icons[1551].hex
$info += 'mainTable[50100] = {'
$info += "`tunidentifiedDisplayName = `"Adventurer's Chronicle`","
$info += "`tunidentifiedResourceName = `"$bookIcon`","
$info += "`tunidentifiedDescriptionName = { `"`" },"
$info += "`tidentifiedDisplayName = `"Adventurer's Chronicle`","
$info += "`tidentifiedResourceName = `"$bookIcon`","
$info += "`tidentifiedDescriptionName = {"
$info += "`t`t`"^777777A journal that writes itself as you live your story.^000000`","
$info += "`t`t`"Use it (or press ^0000FFAlt+B^000000) to read your Chronicle:`","
$info += "`t`t`"what you have done, and where your road leads next.`","
$info += "`t`t`"_______________________`","
$info += "`t`t`"^0000CCType:^000000 Journal (not used up)`","
$info += "`t`t`"^0000CCWeight:^000000 0`""
$info += "`t},"
$info += "`tslotCount = 0,"
$info += "`tClassNum = 0,"
$info += "`tcostume = false"
$info += '}'
$costumeIds = @{}
$shared = 50100
$id = 50100
# Every item id written (and its AegisName): the tbl list below, and no id or
# name twice.
$written = @{ 50100 = $true }
$aegisUsed = @{}
foreach ($c in $chapters) {
    $k = 0
    foreach ($base in $c.costumes) {
        $k++
        if ($c.era) { $cid = $c.costumeId + $k - 1 } else { $shared++; $cid = $shared }
        if ($cid -gt $id) { $id = $cid }
        $ic = $icons[[int]$base]
        if (-not $ic) { throw "No icon data for base item $base" }
        $costumeIds[($c.n - 1) * 3 + $k] = $cid
        $nm = "Costume $($ic.name)"
        $aegis = 'Chronicle_C_' + ($ic.name -replace '[^A-Za-z0-9]', '_')
        if ($written[$cid]) { throw "Item id $cid used twice" }
        if ($aegisUsed[$aegis]) { throw "AegisName $aegis used twice (base $base)" }
        $written[$cid] = $true; $aegisUsed[$aegis] = $true
        $items += "  - Id: $cid"
        $items += "    AegisName: $aegis"
        $items += "    Name: $(Q $nm)"
        $items += '    Type: Armor'
        $items += '    Weight: 0'
        $items += '    Locations:'
        $items += '      Costume_Head_Top: true'
        $items += "    View: $($ic.view)"
        $items += "    ArmorLevel: 1"	# rAthena warns about an armor without one
        $items += '    Trade:'
        $items += '      NoDrop: true'
        # 1.2.4: tradeable, so companions can wear them (the user asked)
        $items += '      NoSell: true'
        $items += '      NoCart: true'
        $items += '      NoMail: true'
        $items += '      NoAuction: true'
        $res = HexToLatin1 $ic.hex
        $info += "mainTable[$cid] = {"
        $info += "`tunidentifiedDisplayName = `"$nm`","
        $info += "`tunidentifiedResourceName = `"$res`","
        $info += "`tunidentifiedDescriptionName = { `"`" },"
        $info += "`tidentifiedDisplayName = `"$nm`","
        $info += "`tidentifiedResourceName = `"$res`","
        $info += "`tidentifiedDescriptionName = {"
        $info += "`t`t`"^777777A keepsake of Chapter $($c.n) of your Chronicle: $($c.title).^000000`","
        $info += "`t`t`"Looks like the $($ic.name), worn in the costume slot.`","
        $info += "`t`t`"_______________________`","
        $info += "`t`t`"^0000CCType:^000000 Costume`","
        $info += "`t`t`"^0000CCPosition:^000000 Upper`","
        $info += "`t`t`"^0000CCWeight:^000000 0`""
        $info += "`t},"
        $info += "`tslotCount = 0,"
        $info += "`tClassNum = $($ic.view),"
        $info += "`tcostume = true"
        $info += '}'
    }
}
# Side Quest keepsakes (cosmetic, like the chapter costumes) and the Passport
# rank costumes (the only ones with a stat: one fixed bonus each).
# Their ids are fixed in side.ps1 (ids / id), so items already given out keep
# their id when Side Quests are added.
$extra = @()
foreach ($sd in $sides) {
    $extra += @{ id = $sd.ids[0]; base = $sd.costume[0]; line = "A keepsake of the Side Quest $($sd.title)."; side = $sd.n }
    $extra += @{ id = $sd.ids[1]; base = $sd.costume[1]; line = "A keepsake of the Side Quest $($sd.title)."; side = $sd.n; alt = $true }
}
$rk = 0
foreach ($r in $side.ranks) { $rk++; $extra += @{ id = $r.id; base = $r.base; line = "Adventurer's Passport, rank $($r.name) ($($r.need) stamps)."; script = $r.script; stat = $r.stat; rank = $rk } }
$extra = @($extra | Sort-Object { [int]$_.id })
$used = @{}
foreach ($e in $extra) {
    if (-not $e.id -or $written[[int]$e.id]) { throw "Item id $($e.id) missing or taken by a chapter costume (base $($e.base))" }
    if ($used[[int]$e.id]) { throw "Item id $($e.id) used twice" }
    $used[[int]$e.id] = $true
    $an = 'Chronicle_C_' + ($icons[[int]$e.base].name -replace '[^A-Za-z0-9]', '_')
    if ($aegisUsed[$an]) { throw "AegisName $an used twice (base $($e.base))" }
    $aegisUsed[$an] = $true
}
$sideCost = @{}; $sideCost2 = @{}; $rankItem = @{}
foreach ($e in $extra) {
    $id = [int]$e.id
    $ic = $icons[[int]$e.base]
    if (-not $ic) { throw "No icon data for base item $($e.base)" }
    if ($e.alt) { $sideCost2[$e.side] = $id } elseif ($e.side) { $sideCost[$e.side] = $id } else { $rankItem[$e.rank] = $id }
    $nm = "Costume $($ic.name)"
    $items += "  - Id: $id"
    $items += "    AegisName: Chronicle_C_$($ic.name -replace '[^A-Za-z0-9]', '_')"
    $items += "    Name: $(Q $nm)"
    $items += '    Type: Armor'
    $items += '    Weight: 0'
    $items += '    Locations:'
    $items += '      Costume_Head_Top: true'
    $items += "    View: $($ic.view)"
    $items += "    ArmorLevel: 1"
    $items += '    Trade:'
    $items += '      NoDrop: true'
    $items += '      NoSell: true'
    $items += '      NoCart: true'
    $items += '      NoMail: true'
    $items += '      NoAuction: true'
    if ($e.script) {
        $items += '    Script: |'
        $items += "      $($e.script)"
    }
    $res = HexToLatin1 $ic.hex
    $info += "mainTable[$id] = {"
    $info += "`tunidentifiedDisplayName = `"$nm`","
    $info += "`tunidentifiedResourceName = `"$res`","
    $info += "`tunidentifiedDescriptionName = { `"`" },"
    $info += "`tidentifiedDisplayName = `"$nm`","
    $info += "`tidentifiedResourceName = `"$res`","
    $info += "`tidentifiedDescriptionName = {"
    $info += "`t`t`"^777777$(Ascii $e.line 'item line')^000000`","
    $info += "`t`t`"Looks like the $($ic.name), worn in the costume slot.`","
    if ($e.stat) { $info += "`t`t`"^0000CCBonus:^000000 $($e.stat)`"," }
    $info += "`t`t`"_______________________`","
    $info += "`t`t`"^0000CCType:^000000 Costume`","
    $info += "`t`t`"^0000CCPosition:^000000 Upper`","
    $info += "`t`t`"^0000CCWeight:^000000 0`""
    $info += "`t},"
    $info += "`tslotCount = 0,"
    $info += "`tClassNum = $($ic.view),"
    $info += "`tcostume = true"
    $info += '}'
}
$info += ''
$info += 'if tbl then'
foreach ($e in $extra) { $written[[int]$e.id] = $true }
foreach ($i in @($written.Keys | Sort-Object)) { $info += "`ttbl[$i] = mainTable[$i]" }
$info += 'end'
if ($era -eq 'pre-renewal' -or $eraOnly) {
    [IO.File]::WriteAllLines((Join-Path $out 'db\item_db.yml'), $items, $utf8)
    [IO.File]::WriteAllText((Join-Path $out 'System\itemInfo.lua'), (($info -join "`n") + "`n"), $latin1)
}

# ---- npc/chronicle.txt ----
$d = @()
$d += "// ---- generated data ----"
$d += "`$@chr_steps = $($steps.Count);"
$d += "`$@chr_chapters = $($chapters.Count);"
$d += "`$@chr_final = $final;"
function Arr([string]$name, $values, [switch]$str, [int]$from = 1) {
    $vals = @($values) | ForEach-Object { if ($str) { Q $_ } else { "$_" } }
    "setarray $name[$from], " + ($vals -join ', ') + ';'
}
$d += Arr '$@chr_sid' ($steps | ForEach-Object { $_.id })
$d += Arr '$@chr_type' ($steps | ForEach-Object { $typeNum[$_.type] })
$d += Arr '$@chr_lv' ($steps | ForEach-Object { $_.lv })
$d += Arr '$@chr_title$' ($steps | ForEach-Object { Ascii $_.title 'title' }) -str
$d += Arr '$@chr_now$' ($steps | ForEach-Object { Ascii $_.now 'now' }) -str
$d += Arr '$@chr_say$' ($steps | ForEach-Object { if ($_.say) { Ascii ($_.say -join '|') 'say' } else { '' } }) -str
$d += Arr '$@chr_items$' ($steps | ForEach-Object { if ($_.items) { ($_.items | ForEach-Object { "$($_[0]),$($_[2]),$(Ascii $_[1] 'item')" }) -join ';' } else { '' } }) -str
$d += Arr '$@chr_map$' ($steps | ForEach-Object { if ($_.map) { $_.map } elseif ($_.where) { $_.where } else { '' } }) -str
$d += Arr '$@chr_bmob' ($steps | ForEach-Object { if ($_.mob) { $_.mob } else { 0 } })
$d += Arr '$@chr_bname$' ($steps | ForEach-Object { if ($_.boss) { Ascii $_.boss 'boss' } else { '' } }) -str
# Monsters the Journal follows on a map: "map|event label|name1,name2,...".
$d += Arr '$@chr_watch$' ($steps | ForEach-Object { if ($_.watch) { Ascii "$($_.watch.map)|$($_.watch.event)|$($_.watch.names -join ',')" 'watch' } else { '' } }) -str
$d += Arr '$@chr_bhp'($steps | ForEach-Object { if ($_.hp) { $_.hp } else { 0 } })
$d += Arr '$@chr_ctitle$' ($chapters | ForEach-Object { Ascii $_.title 'chapter title' }) -str
$d += Arr '$@chr_town$' ($chapters | ForEach-Object { $_.town }) -str
$d += Arr '$@chr_townname$' ($chapters | ForEach-Object { $_.townName }) -str
$d += Arr '$@chr_npc$' ($chapters | ForEach-Object { Ascii $_.npc 'npc' }) -str
$d += Arr '$@chr_x' ($chapters | ForEach-Object { $_.x })
$d += Arr '$@chr_y' ($chapters | ForEach-Object { $_.y })
$d += Arr '$@chr_zeny' ($chapters | ForEach-Object { $_.zeny })
$d += Arr '$@chr_gift$' ($chapters | ForEach-Object { ($_.gift | ForEach-Object { "$($_[0]),$($_[1])" }) -join ';' }) -str
$d += Arr '$@chr_cost' (1..($chapters.Count * 3) | ForEach-Object { $costumeIds[$_] })
# Side Quests: per quest [n], per step [n*10+k].
function ItemList($list) { if ($list) { (@($list) | ForEach-Object { "$($_[0]),$($_[2]),$(Ascii $_[1] 'item')" }) -join ';' } else { '' } }
function PairList($list) { if ($list) { (@($list) | ForEach-Object { "$($_[0]),$($_[1])" }) -join ';' } else { '' } }
$d += "// ---- side quests ----"
$d += "`$@sq_n = $($sides.Count);"
$d += Arr '$@sq_title$' ($sides | ForEach-Object { Ascii $_.title 'side title' }) -str
$d += Arr '$@sq_ch' ($sides | ForEach-Object { $_.ch })
$d += Arr '$@sq_hook' ($sides | ForEach-Object { $_.hook })
$d += Arr '$@sq_steps' ($sides | ForEach-Object { $_.steps.Count })
$d += Arr '$@sq_npc$' ($sides | ForEach-Object { if ($_.npc) { Ascii $_.npc 'npc' } else { '' } }) -str
$d += Arr '$@sq_idle$' ($sides | ForEach-Object { if ($_.idle) { Ascii $_.idle 'idle' } else { '' } }) -str
$d += Arr '$@sq_after$' ($sides | ForEach-Object { if ($_.after) { Ascii $_.after 'after' } else { '' } }) -str
$d += Arr '$@sq_cost' ($sides | ForEach-Object { $sideCost[$_.n] })
$d += Arr '$@sq_cost2' ($sides | ForEach-Object { $sideCost2[$_.n] })
$d += Arr '$@sq_kitk' ($sides | ForEach-Object { if ($_.kitStep) { $_.kitStep } else { 0 } })
$d += Arr '$@sq_gift$' ($sides | ForEach-Object { PairList $_.gift }) -str
$d += Arr '$@sq_kit$' ($sides | ForEach-Object { PairList $_.kit }) -str
$d += Arr '$@sq_nokit$' ($sides | ForEach-Object { if ($_.nokit) { Ascii ($_.nokit -join '|') 'nokit' } else { '' } }) -str
$d += Arr '$@sq_zeny' ($sides | ForEach-Object { $_.zeny })
foreach ($sd in $sides) {
    $ss = $sideSteps | Where-Object { $_.sn -eq $sd.n }
    $at = $sd.n * 10 + 1
    $d += Arr '$@sqs_type' ($ss | ForEach-Object { $typeNum[$_.type] }) -from $at
    $d += Arr '$@sqs_title$' ($ss | ForEach-Object { Ascii $_.title 'title' }) -str -from $at
    $d += Arr '$@sqs_now$' ($ss | ForEach-Object { Ascii $_.now 'now' }) -str -from $at
    $d += Arr '$@sqs_say$' ($ss | ForEach-Object { if ($_.say) { Ascii ($_.say -join '|') 'say' } else { '' } }) -str -from $at
    $d += Arr '$@sqs_map$' ($ss | ForEach-Object { if ($_.map) { $_.map } elseif ($_.where) { $_.where } else { '' } }) -str -from $at
    $d += Arr '$@sqs_bmob' ($ss | ForEach-Object { if ($_.mob) { $_.mob } else { 0 } }) -from $at
    $d += Arr '$@sqs_bname$' ($ss | ForEach-Object { if ($_.boss) { Ascii $_.boss 'boss' } else { '' } }) -str -from $at
    $d += Arr '$@sqs_bhp' ($ss | ForEach-Object { if ($_.hp) { $_.hp } else { 0 } }) -from $at
    $d += Arr '$@sqs_var$' ($ss | ForEach-Object { if ($_.var) { $_.var } else { '' } }) -str -from $at
    $d += Arr '$@sqs_val' ($ss | ForEach-Object { if ($_.val) { $_.val } else { 0 } }) -from $at
    $d += Arr '$@sqs_items$' ($ss | ForEach-Object { ItemList $_.items }) -str -from $at
    $d += Arr '$@sqs_loot$' ($ss | ForEach-Object { if ($_.loot) { "$($_.loot[0]),$($_.loot[1])" } else { '' } }) -str -from $at
    # Over maxLv, the giver can tell the step instead (altAsk, then the alt lines)
    $d += Arr '$@sqs_maxlv' ($ss | ForEach-Object { if ($_.maxLv -and $_.alt) { $_.maxLv } else { 0 } }) -from $at
    $d += Arr '$@sqs_altask$' ($ss | ForEach-Object { if ($_.altAsk) { Ascii $_.altAsk 'altAsk' } else { '' } }) -str -from $at
    $d += Arr '$@sqs_alt$' ($ss | ForEach-Object { if ($_.alt) { Ascii ($_.alt -join '|') 'alt' } else { '' } }) -str -from $at
    # "at|name;at|name": the parts of a step, announced as RO's quest moves on
    $d += Arr '$@sqs_parts$' ($ss | ForEach-Object { if ($_.parts) { (@($_.parts) | ForEach-Object { if ($_.name -match '[|;"]') { throw "Bad character in part $($_.name)" }; "$($_.at)|$(Ascii $_.name 'part')" }) -join ';' } else { '' } }) -str -from $at
}
# RO quest steps are done when their condition holds (by default: the
# variable has reached val), checked with the player attached.
$cond = @('// ---- generated: RO quest step conditions, Side Quest dead ends ----', 'function	script	F_ChronRoCond	{', '	switch (getarg(0)) {')
foreach ($s in $sideSteps | Where-Object { $_.type -eq 'ro' }) {
    $c = $(if ($s.cond) { $s.cond } elseif ($s.var) { "$($s.var) >= $($s.val)" } else { throw "ro step $($s.sid) has neither cond nor var" })
    $cond += "	case $($s.sid): return ($c);"
}
$cond += '	}', '	return 0;', '}', '', 'function	script	F_ChronSideFail	{', '	switch (getarg(0)) {'
foreach ($sd in $sides | Where-Object { $_.fail }) { $cond += "	case $($sd.n): return ($($sd.fail));" }
$cond += '	}', '	return 0;', '}', ''
# The MVP Ledger (bit m of CHRON_MVPK) and the Passport ranks.
$d += "`$@mvp_n = $($side.mvps.Count);"
$d += Arr '$@mvp_id' ($side.mvps | ForEach-Object { $_.id }) -from 0
$d += Arr '$@mvp_name$' ($side.mvps | ForEach-Object { Ascii $_.name 'mvp' }) -str -from 0
$d += "`$@pp_n = $($side.ranks.Count);"
$d += Arr '$@pp_need' ($side.ranks | ForEach-Object { $_.need })
$d += Arr '$@pp_name$' ($side.ranks | ForEach-Object { Ascii $_.name 'rank' }) -str
$d += Arr '$@pp_item' (1..$side.ranks.Count | ForEach-Object { $rankItem[$_] })
# RO quest guides: per guide [i], per step [i*100+k]. Built only into a route
# that has guides, so a route without them is written exactly as before.
$guideFns = @()
if ($guides.Count) {
    $d += "// ---- RO quest guides ----"
    $d += "`$@gd_n = $($guides.Count);"
    $d += Arr '$@gd_key$' ($guides | ForEach-Object { $_.key }) -str
    $d += Arr '$@gd_title$' ($guides | ForEach-Object { Ascii $_.title 'guide title' }) -str
    foreach ($gd in $guides) {
        $at = $gd.i * 100 + 1
        $d += Arr '$@gds_title$' ($gd.steps | ForEach-Object { Ascii $_.title 'guide step' }) -str -from $at
        $d += Arr '$@gds_now$' ($gd.steps | ForEach-Object { Ascii $_.now 'guide now' }) -str -from $at
        $d += Arr '$@gds_items$' ($gd.steps | ForEach-Object { ItemList $_.items }) -str -from $at
        $d += Arr '$@gds_parts$' ($gd.steps | ForEach-Object { if ($_.parts) { (@($_.parts) | ForEach-Object { if ($_.name -match '[|;"]') { throw "Bad character in part $($_.name)" }; "$($_.at)|$(Ascii $_.name 'part')" }) -join ';' } else { '' } }) -str -from $at
    }
    # Where guide getarg(0) stands: -1 its mod is not on this server (needs),
    # 0 not open yet, 100 done, else the first step whose cond is not true.
    $guideFns += '// ---- generated: RO quest guides ----', 'function	script	F_ChronGuideK	{', '	switch (getarg(0)) {'
    foreach ($gd in $guides) {
        $guideFns += "	case $($gd.i):	// $($gd.key)"
        if ($gd.needs) { $guideFns += "		if (!getnpcid(0, $(Q $gd.needs))) return -1;" }
        $guideFns += "		if (CHRON_STEP <= $($gd.hookPos)) return 0;"
        $guideFns += "		if (CHRON_G_$($gd.key)) return 100;"
        foreach ($s in $gd.steps) { $guideFns += "		if (!($($s.cond))) return $($s.k);" }
        $guideFns += '		return 100;'
    }
    $guideFns += '	}', '	return 0;', '}', ''
    # The value of RO's variable on step getarg(0) (i*100+k), for its parts and spots.
    $guideFns += 'function	script	F_ChronGuideRo	{', '	switch (getarg(0)) {'
    foreach ($gd in $guides) { foreach ($s in $gd.steps | Where-Object { $_.var }) { $guideFns += "	case $($gd.i * 100 + $s.k): return $($s.var);" } }
    $guideFns += '	}', '	return -1;', '}', ''
    $guideFns += @'
// The Journal's line for the guides: "k:ro:items" per guide, ';' between.
function	script	F_ChronGuideState	{
	.@s$ = "";
	for (.@i = 1; .@i <= $@gd_n; .@i++) {
		.@k = callfunc("F_ChronGuideK", .@i);
		.@v = -1;
		.@h$ = "";
		if (.@k >= 1 && .@k < 100) {
			.@v = callfunc("F_ChronGuideRo", .@i * 100 + .@k);
			if ($@gds_items$[.@i * 100 + .@k] != "")
				.@h$ = callfunc("F_ChronHaveList", $@gds_items$[.@i * 100 + .@k]);
		}
		.@s$ += (.@i > 1 ? ";" : "") + .@k + ":" + .@v + ":" + .@h$;
	}
	return .@s$;
}

// Every tick: a guide that moved on is announced, one RO finished is stamped.
// The first look after login only notes where each one stands.
function	script	F_ChronGuideTick	{
	for (.@i = 1; .@i <= $@gd_n; .@i++) {
		if (getd("CHRON_G_" + $@gd_key$[.@i]))
			continue;
		.@k = callfunc("F_ChronGuideK", .@i);
		if (.@k == 100) {
			callfunc "F_ChronGuideDone", .@i;
			continue;
		}
		.@v = -1;
		if (.@k >= 1)
			.@v = callfunc("F_ChronGuideRo", .@i * 100 + .@k);
		if (@chr_ginit) {
			.@was = @chr_gk[.@i];
			if (.@k >= 1 && .@was < 1) {
				dispbottom "[Chronicle] New on your road: " + $@gd_title$[.@i] + ", one of Rune-Midgard's own quests. The Journal (Alt+B, Side Quests tab) shows the way.", 0xE5A15E;
				dispbottom "@@event chronicle refresh";
			} else if (.@k >= 1 && .@was != .@k) {
				if (.@k > .@was)
					dispbottom "[Chronicle] " + $@gd_title$[.@i] + ": " + $@gds_title$[.@i * 100 + .@was] + " done. Next: " + $@gds_now$[.@i * 100 + .@k], 0xE5A15E;
				dispbottom "@@event chronicle refresh";
			} else if (.@k >= 1 && .@v != @chr_gv[.@i]) {
				callfunc "F_ChronGuidePart", .@i, .@i * 100 + .@k, .@v;
				dispbottom "@@event chronicle refresh";
			}
		}
		@chr_gk[.@i] = .@k;
		@chr_gv[.@i] = .@v;
	}
	@chr_ginit = 1;
	return;
}

// Guide getarg(0), step getarg(1): RO's variable is now getarg(2). Name the
// part just done and the next one ($@gds_parts$ "at|name;...").
function	script	F_ChronGuidePart	{
	if ($@gds_parts$[getarg(1)] == "")
		return;
	explode(.@pt$, $@gds_parts$[getarg(1)], ";");
	.@done$ = "";
	.@next$ = "";
	for (.@j = 0; .@j < getarraysize(.@pt$); .@j++) {
		explode(.@p$, .@pt$[.@j], "|");
		.@at = atoi(.@p$[0]);
		if (.@at == getarg(2))
			.@done$ = .@p$[1];
		else if (.@at > getarg(2) && .@next$ == "")
			.@next$ = .@p$[1];
	}
	if (.@done$ != "")
		dispbottom "[Chronicle] " + $@gd_title$[getarg(0)] + ": done, " + .@done$ + "." + (.@next$ != "" ? " Next: " + .@next$ + "." : ""), 0xE5A15E;
	return;
}

// How many guides are done (CHRON_G_<key>): Passport stamps, beside the Side Quests'.
function	script	F_ChronGuideStamps	{
	.@n = 0;
	for (.@i = 1; .@i <= $@gd_n; .@i++)
		if (getd("CHRON_G_" + $@gd_key$[.@i]))
			.@n++;
	return .@n;
}

// Guide getarg(0) is done: RO's quest gave its own rewards, the Chronicle
// stamps the Passport (and hands out a rank reached).
function	script	F_ChronGuideDone	{
	.@i = getarg(0);
	setd "CHRON_G_" + $@gd_key$[.@i], 1;
	specialeffect2 EF_ANGEL2;
	dispbottom "[Chronicle] " + $@gd_title$[.@i] + " is done. Your Adventurer's Passport is stamped.", 0xFFDD66;
	.@stamps = callfunc("F_ChronGuideStamps");
	for (.@j = 1; .@j <= $@sq_n; .@j++)
		if (CHRON_SQ[.@j] == 100)
			.@stamps++;
	for (.@r = 1; .@r <= $@pp_n; .@r++) {
		if (.@stamps < $@pp_need[.@r] || (CHRON_PASS & (1 << .@r)))
			continue;
		CHRON_PASS = CHRON_PASS | (1 << .@r);
		getitem $@pp_item[.@r], 1;
		dispbottom "[Chronicle] Passport rank " + $@pp_name$[.@r] + "! You received " + getitemname($@pp_item[.@r]) + ".", 0xFFDD66;
	}
	dispbottom "@@event chronicle refresh";
	return;
}

'@ -split "`r?`n"
}
$npcs = @('// ---- generated NPCs ----')
foreach ($c in $chapters) {
    $npcs += "$($c.town),$($c.x),$($c.y),4`tduplicate(ChronNPC)`t$($c.npc)#c$($c.n)`t$($c.sprite)"
}
foreach ($sd in $sides | Where-Object { $_.npc }) {
    $npcs += "$($sd.town),$($sd.x),$($sd.y),4`tduplicate(ChronSide)`t$($sd.npc)#s$($sd.n)`t$($sd.sprite)"
}
# Passages (story.ps1's gates): open from the position of step id 'from' on.
# A route without that step gets none.
$k = 0
foreach ($gt in $story.gates) {
    $from = @($steps | Where-Object { $_.id -eq $gt.from })
    if (-not $from.Count) { continue }
    $k++
    $npcs += "$($gt.map),$($gt.x),$($gt.y),$($gt.dir)`tscript`t$(Ascii $gt.name 'gate')#chrgate$k`t$($gt.sprite),{"
    $npcs += "`tcallfunc `"F_ChronGate`", $($from[0].g), $(Q $gt.to[0]), $($gt.to[1]), $($gt.to[2]), $(Q (Ascii ($gt.say -join '|') 'gate')), $(Q (Ascii $gt.shut 'gate'));"
    $npcs += "`tend;"
    $npcs += '}'
}
$tpl = Get-Content (Join-Path $here 'chronicle.template.txt') -Raw
$tpl = $tpl.Replace('//@@DATA@@', ($d -join "`n`t")).Replace('//@@NPCS@@', (($cond + $guideFns + $npcs) -join "`n"))
# The template's guide hooks: the calls on a route with guides, gone without
# a trace on one without (each marker must be there, once).
$hooks = [ordered]@{
    '//@@GUIDE_TICK@@' = 'callfunc "F_ChronGuideTick";'
    '//@@GUIDE_STAMPS@@' = '.@stamps += callfunc("F_ChronGuideStamps");'
    '/*@@GUIDE_STATE@@*/' = ' + "|" + callfunc("F_ChronGuideState")'
}
foreach ($m in $hooks.Keys) {
    if (([regex]::Matches($tpl, [regex]::Escape($m))).Count -ne 1) { throw "Template marker $m must be there once" }
    if ($guides.Count) { $tpl = $tpl.Replace($m, $hooks[$m]) }
    elseif ($m.StartsWith('//')) { $tpl = $tpl -replace ('[ \t]*' + [regex]::Escape($m) + '\r?\n'), '' }
    else { $tpl = $tpl.Replace($m, '') }
}
[IO.File]::WriteAllText((Join-Path $out 'npc\chronicle.txt'), $tpl, $utf8)

# ---- client/data.js ----
$js = [ordered]@{ final = $final; chapters = @() }
# Renewal: what comes after the finale, for the Journal (only where the route has it).
if ($era -eq 'renewal' -and $story.soonRe) { $js.Insert(1, 'soon', (Ascii $story.soonRe 'soon')) }
foreach ($c in $chapters) {
    $js.chapters += [ordered]@{
        n = $c.n; title = $c.title; range = $c.range; town = $c.town; townName = $c.townName; npc = $c.npc; x = $c.x; y = $c.y; intro = $c.intro
        steps = @($c.steps | ForEach-Object {
            [ordered]@{
                g = $_.g; id = $_.id; type = $_.type; lv = $_.lv; title = $_.title; now = $_.now; done = $_.done
                map = $(if ($_.map) { $_.map } else { $_.where }); boss = $_.boss; route = (NaviSpot $_)
                mobs = @($_.mobs | Where-Object { $_ } | ForEach-Object { @{ id = $_[0]; name = $_[1]; count = $_[2] } })
                items = @($_.items | Where-Object { $_ } | ForEach-Object { @{ id = $_[0]; name = $_[1]; count = $_[2] } })
                hint = @($_.hint | Where-Object { $_ } | ForEach-Object { Ascii $_ 'hint' })
                spots = @($_.spots | Where-Object { $_ } | ForEach-Object { [ordered]@{ map = $_.map; x = $_.x; y = $_.y; name = (Ascii $_.name 'spot'); sw = $_.sw } })
            } })
    }
}
$js.sides = @()
foreach ($sd in $sides) {
    $c = $chapters[$sd.ch - 1]
    $js.sides += [ordered]@{
        n = $sd.n; ch = $sd.ch; hook = $sd.hook; title = $sd.title; range = $sd.range; intro = $sd.intro; ro = [bool]$sd.ro
        npc = $(if ($sd.npc) { $sd.npc } else { $c.npc }); town = $(if ($sd.npc) { $sd.townName } else { $c.townName }); townMap = $(if ($sd.npc) { $sd.town } else { $c.town })
        x = $(if ($sd.npc) { $sd.x } else { $c.x }); y = $(if ($sd.npc) { $sd.y } else { $c.y })
        costumes = @($icons[[int]$sd.costume[0]].name, $icons[[int]$sd.costume[1]].name); zeny = $sd.zeny
        failText = $(if ($sd.failText) { Ascii $sd.failText 'fail' } else { $null })
        steps = @($sideSteps | Where-Object { $_.sn -eq $sd.n } | ForEach-Object {
            [ordered]@{
                k = $_.k; type = $_.type; label = $_.label; any = [bool]$_.any; minLv = $_.minLv; maxLv = $_.maxLv; alt = [bool]$_.alt; title = $_.title; now = $_.now; done = $_.done
                map = $(if ($_.map) { $_.map } else { $_.where }); boss = $_.boss; route = (SideSpot $_)
                mobs = @($_.mobs | Where-Object { $_ } | ForEach-Object { @{ id = $_[0]; name = $_[1]; count = $_[2] } })
                items = @($_.items | Where-Object { $_ } | ForEach-Object { @{ id = $_[0]; name = $_[1]; count = $_[2] } })
                hint = @($_.hint | Where-Object { $_ } | ForEach-Object { Ascii $_ 'hint' })
                spots = @($_.spots | Where-Object { $_ } | ForEach-Object { [ordered]@{ map = $_.map; x = $_.x; y = $_.y; name = (Ascii $_.name 'spot'); ro = $_.ro } })
                parts = @($_.parts | Where-Object { $_ } | ForEach-Object { [ordered]@{ at = $_.at; name = (Ascii $_.name 'part')
                    route = $(if ($_.route) { [ordered]@{ map = $_.route[0]; x = $_.route[1]; y = $_.route[2]; name = (Ascii $_.route[3] 'part route') } } else { $null }) } })
            } })
    }
}
if ($guides.Count) {
    $js.guides = @($guides | ForEach-Object {
        [ordered]@{
            key = $_.key; ch = $_.ch; hook = $_.hookPos; title = (Ascii $_.title 'guide title'); range = $_.range; intro = (Ascii $_.intro 'guide intro')
            where = (Ascii $_.where 'guide where'); mod = $_.mod; reward = $(if ($_.reward) { Ascii $_.reward 'guide reward' } else { $null })
            steps = @($_.steps | ForEach-Object {
                [ordered]@{
                    k = $_.k; type = 'ro'; label = $_.label; any = [bool]$_.any; minLv = $_.minLv; title = (Ascii $_.title 'guide step'); now = (Ascii $_.now 'guide now'); done = (Ascii $_.done 'guide done')
                    route = $(if ($_.route) { [ordered]@{ map = $_.route[0]; x = $_.route[1]; y = $_.route[2]; name = (Ascii $_.route[3] 'route') } } else { $null })
                    items = @($_.items | Where-Object { $_ } | ForEach-Object { @{ id = $_[0]; name = $_[1]; count = $_[2] } })
                    hint = @($_.hint | Where-Object { $_ } | ForEach-Object { Ascii $_ 'hint' })
                    spots = @($_.spots | Where-Object { $_ } | ForEach-Object { [ordered]@{ map = $_.map; x = $_.x; y = $_.y; name = (Ascii $_.name 'spot'); ro = $_.ro } })
                    parts = @($_.parts | Where-Object { $_ } | ForEach-Object { [ordered]@{ at = $_.at; name = (Ascii $_.name 'part')
                        route = $(if ($_.route) { [ordered]@{ map = $_.route[0]; x = $_.route[1]; y = $_.route[2]; name = (Ascii $_.route[3] 'part route') } } else { $null }) } })
                } })
        } })
}
$js.mvps = @($side.mvps | ForEach-Object { [ordered]@{ id = $_.id; name = $_.name; where = $_.where; map = $_.map; lv = $_.lv; g = $_.g; side = $_.side; k = $_.k } })
$rk = 0
$js.ranks = @($side.ranks | ForEach-Object { $rk++; [ordered]@{ need = $_.need; name = $_.name; item = $rankItem[$rk]; hat = $icons[[int]$_.base].name; stat = $_.stat } })
$json = $js | ConvertTo-Json -Depth 8
[IO.File]::WriteAllText((Join-Path $out 'client\data.js'), "// GENERATED by tools/build.ps1 from tools/story.ps1.`nexport default $json;`n", $utf8)

"Built ${era}: $($steps.Count) steps in $($chapters.Count) chapters, $($sides.Count) Side Quests ($($sideSteps.Count) steps), $($side.mvps.Count) MVPs, $($guides.Count) RO quest guides, items 50100-$id."
}
