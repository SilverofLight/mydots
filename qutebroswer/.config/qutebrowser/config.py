from dracula import blood

config.load_autoconfig(False)
# c.content.user_stylesheets = ["~/.config/qutebrowser/styles/black.css"]

blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})

config.source('bindings.py')

# NOTE: file chooser (untested)
fileChooser = ['kitty', '-T', 'Floating_Term', '-e', 'fish', '-c', 'yazi --chooser-file="$argv[1]"', '--', '{}']
c.fileselect.handler = "external"
c.fileselect.folder.command = fileChooser
c.fileselect.multiple_files.command = fileChooser
c.fileselect.single_file.command = fileChooser

c.zoom.levels = ["25%", "33%", "50%", "67%", "75%", "90%", "100%", "110%", "120%", "130%", "140%", "150%", "175%", "200%", "250%", "300%"]

# c.url.start_pages = 'file:///dev/null'
# c.url.default_page= 'file:///dev/null'
# c.tabs.last_close = "startpage"
c.auto_save.session = False


c.tabs.show = "always"
c.tabs.position = "right"
c.tabs.padding = {"bottom":0, "left":0, "right":0, "top":0}
c.tabs.indicator.width = 0
c.tabs.width = '7%'
c.statusbar.show = "always"
c.completion.height = '30%'

c.keyhint.delay = 0
c.hints.uppercase = False
c.hints.chars = "artdhneioplvmcx"

c.downloads.location.directory = "~/Downloads/"
c.downloads.location.prompt = False
c.downloads.location.suggestion = 'both'
c.downloads.location.remember = False
c.downloads.remove_finished = 3300
c.downloads.position = "bottom"

c.content.fullscreen.window = True # Limit fullscreen to browser window
c.content.blocking.enabled = True
c.content.blocking.method = 'both'
c.content.blocking.adblock.lists = [
  "https://easylist.to/easylist/easylist.txt",
  "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
  "https://easylist.to/easylist/easyprivacy.txt",
  "https://secure.fanboy.co.nz/fanboy-annoyance.txt",]

c.scrolling.smooth = True
c.content.autoplay = True

c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = 'never'
c.colors.webpage.bg = '#282a36' # fix darkmode white flash

# c.content.headers.user_agent = "Mozilla/5.0 ({os_info}; rv:135.0) Gecko/20100101 Firefox/135"
config.set(
    'content.headers.user_agent',
    'Mozilla/5.0 ({os_info}; rv:135.0) Gecko/20100101 Firefox/135',
    pattern='https://accounts.google.com/*'
)
