# .profile
if [ -f $HOME/.profile ]; then
	  source $HOME/.profile
fi

# .bashrc
if [ -f $HOME/.bashrc ]; then
	  source $HOME/.bashrc
fi

# bash history
mkdir -p "$XDG_STATE_HOME"/bash
export HISTFILE="${XDG_STATE_HOME}"/bash/history
