#!/bin/sh
#
# Setup git first 
# 

# Set config user
# --------------------------------

echo "[INPUT] git config --global user.name:"
read INPUT_NAME
if [ "$INPUT_NAME" ==  "" ]; then
  echo "ERROR: empty name"
  exit;
fi
# setup git
git config --global user.name $INPUT_NAME 

echo "[INPUT] git config --global user.email:"
read INPUT_EMAIL
if [ "$INPUT_EMAIL" ==  "" ]; then
  echo "ERROR: empty email"
  exit;
fi
# setup git
git config --global user.email $INPUT_EMAIL 

echo "[INFO] generated ~/.gitconfig"


# Ban commit and push to master
# -------------------------------

GIT_TEMPLATE_DIR=~/.git_template
GIT_TEMPLATE_HOOKS_DIR=$GIT_TEMPLATE_DIR/hooks
PRE_FILES="pre-push pre-commit"

# generate files
mkdir -p $GIT_TEMPLATE_HOOKS_DIR

for PRE_FILE in ${PRE_FILES[@]}; do
  touch $GIT_TEMPLATE_HOOKS_DIR/$PRE_FILE

  # ---------------------------------------------
  cat <<EOF > $GIT_TEMPLATE_HOOKS_DIR/$PRE_FILE
#!/bin/sh

# if the branch is master, then fail.

branch="\$(git symbolic-ref HEAD 2>/dev/null)" || \\
       "\$(git describe --contains --all HEAD)"

if [ "\${branch##refs/heads/}" = "master" ]; then
  echo "Do not commit or push on the master branch!"
  exit 1
fi
EOF
  # ---------------------------------------------
  echo "[INFO] generated $GIT_TEMPLATE_HOOKS_DIR/$PRE_FILE"
done

chmod 755 $GIT_TEMPLATE_HOOKS_DIR/*

# setup git
git config --global init.templatedir $GIT_TEMPLATE_DIR

echo "[INFO] Done."

