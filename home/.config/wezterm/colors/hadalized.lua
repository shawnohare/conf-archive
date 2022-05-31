local function hsluv(val)
    return val
end
-- ---------------------------------------------------------------------------
-- palette
-- Colors are drawn from the okhsl(h, 100, l) color space
-- ---------------------------------------------------------------------------
--
-- okhsl(h, 100, l).
-- Static colors used in both light and dark modes.
local color = {
    -- okhsl hue values for color.
    hues = {
        red     = 025,
        orange  = 055,
        yellow  = 110,
        green   = 130,
        spring  = 155,
        cyan    = 185,
        blue    = 245,
        violet  = 290,
        magenta = 330,
        cerise  = 345,
        rose    = 360,
    },
    -- okhsl(h, 100, 50)
    l50 = {
        red     = hsluv('#df0024'),
        orange  = hsluv('#b45c00'),
        yellow  = hsluv('#7c7d00'),
        green   = hsluv('#588800'),
        spring  = hsluv('#008e50'),
        cyan    = hsluv('#008a7f'),
        blue    = hsluv('#007dc5'),
        violet  = hsluv('#7e43ff'),
        magenta = hsluv('#c300bd'),
        rose    = hsluv('#d70072'),
    },
    -- okhsl(h, 100, 55)
    l55 = {
        red     = hsluv('#f60029'),
        orange  = hsluv('#c76600'),
        yellow  = hsluv('#898a00'),
        green   = hsluv('#629600'), -- h=130
        spring  = hsluv('#009d5a'), -- h=155
        cyan    = hsluv('#00988c'),
        blue    = hsluv('#008ad9'),
        violet  = hsluv('#885eff'),
        magenta = hsluv('#d700d0'), -- h=330
        cerise  = hsluv('#e400a6'),
        rose    = hsluv('#ed007e'), -- h=360
        -- green   = hsluv('#4f9a00'),
        -- green   = hsluv('#009e48'), -- h=150
        -- violet  = hsluv('#716aff'),
    },
    -- okhsl(h, 100, 60)
    l60 = {
        red     = hsluv('#ff3b41'),
        orange  = hsluv('#da7000'),
        yellow  = hsluv('#979700'),
        green   = hsluv('#6ca500'), -- h=130,
        spring  = hsluv('#00ad63'), -- h=155,
        cyan    = hsluv('#00a79a'),  -- h=185
        blue    = hsluv('#0098ee'),
        violet  = hsluv('#9374ff'),
        magenta = hsluv('#eb00e4'),
        cerise  = hsluv('#f900b7'), -- h=345
        rose    = hsluv('#ff1f8b'),
        -- green   = hsluv('#57a900'), -- h=135
        -- green   = hsluv('#00af2f'), -- h=145,
        -- green   = hsluv('#00ae50'), -- h=150
    },
    -- okhsl(h, 100, 65)
    l65 = {
        red = hsluv('#ff625e'),
        orange = hsluv('#ed7b00'),
        yellow = hsluv('#a5a500'),
        green  = hsluv('#76b300'),
        spring  = hsluv('#00bc6c'), -- h=155
        cyan   = hsluv('#00b6a8'),
        blue   = hsluv('#1aa5ff'),
        violet = hsluv('#9e88ff'),
        magenta = hsluv('#ff0bf7'),
        rose    = hsluv('#ff5699'),
    },
    -- okhsl(h, 100, 70)
    -- l70 = {
    --     red     = hsluv('#ff7f78'),
    --     orange  = hsluv('#ff8610'),
    --     yellow  = hsluv('#b3b300'),
    --     green   = hsluv('#80c200'), -- h=130
    --     spring  = hsluv('#00cc76'), -- h=155
    --     cyan    = hsluv('#00c6b6'), -- h=185
    --     blue    = hsluv('#52b3ff'),
    --     violet  = hsluv('#ab9aff'), -- h=290
    --     magenta = hsluv('#ff5cf6'),
    --     cerise  = hsluv('#ff6ec8'),
    --     rose    = hsluv('#ff77a7'), -- h=360,
    --     -- green   = hsluv('#68c700'), -- h=135
    --     -- green   = hsluv('#00cd5f'), -- h=150
    --     -- cyan    = hsluv('#00c5bd'), -- h=190
    --     -- cyan    = hsluv('#00c7af'), -- h=180
    -- },
    -- okhsl(h, 100, 75) for backgrounds
    l75 = {
        red     = hsluv('#ff9890'),
        orange  = hsluv('#ff9e57'),
        yellow  = hsluv('#c1c100'),
        green   = hsluv('#8ad200'), -- h=130
        spring  = hsluv('#00dc7f'), -- h=155
        cyan    = hsluv('#00d5c5'),
        blue    = hsluv('#75c1ff'),
        violet  = hsluv('#b8acff'),
        magenta = hsluv('#ff82f6'),
        cerise  = hsluv('#ff8cd0'),
        rose    = hsluv('#ff92b5'),
    },
    -- okhsl(h, 100, 80) for backgrounds
    l80 = {
        red     = hsluv('#ffafa7'),
        orange  = hsluv('#ffb37f'),
        yellow  = hsluv('#cfd000'),
        green   = hsluv('#95e100'),
        spring  = hsluv('#00ec89'),
        cyan    = hsluv('#00e5d3'),
        blue    = hsluv('#94ceff'),
        violet  = hsluv('#c5bdff'),
        magenta = hsluv('#ff9ff7'),
        rose    = hsluv('#ffaac4'),
    },
    -- okhsl(h, 100, 85)
    l85 = {
        red     = hsluv('#ffc4be'),
        orange  = hsluv('#ffc7a2'),
        yellow  = hsluv('#ddde00'),
        green   = hsluv('#9ff100'),
        spring  = hsluv('#00fc93'),
        cyan    = hsluv('#00f3ea'),
        blue    = hsluv('#b0daff'),
        violet  = hsluv('#d3ceff'),
        magenta = hsluv('#ffbaf8'),
        rose    = hsluv('#ffc1d2'),
    },
    -- gray05 = hsluv('#111111'), -- l=05,
    -- gray10 = hsluv('#1b1b1b'), -- l=10,
    -- gray15 = hsluv('#262626'), -- l=15,
    -- gray20 = hsluv('#303030'), -- l=20,
    -- gray25 = hsluv('#3b3b3b'), -- l=25,
    -- gray30 = hsluv('#474747'), -- l=30,
    -- gray35 = hsluv('#525252'), -- l=35,
    -- gray40 = hsluv('#5e5e5e'), -- l=40,
    -- gray45 = hsluv('#6a6a6a'), -- l=45,
    -- gray50 = hsluv('#777777'), -- l=50,
    -- gray55 = hsluv('#848484'), -- l=55,
    -- gray60 = hsluv('#919191'), -- l=60,
    -- gray65 = hsluv('#9e9e9e'), -- l=65,
    -- gray70 = hsluv('#ababab'), -- l=70,
    -- gray75 = hsluv('#b9b9b9'), -- l=75,
    -- gray80 = hsluv('#c6c6c6'), -- l=80,
    -- gray85 = hsluv('#d4d4d4'), -- l=85,
    -- gray90 = hsluv('#e2e2e2'), -- l=90,
    -- gray95 = hsluv('#f1f1f1'), -- l=95.

    -- base values (saturation mostly 10)
    -- -- base08 = hsluv('#051318'), -- s=50,
    -- -- base10 = hsluv('#08191e'), -- s=50,
    -- -- base15 = hsluv('#0f262d'), -- s=50,
    -- -- base20 = hsluv('#16333b'), -- s=50,
    -- base08 = hsluv('#00141b'), -- s=100,
    -- base10 = hsluv('#001a22'), -- s=100,
    -- base15 = hsluv('#002732'), -- s=100,
    -- base20 = hsluv('#003441'), -- s=100,
    -- -- base25 = hsluv('#1d3f4a'), -- s=50,
    -- -- base25 = hsluv('#004151'), -- s=100,
    -- -- base25 = hsluv('#2a3d43'), -- s=25,
    -- base25 = hsluv('#333c3e'), -- s=10
    -- base30 = hsluv('#3e484b'), -- s=10
    -- base35 = hsluv('#495457'), -- s=10
    -- base40 = hsluv('#556064'), -- s=10
    -- base45 = hsluv('#606d71'), -- s=10
    -- base50 = hsluv('#6c7a7e'), -- s=10
    -- base55 = hsluv('#79878b'), -- s=10
    -- base60 = hsluv('#859499'), -- s=10
    -- base65 = hsluv('#93a1a6'), -- s=10
    -- base70 = hsluv('#a1aeb3'), -- s=10,
    -- base75 = hsluv('#afbbc0'), -- s=10
    -- base80  = hsluv('#bec9cc'),  -- s=10
    -- base85  = hsluv('#ced6d9'),  -- s=10,
    -- base90  =  hsluv('#dee4e6'), -- s=10,
    -- -- base92  =  hsluv('#e4e9eb'), -- s=10,
    -- base95  =  hsluv('#eef1f2'), -- s=10,
    -- base97  =  hsluv('#f5f7f7'), -- s=10,
    -- base87  =  hsluv('#d4dcde'), -- l=87,
    -- base82  =  hsluv('#c4ced1'), -- l=82
    --
    -- base (saturation mostly 5)
    -- base05 = hsluv('#000b0f'),
    base08 = hsluv('#00141b'), -- s=100,
    base10 = hsluv('#001a22'), -- s=100,
    base12 = hsluv('#001f28'), -- s=100,
    base15 = hsluv('#002732'), -- s=100,
    -- base20 = hsluv('#16333b'), -- s=50,
    -- base20 = hsluv('#0b343f'), -- s=75, hsluv(221, 90, 19),
    base20 = hsluv('#003441'), -- s=100,
    base25 = hsluv('#004151'), -- s=100
    -- base25s25 = hsluv('#2a3d43'), -- s=25,
    -- base25s50 = hsluv('#1d3f4a'), -- s=50,
    -- base25 = hsluv('#363b3c'), -- s=05,
    base27 = hsluv('#3b4041'), -- s=05,
    base28 = hsluv('#3d4243'),
    base30 = hsluv('#424748'),
    base35 = hsluv('#4d5355'),
    base40 = hsluv('#595f61'),
    base45 = hsluv('#656c6e'),
    base50 = hsluv('#71787b'),
    base55 = hsluv('#7e8588'),
    base60 = hsluv('#8b9295'),
    base65 = hsluv('#989fa2'),
    base70 = hsluv('#a6adaf'),
    base75 = hsluv('#b4babc'),
    base80 = hsluv('#c2c8c9'),
    base85 = hsluv('#d1d5d7'),
    base90 = hsluv('#e0e3e4'),
    -- base93 = hsluv('#e9ebec'), -- s=05
    -- base95 = hsluv('#f0f1f1'),
    base97 = hsluv('#f6f7f7'),
}

