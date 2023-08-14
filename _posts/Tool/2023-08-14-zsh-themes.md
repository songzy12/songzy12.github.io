---
layout: post
title: "ZSH Themes"
date: 2023-08-14T04:07:43+00:00
---

<https://github.com/ohmyzsh/ohmyzsh/wiki/Themes>

To view all avaliable zsh themes:

```
ls $ZSH/themes/
```

To set zsh theme:

```
ZSH_THEME=random

ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "candy" "risto" )
```

To view the current selected random theme:

```
echo $RANDOM_THEME
```

To view the config of a specific zsh theme:

```
vi $ZSH/themes/robbyrussell.zsh-theme
```
