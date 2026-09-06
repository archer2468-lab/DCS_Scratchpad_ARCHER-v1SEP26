-- F18_JTAC_Carrier_Checklists.lua
-- DCS Scratchpad extension for the DCS F/A-18C Hornet
--
-- Adds:
--   * JTAC 9-Line
--   * Startup / Taxi / Takeoff / Fence / AAR / Landing / Notes
--   * Carrier Launch
--   * CASE I
--   * CASE II
--   * CASE III
--   * Marshal
--   * Overhead Break
--   * ACLS / ICLS setup
--   * A/A attack flow
--   * A/G attack flow
--   * F10 coordinate capture into JTAC Line 6
--
-- Install:
--   Saved Games\DCS\Scripts\Scratchpad\Extensions\F18_JTAC_Carrier_Checklists.lua
--
-- Simulator aid only. Adapt wording, numbers, comms and procedures to your
-- squadron/server SOP and current DCS implementation.

local PAGE = {
    JTAC      = "JTAC 9-LINE",
    START     = "F/A-18 START",
    TO        = "F/A-18 T/O",
    FENCEIN   = "FENCE IN",
    AAR       = "AAR",
    FENCEOUT  = "FENCE OUT",
    LAND      = "LAND/SHDN",
    NOTES     = "NOTES",
    LAUNCH    = "CARRIER LAUNCH",
    CASE1     = "CASE I",
    CASE2     = "CASE II",
    CASE3     = "CASE III",
    MARSHAL   = "MARSHAL",
    BREAK     = "OVERHEAD BREAK",
    ACLS      = "ACLS / ICLS",
    AA        = "A/A ATTACK FLOW",
    AG        = "A/G ATTACK FLOW",
}

local lastCoord = nil
local activePage = PAGE.JTAC

local function join(lines)
    return table.concat(lines, "\n")
end

local function pageHeader(title)
    return join({
        "======================================",
        " " .. title,
        "======================================",
        ""
    })
end

local function jtacPage()
    return pageHeader("JTAC 9-LINE") .. join({
        "CALLSIGN: __________  TYPE: __________",
        "",
        "1. IP/BP:",
        "   _________________________________",
        "2. HEADING / OFFSET:",
        "   _________________________________",
        "3. DISTANCE:",
        "   _________________________________",
        "4. TARGET ELEVATION:",
        "   _________________________________",
        "5. TARGET DESCRIPTION:",
        "   _________________________________",
        "6. TARGET LOCATION:",
        "   _________________________________",
        "7. MARK:",
        "   _________________________________",
        "8. FRIENDLIES:",
        "   _________________________________",
        "9. EGRESS:",
        "   _________________________________",
        "",
        "REMARKS / RESTRICTIONS:",
        "____________________________________",
        "____________________________________",
        "",
        "FINAL ATTACK HDG: _________________",
        "LASER CODE: ______  TOT/TTT: ______",
        "ABORT CODE: _______________________",
        "",
        "READBACK:",
        "[ ] IP/BP",
        "[ ] HDG/OFFSET",
        "[ ] DIST",
        "[ ] ELEV",
        "[ ] TARGET",
        "[ ] GRID",
        "[ ] MARK",
        "[ ] FRIENDLIES",
        "[ ] EGRESS",
    })
end

local function startupPage()
    return pageHeader("F/A-18C - STARTUP") .. join({
        "[ ] PARKING BRAKE - SET",
        "[ ] BATTERY - ON",
        "[ ] FIRE TEST - COMPLETE",
        "[ ] APU - ON / READY",
        "[ ] CRANK - RIGHT",
        "[ ] RIGHT THROTTLE - IDLE",
        "[ ] RIGHT GEN / HYD - CHECK",
        "[ ] CRANK - LEFT",
        "[ ] LEFT THROTTLE - IDLE",
        "[ ] LEFT GEN / HYD - CHECK",
        "[ ] APU - OFF",
        "",
        "[ ] OBOGS - ON",
        "[ ] BLEED AIR - NORM",
        "[ ] FCS RESET - PRESS",
        "[ ] FCS BIT - COMPLETE",
        "[ ] FLAPS - HALF",
        "[ ] TRIM - SET",
        "[ ] ANTI-SKID - ON (FIELD)",
        "[ ] HOOK BYPASS - FIELD/CARRIER",
        "",
        "[ ] INS - GND / CV",
        "[ ] ALIGNMENT - COMPLETE",
        "[ ] INS - NAV",
        "[ ] RADAR - OPR",
        "[ ] RWR - ON",
        "[ ] EW / DISPENSE - SET",
        "[ ] DATALINK - ON / SET",
        "[ ] TACAN - SET",
        "[ ] ILS / ICLS - AS REQUIRED",
        "[ ] COMM 1 / COMM 2 - SET",
        "[ ] HMD - ALIGN / SET",
        "",
        "[ ] STORES / SMS - CHECK",
        "[ ] MASTER ARM - SAFE",
        "[ ] LASER ARM - SAFE",
        "[ ] BINGO - SET",
        "[ ] BARO / ALT - SET",
        "[ ] CANOPY - CLOSED / LOCKED",
    })
