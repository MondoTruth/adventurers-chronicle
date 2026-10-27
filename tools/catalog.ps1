# Adventurer's Chronicle: Rune-Midgard's own side quests on Renewal (the
# Side Quests tab's catalog, concept v3). build.ps1 reads this on Renewal.
#
# Nothing here is written by hand except the conditions below: the regions,
# storylines, quests, steps, /navi spots, rewards, tags and links all come
# from the docs, read at build time:
#   ro-quest-steps.md    the quests and their steps (the order of the tab)
#   ro-quest-catalog.md  the storylines, tags and needs/opens/closes links
#   guide-deferred.md    why a dead end is one
# Fix a doc, run build.ps1, and the tab follows.
#
# A step is ticked from its "done when": `var >= N`, `var == N`, `var` A or B,
# `var` A-B, `VAR & N` and "quest N done/started/active" are read as they
# stand. $conds gives the condition of the others ('' = the Journal can't
# check it: the step ticks when a later one is done). The Journal's current
# step is the one after the last step whose condition holds; a quest is done
# when its last step holds. Quests here stamp no Passport (MondoTruth,
# 2026-10-27): RO's own variables are the only record.

# "<region>|<quest title>|<step>" -> rAthena condition ('' = none).
$conds = @{
    '1|Help Me Shorty|5' = ''	# "quest 14694 gone and no Help Me Shorty item"
    '11|The Cursed Spirit Quest|2' = 'lhz_spi01 == 1 && lhz_spi02 == 1 && lhz_spi03 == 1 && lhz_spi04 == 1'
    '12|The Fish Cake Soup Delivery|3' = ''	# "hg_odeng == 0 after 10": 0 is also before the start
    '23|Frede''s Request|6' = 'checkquest(11165) >= 0 && checkquest(11166) >= 0 && checkquest(11167) >= 0 && checkquest(11168) >= 0 && checkquest(11169) >= 0 && checkquest(11170) >= 0'
    '27|The Wandering Bard|1' = 'checkquest(4297) >= 0 || checkquest(4298) >= 0 || checkquest(4299) >= 0 || checkquest(4300) >= 0 || checkquest(4301) >= 0 || checkquest(4302) >= 0'
    '27|The Verus Police|2' = 'checkquest(5310) >= 0 && checkquest(5311) >= 0 && checkquest(5312) >= 0 && checkquest(5313) >= 0'
    '28|The town''s jobs (food, vigilantes, water, the merchant)|3' = 'checkquest(12390) >= 0 || checkquest(12398) >= 0'
    '28|Mrs. McPhy and Spotty|1' = 'checkquest(1329) >= 0'
    '29|Juperos: Leader Maxim''s camp|1' = 'checkquest(21356) >= 0 || checkquest(21358) >= 0 || checkquest(21352) >= 0 || checkquest(21354) >= 0'
}

$here = $PSScriptRoot

function Join-Para([string[]]$lines) { (($lines | ForEach-Object { $_.Trim() }) -join ' ').Trim() }
# A title as both docs can write it: no "The", no brackets, letters and digits.
function Norm([string]$t) {
    $t = $t.ToLower() -replace '\([^)]*\)', '' -replace '\*', '' -replace '^\s*the\s+', ''
    $t -replace '[^a-z0-9]', ''
}
function Words([string]$t) { (@($t.ToLower() -replace '\([^)]*\)', '' -split '[^a-z0-9]+' | Where-Object { $_ -and $_ -ne 'the' }) | Sort-Object) -join ' ' }
# Text for the player: the docs' pointer to guide-deferred.md becomes one to
# the quest's own dead-end note.
function Player([string]$t) { $t -replace ',? see guide-deferred\.md', ', see the dead-end note of this quest' -replace 'guide-deferred\.md', 'the dead-end note of this quest' }

