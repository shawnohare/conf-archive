" 'sim.vim' -- Vim color scheme.
" Maintainer:   Shawn O'Hare (shawn@shawnohare.com)
" Description:  S(olarized) Im(proved) via use of emphasis and terminal
" fallbacks that should look readable with non-Solarized terminal themes.
"               
"
" NOTE: hi clear + syntax reset seem to obliterate filetype specific
" definitions. At least, they do not appear as autocompletion suggestions.
highlight clear

if exists('syntax_on')
  syntax reset
  " syntax sync fromstart
endif


" Use only 16 ANSI colors, no background. 

let colors_name = 'sim'


" SOLARIZED HEX     SIM 16 16/8 TERMCOL  XTERM/HEX   L*A*B      sRGB        HSB         DESC
" --------- ------- ------ ----------- ---------- ----------- ----------- ----------------
" base03    #002b36 none   8/4 brblack  234 #1c1c1c 15 -12 -12   0  43  54 193 100  21 dark bg 
" base02    #073642 0      0/4 black    235 #262626 20 -12 -12   7  54  66 192  90  26 dark bg highlights
" base01    #586e75 8      10/7 brgreen  240 #4e4e4e 45 -07 -07  88 110 117 194  25  46 dark comments / light emphasis 
" base00    #657b83 none   11/7 bryellow 241 #585858 50 -07 -07 101 123 131 195  23  51 light fg
" base_0     #839496 none   12/6 brblue   244 #808080 60 -06 -03 131 148 150 186  13  59 dark fg
" base1     #93a1a1 7      4/4 brcyan   245 #8a8a8a 65 -05 -02 147 161 161 180   9  63 dark emphasis / light comments
" base2     #eee8d5 15     7/7 white    254 #d7d7af 92 -00  10 238 232 213  44  11  93 light bg highlights
" base3     #fdf6e3 none   15/7 brwhite  230 #ffffd7 97  00  10 253 246 227  44  10  99 light bg
" yellow    #b58900 3      3/3 yellow   136 #af8700 60  10  65 181 137   0  45 100  71
" orange    #cb4b16 9      9/3 brred    166 #d75f00 50  50  55 203  75  22  18  89  80
" red       #dc322f 1      1/1 red      160 #d70000 50  65  45 220  50  47   1  79  86
" magenta   #d33682 5      5/5 magenta  125 #af005f 50  65 -05 211  54 130 331  74  83
" violet    #6c71c4 13     13/5 brmagenta 61 #5f5faf 50  15 -45 108 113 196 237  45  77
" blue      #267bd2 4      4/4 blue      33 #0087ff 55 -10 -45  38 139 210 205  82  82
" cyan      #2aa198 6      6/6 cyan      37 #00afaf 60 -35 -05  42 161 152 175  74  
" green     #859900 2      2/2 green     64 #5f8700 60 -20  65 133 153   0  68 100  60
"

" -----------------------------------------------------------------------------
" Solarized bases. Used for various bg / fg elements. They are grouped
" as follows: base*{3, 2} for backgrounds and base*{0, 1} for content.
" The values are permutead via 0x <-> _x upon background mode switch.
" 
" Rather than permuate the Solarized names, we introduce background mode
" independent scheme.
" i  name dark     light   DESC
" -  ---- -------- ------- ----------------
" 0  bg0  base03   base_3  main bg 
" 1  base02  base02   base_2  bg highlights
" 2  base01  base01   base_1  fg comments
" 3  base00  base00   base_0  Inactive statusline bg. 
" 4  base_0  base_0   base00  fg
" 5  base_1  base_1   base01  fg emphasis, active statusline bg (reversed!)  
" 6  bg2  base_2   base02  ? 
" 7  bg3  base_3   base03  Unused(?) (except in contrast shifts).   

" Define the 8 base colors.
let s:bases = [
            \ ['#002b36', 'None'],
            \ ['#073642', 0],
            \ ['#586e75', 8],
            \ ['#657b83', 'None'],
            \ ["#839496", 'None'],
            \ ["#93a1a1", 7],
            \ ["#eee8d5", 15],
            \ ["#fdf6e3", 'None'],
            \ ]


" Define canonical colors.
" - black / white (Bright white) are secondary background colors.
" - light / dark gray are secondary emphasis foreground colors. 
" - Main foreground and background colors use terminal defaults.
let s:black0   = s:bases[1]
let s:red0     = ["#dc322f",  1]
let s:green0   = ["#859900",  2]
let s:yellow0  = ["#b58900",  3]
let s:blue0    = ["#268bd2",  4]
let s:magenta0 = ["#d33682",  5]
let s:cyan0    = ["#2aa198",  6]
let s:white0   = s:bases[5]
let s:black1   = s:bases[2]
let s:red1     = ["#cb4b16",  9]
let s:green1   = ['#96ad00', 10]
let s:yellow1  = ['#e2ab00', 11]
let s:blue1    = ["#268bd2", 12]
let s:magenta1 = ["#6c71c4", 13]
let s:cyan1    = ["#2aa198", 14] 
let s:white1   = s:bases[6]

let s:black = s:black0
let s:red = s:red0
let s:green = s:green0
let s:yellow = s:yellow0
let s:blue = s:blue0
let s:magenta = s:magenta0
let s:cyan = s:cyan0
let s:lightgray = s:white0
let s:darkgray = s:black1
let s:orange = s:red1
let s:violet = s:magenta1
let s:white = s:white1


" Swap dark and light colors if light mode is explicitly set.
if &background == "light"
    let s:bases = reverse(s:bases)
