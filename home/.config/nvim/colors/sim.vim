" 'sim.vim' -- Vim color scheme.
" Maintainer:   Shawn Michael O'Hare (shawn@shawnohare.com)
" Description:  S(olarized) Im(proved) via use of emphasis, more colors, and
" terminal fallbacks that should look readable with non-Solarized terminal
" themes.
"
" NOTE: This theme assumes that basic foreground and background are defined
" separately from the standard ANSI colors. Moreover,it supports light-dark
" palette swapping.
"
" ----------------------------------------------------------------------------
" TODO:
" - [ ] Name refactor to align with Xresources direction.
"
" ----------------------------------------------------------------------------
highlight clear

" NOTE: hi clear + syntax reset seem to obliterate filetype specific
" definitions. At least, they do not appear as autocompletion suggestions.
" if exists('syntax_on')
"   syntax reset
"   syntax sync fromstart
" endif
"
let colors_name = 'sim'


" SOLARIZED HEX     SIM 16 16/8 TERMCOL      XTERM/HEX   L*A*B          sRGB          HSB
" --------- ------- ------ -----------       ----------  -----------   -----------   ------------
" base03    #002b36 none   8/4 brblack		234 #1c1c1c  15 -12 -12     0  43  54    193 100  21
" base02    #073642 0      0/4 black		235 #262626  20 -12 -12     7  54  66    192  90  26
" base01    #586e75 8      10/7 brgreen		240 #4e4e4e  45 -07 -07    88 110  117   194  25  46
" base00    #657b83 none   11/7 bryellow	241 #585858  50 -07 -07   101 123  131   195  23  51
" base_0    #839496 none   12/6 brblue		244 #808080  60 -06 -03   131 148  150   186  13  59
" base_1    #93a1a1 7      4/4 brcyan		245 #8a8a8a  65 -05 -02   147 161  161   180   9  63
" base_2    #eee8d5 15     7/7 white		254 #d7d7af  92 -00  10   238 232  213    44  11  93
" base_3    #fdf6e3 none   15/7 brwhite		230 #ffffd7  97  00  10   253 246  227    44  10  99
" yellow    #b58900 3      3/3 yellow		136 #af8700  60  10  65   181 137    0    45 100  71
" orange    #cb4b16 9      9/3 brred		166 #d75f00  50  50  55   203  75   22    18  89  80
" red       #dc322f 1      1/1 red		    160 #d70000  50  65  45   220  50   47     1  79  86
" magenta   #d33682 5      5/5  magenta		125 #af005f  50  65 -05   211  54  130   331  74  83
" violet    #6c71c4 13     13/5 brmagenta	 61 #5f5faf  50  15 -45   108 113  196   237  45  77
" blue      #268bd2 4      4/4 blue		     33 #0087ff  55 -10 -45    38 139  210   205  82  82
" cyan      #2aa198 6      6/6 cyan		     37 #00afaf  60 -35 -05    42 161  152   175  74
" green     #859900 2      2/2 green         64 #5f8700  60 -20  65   133 153    0    68 100  60
"

" ----------------------------------------------------------------------------

"  Define dark, light, and invariant palettes.
let s:dark    = {}
let s:light   = {}
let s:def     = {}

" Define canonical colors.
" Main foreground and background colors use terminal defaults.
let s:dark.bg   = ['#002b36', 'NONE']
let s:dark.fg   = ["#839496", 'NONE']
let s:light.bg  = ["#fdf6e3", 'NONE']
let s:light.fg  = ['#657b83', 'NONE']

" Main 16 colors with terminal fallbacks. Invariant wrt background.
let s:v0_black_1     = ['#073642',  0]
let s:v0_red_1       = ["#dc322f",  1]
let s:v0_green_1     = ["#859900",  2]
let s:v0_yellow_1    = ["#b58900",  3]
let s:v0_blue_1      = ["#268bd2",  4]
let s:v0_magenta_1   = ["#d33682",  5]
let s:v0_cyan_1      = ["#2aa198",  6]
let s:v0_white_1     = ["#93a1a1",  7]
let s:v0_black_2   = ['#586e75',  8]
let s:v0_red_2     = ["#cb4b16",  9]
let s:v0_green_2   = ['#96ad00', 10]
let s:v0_yellow_2  = ['#e2ab00', 11]
let s:v0_blue_2    = ["#268bd2", 12]
let s:v0_magenta_2 = ["#6c71c4", 13]
let s:v0_cyan_2    = ["#2aa198", 14]
let s:v0_white_2   = ["#eee8d5", 15]