# ---- ro-quest-catalog.md: storylines, tags, links ----
$catalog = @{}	# region n -> list of entries { names, storyline, text }
$region = 0; $story = $null; $cur = $null
foreach ($line in Get-Content (Join-Path $here 'ro-quest-catalog.md')) {
    if ($line -match '^## (\d+)\. ') { $region = [int]$Matches[1]; $story = $null; $cur = $null; $catalog[$region] = [Collections.ArrayList]@(); continue }
    if ($line -match '^## ') { $region = 0; $cur = $null; continue }
    if (-not $region) { continue }
    if ($line -match '^### Storyline: (.+)$') { $story = $Matches[1].Trim(); $cur = $null; continue }
    if ($line -match '^### ') { $story = $null; $cur = $null; continue }
    if ($line -match '^- \*\*') {
        $cur = @{ storyline = $story; lines = [Collections.ArrayList]@($line.Substring(2)) }
        [void]$catalog[$region].Add($cur)
        continue
    }
    if ($cur -and $line -match '^\s+\S') { [void]$cur.lines.Add($line); continue }
    $cur = $null
}
foreach ($list in $catalog.Values) {
    foreach ($e in $list) {
        $e.text = Join-Para $e.lines
        $e.names = @([regex]::Matches($e.text, '\*\*(.+?)\*\*') | ForEach-Object { Norm $_.Groups[1].Value } | Where-Object { $_ })
        $e.words = @([regex]::Matches($e.text, '\*\*(.+?)\*\*') | ForEach-Object { Words $_.Groups[1].Value })
    }
}

# What a catalog entry says about its quest: the line, the tags, the links.
function EntryInfo($e) {
    $t = $e.text
    $info = @{ tags = [ordered]@{}; links = @() }
    # The line: after "**Title** - ", up to the script's file or the first " | ".
    $line = $t -replace '^(\*\*.+?\*\*[^-]*?) - ', ''
    if ($line -ne $t) {
        $line = ($line -split '\s`|\s\|\s|\s(?:same file|quests? \d)')[0].Trim()
        # Cut inside brackets: back to the last whole sentence.
        if (([regex]::Matches($line, '\(')).Count -gt ([regex]::Matches($line, '\)')).Count -and $line.LastIndexOf('. ') -gt 0) { $line = $line.Substring(0, $line.LastIndexOf('. ')) }
        # Nothing but the script's file: the words in brackets after the title.
        if (-not $line -or $line -match '^(`|same file|quests \d)') { $line = $(if ($t -match '^\*\*.+?\*\* \(([^)]+)\)') { $Matches[1] } else { '' }) }
        $line = $line -replace '[\s.]+$', ''
        if ($line) { $info.line = $line.Substring(0, 1).ToUpper() + $line.Substring(1) + $(if ($line -match '[?!]$') { '' } else { '.' }) }
    }
    if ($t -match '\bparty (\d+)') { $info.tags.players = [int]$Matches[1] }
    if ($t -match '\brepeatable\b') { $info.tags.repeatable = $true }
    if ($t -match '(?<!not a )\bdead end\b') { $info.tags.deadEnd = $true }
    if ($t -match '\bneeds a mod\b') { $info.tags.mod = $true }
    if ($t -match '\bopens a place\b') { $info.tags.place = $true }
    if ($t -match '\bguided `?([a-z0-9_]+)') { $info.tags.guided = $Matches[1] }
    if ($t -match '\bside (\d+)\b') { $info.tags.side = [int]$Matches[1] }
    # needs / opens / closes / makes unnecessary, each to the next " | " or ";".
    foreach ($m in [regex]::Matches($t, '(?:^|\|\s*|;\s*)((?:needs|opens(?: a place)?|closes|makes unnecessary):\s*[^|]+)')) {
        $info.links += $m.Groups[1].Value.Trim().TrimEnd('.', ' ') -replace '\s+', ' '
    }
    $info
}

# ---- guide-deferred.md: why a dead end is one ----
$deferred = @()
foreach ($line in Get-Content (Join-Path $here 'guide-deferred.md')) {
    if ($line -notmatch '^\| [^-|]') { continue }
    $f = $line.Trim('|').Split('|') | ForEach-Object { $_.Trim() }
    if ($f[0] -match '^Quest') { continue }
    $deferred += @{ names = @(($f[0] -split '\band\b|,|:') | ForEach-Object { Norm ($_ -replace '`[^`]*`', '') } | Where-Object { $_.Length -ge 6 }); why = $f[2]; fix = $f[3] }
}

