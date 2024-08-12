export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="minimal"

plugins=(git history)

source $ZSH/oh-my-zsh.sh

export GOPATH=$HOME/go
export PATH=$HOME/bin:$PATH:/usr/local/go/bin/:$HOME/go/bin:$HOME/node/bin
LS_COLORS='no=00:fi=00:di=36:ln=35:pi=37;44:so=37;44:do=37;44:bd=37;44:cd=37;44:or=05;37;45:mi=05;37;45:tw=30;46:ow=30;46:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=33:*.org=33:*.md=33:*.mkd=33:*.C=32:*.c=32:*.cc=32:*.csh=32:*.css=32:*.cxx=32:*.el=32:*.h=32:*.hs=32:*.htm=32:*.html=32:*.java=32:*.js=32:*.man=32:*.objc=32:*.php=32:*.pl=32:*.pm=32:*.pod=32:*.py=32:*.rb=32:*.rdf=32:*.sh=32:*.shtml=32:*.tex=32:*.vim=32:*.xml=32:*.zsh=32:*.bmp=01;35:*.cgm=01;35:*.dl=01;35:*.dvi=01;35:*.emf=01;35:*.eps=01;35:*.gif=01;35:*.jpeg=01;35:*.jpg=01;35:*.JPG=01;35:*.mng=01;35:*.pbm=01;35:*.pcx=01;35:*.pdf=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.pps=01;35:*.ppsx=01;35:*.ps=01;35:*.svg=01;35:*.svgz=01;35:*.tga=01;35:*.tif=01;35:*.tiff=01;35:*.xbm=01;35:*.xcf=01;35:*.xpm=01;35:*.xwd=01;35:*.xwd=01;35:*.yuv=01;35:*.aac=01;35:*.au=01;35:*.flac=01;35:*.mid=01;35:*.midi=01;35:*.mka=01;35:*.mp3=01;35:*.mpa=01;35:*.mpeg=01;35:*.mpg=01;35:*.ogg=01;35:*.ra=01;35:*.wav=01;35:*.anx=01;35:*.asf=01;35:*.avi=01;35:*.axv=01;35:*.flc=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.m2v=01;35:*.m4v=01;35:*.mkv=01;35:*.mov=01;35:*.mp4=01;35:*.mp4v=01;35:*.mpeg=01;35:*.mpg=01;35:*.nuv=01;35:*.ogm=01;35:*.ogv=01;35:*.ogx=01;35:*.qt=01;35:*.rm=01;35:*.rmvb=01;35:*.swf=01;35:*.vob=01;35:*.wmv=01;35:*.doc=33:*.docx=33:*.rtf=33:*.dot=33:*.dotx=33:*.xls=33:*.xlsx=33:*.ppt=33:*.pptx=33:*.fla=33:*.psd=33:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:*.Z=1;35:*.zip=1;35:*.ANSI-black=30:*.ANSI-black-bright=01;30:*.ANSI-red=31:*.ANSI-red-bright=01;31:*.ANSI-green=32:*.ANSI-green-bright=01;32:*.ANSI-yellow=33:*.ANSI-yellow-bright=01;33:*.ANSI-blue=34:*.ANSI-blue-bright=01;34:*.ANSI-magenta=35:*.ANSI-magenta-bright=01;35:*.ANSI-cyan=36:*.ANSI-cyan-bright=01;36:*.ANSI-white=37:*.ANSI-white-bright=01;37:*#=32:*~=32:*.log=32:*,v=01;30:*.BAK=01;30:*.DIST=01;30:*.OFF=01;30:*.OLD=01;30:*.ORIG=01;30:*.bak=01;30:*.dist=01;30:*.off=01;30:*.old=01;30:*.org_archive=01;30:*.orig=01;30:*.swo=01;30:*.swp=01;30:';
export LS_COLORS
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion