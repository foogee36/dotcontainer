
## Vars
REPO=${HOME}/.mpcfg

function command_exists () {
    command -v $1 >/dev/null 2>&1;
}

## Clone as Git bare repository
git clone --bare https://github.com/foogee36/dotcontainer.git ${REPO}

function wagaya {
   /usr/bin/git --git-dir=${REPO} --work-tree=${HOME} $@
}

## Checkout
mkdir -p .mpcfg-backup
wagaya checkout

## Move existing files to backup directory
if [ $? = 0 ]; then
  echo "Checked out dotcontainer.";
else
    echo "Backing up pre-existing dot files.";
    wagaya checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .mpcfg-backup/{}
fi;

## Retry checkout
wagaya checkout
wagaya config status.showUntrackedFiles no

echo 'Setup complete'