endif

let s:base03 = s:bases[0]
let s:base02 = s:bases[1]
let s:base01 = s:bases[2]
let s:base00 = s:bases[3]
let s:base_0 = s:bases[4]
let s:base_1 = s:bases[5]
let s:base_2 = s:bases[6]
let s:base_3 = s:bases[7]

" -----------------------------------------------------------------------------
" Emphasis values. Elements are gui/cterm, guisp
let s:none  = ['None', 'None']
let s:reverse = ['reverse ', 'None']

if get(g:, 'sim#emphasis', 1)
    let s:italic = ['italic', 'None']
    let s:bold = ['bold', 'None']
    let s:underline = ['underline', 'None']
    let s:undercurl = ['undercurl', 'undercurl']
    let s:bold_italic = ['bold,italic', 'None']
    let s:bold_italic_underline = ['bold,italic,underline', 'None']
    let s:bold_underline = ['bold,underline', 'None']
    let s:italic_underline = ['italic,underline', 'None']
else
    let s:italic = s:none
    let s:bold = s:none
    let s:underline = s:none
    let s:undercurl = s:none
    let s:italic = s:none 
    let s:bold_italic = s:none 
    let s:bold_underline = s:none 
    let s:italic_underline = s:none 
endif

" -----------------------------------------------------------------------------
" ANSI 16 Colors.
" In terminal mode without `termguicolors` set we fallback to the values
" provided by the emulator.
" TODO: Define experimental versions of bright colors.
" - [x] Right Red / Orange (by Solarized)
" - [x] Bright Magenta / Violet (Solarized)
" - [x] Bright Black / Dark Gray (Solarized content 0)
" - [x] Dark White / Light Gray (Solarized content 4)
" - [x] Bright White (Solarized light background)


" -----------------------------------------------------------------------------
" Vim terminal buffer colors.
let g:terminal_ansi_colors = [
            \ s:black0[0],
            \ s:red0[0],
            \ s:green0[0],
            \ s:yellow0[0],
            \ s:blue0[0],
            \ s:magenta0[0],
            \ s:cyan0[0],
            \ s:white0[0],
            \ s:black1[0],
            \ s:red1[0],
            \ s:green1[0],
            \ s:yellow1[0],
            \ s:blue1[0],
            \ s:magenta1[0],
            \ s:cyan1[0],
            \ s:white1[0],
            \ ]

" -----------------------------------------------------------------------------
" Neovim terminal buffer colors
if has('nvim')
    let g:terminal_color_0  = g:terminal_ansi_colors[0]
    let g:terminal_color_1  = g:terminal_ansi_colors[1]
    let g:terminal_color_2  = g:terminal_ansi_colors[2]
    let g:terminal_color_3  = g:terminal_ansi_colors[3]
    let g:terminal_color_4  = g:terminal_ansi_colors[4]
    let g:terminal_color_5  = g:terminal_ansi_colors[5]
    let g:terminal_color_6  = g:terminal_ansi_colors[6]
    let g:terminal_color_7  = g:terminal_ansi_colors[7]
    let g:terminal_color_8  = g:terminal_ansi_colors[8]
    let g:terminal_color_9  = g:terminal_ansi_colors[9]
    let g:terminal_color_10 = g:terminal_ansi_colors[10]
    let g:terminal_color_11 = g:terminal_ansi_colors[11]
    let g:terminal_color_12 = g:terminal_ansi_colors[12]
    let g:terminal_color_13 = g:terminal_ansi_colors[13]
    let g:terminal_color_14 = g:terminal_ansi_colors[14]
    let g:terminal_color_15 = g:terminal_ansi_colors[15]
endif

" Define a map of special characters. Can recent if no special
" let s:special['italic'] = 'italic'
" let s:special['bold'] = 'bold'

" -----------------------------------------------------------------------------
"  Predefined groups to link to.
function! s:hi(group, emph, fg, bg)
    " Arguments: group: str, emphasis: array, foreground: array, background: array.
      " let histring = [
      "       \ 'hi! ',    . a:group,
      "       \ 'guifg='   . a:fg[0],
      "       \ 'ctermfg=' . a:fg[1],
      "       \ 'guibg='   . a:bg[0],
      "       \ 'ctermbg=' . a:bg[1],
      "       \ 'gui='     . a:emph[0],
      "       \ 'cterm='   . a:emph[1]
      "       \ ]
      " execute join(histring, ' ')
      " if empty(a:fg)
      "     let fg = ['None', 'None']
      " elseif len(a:fg) == 1
      "     let fg = add(a:fg, 'None')
      " endif

      " if empty(a:bg)
      "     let bg = ['None', 'None']
      " elseif len(a:bg) == 1
      "     let bg = add(a:bg, 'None')
      " endif

      " if empty(a:emph)
      "     let emph = ['None', 'None']
      " elseif len(a:em) == 1
      "     let emph = add(a:emph, 'None')
      " endif

      execute 'hi '  . a:group
                  \  . ' gui='     . a:emph[0]
                  \  . ' guisp='   . a:emph[1]
                  \  . ' cterm='   . a:emph[0]
                  \  . ' guifg='   . a:fg[0]
                  \  . ' ctermfg=' . a:fg[1]
                  \  . ' guibg='   . a:bg[0]
                  \  . ' ctermbg=' . a:bg[1]
endfunction