let s:lightgray = s:v0_white_1
let s:darkgray  = s:v0_black_2

" Bases
" ----------------------------------------------------------------------------
" i | dark   | light  | canonical | description
" ----------------------------------------------------------------------------
" 0 | base03 | base_3 | base_l3   | main bg
" 1 | base02 | base_2 | base_l2   | bg highlights
" 2 | base01 | base_1 | base_l1   | fg comments
" 3 | base00 | base_0 | base_l0   | Inactive statusline bg.
" 4 | base_0 | base00 | base_r0   | fg
" 5 | base_1 | base01 | base_r1   | fg emphasis, active statusline, bg reversed
" 6 | base_2 | base02 | base_r2   | ?
" 7 | base_3 | base03 | base_r3   | Unused(?) (except in contrast shifts).
" ---------------------------------------------------------------------------

let s:bases = [
            \ s:dark.bg,
            \ s:v0_black_1,
            \ s:v0_black_2,
            \ s:light.fg,
            \ s:dark.fg,
            \ s:v0_white_1,
            \ s:v0_white_2,
            \ s:light.bg,
            \ ]

" ----------------------------------------------------------------------------
" TODO: All colors grouped by shade.
" It's unclear how this should be organized. Probably something like
" gN_color or group_color_n where group is a named group.
"
" let s:v0_black_1        = ['#073642',  0]
" let s:v0_black_2        = ['#586e75',  8]
" let s:v2_black          = ['#282c34', 16]

" let s:v0_red_1          = ["#dc322f",  1]
" let s:v0_red_2          = ["#cb4b16",  9]
" let s:v1_faded_red      = ['#9d0006', 88]      " 157-0-6
" let s:v1_neutral_red    = ['#cc241d', 124]     " 204-36-29
" let s:v1_bright_red     = ['#fb4934', 167]     " 251-73-52
" let s:v2_red            = ['#be5046', 130]
" let s:v2_brred          = ['#e06c75', 168]
" let s:v1_faded_orange   = ['#af3a03', 130]     " 175-58-3
" let s:v1_neutral_orange = ['#d65d0e', 166]     " 214-93-14
" let s:v1_bright_orange  = ['#fe8019', 208]     " 254-128-25

" let s:v0_green_1        = ["#859900",  2]
" let s:v0_green_2        = ['#96ad00', 10]
" let s:v2_green          = ['#98c379', 114]
" let s:v1_faded_green    = ['#79740e', 100]     " 121-116-14
" let s:v1_neutral_green  = ['#98971a', 106]     " 152-151-26
" let s:v1_bright_green   = ['#b8bb26', 142]     " 184-187-38

" let s:v0_yellow_1       = ["#b58900",  3]
" let s:v0_yellow_2       = ['#e2ab00', 11]
" let s:v2_yellow         = ['#d19a66', 173]
" let s:v2_bryellow       = ['#e5c07b', 180]
" let s:v1_faded_yellow   = ['#b57614', 136]     " 181-118-20
" let s:v1_neutral_yellow = ['#d79921', 172]     " 215-153-33
" let s:v1_bright_yellow  = ['#fabd2f', 214]     " 250-189-47

" let s:v0_blue_1         = ["#268bd2",  4]
" let s:v0_blue_2         = ["#268bd2", 12]
" let s:v2_blue           = ['#61afef', 75]
" let s:v1_faded_blue     = ['#076678', 24]      " 7-102-120
" let s:v1_neutral_blue   = ['#458588', 66]      " 69-133-136
" let s:v1_bright_blue    = ['#83a598', 109]     " 131-165-152

" let s:v0_magenta_1      = ["#d33682",  5]
" let s:v0_magenta_2      = ["#6c71c4", 13]
" let s:v2_magenta        = ['#c678dd', 176]

