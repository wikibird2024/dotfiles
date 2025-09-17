# ============================ BASIC SHORTCUTS ============================
alias ll='ls -alF --color=auto'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias config='cd ~/.config/'
alias download='cd ~/Downloads/'
alias dotfiles='cd ~/dotfiles/'
alias plugin.='cd ~/dotfiles/nvim/.config/nvim/lua/user/plugins/'
alias aliasesedit='nvim ~/.bash_aliases'
alias functionsedit='nvim ~/.bash_functions'
alias bashrcedit='nvim ~/.bashrc'
alias c='clear'
alias s='source ~/.bashrc'
alias sz='source ~/.zshrc'
alias thesis='cd ~/Documents/thesis_latex' 
alias zbm='zathura build/main.pdf'
alias zm='zathura main.pdf'
alias zth='zathura'
alias fondlist='fc-list --format='%{family}\n' | sort -u'
alias xe='xelatex main.tex && biber main && xelatex main.tex && xelatex main.tex && zathura main.pdf'
alias cl='./clean.sh'
alias b='./build.sh'
alias qute='qutebrowser'
alias pdf='xreader'
alias image='feh'

# ============================  SYS CTL SHORTCUTS ============================

alias sctl='sudo systemctl'
alias tctl='timedatectl'
alias hctl='hostnamectl'
alias lctl='loginctl'
alias nctl='networkctl'
alias lcl='localectl'
alias getlocation='curl -s https://ipinfo.io/loc'

# ============================  PYTHON ================================
#
alias py='python'
alias miniterm='python -m serial.tools.miniterm'
alias cdpy='cd ~/python'
alias rmp='py main.py'

# ============================ TMUX MANAGEMENT ================================
alias tmls='tmux ls'                 # list all sessions
alias tm='tmux'                 # Lazy call tmux 
alias tma='tmux attach -t '     # attach to a session
alias tmn='tmux new -s'           # create new named session
alias tmks='tmux kill-session -t ' # kill a session
alias tmd='tmux detach'              # detach current session (tmux d also works)
alias tmrws='tmux rename-window -t '  # rename a window in the current session
alias tmrs='tmux rename-session -t ' # rename the current session
alias tmkall='tmux kill-server'     # kill all session

# ============================ SYSTEM CONTROL =============================
alias shutdown='sudo shutdown -P now'
alias reboot='sudo reboot'

# ============================ SYSTEM OPS ================================
alias update='sudo apt update && sudo apt upgrade -y'
alias install='sudo apt install'
alias remove='sudo apt remove'
alias search='apt search'

#============================= SOMETHING ELSE CAT.. ==============================
alias df='df -h'
alias du='du -h --max-depth=1'
alias mountlist='lsblk -f'

alias cat='batcat --paging=never'
alias view='batcat'
alias less='batcat --paging=always'
alias bat='batcat'

# ============================ NETWORKING ================================
alias ports='sudo lsof -i -P -n'
alias myip='curl ifconfig.me'
alias pingg='ping google.com'
alias scanwifi='nmcli dev wifi list'
alias connectwifi='nmtui'

# ============================ ASTERISK MANAGEMENT ======================

# === ASTERISK CORE ===
alias d_ast='sudo systemctl stop asterisk'
alias e_ast='sudo systemctl start asterisk'
alias sudo_ast='sudo -u asterisk asterisk -rvvvvv'
alias astcli='sudo asterisk -rvvvvv'                          # Enter Asterisk CLI interactively
alias ast.corereload='sudo asterisk -rx "core reload"'             # Reload full core
alias ast.coreshowuptime='sudo asterisk -rx "core show uptime"'        # Show system uptime
alias ast.log='sudo tail -f /var/log/asterisk/full'            # Live log viewer

# === SIP MANAGEMENT (for chan_sip) ===
alias sip.reload='sudo asterisk -rx "sip reload"'              # Reload SIP settings
alias sip.showpeers='sudo asterisk -rx "sip show peers"'       # Show SIP peers (devices)
alias sip.showusers='sudo asterisk -rx "sip show users"'       # Show SIP user accounts
alias sip.showregistry='sudo asterisk -rx "sip show registry"' # Show SIP registration status

# === CONFIG FILES QUICK EDIT ===
alias ast.pjsip='sudo vim /etc/asterisk/pjsip.conf'              # Edit SIP config
alias ast.sip='sudo nvim /etc/asterisk/sip.conf'              # Edit SIP config
alias ast.ext='sudo nvim /etc/asterisk/extensions.conf'       # Edit dialplan
alias ast.voicemail='sudo nvim /etc/asyterisk/voicemail.conf'      # Edit voicemail
alias ast.manager='sudo nvim /etc/asterisk/manager.conf'     #manager AMI 

# === DIALPLAN MANAGEMENT ===
alias dialplanreload='sudo asterisk -rx "dialplan reload"'    # Reload only dialplan

# === LOGGING UTILITIES ===
alias astgrep='sudo grep -i --color=auto -r'                  # Case-insensitive grep for asterisk logs
alias astping='sudo asterisk -rx "sip show peers" | grep -i unreachable' # Detect unreachable peers