end

local function takeoffPage()
    return pageHeader("F/A-18C - TAXI / TAKEOFF") .. join({
        "BEFORE TAXI",
        "[ ] CHOCKS - REMOVED",
        "[ ] NWS - CHECK",
        "[ ] BRAKES - CHECK",
        "[ ] FLIGHT CONTROLS - FREE/CORRECT",
        "[ ] FLAPS - HALF",
        "[ ] TRIM - SET",
        "[ ] DDIs / MPCD - SET",
        "[ ] TACAN / WAYPOINT - SET",
        "",
        "BEFORE TAKEOFF",
        "[ ] CANOPY - CLOSED / LOCKED",
        "[ ] HARNESS - SET",
        "[ ] EJECTION SEAT - ARMED",
        "[ ] ANTI-SKID - AS REQUIRED",
        "[ ] HOOK - UP",
        "[ ] SPEED BRAKE - IN",
        "[ ] FLAPS - HALF",
        "[ ] TRIM - CHECK",
        "[ ] FCS - CHECK",
        "[ ] MASTER ARM - SAFE",
        "[ ] RADAR - AS REQUIRED",
        "[ ] RWR / DATALINK - ON",
        "[ ] BINGO - SET",
        "[ ] DEPARTURE / ALTITUDE - REVIEW",
        "",
        "TAKEOFF",
        "[ ] THROTTLES - MIL / MAX",
        "[ ] ENGINE INSTRUMENTS - CHECK",
        "[ ] FLY DEPARTURE",
        "[ ] GEAR - UP",
        "[ ] FLAPS - AUTO",
    })
end

local function fenceInPage()
    return pageHeader("F/A-18C - FENCE IN") .. join({
        "[ ] MASTER ARM - ARM",
        "[ ] A/A OR A/G MODE - SET",
        "[ ] STORES - VERIFY",
        "[ ] FUZING - VERIFY",
        "[ ] LASER CODE - VERIFY",
        "[ ] LASER ARM - AS REQUIRED",
        "[ ] RADAR - SET",
        "[ ] RWR - ON",
        "[ ] EW / DISPENSE - SET",
        "[ ] DATALINK - ON",
        "[ ] HMD - ON / SET",
        "[ ] TACAN / WP / TGT - SET",
        "[ ] ALTITUDE SOURCE - SET",
        "[ ] BINGO / JOKER - CHECK",
        "[ ] EXT LIGHTS - OFF / AS REQUIRED",
        "[ ] FORMATION / COMMS - CHECK",
        "",
        "WEAPONS / SENSOR QUICK CHECK",
        "[ ] A/A: AIM-9 / AIM-120 / GUN",
        "[ ] A/G: STORES / PROFILE / QTY",
        "[ ] FLIR / TGP - AS REQUIRED",
        "[ ] LTD/R / LST - AS REQUIRED",
        "[ ] SA PAGE - REVIEW",
    })
end