" let s:v0_cyan_1         = ["#2aa198",  6]
" let s:v0_cyan_2         = ["#2aa198", 14]
" let s:v2_cyan           = ['#56b6c2', 73]
" let s:v1_faded_aqua     = ['#427b58', 66]      " 66-123-88
" let s:v1_neutral_aqua   = ['#689d6a', 72]      " 104-157-106
" let s:v1_bright_aqua    = ['#8ec07c', 108]     " 142-192-124

" let s:v0_white_1        = ["#93a1a1",  7]
" let s:v0_white_2        = ["#eee8d5", 15]

" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" one (dark) colors
" +---------------------------------------------+--------------------------|
" |  Color Name  |         RGB        |   Hex   |         Desc             |
" |--------------+--------------------+---------|--------------------------|
" | Black        | rgb(40, 44, 52)    | #282c34 |         syntax bg
" |--------------+--------------------+---------|--------------------------|
" | White        | rgb(171, 178, 191) | #abb2bf |
" |--------------+--------------------+---------|--------------------------|
" | Light Red    | rgb(224, 108, 117) | #e06c75 |
" |--------------+--------------------+---------|--------------------------|
" | Dark Red     | rgb(190, 80, 70)   | #be5046 |
" |--------------+--------------------+---------|--------------------------|
" | Green        | rgb(152, 195, 121) | #98c379 |
" |--------------+--------------------+---------|--------------------------|
" | Light Yellow | rgb(229, 192, 123) | #e5c07b |
" |--------------+--------------------+---------|--------------------------|
" | Dark Yellow  | rgb(209, 154, 102) | #d19a66 |
" |--------------+--------------------+---------|--------------------------|
" | Blue         | rgb(97, 175, 239)  | #61afef |
" |--------------+--------------------+---------|--------------------------|
" | Magenta      | rgb(198, 120, 221) | #c678dd |
" |--------------+--------------------+---------|--------------------------|
" | Cyan         | rgb(86, 182, 194)  | #56b6c2 |
" |--------------+--------------------+---------|--------------------------|
" | Gutter Grey  | rgb(76, 82, 99)    | #4b5263 |
" |--------------+--------------------+---------|--------------------------|
" | Comment Grey | rgb(92, 99, 112)   | #5c6370 |
" +---------------------------------------------+--------------------------|

" let s:mono_1        = ['#abb2bf', 145]
" let s:mono_2        = ['#828997', 102]
" let s:mono_3        = ['#5c6370', 59]
" let s:mono_4        = ['#4b5263', 59]
let s:v2_black     = ['#282c34', 16]
let s:v2_cyan      = ['#56b6c2', 73]
let s:v2_blue      = ['#61afef', 75]
let s:v2_magenta   = ['#c678dd', 176]
let s:v2_green     = ['#98c379', 114]
let s:v2_red       = ['#be5046', 130]
let s:v2_brred     = ['#e06c75', 168]
let s:v2_yellow    = ['#d19a66', 173]
let s:v2_bryellow  = ['#e5c07b', 180]
" let s:syntax_bg     = ['#282c34', 16]
" let s:syntax_gutter = ['#636d83', 60]
" let s:syntax_cursor = ['#2c323c', 16]
" let s:syntax_accent = ['#528bff', 69]
" let s:vertsplit     = ['#181a1f', 233]
" let s:special_grey  = ['#3b4048', 16]
" let s:visual_grey   = ['#3e4452', 17]
" let s:pmenu         = ['#333841', 16]


" Additional Gruvbox colors.
" Dark uses neutral for lower ANSI colors and bright for bright.
" Light uses neutral for lower ANSI colors and faded for bright.
" color2,3 or names?
let s:v1_dark0          = ['#282828', 235]     " 40-40-40
let s:v1_dark1          = ['#3c3836', 237]     " 60-56-54
let s:v1_dark2          = ['#504945', 239]     " 80-73-69
let s:v1_dark3          = ['#665c54', 241]     " 102-92-84
let s:v1_dark4          = ['#7c6f64', 243]     " 124-111-100

let s:v1_gray           = ['#928374', 245]     " 146-131-116