# === QUICK SETUP CHECK ===
alias astcheck='sudo asterisk -rx "core show version"; sudo asterisk -rx "sip show peers"; sudo asterisk -rx "sip show registry"'

# ============================ PROCESSES ================================
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias topcpu='ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head'

# ============================ GIT POWER TOOLS ============================
alias gro='git remote add origin'
alias gru='git remote set-url origin'
alias grv='git remote -v'

alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gco='git checkout'
alias gb='git branch'
alias gbd='git branch -d'
alias gcb='git checkout -b'
alias gp='git push'
alias gpo='git push origin'
alias gl='git pull'
alias gcl='git clone'
alias greset='git reset --hard'
alias glog='git log --oneline --graph --decorate --all'
alias gclean='git clean -fd'

alias gst='git stash'
alias gsp='git stash pop'
alias guncommit='git reset --soft HEAD~1'

# ============================ DOCKER SHORTCUTS ============================
alias d='docker'
alias dps='docker ps'
alias di='docker images'
alias dstopall='docker stop $(docker ps -q)'
alias drm='docker rm $(docker ps -a -q)'
alias drmi='docker rmi $(docker images -q)'
alias dclean='docker system prune -af'

# ============================ MAKE & BUILD ================================
alias m='make'
alias mc='make clean'
alias mb='make && make flash'

# ============================ ARCHIVES & FILE OPS =========================
alias untar='tar -xvzf'
alias zipf='zip -r'
alias extract='tar -xf'

# ============================ SEARCH & GREP ===============================
alias grep='grep --color=auto'
alias f='find . -name'
alias ff='find . -type f -iname'

# ============================ SEARCH & RIP GIREP ===============================
alias rgg='rp --hidden --smart-case'




# ============================ (NEO)VIM ====================================
alias n='nvim'
alias snv='sudo nvim'
alias v='nvim .'

# ============================ EMBEDDED & SERIAL ===========================
alias tty='ls /dev/tty*'
alias ttyusb='ls /dev/ttyUSB*'
alias ttyacm='ls /dev/ttyACM*'

# ============================ SYSTEMD =====================================
alias jctl='journalctl -xe'
alias sys='systemctl'
alias sysr='sudo systemctl restart'
alias sysl='systemctl list-units --type=service'

# ============================ ESP-IDF SHORTCUTS ===========================
alias cdesp='cd ~/esp/mainproject'
alias idfb='idf.py build'
alias idfst='idf.py set-target'
alias idfmc='idf.py menuconfig'
alias idff='idf.py flash'
alias idfm='idf.py monitor'
alias idfc='rm -rf build && idf.py fullclean'
alias idfcb='rm -rf build && idf.py fullclean build'
alias idffm='idf.py flash monitor'
alias idfall='idf.py fullclean build flash monitor'

# ============================ MISC TOOLS ==================================
alias please='sudo $(fc -ln -1)'    # Run last command with sudo
alias now='date "+%Y-%m-%d %H:%M:%S"'

# ============================ SAFETY ALIASES ==============================
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ============================ TREE SHORTCUTS ==============================
alias t='tree'                          # Basic tree
alias taf='tree -a -C'                   # All files
alias td='tree -d -C'                   # Directories only
alias t1='tree -L 1 -C'                 # Depth 1
alias t2='tree -L 2 -C'                 # Depth 2
alias t3='tree -L 3 -C'                 # Depth 3
alias t4='tree -L 4 -C'                 # Depth 4

# --- Filtered trees ---
alias tg='tree -C -I ".git|__pycache__|.vscode"'
alias tp='tree -C -L 2 -I "build|.git|*.o|*.bin|*.elf|__pycache__"'

# --- Enhanced trees ---
alias ts='tree -C -h --du'
alias tn='tree -C -n'
alias tt='tree -C -L 2 | less'
alias tw='watch -n 2 "tree -L 2 -C"'

# --- Export trees ---
alias tjson='tree -J -L 2 > tree.json'
alias thtml='tree -H . -L 2 -o tree.html'

# --- System path views ---
alias trc='tree /etc -L 2 -C'
alias th='tree ~ -L 2 -C'
alias tmp='tree /tmp -L 1 -C'

# --- Tree counters ---
alias tfc='tree -fi | wc -l'
alias tfc2='tree -L 2 -fi | wc -l'
alias tcount='tree -fi | grep -v "/$" | wc -l'
alias tdc='tree -d -fi | wc -l'

# --- Sorting & Sizes ---
alias tsize='tree -C -s -h --du -L 2'
alias tsort='tree -C -L 2 | sort'

# --- Project-specific trees ---
alias tc='tree -C -I "build|*.o|*.elf|*.bin|.git|.vscode|*.pyc|__pycache__"'
alias tpj='tree -C -L 2 -I "node_modules|dist|.git|.vscode|*.lock"'
alias tpy='tree -C -I "__pycache__|.venv|.git|*.pyc"'

# Create and activate `.venv` in current directory
alias .venv='source .venv/bin/activate'
alias venv='source venv/bin/activate'