" Memoize certain common groups
call s:hi('SimBlack', s:none, s:black0, s:none)
call s:hi('SimRed', s:none, s:red0, s:none)
call s:hi('SimBoldRed', s:bold, s:red0, s:none)
call s:hi('SimItalicRed', s:italic, s:red0, s:none)
call s:hi('SimOrange', s:none, s:red1, s:none)
call s:hi('SimBoldOrange', s:bold, s:red1, s:none)
call s:hi('SimItalicOrange', s:italic, s:red1, s:none)
call s:hi('SimYellow', s:none, s:yellow0, s:none)
call s:hi('SimBoldYellow', s:bold, s:yellow0, s:none)
call s:hi('SimItalicYellow', s:italic, s:yellow0, s:none)
call s:hi('SimBrightYellow', s:none, s:yellow1, s:none)
call s:hi('SimBlue', s:none, s:blue0, s:none)
call s:hi('SimBoldBlue', s:bold, s:blue0, s:none)
call s:hi('SimItalicBlue', s:italic, s:blue0, s:none)
call s:hi('SimBrightBlue', s:none, s:blue1, s:none)
call s:hi('SimGreen', s:none, s:green0, s:none)
call s:hi('SimBoldGreen', s:bold, s:green0, s:none)
call s:hi('SimItalicGreen', s:italic, s:green0, s:none)
call s:hi('SimBrightGreen', s:none, s:green1, s:none)
call s:hi('SimCyan', s:none, s:cyan0, s:none)
call s:hi('SimBoldCyan', s:bold, s:cyan0, s:none)
call s:hi('SimItalicCyan', s:italic, s:cyan0, s:none)
call s:hi('SimBrightCyan', s:none, s:cyan1, s:none)
call s:hi('SimMagenta', s:none, s:magenta0, s:none)
call s:hi('SimBoldMagenta', s:bold, s:magenta0, s:none)
call s:hi('SimItalicMagenta', s:italic, s:magenta0, s:none)
call s:hi('SimViolet', s:none, s:magenta1, s:none)
call s:hi('SimBoldViolet', s:bold, s:magenta1, s:none)
call s:hi('SimItalicViolet', s:italic, s:magenta1, s:none)
call s:hi('SimLightGray', s:none, s:white0, s:none)
call s:hi('SimBoldLightGray', s:bold, s:white0, s:none)
call s:hi('SimItalicLightGray', s:italic, s:white0, s:none)
call s:hi('SimDarkGray', s:none, s:black1, s:none)
call s:hi('SimBoldDarkGray', s:bold, s:black1, s:none)
call s:hi('SimItalicDarkGray', s:italic, s:black1, s:none)
call s:hi('SimWhite', s:none, s:white1, s:none)
call s:hi('SimBoldWhite', s:bold, s:white1, s:none)
call s:hi('SimItalicWhite', s:italic, s:white1, s:none)

call s:hi('SimBackgroundHi', s:none, s:none, s:base02)