# ---- conditions ----
# A "done when" as an rAthena condition, or $null when it isn't one of the
# plain forms.
function AutoCond([string]$d) {
    $d = $d.Trim()
    # A runner of the Party Relay: "Swordman `party_relay >= 6`".
    $d = $d -replace '^(leader|runner|Swordman|Mage|Acolyte|Archer|Thief|Merchant) (?=`)', ''
    if ($d -match '^`([A-Za-z_][A-Za-z0-9_]*) (>=|==|>) (-?\d+)`(.*)$') {
        $v = $Matches[1]; $c = "$v $($Matches[2]) $($Matches[3])"; $rest = $Matches[4]
        # "... or `v == M`" / "... or `== M`": other values that also mean done.
        while ($rest -match '^\s*or `(?:([A-Za-z_][A-Za-z0-9_]*) )?(==|>=) (-?\d+)`(.*)$') {
            $w = $(if ($Matches[1]) { $Matches[1] } else { $v })
            $c = "$c || $w $($Matches[2]) $($Matches[3])"; $rest = $Matches[4]
        }
        if ($rest -match '^\s*(or|and)\b') { return $null }
        return $c
    }
    if ($d -match '^`([A-Za-z_][A-Za-z0-9_]*) & (\d+)`') { return "$($Matches[1]) & $($Matches[2])" }
    # Standing on a map: done while you are there (a later step keeps it ticked).
    if ($d -match '^(?:on|inside|you stand in) `([a-z0-9_]+)`$') { return "strcharinfo(3) == `"$($Matches[1])`"" }
    # Brackets out: "`prt_curse` 35 (told Rodafrian), 44 (did not tell) or 54".
    $p = $d
    while ($p -match '\([^()]*\)') { $p = $p -replace '\s*\([^()]*\)', '' }
    $p = $p.Trim()
    if ($p -match '^`([A-Za-z_][A-Za-z0-9_]*)` (?:is )?(-?\d+)(?: ?(?:-|to) ?(-?\d+))?$') {
        $v = $Matches[1]
        if ($Matches[3]) { return "$v >= $($Matches[2]) && $v <= $($Matches[3])" }
        return "$v == $($Matches[2])"
    }
    if ($p -match '^`([A-Za-z_][A-Za-z0-9_]*)` (?:is )?((?:-?\d+, )*-?\d+ or -?\d+)$') {
        $v = $Matches[1]
        return (($Matches[2] -split ', | or ') | ForEach-Object { "$v == $_" }) -join ' || '
    }
    if ($p -match '^quests? (\d+)((?: (?:or|and) \d+)*) (done|started|active)$') {
        $test = @{ done = '== 2'; started = '>= 0'; active = '>= 1' }[$Matches[3]]
        $ids = @($Matches[1]) + @([regex]::Matches($Matches[2], '\d+') | ForEach-Object { $_.Value })
        $join = $(if ($Matches[2] -match ' and ') { ' && ' } else { ' || ' })
        return (($ids | ForEach-Object { "checkquest($_) $test" }) -join $join)
    }
    $null
}

# ---- ro-quest-steps.md: regions, quests, steps ----
$labels = '^(Why|Reward[^:]{0,25}|Fails?|Opens(?: a place)?|Notes?|Branch(?:es)?(?: / fails)?(?: \([^)]*\))?|Repeat|Needs|Warning|To verify|Blocker|Again|Daily|Closes|Menu path|Path \d+|Players):\s*'
$regions = [Collections.ArrayList]@()
$R = $null; $Q = $null; $S = $null; $group = $null
$para = [Collections.ArrayList]@()
$mode = 'none'	# where plain lines go: about (before step 1), after (after the steps), group (a ### with #### quests)
function FlushPara {
    if (-not $para.Count) { return }
    $text = Player (Join-Para $para)
    $para.Clear()
    if ($mode -eq 'group' -and $group) { $group.intro += $text }
    elseif ($Q -and $mode -eq 'about') { $Q.about += $text }
    elseif ($Q) { $Q.after += $text }
}
function NewQuest([string]$title) {
    $script:Q = @{ title = $title.Trim(); about = @(); after = @(); steps = [Collections.ArrayList]@(); group = $group; entries = @() }
    [void]$R.quests.Add($Q)
    $script:S = $null
    $script:mode = 'about'
}
$lines = @(Get-Content (Join-Path $here 'ro-quest-steps.md')) + '## END'
for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    if ($line -match '^## ') {
        FlushPara
        if ($line -match '^## (\d+)\. (.+)$') {
            $R = @{ n = [int]$Matches[1]; title = $Matches[2].Trim(); quests = [Collections.ArrayList]@() }
            [void]$regions.Add($R)
        } elseif ($line -match '^## Entrances') {
            $R = @{ n = 0; title = 'Entrances without a quest'; quests = [Collections.ArrayList]@(); entrances = $true }
            [void]$regions.Add($R)
        } else { $R = $null }
        $Q = $null; $S = $null; $group = $null; $mode = 'none'
        continue
    }
    if (-not $R) { continue }
    if ($line -match '^### (.+)$') {
        FlushPara
        $title = $Matches[1].Trim()
        # A ### whose quests are ####s is a storyline of its own.
        $sub = $false
        for ($j = $i + 1; $j -lt $lines.Count; $j++) {
            if ($lines[$j] -match '^#### ') { $sub = $true; break }
            if ($lines[$j] -match '^#{2,3} |^\d+\. ') { break }
        }
        if ($sub) { $group = @{ title = $title; intro = @() }; $Q = $null; $S = $null; $mode = 'group' }
        else { $group = $null; NewQuest $title }
        continue
    }
    if ($line -match '^#### (.+)$') { FlushPara; NewQuest $Matches[1]; continue }
    # The entrances: one bullet each, no steps.
    if ($R.entrances) {
        if ($line -match '^- \*\*(.+?)\*\*\s*(.*)$') {
            FlushPara
            NewQuest $Matches[1]
            [void]$para.Add(($Matches[2] -replace '^-\s*', ''))
        } elseif ($line.Trim()) { [void]$para.Add($line) } else { FlushPara }
        continue
    }
    if ($Q -and $line -match '^(\d+)\. \*\*(.+?)\*\*(.*)$') {
        FlushPara
        $k = [int]$Matches[1]; $title = $Matches[2]; $rest = $Matches[3]
        if ($rest -match '^\s*(\([^)]*\))\s*-\s*(.*)$') { $title += " $($Matches[1])"; $rest = $Matches[2] }
        $rest = $rest -replace '^\s*-\s*', ''
        $S = @{ k = $k; title = $title.Trim(); raw = [Collections.ArrayList]@(); }
        if ($rest.Trim()) { [void]$S.raw.Add($rest.Trim()) } else { [void]$S.raw.Add('') }
        [void]$Q.steps.Add($S)
        $mode = 'steps'
        continue
    }
    if ($S -and $mode -eq 'steps' -and $line -match '^\s+\S') { [void]$S.raw.Add($line); continue }
    if (-not $line.Trim()) { FlushPara; continue }
    if ($mode -eq 'steps') { $mode = 'after'; $S = $null }
    [void]$para.Add($line)
}

# A step's lines: what to do, then one line per label (Why, Reward, ...), the
# /navi and "done when" line, and bullets.
foreach ($R in $regions) {
    foreach ($Q in $R.quests) {
        foreach ($S in $Q.steps) {
            $logical = [Collections.ArrayList]@()
            $first = $true
            foreach ($l in $S.raw) {
                $t = $l.Trim()
                $new = $first -or $t -match $labels -or $t -match '^(`/navi|\| done when|done when:)' -or $t -match '^- '
                if ($new) { [void]$logical.Add(@($t)) } else { $logical[$logical.Count - 1] += $t }
                $first = $false
            }
            $S.lines = @()
            $S.navi = @()
            foreach ($lg in $logical) {
                $t = Join-Para $lg
                if (-not $t) { continue }
                if ($t -match '^(.*?)\|?\s*done when:\s*(.*)$') {
                    $before = $Matches[1].Trim().TrimEnd('|').Trim()
                    $S.done = Player $Matches[2].Trim()
                    if ($before) { $S.lines += , @('Go', (Player $before)) }
                    continue
                }
                if ($t -match $labels) { $S.lines += , @($Matches[1], (Player ($t -replace $labels, ''))); continue }
                $S.lines += , @('', (Player $t))
            }
            $S.Remove('raw')
        }
    }
}

