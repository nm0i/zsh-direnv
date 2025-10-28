# zsh-direnv

zsh plugin for loading [direnv](https://github.com/direnv/direnv.git)

## Requirements

[direnv](https://github.com/direnv/direnv.git) should be in your `$path`
at the time you load this plugin. 

## Optional: Adding current direnv dir to the prompt

You can add your current direnv directory to the PROMPT:

    PROMPT="${DIRENV_DIR##*/} ${PROMPT}"

## Installation

### Package managers

Load `nm0i/zsh-direnv` 

### Manual

Clone and source init.zsh of this plugin:

    mkdir -p ~/.zsh/plugins/ && cd ~/.zsh/plugins/
    git clone https://github.com/nm0i/zsh-direnv.git
    echo 'source ~/.zsh/plugins/zsh-direnv/init.zsh' >> ~/.zshrc

