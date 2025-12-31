# caret:

config.unbind('J', mode='caret')
config.unbind('K', mode='caret')
config.unbind('L', mode='caret')

config.bind('H', 'scroll left', mode='caret')
config.bind('N', 'scroll down', mode='caret')
config.bind('E', 'scroll up', mode='caret')
config.bind('I', 'scroll right', mode='caret')


config.unbind('j', mode='caret')
config.unbind('k', mode='caret')
config.unbind('l', mode='caret')

config.bind('h', 'move-to-prev-char', mode='caret')
config.bind('n', 'move-to-next-line', mode='caret')
config.bind('e', 'move-to-prev-line', mode='caret')
config.bind('i', 'move-to-next-char', mode='caret')

config.bind('qt', 'spawn --userscript qute-dict', mode='caret')

# normal:

config.unbind('q', mode='normal')
config.bind('qt', 'spawn --userscript qute-dict')
config.bind('qh', 'spawn --userscript qute-html')
config.bind('qb', 'spawn mpv {url}')

config.bind(']]', "spawn --userscript qute-navigate next")
config.bind('[[', "spawn --userscript qute-navigate prev")

config.unbind(';I', mode='normal')
config.unbind(';O', mode='normal')
config.unbind(';R', mode='normal')
config.unbind(';Y', mode='normal')
config.unbind(';b', mode='normal')
config.unbind(';d', mode='normal')
config.unbind(';f', mode='normal')
config.unbind(';h', mode='normal')
config.unbind(';i', mode='normal')
config.unbind(';o', mode='normal')
config.unbind(';r', mode='normal')
config.unbind(';t', mode='normal')
config.unbind(';y', mode='normal')
config.bind(';', 'cmd-set-text :', mode='normal')


config.unbind('<Alt-1>', mode='normal')
config.unbind('<Alt-2>', mode='normal')
config.unbind('<Alt-3>', mode='normal')
config.unbind('<Alt-4>', mode='normal')
config.unbind('<Alt-5>', mode='normal')
config.unbind('<Alt-6>', mode='normal')
config.unbind('<Alt-7>', mode='normal')
config.unbind('<Alt-8>', mode='normal')
config.unbind('<Alt-9>', mode='normal')
config.unbind('<Alt-m>', mode='normal')
config.bind('<Meta-1>', "tab-focus 1", mode='normal')
config.bind('<Meta-2>', "tab-focus 2", mode='normal')
config.bind('<Meta-3>', "tab-focus 3", mode='normal')
config.bind('<Meta-4>', "tab-focus 4", mode='normal')
config.bind('<Meta-5>', "tab-focus 5", mode='normal')
config.bind('<Meta-6>', "tab-focus 6", mode='normal')
config.bind('<Meta-7>', "tab-focus 7", mode='normal')
config.bind('<Meta-8>', "tab-focus 8", mode='normal')
config.bind('<Meta-9>', "tab-focus 9", mode='normal')
config.bind('<Meta-m>', "tab-mute", mode='normal')


config.bind('x', "tab-close", mode='normal')
config.bind('H', "back", mode='normal')
config.bind('N', "tab-next", mode='normal')
config.bind('E', "tab-prev", mode='normal')
config.bind('I', "forward", mode='normal')
config.bind('K', "search-prev", mode='normal')

config.bind('s', 'hint all', mode='normal')
config.bind('Ss', 'hint all tab-fg', mode='normal')
config.bind('<Ctrl-s>', 'hint all hover', mode='normal')
config.bind('X', 'undo', mode='normal')

config.bind('d', 'scroll-page 0 0.5', mode='normal')
config.bind('l', 'scroll-page 0 -0.5', mode='normal')

config.bind('h', 'scroll-page -0.1 0', mode='normal')
config.bind('n', 'scroll-page 0 0.1', mode='normal')
config.bind('e', 'scroll-page 0 -0.1', mode='normal')
config.bind('i', 'scroll-page 0.1 0', mode='normal')
config.bind('gN', "tab-move +", mode='normal')
config.bind('gE', "tab-move -", mode='normal')

config.bind('m', 'mode-enter set_mark', mode='normal')
config.bind('k', 'search-next', mode='normal')

config.unbind('sf', mode='normal')
config.unbind('sk', mode='normal')
config.unbind('sl', mode='normal')
config.unbind('ss', mode='normal')

config.bind('Q', "macro-record", mode='normal')
config.bind('t', 'open -t', mode='normal')

config.unbind('u', mode='normal')

config.bind('u', 'mode-enter insert', mode="normal")

config.bind('.', 'config-cycle tabs.show always never')

config.unbind('g$', mode="normal")
config.unbind('g0', mode="normal")
config.unbind('gB', mode="normal")
config.unbind('gO', mode="normal")
config.unbind('gd', mode="normal")
config.unbind('gm', mode="normal")
config.unbind('go', mode="normal")
config.unbind('gu', mode="normal")
config.unbind('ga', mode="normal")
config.unbind('gb', mode="normal")
config.unbind('g^', mode="normal")
config.unbind('gU', mode="normal")

config.bind('guu', 'spawn -u qute-bw username', mode="normal")
config.bind('gup', 'spawn -u qute-bw password', mode="normal")
config.bind('guf', 'spawn -u qute-bw fill', mode="normal")
config.bind('b', 'spawn -u qute-bookmarks open', mode='normal')
config.bind('B', 'spawn -u qute-bookmarks add', mode='normal')

# hint
config.bind('s', 'mode-leave', mode="hint")
