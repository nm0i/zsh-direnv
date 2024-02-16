# zsh-direnv

zsh plugin for loading [direnv](https://github.com/direnv/direnv.git)

## Requirements

[direnv](https://github.com/direnv/direnv.git) should be in your path
at the time you load this plugin. 

## Adding current direnv dir to the PROMPT (optional)

The plugin provides `_zsh_direnv_dir` function that will return
current direnv directory or an empty string.

You can add it to your PROMPT like this:

    PROMPT="$(_zsh_direnv_dir)$PROMPT"
    
Or any other way you like.

## Installation

### Package managers

Load `nm0i/zsh-direnv` 

### Manual

Clone and source init.zsh of this plugin:

    mkdir -p ~/.zsh/plugins/ && cd ~/.zsh/plugins/
    git clone https://github.com/nm0i/zsh-direnv.git
    echo 'source ~/.zsh/plugins/zsh-direnv/init.zsh' >> ~/.zshrc