" -----------------------------------------------------------------------------
" Basic highlighting"{{{
"
" Normal text uses no foreground / background in terminal mode when  
" termguicolors is not set.
call s:hi('Normal',  s:none,   s:base_0, s:base03)
call s:hi('Comment', s:italic, s:base01, s:none)
""       *Comment         any comment

hi! link Constant SimCyan
hi! link Number SimViolet 
hi! link Boolean SimOrange
hi! link Float SimWhite
""       *Constant        any constant
""        String          a string constant: "this is a string"
""        Character       a character constant: 'c', '\n'
""        Number          a number constant: 234, 0xff
""        Boolean         a boolean constant: TRUE, false
""        Float           a floating point constant: 2.3e10

hi! link Identifier SimBlue
" hi! link Function SimBoldBlue
" call s:hi("Identifier"     ,s:none,   s:blue   s:none
""       *Identifier      any variable name
""        Function        function name (also: methods for classes)

" TODO: Square these away.
hi! link Statement SimGreen
" hi! link Keyword SimMagenta 
" hi! link Conditional SimYellow
" hi! link Repeat SimOrange 
" hi! link Label SimCyan
" hi! link Operator SimYellow
" hi! link Exception SimOrange 
"call s:hi("Statement"      ,s:none,   s:green  s:none
""       *Statement       any statement
""        Conditional     if, then, else, endif, switch, etc.
""        Repeat          for, do, while, etc.
""        Label           case, default, etc.
""        Operator        "sizeof", "+", "*", etc.
""        Keyword         any other keyword
""        Exception       try, catch, throw

hi! link PreProc SimBoldOrange
"call s:hi("PreProc"        ,s:none,   s:orange s:none
""       *PreProc         generic Preprocessor
""        Include         preprocessor #include
""        Define          preprocessor #define
""        Macro           same as Define
""        PreCondit       preprocessor #if, #else, #endif, etc.

hi! link Type SimYellow
hi! link StorageClass SimYellow
hi! link Structure SimOrange 
"call s:hi("Type"           ,s:none,   s:yellow s:none
""       *Type            int, long, char, etc.
""        StorageClass    static, register, volatile, etc.
""        Structure       struct, union, enum, etc.
""        Typedef         A typedef

hi! link Special SimRed 
hi! link Delimiter SimOrange
hi! link Debug SimBoldRed
"call s:hi("Special"        ,s:none,   ,s:red0    s:none
""       *Special         any special symbol
""        SpecialChar     special character in a constant
""        Tag             you can use CTRL-] on this
""        Delimiter       character that needs attention
""        SpecialComment  special things inside a comment
""        Debug           debugging statements

call s:hi('Underlined', s:underline, s:magenta1, s:none)
"call s:hi("Underlined"     ,s:none,   s:violet s:none
""       *Underlined      text that stands out, HTML links

call s:hi('Ignore', s:none, s:none, s:none)
"call s:hi("Ignore"         ,s:none,   s:none   s:none
""       *Ignore          left blank, hidden  |hl-Ignore|

hi! link Error SimBoldRed
"call s:hi("Error"          ,s:bold,   ,s:red0    s:none
""       *Error           any erroneous construct

hi! link Todo SimBoldMagenta
""       *Todo            anything that needs extra attention; mostly the
""                        keywords TODO FIXME and XXX
""
" -----------------------------------------------------------------------------
" Extended highlighting 
call s:hi('SpecialKey',      s:bold, s:base00, s:base02) 
call s:hi("NonText",         s:bold, s:base00, s:none)
call s:hi("StatusLine",      s:reverse,  s:none, s:none)
call s:hi("StatusLineNC",    s:reverse,  s:base01, s:none)
" TODO: Figure out visual.
call s:hi("Visual",          s:none,   s:none, s:base02)
" call s:hi("Visual",          s:reverse,   s:base01, s:base03)
call s:hi("Directory",       s:none,   s:blue0,   s:none)
call s:hi("ErrorMsg",        s:bold, s:red0,   s:none)
call s:hi("IncSearch",       s:reverse, s:red1,   s:none)
call s:hi("Search",          s:reverse,  s:yellow0, s:none)
call s:hi("MoreMsg",        s:none,   s:blue0,   s:none)
call s:hi("ModeMsg",        s:none,   s:blue0,   s:none)
call s:hi("LineNr",         s:none,    s:base01, s:base02)
call s:hi("Question",       s:bold,   s:cyan0,   s:none)
call s:hi("VertSplit",      s:none,   s:base00, s:none)
hi! link Title SimBoldOrange
"call s:hi("VisualNOS"      ,s:fmt_stnd   s:none   s:base02 ,s:fmt_revbb)
"call s:hi("WarningMsg"     ,s:bold,   ,s:red0    s:none)
call s:hi("WildMenu",       s:reverse,   s:base_2,  s:base02)
" call s:hi("Folded"         ,s:bold,   s:base_0  s:base02  ,s:sp_base03)
"call s:hi("FoldColumn"     ,s:none,   s:base_0  s:base02)

" call s:hi("DiffAdd"        ,s:bold,   s:green  s:base02 ,s:sp_green)
" call s:hi("DiffChange"     ,s:bold,   s:yellow s:base02 ,s:sp_yellow)
" call s:hi("DiffDelete"     ,s:bold,   ,s:red0    s:base02)
" call s:hi("DiffText"       ,s:bold,   s:blue   s:base02 ,s:sp_blue)
call s:hi('DiffAdd', s:bold, s:green0, s:base02)
call s:hi('DiffChange', s:bold, s:yellow0, s:base02)
call s:hi('DiffDelete', s:bold, s:red0, s:base02)
call s:hi('DiffText', s:bold, s:red0, s:base02)

call s:hi("SignColumn",     s:none,   s:none,  s:none)
"call s:hi("Conceal"        ,s:none,   s:blue   s:none)
"call s:hi("SpellBad"       ,s:fmt_curl   s:none   s:none    ,s:sp_red)
"call s:hi("SpellCap"       ,s:fmt_curl   s:none   s:none    ,s:sp_violet)
"call s:hi("SpellRare",     s:fmt_curl   s:none   s:none    ,s:sp_cyan)
"call s:hi("SpellLocal",    s:fmt_curl   s:none   s:none    ,s:sp_yellow)
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
call s:hi("CursorLineNr",   s:bold, s:none,  s:base02)
call s:hi("Cursor",         s:none,   s:base03, s:base_0)
hi! link lCursor Cursor
call s:hi("MatchParen", s:bold, s:none, s:base_3)

"" -----------------------------------------------------------------------------
"" vim syntax highlighting "{{{
""exe "hi! vimLineComment" . s:fg_base01 .s:bg_none   .s:fmt_ital
""hi! link vimComment Comment
""hi! link vimLineComment Comment
 "hi! link vimVar Identifier
" hi! link vimFunc Function
"hi! link vimUserFunc Function
"hi! link helpSpecial Special
"hi! link vimSet Normal
"hi! link vimSetEqual Normal
"exe "hi! vimCommentString"  .s:fmt_none    .s:fg_violet .s:bg_none
"exe "hi! vimCommand"        .s:fmt_none    .s:fg_yellow .s:bg_none
"exe "hi! vimCmdSep"         .s:fmt_bold    .s:fg_blue   .s:bg_none
"exe "hi! helpExample"       .s:fmt_none    .s:fg_base1  .s:bg_none
"exe "hi! helpOption"        .s:fmt_none    .s:fg_cyan   .s:bg_none
"exe "hi! helpNote"          .s:fmt_none    .s:fg_magenta.s:bg_none
"exe "hi! helpVim"           .s:fmt_none    .s:fg_magenta.s:bg_none
"exe "hi! helpHyperTextJump" .s:fmt_undr    .s:fg_blue   .s:bg_none
"exe "hi! helpHyperTextEntry".s:fmt_none    .s:fg_green  .s:bg_none
"exe "hi! vimIsCommand"      .s:fmt_none    .s:fg_base00 .s:bg_none
"exe "hi! vimSynMtchOpt"     .s:fmt_none    .s:fg_yellow .s:bg_none
"exe "hi! vimSynType"        .s:fmt_none    .s:fg_cyan   .s:bg_none
"exe "hi! vimHiLink"         .s:fmt_none    .s:fg_blue   .s:bg_none
"exe "hi! vimHiGroup"        .s:fmt_none    .s:fg_blue   .s:bg_none
"exe "hi! vimGroup"          .s:fmt_undb    .s:fg_blue   .s:bg_none
""}}}

