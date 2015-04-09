
PYENV_ROOT="$HOME/.pyenv"

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

export PATH=~/.pyenv/shims:/bin:/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$PATH
export EDITOR='subl -w'
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export NVM_DIR="/Users/thomasweaver/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#ec2-api-tools
export JAVA_HOME="$(/usr/libexec/java_home)"
export AWS_ACCESS_KEY="<Your AWS Access ID>"
export AWS_SECRET_KEY="<Your AWS Secret Key>"
export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.7.1.0/libexec"

#ec2-ami-tools
export JAVA_HOME="$(/usr/libexec/java_home)"
export AWS_ACCESS_KEY="<Your AWS Access ID>"
export AWS_SECRET_KEY="<Your AWS Secret Key>"
export EC2_AMITOOL_HOME="/usr/local/Cellar/ec2-ami-tools/1.5.3/libexec"

#elb-tools
export JAVA_HOME="$(/usr/libexec/java_home)"
export AWS_ACCESS_KEY="<Your AWS Access ID>"
export AWS_SECRET_KEY="<Your AWS Secret Key>"
export AWS_ELB_HOME="/usr/local/Cellar/elb-tools/1.0.35.0/libexec"

source ~/.git-completion.sh
source ~/.git-prompt.sh

PERL_MB_OPT="--install_base \"/Users/thomasweaver/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/thomasweaver/perl5"; export PERL_MM_OPT;