let s:v1_light0         = ['#fbf1c7', 229]     " 253-244-193
let s:v1_light1         = ['#ebdbb2', 223]     " 235-219-178
let s:v1_light2         = ['#d5c4a1', 250]     " 213-196-161
let s:v1_light3         = ['#bdae93', 248]     " 189-174-147
let s:v1_light4         = ['#a89984', 246]     " 168-153-132


let s:v1_faded_red      = ['#9d0006', 88]      " 157-0-6
let s:v1_faded_green    = ['#79740e', 100]     " 121-116-14
let s:v1_faded_yellow   = ['#b57614', 136]     " 181-118-20
let s:v1_faded_blue     = ['#076678', 24]      " 7-102-120
let s:v1_faded_purple   = ['#8f3f71', 96]      " 143-63-113
let s:v1_faded_aqua     = ['#427b58', 66]      " 66-123-88
let s:v1_faded_orange   = ['#af3a03', 130]     " 175-58-3

let s:v1_neutral_red    = ['#cc241d', 124]     " 204-36-29
let s:v1_neutral_green  = ['#98971a', 106]     " 152-151-26
let s:v1_neutral_yellow = ['#d79921', 172]     " 215-153-33
let s:v1_neutral_blue   = ['#458588', 66]      " 69-133-136
let s:v1_neutral_purple = ['#b16286', 132]     " 177-98-134
let s:v1_neutral_aqua   = ['#689d6a', 72]      " 104-157-106
let s:v1_neutral_orange = ['#d65d0e', 166]     " 214-93-14

let s:v1_bright_red     = ['#fb4934', 167]     " 251-73-52
let s:v1_bright_green   = ['#b8bb26', 142]     " 184-187-38
let s:v1_bright_yellow  = ['#fabd2f', 214]     " 250-189-47
let s:v1_bright_blue    = ['#83a598', 109]     " 131-165-152
let s:v1_bright_purple  = ['#d3869b', 175]     " 211-134-155
let s:v1_bright_aqua    = ['#8ec07c', 108]     " 142-192-124
let s:v1_bright_orange  = ['#fe8019', 208]     " 254-128-25


" Neutral colors.
let s:v1_red0    = s:v1_neutral_red
let s:v1_green0  = s:v1_neutral_green
let s:v1_yellow0 = s:v1_neutral_yellow
let s:v1_blue0   = s:v1_neutral_blue
let s:v1_purple0 = s:v1_neutral_purple
let s:v1_aqua0   = s:v1_neutral_aqua
let s:v1_orange0 = s:v1_neutral_orange
" Dark background brights.
let s:v1_red1    = s:v1_bright_red
let s:v1_green1  = s:v1_bright_green
let s:v1_yellow1 = s:v1_bright_yellow
let s:v1_blue1   = s:v1_bright_blue
let s:v1_purple1 = s:v1_bright_purple
let s:v1_aqua1   = s:v1_bright_aqua
let s:v1_orange1 = s:v1_bright_orange

" ----------------------------------------------------------------------------
" Swap dark and light colors if light mode is explicitly set.
if &background == "light"
    " Invert sim bases
    let s:bases = reverse(s:bases)

    " Light background brights.
    let s:v1_red1             = s:v1_faded_red
    let s:v1_green1           = s:v1_faded_green
    let s:v1_yellow1          = s:v1_faded_yellow
    let s:v1_blue1            = s:v1_faded_blue
    let s:v1_purple1          = s:v1_faded_purple
    let s:v1_aqua1            = s:v1_faded_aqua
    let s:v1_orange1          = s:v1_faded_orange

    " vim-one light variant.
    let s:v2_mono_1          = ['#494b53', '23']
    let s:v2_mono_2          = ['#696c77', '60']
    let s:v2_mono_3          = ['#a0a1a7', '145']
    let s:v2_mono_4          = ['#c2c2c3', '250']
    let s:v2_cyan            = ['#0184bc', '31'] " cyan
    let s:v2_blue            = ['#4078f2', '33'] " blue
    let s:v2_magenta         = ['#a626a4', '127'] " purple
    let s:v2_green           = ['#50a14f', '71'] " green
    let s:v2_brred           = ['#e45649', '166'] " red 1
    let s:v2_red             = ['#ca1243', '160'] " red 2
    let s:v2_yellow          = ['#986801', '94'] " orange 1
    let s:v2_bryellow        = ['#c18401', '136'] " orange 2
    let s:v2_syntax_bg       = ['#fafafa', '255']
    let s:v2_syntax_gutter   = ['#9e9e9e', '247']
    let s:v2_syntax_cursor   = ['#f0f0f0', '254']
    let s:v2_syntax_accent   = ['#526fff', '63']
    let s:v2_syntax_accent_2 = ['#0083be', '31']
    let s:v2_vertsplit       = ['#e7e9e1', '188']
    let s:v2_special_grey    = ['#d3d3d3', '251']
    let s:v2_visual_grey     = ['#d0d0d0', '251']
    let s:v2_pmenu           = ['#dfdfdf', '253']