"" diff highlighting "{{{
"" ---------------------------------------------------------------------
" hi! link diffAdded Statement
" hi! link diffLine Identifier
""}}}

"" git & gitcommit highlighting "{{{
""git
""exe "hi! gitDateHeader"
""exe "hi! gitIdentityHeader"
""exe "hi! gitIdentityKeyword"
""exe "hi! gitNotesHeader"
""exe "hi! gitReflogHeader"
""exe "hi! gitKeyword"
""exe "hi! gitIdentity"
""exe "hi! gitEmailDelimiter"
""exe "hi! gitEmail"
""exe "hi! gitDate"
""exe "hi! gitMode"
""exe "hi! gitHashAbbrev"
""exe "hi! gitHash"
""exe "hi! gitReflogMiddle"
""exe "hi! gitReference"
""exe "hi! gitStage"
""exe "hi! gitType"
""exe "hi! gitDiffAdded"
""exe "hi! gitDiffRemoved"
""gitcommit
""exe "hi! gitcommitSummary"
"exe "hi! gitcommitComment"      .s:fmt_ital     .s:fg_base01    .s:bg_none
"hi! link gitcommitUntracked gitcommitComment
"hi! link gitcommitDiscarded gitcommitComment
"hi! link gitcommitSelected  gitcommitComment
"exe "hi! gitcommitUnmerged"     .s:fmt_bold     .s:fg_green     .s:bg_none
"exe "hi! gitcommitOnBranch"     .s:fmt_bold     .s:fg_base01    .s:bg_none
"exe "hi! gitcommitBranch"       .s:fmt_bold     .s:fg_magenta   .s:bg_none
"hi! link gitcommitNoBranch gitcommitBranch
"exe "hi! gitcommitDiscardedType".s:fmt_none     .s:fg_red       .s:bg_none
"exe "hi! gitcommitSelectedType" .s:fmt_none     .s:fg_green     .s:bg_none
""exe "hi! gitcommitUnmergedType"
""exe "hi! gitcommitType"
""exe "hi! gitcommitNoChanges"
""exe "hi! gitcommitHeader"
"exe "hi! gitcommitHeader"       .s:fmt_none     .s:fg_base01    .s:bg_none
"exe "hi! gitcommitUntrackedFile".s:fmt_bold     .s:fg_cyan      .s:bg_none
"exe "hi! gitcommitDiscardedFile".s:fmt_bold     .s:fg_red       .s:bg_none
"exe "hi! gitcommitSelectedFile" .s:fmt_bold     .s:fg_green     .s:bg_none
"exe "hi! gitcommitUnmergedFile" .s:fmt_bold     .s:fg_yellow    .s:bg_none
"exe "hi! gitcommitFile"         .s:fmt_bold     .s:fg_base_0     .s:bg_none
"hi! link gitcommitDiscardedArrow gitcommitDiscardedFile
"hi! link gitcommitSelectedArrow  gitcommitSelectedFile
"hi! link gitcommitUnmergedArrow  gitcommitUnmergedFile
""exe "hi! gitcommitArrow"
""exe "hi! gitcommitOverflow"
""exe "hi! gitcommitBlank"
"" }}}
""
"" html highlighting "{{{
"" ---------------------------------------------------------------------
"exe "hi! htmlTag"           .s:fmt_none .s:fg_base01 .s:bg_none
"exe "hi! htmlEndTag"        .s:fmt_none .s:fg_base01 .s:bg_none
"exe "hi! htmlTagN"          .s:fmt_bold .s:fg_base1  .s:bg_none
"exe "hi! htmlTagName"       .s:fmt_bold .s:fg_blue   .s:bg_none
"exe "hi! htmlSpecialTagName".s:fmt_ital .s:fg_blue   .s:bg_none
"exe "hi! htmlArg"           .s:fmt_none .s:fg_base00 .s:bg_none
"exe "hi! javaScript"        .s:fmt_none .s:fg_yellow .s:bg_none
""}}}

"" perl highlighting "{{{
"" ---------------------------------------------------------------------
"exe "hi! perlHereDoc"    . s:fg_base1  .s:bg_back   .s:fmt_none
"exe "hi! perlVarPlain"   . s:fg_yellow .s:bg_back   .s:fmt_none
"exe "hi! perlStatementFileDesc". s:fg_cyan.s:bg_back.s:fmt_none

""}}}

"" tex highlighting "{{{
"" ---------------------------------------------------------------------
"exe "hi! texStatement"   . s:fg_cyan   .s:bg_back   .s:fmt_none
"exe "hi! texMathZoneX"   . s:fg_yellow .s:bg_back   .s:fmt_none
"exe "hi! texMathMatcher" . s:fg_yellow .s:bg_back   .s:fmt_none
"exe "hi! texMathMatcher" . s:fg_yellow .s:bg_back   .s:fmt_none
"exe "hi! texRefLabel"    . s:fg_yellow .s:bg_back   .s:fmt_none
""}}}

"" ruby highlighting "{{{
"" ---------------------------------------------------------------------
"exe "hi! rubyDefine"     . s:fg_base1  .s:bg_back   .s:fmt_bold
""rubyInclude
""rubySharpBang
""rubyAccess
""rubyPredefinedVariable
""rubyBoolean
""rubyClassVariable
""rubyBeginEnd
""rubyRepeatModifier
""hi! link rubyArrayDelimiter    Special  " [ , , ]
""rubyCurlyBlock  { , , }

