config.load_autoconfig() # load settings done via the gui
c.auto_save.session = True # save tabs on quit/restart

# tabs
c.tabs.position = "right"
c.tabs.title.format = "{audio}{current_title}"
c.fonts.web.size.default = 20
c.tabs.show = "multiple"

# Darkmode
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.images = 'never'
config.set('colors.webpage.darkmode.enabled', True, 'file://*')
config.set('colors.webpage.darkmode.enabled', True)

# styles, cosmetics
# c.content.user_stylesheets = ["~/.config/qutebrowser/styles/youtube-tweaks.css"]
c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 9, 'right': 9}
c.tabs.indicator.width = 0 # no tab indicators
# c.window.transparent = True # apparently not needed
c.tabs.width = '7%'

# fonts
c.fonts.default_family = "Iosevka Nerd Font Propo"
c.fonts.default_size = '14pt'
#c.fonts.web.family.fixed = 'monospace'
#c.fonts.web.family.sans_serif = 'monospace'
#c.fonts.web.family.serif = 'monospace'
#c.fonts.web.family.standard = 'monospace'

# privacy - adjust these settings based on your preference
# config.set("completion.cmd_history_max_items", 0)
# config.set("content.private_browsing", True)
config.set("content.webgl", False, "*")
config.set("content.canvas_reading", False)
config.set("content.geolocation", False)
config.set("content.webrtc_ip_handling_policy", "default-public-interface-only")
config.set("content.cookies.accept", "no-3rdparty")
config.set("content.cookies.store", True)
# config.set("content.javascript.enabled", False) # tsh keybind to toggle


# Adblock
c.content.blocking.enabled = True
config.set("content.blocking.method", "both")
