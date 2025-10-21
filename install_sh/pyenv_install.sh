
#!/usr/bin/env bash
set -e
set -u

echo ">>> Installing pyenv and pyenv-virtualenv..."

# 1. Cài dependencies
sudo apt update
sudo apt install -y build-essential curl git libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl

# 2. Cài pyenv
PYENV_ROOT="$HOME/.pyenv"
if [ ! -d "$PYENV_ROOT" ]; then
    git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT"
else
    cd "$PYENV_ROOT" && git pull
fi

# 3. Cài pyenv-virtualenv
PLUGIN_DIR="$PYENV_ROOT/plugins/pyenv-virtualenv"
if [ ! -d "$PLUGIN_DIR" ]; then
    git clone https://github.com/pyenv/pyenv-virtualenv.git "$PLUGIN_DIR"
else
    cd "$PLUGIN_DIR" && git pull
fi

echo ">>> Installation completed!"
echo ">>> To use pyenv, run:"
echo "    export PYENV_ROOT=\"$HOME/.pyenv\""
echo "    export PATH=\"$PYENV_ROOT/bin:\$PATH\""
echo "    eval \"\$(pyenv init --path)\""
echo "    eval \"\$(pyenv init -)\""
echo "    eval \"\$(pyenv virtualenv-init -)\""
