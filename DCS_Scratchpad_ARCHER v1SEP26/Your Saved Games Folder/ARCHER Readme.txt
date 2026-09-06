# F/A-18C JTAC & Carrier Checklists for DCS Scratchpad

Credit to original creator - https://github.com/rkusa/dcs-scratchpad

This package contains my version of mucking around (learning) with scratchpad, to add additional menus for checklists for the F18 platform.
100% a work in progress, and it is offered as is. It works on my system.

The F/A-18C checklist extension and the supporting DCS Scratchpad files are needed to run it, however DCS World and the F/A-18C module are
not included.

#####
NOTE: If a compatible version of DCS Scratchpad is already installed, you should only need
to copy `F18_JTAC_Carrier_Checklists.lua` into `Scripts\Scratchpad\Extensions`.
#####

## Install
1. Close DCS and back up any existing Scratchpad files. Make a copy of C:\Users\<your user folder>\Saved Games\DCS.openbeta (or DCS)\"Scratchpad' folder and 'Scripts' folders.

2. Extract the ZIP.

3. Copy the enclosed `Scripts` folder into your active DCS Saved Games folder.
   For the supplied installation, that folder is:

       C:\Users\<your user folder>\Saved Games\DCS.openbeta (or DCS)\

   Merge the `Scripts` folder with the existing folder. Do not delete or
   replace the whole existing folder.

4. Confirm that these files exist:

       Scripts\Hooks\scratchpad-hook.lua
       Scripts\Scratchpad\ScratchpadWindow.dlg
       Scripts\Scratchpad\CrosshairWindow.dlg
       Scripts\Scratchpad\Extensions\F18_JTAC_Carrier_Checklists.lua

5. Remove or move any old copy of my `F18_JTAC_Carrier_Checklists.lua` from
   `Scripts\Hooks`; the checklist belongs in `Scripts\Scratchpad\Extensions`.

6. Start DCS, enter a mission, and press `Ctrl+Shift+X` to open Scratchpad.


## Use

The four button rows provide templates for:

- JTAC 9-line
- Startup, taxi/takeoff, fence in/out, AAR, and landing/shutdown
- Notes, carrier launch, marshal, CASE I/II/III, and overhead break
- ACLS/ICLS setup and A/A and A/G attack flows

Clicking a checklist button replaces the current Scratchpad text with a fresh
template. Copy any notes you want to keep before changing templates. Edit
`[ ]` to `[x]` manually.

- `RST` restores the currently selected template.
- `CLR` clears the current text.
- `TGT->L6` inserts the last captured coordinate into Line 6 of the JTAC page.

To use `TGT->L6`, open the `9L` page, enable Scratchpad's coordinate mode, open
the F10 map, place the centre dot over the target, and click `+ L/L`. Return to
Scratchpad and click `TGT->L6`. Coordinate capture requires single-player or a
server with Allow Player Export enabled.

Press `Esc` to release text-field focus while leaving Scratchpad open. Resize
the Scratchpad window if the extension buttons are clipped.

## Troubleshooting and removal

If the buttons do not appear, check the paths above, restart DCS, and inspect
`Logs\Scratchpad.log` inside the active DCS Saved Games folder.

To remove only the checklists, close DCS and delete
`Scripts\Scratchpad\Extensions\F18_JTAC_Carrier_Checklists.lua`. The base
Scratchpad files may remain for normal Scratchpad use and other extensions.

These checklists are concise simulator aids. Adapt them to your mission,
server, and squadron procedures. The package structure and file integrity were
checked, but no independent procedural validation was
performed.

## Included third-party software

DCS Scratchpad: https://github.com/rkusa/dcs-scratchpad

Bundled upstream revision:
`2ae8e163a2004ed8f785663aded67f3dc0cde158` (retrieved 2026-09-05).
Its MIT license and original README are included in `docs`.

The checklist Lua is the user-supplied file and is packaged byte-for-byte.