endif

" Set sim bases.
let s:base03 = s:bases[0]
let s:base02 = s:bases[1]
let s:base01 = s:bases[2]
let s:base00 = s:bases[3]
let s:base_0 = s:bases[4]
let s:base_1 = s:bases[5]
let s:base_2 = s:bases[6]
let s:base_3 = s:bases[7]

" ----------------------------------------------------------------------------
" Emphasis values. Elements are gui/cterm, guisp
let s:none  = ['NONE', 'NONE']
let s:reverse = ['reverse ', 'NONE']

if get(g:, 'sim#emphasis', 1)
    let s:italic                = ['italic', 'NONE']
    let s:bold                  = ['bold', 'NONE']
    let s:underline             = ['underline', 'NONE']
    let s:undercurl             = ['undercurl', 'undercurl']
    let s:bold_italic           = ['bold,italic', 'NONE']
    let s:bold_italic_underline = ['bold,italic,underline', 'NONE']
    let s:bold_underline        = ['bold,underline', 'NONE']
    let s:italic_underline      = ['italic,underline', 'NONE']
else
    let s:italic                = s:none
    let s:bold                  = s:none
    let s:underline             = s:none
    let s:undercurl             = s:none
    let s:italic                = s:none
    let s:bold_italic           = s:none
    let s:bold_underline        = s:none
    let s:italic_underline      = s:none
endif

" ----------------------------------------------------------------------------
" Vim terminal buffer colors.
let g:terminal_ansi_colors = [
            \ s:v0_black_1[0],
            \ s:v0_red_1[0],
            \ s:v0_green_1[0],
            \ s:v0_yellow_1[0],
            \ s:v0_blue_1[0],
            \ s:v0_magenta_1[0],
            \ s:v0_cyan_1[0],
            \ s:v0_white_1[0],
            \ s:v0_black_2[0],
            \ s:v0_red_2[0],
            \ s:v0_green_2[0],
            \ s:v0_yellow_2[0],
            \ s:v0_blue_2[0],
            \ s:v0_magenta_2[0],
            \ s:v0_cyan_2[0],
            \ s:v0_white_2[0],
            \ ]

" Neovim terminal buffer colors
let g:terminal_color_0  = s:v0_black_1[0]
let g:terminal_color_1  = s:v0_red_1[0]
let g:terminal_color_2  = s:v0_green_1[0]
let g:terminal_color_3  = s:v0_yellow_1[0]
let g:terminal_color_4  = s:v0_blue_1[0]
let g:terminal_color_5  = s:v0_magenta_1[0]
let g:terminal_color_6  = s:v0_cyan_1[0]
let g:terminal_color_7  = s:v0_white_1[0]
let g:terminal_color_8  = s:v0_black_2[0]
let g:terminal_color_9  = s:v0_red_2[0]
let g:terminal_color_10 = s:v0_green_2[0]
let g:terminal_color_11 = s:v0_yellow_2[0]
let g:terminal_color_12 = s:v0_blue_2[0]
let g:terminal_color_13 = s:v0_magenta_2[0]
let g:terminal_color_14 = s:v0_cyan_2[0]
let g:terminal_color_15 = s:v0_white_2[0]