local function aarPage()
    return pageHeader("F/A-18C - A/A REFUEL") .. join({
        "[ ] TACAN / TANKER - SET",
        "[ ] RADIO - TANKER FREQ",
        "[ ] MASTER ARM - SAFE",
        "[ ] RADAR - STBY / AS REQUIRED",
        "[ ] EXT LIGHTS - AS REQUIRED",
        "[ ] PROBE - EXTEND",
        "[ ] FUEL PAGE - MONITOR",
        "",
        "PRE-CONTACT",
        "[ ] STABILIZE BEHIND BASKET",
        "[ ] TRIM - MINIMIZE",
        "[ ] SMALL THROTTLE INPUTS",
        "[ ] SMALL STICK INPUTS",
        "",
        "CONTACT",
        "[ ] FLY FORMATION ON TANKER",
        "[ ] MAINTAIN PLUG POSITION",
        "[ ] MONITOR FUEL",
        "",
        "DISCONNECT",
        "[ ] MOVE AFT / CLEAR",
        "[ ] PROBE - RETRACT",
        "[ ] LIGHTS - RESET",
        "[ ] MASTER ARM - AS REQUIRED",
        "[ ] REJOIN / DEPART",
    })
end

local function fenceOutPage()
    return pageHeader("F/A-18C - FENCE OUT / RECOVERY") .. join({
        "[ ] MASTER ARM - SAFE",
        "[ ] LASER ARM - SAFE",
        "[ ] STORES - SAFE / REVIEW",
        "[ ] RADAR - AS REQUIRED",
        "[ ] EW / DISPENSE - SAFE/SET",
        "[ ] RWR - ON",
        "[ ] LIGHTS - AS REQUIRED",
        "[ ] TACAN - RECOVERY",
        "[ ] ILS / ICLS - SET",
        "[ ] COMM - RECOVERY FREQ",
        "[ ] BINGO / FUEL - CHECK",
        "[ ] WAYPOINT / COURSE - SET",
        "[ ] ALTIMETER - SET",
    })
end

local function landingPage()
    return pageHeader("F/A-18C - LANDING / SHUTDOWN") .. join({
        "LANDING",
        "[ ] MASTER ARM - SAFE",
        "[ ] GEAR - DOWN / 3 GREEN",
        "[ ] FLAPS - FULL",
        "[ ] SPEED BRAKE - AS REQUIRED",
        "[ ] HOOK - AS REQUIRED",
        "[ ] ANTI-SKID - FIELD / OFF CARRIER",
        "[ ] NWS - READY",
        "[ ] AOA - ON SPEED",
        "",
        "AFTER LANDING",
        "[ ] FLAPS - AUTO / HALF AS REQUIRED",
        "[ ] SPEED BRAKE - IN",
        "[ ] HOOK - UP",
        "[ ] EJECTION SEAT - SAFE",
        "[ ] RADAR - STBY",
        "[ ] MASTER ARM - SAFE",
        "[ ] LASER ARM - SAFE",
        "",
        "SHUTDOWN",
        "[ ] PARKING BRAKE - SET",
        "[ ] INS - OFF",
        "[ ] OBOGS - OFF",
        "[ ] LEFT THROTTLE - OFF",
        "[ ] RIGHT THROTTLE - OFF",
        "[ ] BATTERY - OFF",
    })
end

local function notesPage()
    return pageHeader("F/A-18C - QUICK NOTES") .. join({
        "MISSION:",
        "____________________________________",
        "PACKAGE / CALLSIGNS:",
        "____________________________________",
        "COMMS:",
        "PRI: __________  SEC: __________",
        "AWACS: ________  JTAC: _________",
        "TANKER: _______  GUARD: ________",
        "NAV:",
        "WP: ____  TACAN: ____  CRS: ____",
        "FUEL:",
        "JOKER: ______  BINGO: ______",
        "WEAPONS:",
        "____________________________________",
        "TARGET / GRID:",
        "____________________________________",
        "THREATS:",
        "____________________________________",
    })
end

local function carrierLaunchPage()
    return pageHeader("F/A-18C - CARRIER LAUNCH") .. join({
        "DECK / START",
        "[ ] HOOK BYPASS - CARRIER",
        "[ ] ANTI-SKID - OFF",
        "[ ] LAUNCH BAR - RETRACT UNTIL DIRECTED",
        "[ ] WINGS - SPREAD / LOCKED",
        "[ ] FLAPS - HALF",
        "[ ] TRIM - SET",
        "[ ] FCS - CHECK",
        "[ ] NWS - AS REQUIRED",
        "",
        "CATAPULT",
        "[ ] LAUNCH BAR - EXTEND",
        "[ ] TAXI ONTO CAT",
        "[ ] LAUNCH BAR - RETRACT AFTER ENGAGEMENT",
        "[ ] HOLD BACK / SHUTTLE - CONFIRM",
        "[ ] WINGS - LOCKED",
        "[ ] FLAPS - HALF",
        "[ ] TRIM - VERIFY",
        "[ ] CONTROLS - WIPEOUT",
        "[ ] MASTER ARM - SAFE",
        "[ ] HUD / DDI - SET",
        "[ ] FINAL SALUTE WHEN READY",
        "",
        "LAUNCH",
        "[ ] THROTTLES - MIL / MAX AS REQUIRED",
        "[ ] ENGINE INSTRUMENTS - CHECK",
        "[ ] HANDS OFF UNTIL FLYING",
        "[ ] GEAR - UP",
        "[ ] FLAPS - AUTO",
        "[ ] JOIN DEPARTURE",
    })