local light = {
    -- okhsl(220, 10, l)
    bg = {
        color.base97,
        -- color.base95,
        color.base93,
        color.base90,
        color.base85,
        color.base80,
    },
    fg = {
        color.base55,
        color.base45,
        color.base35,
        color.base28,
        color.base08,
    },
    bg0 = color.base97,
    bg1 = color.base93,
    bg2 = color.base90,
    bg3 = color.base85,
    bg4 = color.base80,
    fg4 = color.base55,
    fg3 = color.base45,
    fg2 = color.base35,
    fg1 = color.base28,
    dim = color.l55,
    hue = color.l55,
    red = color.l55.red,
    orange = color.l55.orange,
    yellow = color.l55.yellow,
    green = color.l55.green,
    spring = color.l55.spring,
    cyan = color.l55.cyan,
    blue = color.l55.blue,
    violet = color.l55.violet,
    magenta = color.l55.magenta,
    rose = color.l55.rose,
    br = color.l65,
    hl = color.l85,
}

local dark = {
    -- okhsl(220, 100, l)
    bg0 = color.base08,
    bg1 = color.base12,
    bg2 = color.base15,
    bg3 = color.base20,
    bg4 = color.base25,
    fg4 = color.base45,
    fg3 = color.base55,
    fg2 = color.base65,
    fg1 = color.base75,
    fg0 = color.base90,
    -- colors
    dim = color.l55,
    hue = color.l60,
    red = color.l60.red,
    orange = color.l60.orange,
    yellow = color.l60.yellow,
    green = color.l60.green,
    spring = color.l60.spring,
    cyan = color.l60.cyan,
    blue = color.l60.blue,
    violet = color.l60.violet,
    magenta = color.l60.magenta,
    rose = color.l60.rose,
    br = color.l75,
    hl = color.l85,
}