" ----------------------------------------------------------------------------
"  Predefined groups to link to.
function! s:hi(group, emph, fg, bg)
    " Arguments: group: str, emphasis: array, foreground: array, background: array.
      execute 'hi! '  . a:group
                  \  . ' gui='     . a:emph[0]
                  \  . ' cterm='   . a:emph[0]
                  \  . ' guisp='   . a:emph[1]
                  \  . ' guifg='   . a:fg[0]
                  \  . ' ctermfg=' . a:fg[1]
                  \  . ' guibg='   . a:bg[0]
                  \  . ' ctermbg=' . a:bg[1]
endfunction

" Memoize certain common groups
call s:hi('SimBackgroundHi',      s:none,   s:none,          s:base02)
call s:hi('SimBlack',             s:none,   s:v0_black_1,        s:none)
call s:hi('SimRed',               s:none,   s:v0_red_1,           s:none)
call s:hi('SimBoldRed',           s:bold,   s:v0_red_1,           s:none)
call s:hi('SimItalicRed',         s:italic, s:v0_red_1,           s:none)
call s:hi('SimOrange',            s:none,   s:v0_red_2,          s:none)
call s:hi('SimBoldOrange',        s:bold,   s:v0_red_2,          s:none)
call s:hi('SimItalicOrange',      s:italic, s:v0_red_2,          s:none)
call s:hi('SimYellow',            s:none,   s:v0_yellow_1,       s:none)
call s:hi('SimBoldYellow',        s:bold,   s:v0_yellow_1,       s:none)
call s:hi('SimItalicYellow',      s:italic, s:v0_yellow_1,       s:none)
call s:hi('SimBrightYellow',      s:none,   s:v0_yellow_2,       s:none)
call s:hi('SimBlue',              s:none,   s:v0_blue_1,         s:none)
call s:hi('SimBoldBlue',          s:bold,   s:v0_blue_1,         s:none)
call s:hi('SimItalicBlue',        s:italic, s:v0_blue_1,         s:none)
call s:hi('SimBrightBlue',        s:none,   s:v0_blue_2,         s:none)
call s:hi('SimGreen',             s:none,   s:v0_green_1,        s:none)
call s:hi('SimBoldGreen',         s:bold,   s:v0_green_1,        s:none)
call s:hi('SimItalicGreen',       s:italic, s:v0_green_1,        s:none)
call s:hi('SimBrightGreen',       s:none,   s:v0_green_2,        s:none)
call s:hi('SimCyan',              s:none,   s:v0_cyan_1,         s:none)
call s:hi('SimBoldCyan',          s:bold,   s:v0_cyan_1,         s:none)
call s:hi('SimItalicCyan',        s:italic, s:v0_cyan_1,         s:none)
call s:hi('SimBrightCyan',        s:none,   s:v0_cyan_2,         s:none)
call s:hi('SimMagenta',           s:none,   s:v0_magenta_1,      s:none)
call s:hi('SimBoldMagenta',       s:bold,   s:v0_magenta_1,      s:none)
call s:hi('SimItalicMagenta',     s:italic, s:v0_magenta_1,      s:none)
call s:hi('SimViolet',            s:none,   s:v0_magenta_2,      s:none)
call s:hi('SimBoldViolet',        s:bold,   s:v0_magenta_2,      s:none)
call s:hi('SimItalicViolet',      s:italic, s:v0_magenta_2,      s:none)
call s:hi('SimLightGray',         s:none,   s:v0_white_1,        s:none)
call s:hi('SimBoldLightGray',     s:bold,   s:v0_white_1,        s:none)
call s:hi('SimItalicLightGray',   s:italic, s:v0_white_1,        s:none)
call s:hi('SimDarkGray',          s:none,   s:v0_black_2,        s:none)
call s:hi('SimBoldDarkGray',      s:bold,   s:v0_black_2,        s:none)
call s:hi('SimItalicDarkGray',    s:italic, s:v0_black_2,        s:none)
call s:hi('SimWhite',             s:none,   s:v0_white_2,        s:none)
call s:hi('SimBoldWhite',         s:bold,   s:v0_white_2,        s:none)
call s:hi('SimItalicWhite',       s:italic, s:v0_white_2,        s:none)