end

local function case1Page()
    return pageHeader("F/A-18C - CASE I RECOVERY") .. join({
        "ENTRY",
        "[ ] WEATHER / CASE - CONFIRM",
        "[ ] TACAN / COMM - SET",
        "[ ] MASTER ARM / LASER - SAFE",
        "[ ] DESCEND / ARRIVE AS BRIEFED",
        "[ ] ENTER BREAK / INITIAL",
        "",
        "BREAK",
        "[ ] 800 FT AGL / AS BRIEFED",
        "[ ] 350 KIAS MAX AT BREAK",
        "[ ] BREAK LEFT",
        "[ ] SPEED BRAKE - EXTEND AS REQUIRED",
        "[ ] GEAR - DOWN BELOW LIMIT",
        "[ ] FLAPS - FULL",
        "[ ] HOOK - DOWN",
        "[ ] ON-SPEED AOA",
        "",
        "DOWNWIND / ABEAM",
        "[ ] 600 FT AGL",
        "[ ] APPROX 1.2-1.3 NM ABEAM",
        "[ ] CHECK GEAR / FLAPS / HOOK",
        "[ ] DESCENT IN 180",
        "",
        "GROOVE",
        "[ ] BALL / LINEUP / AOA",
        "[ ] CALL THE BALL AS REQUIRED",
        "[ ] FLY MEATBALL",
        "[ ] MAINTAIN CENTERLINE",
        "",
        "BOLTER / WAVE-OFF",
        "[ ] MIL / MAX",
        "[ ] FLY UP ANGLED DECK",
        "[ ] GEAR / FLAPS REMAIN DOWN",
        "[ ] RE-ENTER PATTERN",
    })
end

local function case2Page()
    return pageHeader("F/A-18C - CASE II RECOVERY") .. join({
        "[ ] WEATHER / CASE II - CONFIRM",
        "[ ] TACAN / COMM / ICLS - SET",
        "[ ] MARSHAL / EXPECTED APPROACH - COPY",
        "[ ] DESCEND IN INSTRUMENT CONDITIONS",
        "[ ] TRANSITION TO VMC WHEN AVAILABLE",
        "[ ] FOLLOW CASE III-LIKE APPROACH UNTIL VMC",
        "",
        "WHEN VMC",
        "[ ] CONTINUE TO CASE I PATTERN AS DIRECTED",
        "[ ] ESTABLISH BREAK / DOWNWIND",
        "[ ] GEAR / FLAPS / HOOK - SET",
        "[ ] ON-SPEED AOA",
        "[ ] BALL / LINEUP / AOA",
        "",
        "IF IMC PERSISTS",
        "[ ] CONTINUE INSTRUMENT APPROACH",
        "[ ] USE ICLS / ACLS AS BRIEFED",
        "[ ] FOLLOW FINAL CONTROLLER / LSO",
    })
end