""hi! link rubyClass             Keyword
""hi! link rubyModule            Keyword
""hi! link rubyKeyword           Keyword
""hi! link rubyOperator          Operator
""hi! link rubyIdentifier        Identifier
""hi! link rubyInstanceVariable  Identifier
""hi! link rubyGlobalVariable    Identifier
""hi! link rubyClassVariable     Identifier
""hi! link rubyConstant          Type
""}}}

"" haskell syntax highlighting"{{{
"" ---------------------------------------------------------------------
"" For use with syntax/haskell.vim : Haskell Syntax File
"" http://www.vim.org/scripts/script.php?script_id=3034
"" See also Steffen Siering's github repository:
"" http://github.com/urso/dotrc/blob/master/vim/syntax/haskell.vim
"" ---------------------------------------------------------------------
""
"" Treat True and False specially, see the plugin referenced above
"let hs_highlight_boolean=1
"" highlight delims, see the plugin referenced above
"let hs_highlight_delimiters=1

"exe "hi! cPreCondit". s:fg_orange.s:bg_none   .s:fmt_none

"exe "hi! VarId"    . s:fg_blue   .s:bg_none   .s:fmt_none
"exe "hi! ConId"    . s:fg_yellow .s:bg_none   .s:fmt_none
"exe "hi! hsImport" . s:fg_magenta.s:bg_none   .s:fmt_none
"exe "hi! hsString" . s:fg_base00 .s:bg_none   .s:fmt_none

"exe "hi! hsStructure"        . s:fg_cyan   .s:bg_none   .s:fmt_none
"exe "hi! hs_hlFunctionName"  . s:fg_blue   .s:bg_none
"exe "hi! hsStatement"        . s:fg_cyan   .s:bg_none   .s:fmt_none
"exe "hi! hsImportLabel"      . s:fg_cyan   .s:bg_none   .s:fmt_none
"exe "hi! hs_OpFunctionName"  . s:fg_yellow .s:bg_none   .s:fmt_none
"exe "hi! hs_DeclareFunction" . s:fg_orange .s:bg_none   .s:fmt_none
"exe "hi! hsVarSym"           . s:fg_cyan   .s:bg_none   .s:fmt_none
"exe "hi! hsType"             . s:fg_yellow .s:bg_none   .s:fmt_none
"exe "hi! hsTypedef"          . s:fg_cyan   .s:bg_none   .s:fmt_none
"exe "hi! hsModuleName"       . s:fg_green  .s:bg_none   .s:fmt_undr
"exe "hi! hsModuleStartLabel" . s:fg_magenta.s:bg_none   .s:fmt_none
"hi! link hsImportParams      Delimiter
"hi! link hsDelimTypeExport   Delimiter
"hi! link hsModuleStartLabel  hsStructure
"hi! link hsModuleWhereLabel  hsModuleStartLabel

"" following is for the haskell-conceal plugin
"" the first two items don't have an impact, but better safe
"exe "hi! hsNiceOperator"     . s:fg_cyan   .s:bg_none   .s:fmt_none
"exe "hi! hsniceoperator"     . s:fg_cyan   .s:bg_none   .s:fmt_none

""}}}

"" pandoc markdown syntax highlighting "{{{
"" ---------------------------------------------------------------------

""PandocHiLink pandocNormalBlock
"exe "hi! pandocTitleBlock"               .s:fg_blue   .s:bg_none   .s:fmt_none
"exe "hi! pandocTitleBlockTitle"          .s:fg_blue   .s:bg_none   .s:fmt_bold
"exe "hi! pandocTitleComment"             .s:fg_blue   .s:bg_none   .s:fmt_bold
"exe "hi! pandocComment"                  .s:fg_base01 .s:bg_none   .s:fmt_ital
"exe "hi! pandocVerbatimBlock"            .s:fg_yellow .s:bg_none   .s:fmt_none
"hi! link pandocVerbatimBlockDeep         pandocVerbatimBlock
"hi! link pandocCodeBlock                 pandocVerbatimBlock
"hi! link pandocCodeBlockDelim            pandocVerbatimBlock
"exe "hi! pandocBlockQuote"               .s:fg_blue   .s:bg_none   .s:fmt_none
"exe "hi! pandocBlockQuoteLeader1"        .s:fg_blue   .s:bg_none   .s:fmt_none
"exe "hi! pandocBlockQuoteLeader2"        .s:fg_cyan   .s:bg_none   .s:fmt_none
"exe "hi! pandocBlockQuoteLeader3"        .s:fg_yellow .s:bg_none   .s:fmt_none
"exe "hi! pandocBlockQuoteLeader4"        .s:fg_red    .s:bg_none   .s:fmt_none
"exe "hi! pandocBlockQuoteLeader5"        .s:fg_base_0  .s:bg_none   .s:fmt_none
"exe "hi! pandocBlockQuoteLeader6"        .s:fg_base01 .s:bg_none   .s:fmt_none
"exe "hi! pandocListMarker"               .s:fg_magenta.s:bg_none   .s:fmt_none
"exe "hi! pandocListReference"            .s:fg_magenta.s:bg_none   .s:fmt_undr

