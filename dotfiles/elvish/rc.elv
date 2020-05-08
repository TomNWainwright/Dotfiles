E:GOPATH = ""
paths = [
~/bin
~/.local/bin
/usr/local/sbin
/usr/local/bin
/usr/bin
/usr/lib/jvm/default/bin
/usr/bin/site_perl
/usr/bin/vendor_perl
/usr/bin/core_perl
/var/lib/snapd/snap/bin
]




use epm


epm:install &silent-if-installed=$true   \
  github.com/zzamboni/elvish-modules     \
  github.com/zzamboni/elvish-completions \
  github.com/zzamboni/elvish-themes      \
  github.com/xiaq/edit.elv               \
  github.com/muesli/elvish-libs          \
  github.com/iwoloschin/elvish-packages
  
  
use re


edit:insert:binding[Alt-Backspace] = $edit:kill-small-word-left~
    
edit:insert:binding[Alt-d] = $edit:kill-small-word-right~

#edit:insert:binding[Alt-m] = $edit:-instant:start~

use github.com/zzamboni/elvish-modules/alias



use github.com/xiaq/edit.elv/smart-matcher
smart-matcher:apply

use github.com/zzamboni/elvish-completions/git
use github.com/zzamboni/elvish-completions/cd
use github.com/zzamboni/elvish-completions/builtins

use github.com/zzamboni/elvish-modules/long-running-notifications


use github.com/zzamboni/elvish-modules/dir
alias:new cd &use=[github.com/zzamboni/elvish-modules/dir] dir:cd 
alias:new cdb &use=[github.com/zzamboni/elvish-modules/dir] dir:cdb  


edit:insert:binding[Alt-i] = $dir:history-chooser~


edit:insert:binding[Alt-b] = $dir:left-small-word-or-prev-dir~
edit:insert:binding[Alt-f] = $dir:right-small-word-or-next-dir~


edit:insert:binding[Ctrl-R] = {
  edit:histlist:start
  edit:histlist:toggle-case-sensitivity
}


fn ls [@_args]{
  e:exa --color-scale --git --group-directories-first (each [o]{
      if (eq $o "-lrt") { put "-lsnew" } else { put $o }
  } $_args)
}

use github.com/zzamboni/elvish-modules/terminal-title


# do private stuff private-loaded = ?(use private)

E:EDITOR = "kak"


E:LC_ALL = "en_GB.UTF-8"

# E:PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"

use github.com/zzamboni/elvish-modules/util
use github.com/muesli/elvish-libs/git
use github.com/iwoloschin/elvish-packages/update
update:curl-timeout = 3
update:check-commit &verbose
util:electric-delimiters

alias:new echob echo b
alias:new pipi pip3 install --user 

-exports- = (alias:export)