local function case3Page()
    return pageHeader("F/A-18C - CASE III RECOVERY") .. join({
        "[ ] WEATHER / CASE III - CONFIRM",
        "[ ] MARSHAL INSTRUCTIONS - COPY",
        "[ ] TACAN / COMM / ICLS - SET",
        "[ ] ACLS / LINK - AS REQUIRED",
        "[ ] BARO / ALTITUDE - SET",
        "",
        "MARSHAL",
        "[ ] HOLD AT ASSIGNED FIX / RADIAL / DME",
        "[ ] ALTITUDE - MAINTAIN",
        "[ ] COMMENCE TIME - CONFIRM",
        "",
        "COMMENCE",
        "[ ] LEAVE HOLD AT ASSIGNED TIME",
        "[ ] DESCENT PROFILE - FLY",
        "[ ] SPEED / CONFIGURATION - MANAGE",
        "[ ] LANDING CHECK - COMPLETE",
        "[ ] GEAR - DOWN",
        "[ ] FLAPS - FULL",
        "[ ] HOOK - DOWN",
        "[ ] ON-SPEED AOA",
        "",
        "FINAL",
        "[ ] ICLS / ACLS - MONITOR",
        "[ ] NEEDLES / COURSE - CROSSCHECK",
        "[ ] BALL / LINEUP / AOA WHEN VISUAL",
        "[ ] FOLLOW FINAL CONTROLLER / LSO",
        "",
        "MISSED / BOLTER",
        "[ ] POWER - MIL / MAX",
        "[ ] FLY PUBLISHED / DIRECTED MISSED",
        "[ ] RECONTACT APPROACH",
    })
end

local function marshalPage()
    return pageHeader("F/A-18C - MARSHAL") .. join({
        "CARRIER: ___________________________",
        "BRC: ________",
        "TACAN: ______  CH: ______",
        "ICLS: _______  CH: ______",
        "",
        "MARSHAL DATA",
        "RADIAL: ________",
        "DME: ___________",
        "ALTITUDE: _______",
        "EXPECTED APPROACH TIME: ___________",
        "COMMENCE: _________________________",
        "",
        "CHECKS",
        "[ ] FUEL - CHECK",
        "[ ] BINGO - REVIEW",
        "[ ] MASTER ARM - SAFE",
        "[ ] LASER ARM - SAFE",
        "[ ] TACAN - SET",
        "[ ] ICLS - SET",
        "[ ] ACLS / LINK - AS REQUIRED",
        "[ ] BARO - SET",
        "[ ] COMM - SET",
        "[ ] APPROACH PLATE / PROFILE - REVIEW",
        "",
        "NOTES:",
        "____________________________________",
        "____________________________________",
    })
end

local function overheadBreakPage()
    return pageHeader("F/A-18C - OVERHEAD BREAK") .. join({
        "INITIAL",
        "[ ] ARRIVE 800 FT AGL / AS BRIEFED",
        "[ ] 350 KIAS MAX",
        "[ ] PARALLEL BRC",
        "[ ] INTERVAL - CHECK",
        "",
        "BREAK",
        "[ ] 3-4 G LEVEL BREAK",
        "[ ] THROTTLE - IDLE / AS REQUIRED",
        "[ ] SPEED BRAKE - EXTEND",
        "[ ] BELOW GEAR LIMIT: GEAR DOWN",
        "[ ] FLAPS - FULL",
        "[ ] HOOK - DOWN FOR CARRIER",
        "",
        "DOWNWIND",
        "[ ] 600 FT AGL",
        "[ ] ON-SPEED AOA",
        "[ ] APPROX 1.2-1.3 NM ABEAM",
        "[ ] LANDING CHECK COMPLETE",
        "",
        "180 / GROOVE",
        "[ ] DESCEND / TURN AT ABEAM",
        "[ ] ROLL OUT 3/4 NM APPROX",
        "[ ] BALL / LINEUP / AOA",
    })
end

local function aclsPage()
    return pageHeader("F/A-18C - ACLS / ICLS SETUP") .. join({
        "NAV / COMM",
        "[ ] TACAN - CARRIER CHANNEL",
        "[ ] COURSE - SET TO RECOVERY HEADING",
        "[ ] ICLS - ON / CHANNEL SET",
        "[ ] COMM - APPROACH / FINAL",
        "",
        "ACLS / LINK",
        "[ ] DATALINK - ON",
        "[ ] ACLS / LINK FUNCTION - AS REQUIRED",
        "[ ] VERIFY VALID STEERING / NEEDLES",
        "[ ] CROSSCHECK HUD / HSI / ADI",
        "",
        "LANDING CONFIG",
        "[ ] MASTER ARM - SAFE",
        "[ ] GEAR - DOWN",
        "[ ] FLAPS - FULL",
        "[ ] HOOK - DOWN",
        "[ ] ON-SPEED AOA",
        "",
        "FINAL",
        "[ ] ICLS NEEDLES - MONITOR",
        "[ ] ACLS CUES - MONITOR",
        "[ ] DO NOT CHASE LARGE CUE MOVEMENTS",
        "[ ] TRANSITION TO BALL WHEN VISUAL",
        "[ ] LSO / FINAL CONTROLLER CALLS - PRIORITY",
        "",
        "SETTINGS NOTES:",
        "TACAN: ______  ICLS: ______",
        "BRC/CRS: ____  ALT: ______",
    })