call s:hi('SimGruvyOrange',       s:none,   s:v1_orange0, s:none)
call s:hi('SimGruvyBrightOrange', s:none,   s:v1_orange1, s:none)
call s:hi('SimGruvyYellow',       s:none,   s:v1_yellow0, s:none)
call s:hi('SimGruvyBrightYellow', s:none,   s:v1_yellow1, s:none)
call s:hi('SimGruvyGreen',        s:none,   s:v1_green0,  s:none)
call s:hi('SimGruvyBrightGreen',  s:none,   s:v1_green1,  s:none)
call s:hi('SimGruvyRed',          s:none,   s:v1_red0,    s:none)
call s:hi('SimGruvyBrightRed',    s:none,   s:v1_red1,    s:none)
call s:hi('SimGruvyBlue',         s:none,   s:v1_blue0,   s:none)
call s:hi('SimGruvyBrightBlue',   s:none,   s:v1_blue1,   s:none)
call s:hi('SimGruvyAqua',         s:none,   s:v1_aqua0, s:none)
call s:hi('SimGruvyBrightAqua',   s:none,   s:v1_aqua1, s:none)
call s:hi('SimGruvyPurple',       s:none,   s:v1_purple0, s:none)
call s:hi('SimGruvyBrightPurple', s:none,   s:v1_purple1, s:none)

" call s:hi('SimOneBlack',             s:none,   s:v2_black,        s:none)
call s:hi('SimOneRed',               s:none,   s:v2_red,           s:none)
call s:hi('SimOneBrightRed',            s:none,   s:v2_brred,          s:none)
call s:hi('SimOneYellow',            s:none,   s:v2_yellow,       s:none)
call s:hi('SimOneBrightYellow',      s:none,   s:v2_bryellow,       s:none)
call s:hi('SimOneBlue',              s:none,   s:v2_blue,         s:none)
" call s:hi('SimOneBrightBlue',        s:none,   s:v2_brblue,         s:none)
call s:hi('SimOneGreen',             s:none,   s:v2_green,        s:none)
" call s:hi('SimOneBrightGreen',       s:none,   s:v2_brgreen,        s:none)
call s:hi('SimOneCyan',              s:none,   s:v2_cyan,         s:none)
" call s:hi('SimOneBrightCyan',        s:none,   s:v2_brcyan,         s:none)
call s:hi('SimOneMagenta',           s:none,   s:v2_magenta,      s:none)
" call s:hi('SimOneViolet',            s:none,   s:v2_brmagenta,      s:none)
" call s:hi('SimOneLightGray',         s:none,   s:v2_white,        s:none)
" call s:hi('SimOneDarkGray',          s:none,   s:v2_brblack,        s:none)
" call s:hi('SimOneWhite',             s:none,   s:v2_brwhite,        s:none)


" -----------------------------------------------------------------------------
" Basic highlighting
"
call s:hi('Normal',  s:none,   s:base_0, s:base03)
call s:hi('Comment', s:none, s:base01, s:none)

" Constant
hi! link Constant SimBrightCyan
hi! link Boolean SimBoldYellow
hi! link Character SimBoldCyan
hi! link Float SimViolet
hi! link Number SimViolet
hi! link String SimCyan

" Identifier
hi! link Identifier SimGreen
hi! link Function SimBlue

" Statement
hi! link Statement SimGreen
hi! link Conditional SimYellow
hi! link Exception SimRed
hi! link Keyword SimViolet
hi! link Label SimBlue
" hi! link Operator SimMagenta
hi! link Repeat SimOrange
call s:hi('Operator', s:none, s:v1_purple0, s:none)

" PreProc
hi! link PreProc   SimOrange
hi! link Include   SimBoldOrange
hi! link Define    Function
hi! link PreCondit Conditional

"" TODO: Add emphasis?
" Type
hi! link Type SimYellow
hi! link StorageClass SimGreen
hi! link Structure SimOrange
hi! link Typedef SimRed

" Special
hi! link Special SimRed
hi! link SpecialChar SimRed
hi! link Tag SimBlue
hi! link Delimiter SimOrange
hi! link SpecialComment SimItalicRed
hi! link Debug SimItalicRed