# Storylines, tags and links from the catalog; dead-end notes; conditions.
$out = @()
$qi = 0
$missing = @()
$used = @{}
foreach ($R in $regions) {
    $entries = $(if ($catalog.ContainsKey($R.n)) { $catalog[$R.n] } else { @() })
    $stories = [ordered]@{}
    foreach ($Q in $R.quests) {
        $qi++
        $Q.i = $qi
        $n = Norm $Q.title
        $match = @($entries | Where-Object { $_.names -contains $n })
        if (-not $match.Count) { $match = @($entries | Where-Object { $e = $_; @($e.names | Where-Object { $_.Length -ge 6 -and ($n.Contains($_) -or $_.Contains($n)) }).Count }) }
        # The same words in another order ("Pyramid nightmare hunts").
        if (-not $match.Count) { $w = Words $Q.title; $match = @($entries | Where-Object { @($_.words) -contains $w }) }
        if (-not $match.Count -and $Q.group) { $match = @($entries | Where-Object { $_.names -contains (Norm $Q.group.title) }) }
        $story = $(if ($Q.group) { $Q.group.title } elseif ($match.Count -and $match[0].storyline) { $match[0].storyline } else { '' })
        $tags = [ordered]@{}; $links = @(); $line = $null
        foreach ($e in $match) {
            $info = EntryInfo $e
            foreach ($k in $info.tags.Keys) { $tags[$k] = $info.tags[$k] }
            $links += $info.links
            if (-not $line -and -not $Q.group) { $line = $info.line }
        }
        if (-not $match.Count -and -not $R.entrances) { $missing += "$($R.n): $($Q.title)" }
        # "Players: N" in the steps doc's own text.
        if (-not $tags.Contains('players') -and (($Q.about -join ' ') -match '\*\*Players: (\d+)\*\*')) { $tags.players = [int]$Matches[1] }
        if ($R.n -eq 29) { $tags.mod = $true }
        $dead = $null
        if ($tags.deadEnd -or (($Q.steps | ForEach-Object { $_.lines | ForEach-Object { $_[1] } }) -join ' ') -match '(?<!not a )\b[Dd]ead end\b') {
            $tags.deadEnd = $true
            $d = $deferred | Where-Object { $dn = $_.names; @($dn | Where-Object { $n.Contains($_) -or $_.Contains($n) }).Count } | Select-Object -First 1
            if ($d) { $dead = "$(Player $d.why) Could open it: $(Player $d.fix)" -replace '`', '' }
        }
        $k = 0
        foreach ($S in $Q.steps) {
            $k++
            if ($S.k -ne $k) { throw "Region $($R.n), $($Q.title): step $k is numbered $($S.k)" }
            $key = "$($R.n)|$($Q.title)|$k"
            if ($conds.ContainsKey($key)) { $S.cond = $conds[$key]; $used[$key] = $true }
            elseif ($S.done) { $S.cond = AutoCond $S.done }
            if (-not $S.cond) { $S.cond = '' }
        }
        $sk = $(if ($story) { $story } else { '' })
        if (-not $stories.Contains($sk)) { $stories[$sk] = @{ title = $story; intro = $(if ($Q.group) { $Q.group.intro -join ' ' } else { '' }); quests = @() } }
        $stories[$sk].quests += [ordered]@{
            i = $Q.i; title = $Q.title; line = $line; tags = $tags; links = @($links | Select-Object -Unique)
            about = @($Q.about); after = @($Q.after); dead = $dead
            steps = @($Q.steps | ForEach-Object { [ordered]@{ k = $_.k; title = (Player $_.title); lines = @($_.lines | ForEach-Object { , @($_[0], $_[1]) }); done = $_.done; cond = $_.cond } })
        }
    }
    # Storylines first, in the order they come; single quests last.
    $keys = @($stories.Keys | Where-Object { $_ }) + @($stories.Keys | Where-Object { -not $_ })
    $out += [ordered]@{ n = $R.n; title = $R.title; entrances = [bool]$R.entrances
        storylines = @($keys | ForEach-Object { $s = $stories[$_]; [ordered]@{ title = $s.title; intro = $s.intro; quests = @($s.quests) } }) }
}

foreach ($key in $conds.Keys) { if (-not $used[$key]) { throw "No step '$key' in ro-quest-steps.md for its condition" } }

@{ regions = $out; quests = $qi; missing = $missing }