end

local function aaAttackPage()
    return pageHeader("F/A-18C - A/A ATTACK FLOW") .. join({
        "PRE-COMMIT",
        "[ ] MASTER ARM - ARM",
        "[ ] A/A MODE - SELECT",
        "[ ] RADAR - SET",
        "[ ] DATALINK / SA - CHECK",
        "[ ] RWR - CHECK",
        "[ ] IFF / ID - ESTABLISH",
        "[ ] WEAPON - SELECT / VERIFY",
        "",
        "SORT / TARGETING",
        "[ ] BUILD SA",
        "[ ] ASSIGN / SORT TARGET",
        "[ ] VERIFY FRIENDLY DECONFLICTION",
        "[ ] SET RADAR RANGE / AZ / BARS",
        "[ ] DESIGNATE TARGET",
        "",
        "COMMIT / ENGAGE",
        "[ ] MANAGE CLOSURE",
        "[ ] CHECK WEZ",
        "[ ] LAUNCH PARAMETERS - VALID",
        "[ ] FOX CALL AS REQUIRED",
        "[ ] SUPPORT MISSILE AS REQUIRED",
        "[ ] CRANK / DEFEND AS REQUIRED",
        "",
        "MERGE / WVR",
        "[ ] SENSOR CONTROL - AS REQUIRED",
        "[ ] AIM-9 / GUN - SELECT",
        "[ ] HMD - USE AS REQUIRED",
        "[ ] MAINTAIN ENERGY / SA",
        "",
        "DISENGAGE",
        "[ ] SEPARATE / EXTEND",
        "[ ] CHECK FUEL / WEAPONS",
        "[ ] REBUILD SA",
        "[ ] REJOIN / RECOMMIT AS DIRECTED",
    })
end

local function agAttackPage()
    return pageHeader("F/A-18C - A/G ATTACK FLOW") .. join({
        "INGRESS",
        "[ ] MASTER ARM - ARM",
        "[ ] A/G MODE - SELECT",
        "[ ] STORES / PROFILE - VERIFY",
        "[ ] FUZING / QTY / MULT - VERIFY",
        "[ ] LASER CODE - VERIFY",
        "[ ] FLIR / TGP - SET",
        "[ ] RWR / EW - CHECK",
        "[ ] TARGET / WAYPOINT - VERIFY",
        "",
        "TARGET ACQUISITION",
        "[ ] SENSOR TO TARGET AREA",
        "[ ] IDENTIFY TARGET",
        "[ ] CONFIRM FRIENDLIES / RESTRICTIONS",
        "[ ] DESIGNATE TARGET",
        "[ ] CHECK ATTACK HEADING / ALTITUDE",
        "",
        "ATTACK",
        "[ ] STABILIZE ATTACK",
        "[ ] VERIFY WEAPON CUES",
        "[ ] IN-RANGE / RELEASE CUE",
        "[ ] PICKLE / TRIGGER",
        "[ ] LASER - AS REQUIRED",
        "[ ] MAINTAIN SAFE ESCAPE",
        "",
        "EGRESS",
        "[ ] FOLLOW BRIEFED EGRESS",
        "[ ] DISPENSE / DEFEND AS REQUIRED",
        "[ ] MASTER ARM - SAFE WHEN COMPLETE",
        "[ ] CHECK FUEL / STORES",
        "[ ] BDA / REATTACK AS DIRECTED",
    })
end

