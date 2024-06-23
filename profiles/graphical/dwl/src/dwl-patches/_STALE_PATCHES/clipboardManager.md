### Description
Store your clipboard history using `clipman` clipboard manager without your KeePassXC passwords leaking into clipman.

Ensure these dependencies are installed (instructions for debian, other distros are left as an exercise...):

    apt install clipman libmodern-perl-perl moreutils wl-clipboard

Change your command to launch `dwl` to something like the following:

    dwl -s 'pee somebar dwl-getwindowtitle'

Ensure the following command is running in the background of your `dwl` session. Put it whereever your auto-started stuff is.

    exec wl-paste -t text --watch dwl-clipman

This solution is based on the following reddit post, modified to support `dwl`. https://www.reddit.com/r/swaywm/comments/ljl0dh/keeping_secrets_secret_with_keepassxc_clipman_and/

Feel free to use this code however you want, but I can't guarantee it will work for what you are trying to do. Licenced under the same license as `dwl`, "WITHOUT WARRANTY OF ANY KIND".



### Download
- [2022-12-21](https://github.com/djpohly/dwl/compare/main...bencollerson:clipboard-manager.patch)
- [2022-12-01](https://github.com/djpohly/dwl/compare/main...bencollerson:94d0a21.patch)

### Authors
- [Ben Collerson](https://github.com/bencollerson)