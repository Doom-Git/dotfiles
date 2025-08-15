/* user and group to drop privileges to */
static const char *user  = "mario";
static const char *group = "nogroup";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

static const char* background_image = "./Lockscreen.png";
//~/.config/suckless/slock/