local pageBuilders = {
    [PAGE.JTAC]     = jtacPage,
    [PAGE.START]    = startupPage,
    [PAGE.TO]       = takeoffPage,
    [PAGE.FENCEIN]  = fenceInPage,
    [PAGE.AAR]      = aarPage,
    [PAGE.FENCEOUT] = fenceOutPage,
    [PAGE.LAND]     = landingPage,
    [PAGE.NOTES]    = notesPage,
    [PAGE.LAUNCH]   = carrierLaunchPage,
    [PAGE.CASE1]    = case1Page,
    [PAGE.CASE2]    = case2Page,
    [PAGE.CASE3]    = case3Page,
    [PAGE.MARSHAL]  = marshalPage,
    [PAGE.BREAK]    = overheadBreakPage,
    [PAGE.ACLS]     = aclsPage,
    [PAGE.AA]       = aaAttackPage,
    [PAGE.AG]       = agAttackPage,
}

local function showPage(text, name)
    local builder = pageBuilders[name]
    if not builder then return end
    activePage = name
    text:setText(builder())
end

local function coordString(lat, lon, alt)
    local latText = formatCoord("DDM", true, lat, {precision = 3})
    local lonText = formatCoord("DDM", false, lon, {precision = 3, lonDegreesWidth = 3})
    local altFt = math.floor((alt or 0) * 3.28084 + 0.5)
    return latText .. "  " .. lonText .. string.format("  %d FT", altFt)
end

local function applyTargetCoord(text)
    if not lastCoord then
        text:insertBottom("[JTAC] Capture a coordinate with Scratchpad's F10 coordinate tool first.")
        return
    end

    local current = text:getText() or ""
    local replacement = "6. TARGET LOCATION:\n   " .. lastCoord
    local updated, count = current:gsub(
        "6%. TARGET LOCATION:%s*\n%s*[^\r\n]*",
        replacement,
        1
    )

    if count > 0 then
        text:setText(updated)
    else
        text:insertBottom("JTAC TARGET: " .. lastCoord)
    end
end

addCoordinateListener(function(text, lat, lon, alt)
    local ok, result = pcall(coordString, lat, lon, alt)
    if ok then
        lastCoord = result
        log("F18 JTAC Carrier Checklists: captured coordinate " .. result)
    else
        log("F18 JTAC Carrier Checklists: coordinate capture failed: " .. tostring(result))
    end
end)

-- NAV ROW 1
addButton(0,   0, 58, 24, "9L",      function(text) showPage(text, PAGE.JTAC) end)
addButton(62,  0, 58, 24, "START",   function(text) showPage(text, PAGE.START) end)
addButton(124, 0, 58, 24, "T/O",     function(text) showPage(text, PAGE.TO) end)
addButton(186, 0, 58, 24, "F-IN",    function(text) showPage(text, PAGE.FENCEIN) end)
addButton(248, 0, 58, 24, "AAR",     function(text) showPage(text, PAGE.AAR) end)

-- NAV ROW 2
addButton(0,   28, 58, 24, "F-OUT",  function(text) showPage(text, PAGE.FENCEOUT) end)
addButton(62,  28, 58, 24, "LAND",   function(text) showPage(text, PAGE.LAND) end)
addButton(124, 28, 58, 24, "NOTES",  function(text) showPage(text, PAGE.NOTES) end)
addButton(186, 28, 58, 24, "LAUNCH", function(text) showPage(text, PAGE.LAUNCH) end)
addButton(248, 28, 58, 24, "MARSHAL",function(text) showPage(text, PAGE.MARSHAL) end)

-- NAV ROW 3
addButton(0,   56, 58, 24, "CASE I",   function(text) showPage(text, PAGE.CASE1) end)
addButton(62,  56, 58, 24, "CASE II",  function(text) showPage(text, PAGE.CASE2) end)
addButton(124, 56, 58, 24, "CASE III", function(text) showPage(text, PAGE.CASE3) end)
addButton(186, 56, 58, 24, "BREAK",    function(text) showPage(text, PAGE.BREAK) end)
addButton(248, 56, 58, 24, "ACLS",     function(text) showPage(text, PAGE.ACLS) end)

-- NAV ROW 4
addButton(0,   84, 58, 24, "A/A",       function(text) showPage(text, PAGE.AA) end)
addButton(62,  84, 58, 24, "A/G",       function(text) showPage(text, PAGE.AG) end)
addButton(124, 84, 88, 24, "TGT->L6",   function(text) applyTargetCoord(text) end)
addButton(216, 84, 42, 24, "RST",       function(text) showPage(text, activePage) end)
addButton(262, 84, 44, 24, "CLR",       function(text) text:setText("") end)

log("F18 JTAC Carrier Checklists extension loaded.")