"" Definitions
"" ---------------------------------------------------------------------
"let s:fg_pdef = s:fg_violet
"exe "hi! pandocDefinitionBlock"              .s:fg_pdef  .s:bg_none  .s:fmt_none
"exe "hi! pandocDefinitionTerm"               .s:fg_pdef  .s:bg_none  .s:fmt_stnd
"exe "hi! pandocDefinitionIndctr"             .s:fg_pdef  .s:bg_none  .s:fmt_bold
"exe "hi! pandocEmphasisDefinition"           .s:fg_pdef  .s:bg_none  .s:fmt_ital
"exe "hi! pandocEmphasisNestedDefinition"     .s:fg_pdef  .s:bg_none  .s:fmt_bldi
"exe "hi! pandocStrongEmphasisDefinition"     .s:fg_pdef  .s:bg_none  .s:fmt_bold
"exe "hi! pandocStrongEmphasisNestedDefinition"   .s:fg_pdef.s:bg_none.s:fmt_bldi
"exe "hi! pandocStrongEmphasisEmphasisDefinition" .s:fg_pdef.s:bg_none.s:fmt_bldi
"exe "hi! pandocStrikeoutDefinition"          .s:fg_pdef  .s:bg_none  .s:reverse
"exe "hi! pandocVerbatimInlineDefinition"     .s:fg_pdef  .s:bg_none  .s:fmt_none
"exe "hi! pandocSuperscriptDefinition"        .s:fg_pdef  .s:bg_none  .s:fmt_none
"exe "hi! pandocSubscriptDefinition"          .s:fg_pdef  .s:bg_none  .s:fmt_none

"" Tables
"" ---------------------------------------------------------------------
"let s:fg_ptable = s:fg_blue
"exe "hi! pandocTable"                        .s:fg_ptable.s:bg_none  .s:fmt_none
"exe "hi! pandocTableStructure"               .s:fg_ptable.s:bg_none  .s:fmt_none
"hi! link pandocTableStructureTop             pandocTableStructre
"hi! link pandocTableStructureEnd             pandocTableStructre
"exe "hi! pandocTableZebraLight"              .s:fg_ptable.s:bg_base03.s:fmt_none
"exe "hi! pandocTableZebraDark"               .s:fg_ptable.s:bg_base02.s:fmt_none
"exe "hi! pandocEmphasisTable"                .s:fg_ptable.s:bg_none  .s:fmt_ital
"exe "hi! pandocEmphasisNestedTable"          .s:fg_ptable.s:bg_none  .s:fmt_bldi
"exe "hi! pandocStrongEmphasisTable"          .s:fg_ptable.s:bg_none  .s:fmt_bold
"exe "hi! pandocStrongEmphasisNestedTable"    .s:fg_ptable.s:bg_none  .s:fmt_bldi
"exe "hi! pandocStrongEmphasisEmphasisTable"  .s:fg_ptable.s:bg_none  .s:fmt_bldi
"exe "hi! pandocStrikeoutTable"               .s:fg_ptable.s:bg_none  .s:reverse
"exe "hi! pandocVerbatimInlineTable"          .s:fg_ptable.s:bg_none  .s:fmt_none
"exe "hi! pandocSuperscriptTable"             .s:fg_ptable.s:bg_none  .s:fmt_none
"exe "hi! pandocSubscriptTable"               .s:fg_ptable.s:bg_none  .s:fmt_none

"" Headings
"" ---------------------------------------------------------------------
"let s:fg_phead = s:fg_orange
"exe "hi! pandocHeading"                      .s:fg_phead .s:bg_none.s:fmt_bold
"exe "hi! pandocHeadingMarker"                .s:fg_yellow.s:bg_none.s:fmt_bold
"exe "hi! pandocEmphasisHeading"              .s:fg_phead .s:bg_none.s:fmt_bldi
"exe "hi! pandocEmphasisNestedHeading"        .s:fg_phead .s:bg_none.s:fmt_bldi
"exe "hi! pandocStrongEmphasisHeading"        .s:fg_phead .s:bg_none.s:fmt_bold
"exe "hi! pandocStrongEmphasisNestedHeading"  .s:fg_phead .s:bg_none.s:fmt_bldi
"exe "hi! pandocStrongEmphasisEmphasisHeading".s:fg_phead .s:bg_none.s:fmt_bldi
"exe "hi! pandocStrikeoutHeading"             .s:fg_phead .s:bg_none.s:reverse
"exe "hi! pandocVerbatimInlineHeading"        .s:fg_phead .s:bg_none.s:fmt_bold
"exe "hi! pandocSuperscriptHeading"           .s:fg_phead .s:bg_none.s:fmt_bold
"exe "hi! pandocSubscriptHeading"             .s:fg_phead .s:bg_none.s:fmt_bold

"" Links
"" ---------------------------------------------------------------------
"exe "hi! pandocLinkDelim"                .s:fg_base01 .s:bg_none   .s:fmt_none
"exe "hi! pandocLinkLabel"                .s:fg_blue   .s:bg_none   .s:fmt_undr
"exe "hi! pandocLinkText"                 .s:fg_blue   .s:bg_none   .s:fmt_undb
"exe "hi! pandocLinkURL"                  .s:fg_base00 .s:bg_none   .s:fmt_undr
"exe "hi! pandocLinkTitle"                .s:fg_base00 .s:bg_none   .s:fmt_undi
"exe "hi! pandocLinkTitleDelim"           .s:fg_base01 .s:bg_none   .s:fmt_undi   .s:sp_base00
"exe "hi! pandocLinkDefinition"           .s:fg_cyan   .s:bg_none   .s:fmt_undr   .s:sp_base00
"exe "hi! pandocLinkDefinitionID"         .s:fg_blue   .s:bg_none   .s:fmt_bold
"exe "hi! pandocImageCaption"             .s:fg_violet .s:bg_none   .s:fmt_undb
"exe "hi! pandocFootnoteLink"             .s:fg_green  .s:bg_none   .s:fmt_undr
"exe "hi! pandocFootnoteDefLink"          .s:fg_green  .s:bg_none   .s:fmt_bold
"exe "hi! pandocFootnoteInline"           .s:fg_green  .s:bg_none   .s:fmt_undb
"exe "hi! pandocFootnote"                 .s:fg_green  .s:bg_none   .s:fmt_none
"exe "hi! pandocCitationDelim"            .s:fg_magenta.s:bg_none   .s:fmt_none
"exe "hi! pandocCitation"                 .s:fg_magenta.s:bg_none   .s:fmt_none
"exe "hi! pandocCitationID"               .s:fg_magenta.s:bg_none   .s:fmt_undr
"exe "hi! pandocCitationRef"              .s:fg_magenta.s:bg_none   .s:fmt_none