call s:hi('Underlined', s:underline, s:v0_magenta_2, s:none)
call s:hi('Ignore', s:none, s:none, s:none)
hi! link Error SimBoldRed
hi! link Todo SimBoldMagenta
" -----------------------------------------------------------------------------
" Extended highlighting
call s:hi('SpecialKey',      s:bold, s:base00, s:base02)
call s:hi("NonText",         s:bold, s:base00, s:none)
call s:hi("Whitespace",      s:none, s:v0_red_1, s:none)
call s:hi("StatusLine",      s:reverse,  s:none, s:none)
call s:hi("StatusLineNC",    s:reverse,  s:base01, s:none)
" TODO: Figure out visual.
call s:hi("Visual",          s:none,   s:none, s:base02)
" call s:hi("Visual",          s:reverse,   s:base01, s:base03)
hi! link Directory SimBoldBlue
hi! link ErrorMsg SimBoldRed
call s:hi("IncSearch",       s:reverse, s:v0_red_1,   s:none)
call s:hi("Search",          s:reverse,  s:v0_yellow_1, s:none)
call s:hi("MoreMsg",        s:none,   s:v0_blue_1,   s:none)
call s:hi("ModeMsg",        s:none,   s:v0_blue_1,   s:none)
call s:hi("LineNr",         s:none,    s:base01, s:base02)
call s:hi("Question",       s:bold,   s:v0_cyan_1,   s:none)
call s:hi("VertSplit",      s:none,   s:base00, s:none)
hi! link Title SimBoldOrange
"call s:hi("VisualNOS"      ,s:fmt_stnd   s:none   s:base02 ,s:fmt_revbb)
hi! link WarningMsg SimBoldOrange
call s:hi("WildMenu",       s:reverse,   s:base_2,  s:base02)
" call s:hi("Folded"         ,s:bold,   s:base_0  s:base02  ,s:sp_base03)
"call s:hi("FoldColumn"     ,s:none,   s:base_0  s:base02)

call s:hi('DiffAdd', s:bold, s:v0_green_1, s:base02)
call s:hi('DiffChange', s:bold, s:v0_yellow_1, s:base02)
call s:hi('DiffDelete', s:bold, s:v0_red_1, s:base02)
call s:hi('DiffText', s:bold, s:v0_red_1, s:base02)

call s:hi("Conceal",       s:none,   s:v0_blue_1,   s:none)
call s:hi("SpellBad",      s:undercurl,   s:v0_red_1, s:none)
call s:hi("SpellCap",      s:undercurl,   s:v0_magenta_2, s:none)
call s:hi("SpellRare",     s:undercurl,   s:v0_cyan_1, s:none)
call s:hi("SpellLocal",    s:undercurl,   s:v0_yellow_1, s:none)
"
" TODO: These might look better without reverse.
" call s:hi("Pmenu",          s:reverse,   s:base_0,  s:base02)
" call s:hi("PmenuSel",       s:reverse,   s:base01,  s:base_2)
" call s:hi("PmenuSbar",      s:reverse,   s:base_2,  s:base_0)
" call s:hi("PmenuThumb",     s:reverse,   s:base_0,  s:base03)
call s:hi("Pmenu",          s:none,   s:base_0,  s:base02)
call s:hi("PmenuSel",       s:none,   s:base01,  s:base_2)
call s:hi("PmenuSbar",      s:none,   s:base_2,  s:base_0)
call s:hi("PmenuThumb",     s:none,   s:base_0,  s:base03)

"
call s:hi("TabLine",        s:none,   s:base_0,  s:base02)
call s:hi("TabLineFill",    s:none,   s:base_0,  s:base02)
call s:hi("TabLineSel",     s:reverse,   s:base01,  s:base_2)
hi! link CursorLine SimBackgroundHi
hi! link CursorColumn SimBackgroundHi
hi! link ColorColumn SimBackgroundHi
hi! link SignColumn SimBackgroundHi
call s:hi("CursorLineNr",   s:bold, s:none,  s:base02)
call s:hi("Cursor",         s:none,   s:base03, s:base_0)
hi! link lCursor Cursor
call s:hi("MatchParen", s:none, s:none, s:base_2)

" ----------------------------------------------------------------------------
" diff highlighting
" hi! link diffAdded Statement
" hi! link diffLine Identifier
hi! link diffAdded DiffAdd
call s:hi('diffLine', s:none, s:none, s:base02)
