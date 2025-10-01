/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 42;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Iosevka Nerd Font Propo:pixelsize=15" };
static const char dmenufont[]       = "Iosevka Nerd Font Propo:pixelsize=18";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char col_st_green[]    = "#080F0B";
static const char col_green[]       = "#00a877";
static const char col_black[]       = "#000000";

static const char col_fg[]      = "#ebdbb2";  // Light1
static const char col_bg2[]     = "#282828";  // Dark0
static const char col_sel[]     = "#d65d0e";  // Orange
static const char col_border[]  = "#458588";  // Blue (gut sichtbar für Rand)

static const char *colors[][3] = {
    /*               fg        bg        border    */
    [SchemeNorm] = { col_fg,   col_bg2,  col_bg2   },  // normale Leiste
    [SchemeSel]  = { col_fg,   col_sel,  col_border }, // ausgewähltes Fenster
};

/* tagging */
static const char *tags[] = { "", "󰈹", "󰎆", "", "5", "6", "7", "8", "󱜏" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Firefox",      NULL,   "Firefox",  1 << 1,       0,           -1 },
	{ "gl",      	    NULL,   "mpv",  		1 << 8,      -1,           -1 },
	{ "mpv",     	    NULL,   "mpv",  		1 << 8,       0,           -1 },
	{ "Discord",   	  NULL,   "vesktop",  1 << 3,       0,           -1 },
	{ "vesktop",   	  NULL,   "vesktop",  1 << 3,       0,           -1 },

};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int nviews      = 0;    /* mask of tags highlighted by default (tags 1-4) */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int statusall   = 1;    /* 1 means status is shown in all bars, not just active monitor */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const float facts[1];    //static const float facts[]     = {     0,     0.5 }; // = mfact   // 50%
static const int masters[1];    //static const int masters[]     = {     0,      -1 }; // = nmaster // vertical stacking (for rotated monitor)
static const int views[1];      //static const int views[]       = {     0,      ~0 }; // = nviews  // all tags
/* invert tags after nviews */  /* array dimentions can both be as big as needed */  // final highlighted tags
static const int toggles[1][1]; //static const int toggles[2][2] = { {0,8}, {~0,~0} }; // 2-4+9     // all (leave as views above)
static const int toggles[1][1] = {{~0}};

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define WINKEY Mod1Mask //Alt
#define MODKEY Mod4Mask //Win
#define DMENU_MOD Mod4Mask|Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|WINKEY,                KEY,      nview,          {.ui = 1 << TAG} }, \
	{ MODKEY|WINKEY|ControlMask,    KEY,      ntoggleview,    {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define BROWSER "firefox"

#define STATUSBAR "dwmblocks"

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
//static const char *dmenucmd[] = { "dmenu_run", "-l", "10", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, NULL, col_cyan, NULL, col_gray4, NULL };
static const char *dmenucmd[] = { 
    "dmenu_run", 
    "-l", "10", 
    "-m", dmenumon, 
    "-fn", dmenufont, 
    "-nb", "#282828",  // Hintergrund (normal) – Gruvbox bg0
    "-nf", "#ebdbb2",  // Textfarbe (normal) – Gruvbox fg
    "-sb", "#d65d0e",  // Hintergrund (ausgewählt) – Gruvbox blue
    "-sf", "#282828",  // Textfarbe (ausgewählt) – Gruvbox bg0
};
static const char *termcmd[]  = { "st", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
  { MODKEY|ShiftMask,             XK_f,      spawn,     		 SHCMD("$HOME/.config/scripts/dim.sh") },
	{ DMENU_MOD, 						 				XK_t,			 spawn,					 SHCMD("$HOME/.config/scripts/time.sh") },
	{ DMENU_MOD,										XK_a, 		 spawn,					 SHCMD("$HOME/projects/ani-cli/ani-cli --dmenu") },
  { MODKEY|ControlMask,           XK_l,      spawn,          SHCMD("cd $HOME/.config/suckless/slock/ && slock") },
  { MODKEY|ShiftMask,			        XK_b,      spawn,          {.v = (const char*[]){ BROWSER, NULL } } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,      pushdown,       {0} },
	{ MODKEY|ShiftMask,             XK_k,      pushup,         {0} },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_Tab,    swapfocus,      {0} },
  { MODKEY|ShiftMask,             XK_h,      spawn,     		 SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+") },
  { MODKEY|ShiftMask,             XK_l,      spawn,     		 SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-") },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_plus,   setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = 0  } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY,                       XK_grave,  reset_view,     {0} }, // `
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkMonNum,            0,              Button1,        focusmon,       {.i = +1} },
	{ ClkMonNum,            0,              Button3,        focusmon,       {.i = -1} },
	{ ClkMonNum,            0,              Button2,        reset_view,     {0} },
  { ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        sigstatusbar,   {.i = 1} },
	{ ClkStatusText,        0,              Button2,        sigstatusbar,   {.i = 2} },
	{ ClkStatusText,        0,              Button3,        sigstatusbar,   {.i = 3} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            MODKEY|WINKEY,  Button1,        nview,          {0} },
	{ ClkTagBar,            MODKEY|WINKEY,  Button3,        ntoggleview,    {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

