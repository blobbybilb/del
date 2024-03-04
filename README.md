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

---

### Other Stuff

