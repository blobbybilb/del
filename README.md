# Not Really Config Configs

I don't like spending time configuring things unless it's really necessary. This is a collection of scripts, configs, etc. that I have made as needed.

---

#### [`del`](https://github.com/blobbybilb/not-configs/blob/main/del) - rm on mac is scary
- a script to move files into macOS Trash
- uses Ruby because it's pre-installed on macOS (Sonoma)
- `sudo curl https://raw.githubusercontent.com/blobbybilb/not-configs/main/del -o /usr/local/bin/del; sudo chmod +x /usr/local/bin/del`

#### [`Apple Notes Export`](https://github.com/blobbybilb/not-configs/blob/main/apple-notes-export-script.py)
- a script to export Apple Notes to pdf en masse (but individually) on macOS
- before using, set a keyboard shortcut for export note to `cmd+shift+e` (from System Settings)
- the line `mouse.position = (975, 23)` might need to be tweaked (it moves the mouse to the Trash button if I remember correctly) (that and line below it can be removed to stop deleting)
- before starting the script, click on the first note you want to export in gallery view
- [note to self](https://github.com/blobbybilb/xyz-old/blob/main/apple-notes-export-script/apple-notes-export%20(made%20on%20or%20around%209.Jul.2023).py) (ignore, it's a private repo anyway)

#### [`$`](https://github.com/blobbybilb/not-configs/blob/main/del)
- when copying commands sometimes there's a `$` at the start, this one-line script ignores that (in simple cases) (does `echo "$@"`) (I might make it a bit more sophisticated later) (doesn't work on all shells but works on sh, bash, zsh, etc. (not fish))
- `sudo curl https://raw.githubusercontent.com/blobbybilb/not-configs/main/\$ -o /usr/local/bin/\$; sudo chmod +x /usr/local/bin/\$`

#### [`PDF to Image`](https://github.com/blobbybilb/not-configs/blob/main/PDF%20to%20Images.shortcut)
- Apple Shortcuts shortcut that converts each page of a PDF to PNG images

#### [`PDF Reorder`]
- Reorders a stack of pages scanned from one side then another

---

### Other Stuff

TODO