"" Main Styles
"" ---------------------------------------------------------------------
"exe "hi! pandocStyleDelim"               .s:fg_base01 .s:bg_none  .s:fmt_none
"exe "hi! pandocEmphasis"                 .s:fg_base_0  .s:bg_none  .s:fmt_ital
"exe "hi! pandocEmphasisNested"           .s:fg_base_0  .s:bg_none  .s:fmt_bldi
"exe "hi! pandocStrongEmphasis"           .s:fg_base_0  .s:bg_none  .s:fmt_bold
"exe "hi! pandocStrongEmphasisNested"     .s:fg_base_0  .s:bg_none  .s:fmt_bldi
"exe "hi! pandocStrongEmphasisEmphasis"   .s:fg_base_0  .s:bg_none  .s:fmt_bldi
"exe "hi! pandocStrikeout"                .s:fg_base01 .s:bg_none  .s:reverse
"exe "hi! pandocVerbatimInline"           .s:fg_yellow .s:bg_none  .s:fmt_none
"exe "hi! pandocSuperscript"              .s:fg_violet .s:bg_none  .s:fmt_none
"exe "hi! pandocSubscript"                .s:fg_violet .s:bg_none  .s:fmt_none

"exe "hi! pandocRule"                     .s:fg_blue   .s:bg_none  .s:fmt_bold
"exe "hi! pandocRuleLine"                 .s:fg_blue   .s:bg_none  .s:fmt_bold
"exe "hi! pandocEscapePair"               .s:fg_red    .s:bg_none  .s:fmt_bold
"exe "hi! pandocCitationRef"              .s:fg_magenta.s:bg_none   .s:fmt_none
"exe "hi! pandocNonBreakingSpace"         . s:fg_red   .s:bg_none  .s:reverse
"hi! link pandocEscapedCharacter          pandocEscapePair
"hi! link pandocLineBreak                 pandocEscapePair

"" Embedded Code
"" ---------------------------------------------------------------------
"exe "hi! pandocMetadataDelim"            .s:fg_base01 .s:bg_none   .s:fmt_none
"exe "hi! pandocMetadata"                 .s:fg_blue   .s:bg_none   .s:fmt_none
"exe "hi! pandocMetadataKey"              .s:fg_blue   .s:bg_none   .s:fmt_none
"exe "hi! pandocMetadata"                 .s:fg_blue   .s:bg_none   .s:fmt_bold
"hi! link pandocMetadataTitle             pandocMetadata

""}}}

"" neomake highlighting "{{{
"" ---------------------------------------------------------------------
"exe "hi! NeomakeErrorSign"          . s:fg_orange   .s:bg_none   .s:fmt_none
"exe "hi! NeomakeWarningSign"        . s:fg_yellow   .s:bg_none   .s:fmt_none
"exe "hi! NeomakeMessageSign"        . s:fg_cyan     .s:bg_none   .s:fmt_none
"exe "hi! NeomakeNeomakeInfoSign"    . s:fg_green    .s:bg_none   .s:fmt_none

""}}}

"" gitgutter highlighting "{{{
"" ---------------------------------------------------------------------
"exe "hi! GitGutterAdd"              . s:fg_green    .s:bg_none  .s:fmt_none
"exe "hi! GitGutterChange"           . s:fg_yellow   .s:bg_none  .s:fmt_none
"exe "hi! GitGutterDelete"           . s:fg_red      .s:bg_none  .s:fmt_none
"exe "hi! GitGutterChangeDelete"     . s:fg_red      .s:bg_none  .s:fmt_none
"" }}}"

"" signify highlighting "{{{
"" ---------------------------------------------------------------------
call s:hi('SignifySignAdd', s:reverse, s:green0, s:none)
call s:hi('SignifySignChange', s:reverse, s:yellow0, s:none)
call s:hi('SignifySignDelete', s:reverse, s:red0, s:none)
call s:hi('SignifySignChangeDelete', s:reverse, s:red0, s:none)
"exe "hi! SignifySignAdd"            . s:fg_green    .s:bg_none  .s:fmt_none
"exe "hi! SignifySignChange"         . s:fg_yellow   .s:bg_none  .s:fmt_none
"exe "hi! SignifySignDelete"         . s:fg_red      .s:bg_none  .s:fmt_none
"exe "hi! SignifySignChangeDelete"   . s:fg_red      .s:bg_none  .s:fmt_none
"" }}}"

"" ALE highlighting "{{{
"" ---------------------------------------------------------------------
"exe "hi! ALEErrorSign"          . s:fg_orange   .s:bg_none   .s:fmt_none
"exe "hi! ALEWarningSign"        . s:fg_yellow   .s:bg_none   .s:fmt_none
"" }}}"
