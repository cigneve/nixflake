# dwl-patches
* A general [dwl wiki](https://codeberg.org/dwl/dwl/wiki) is available at the main [dwl](https://codeberg.org/dwl/dwl) page.
* This repository is exclusively for dwl PATCHES.

## _STALE_PATCHES
Many patches previously in regular use do not cleanly apply to the current code base. Following the migration to Codeberg, these stale patch descriptions were relocated to [_STALE_PATCHES].

Additionally, patches that have been deprecated by their author(s)/maintainer(s) may be found in _STALE_PATCHES.

If you are an original author of one of these or you have the inclination to revive one of these, please follow the same procedures outlined below for contributing new patches.

In your initial pull request (or in the commit that revives the stale patch if you already have write access), remove the `.md` file from [_STALE_PATCHES] for the patch which you have revived.

## Patching
Since dwl follows [suckless](https://suckless.org/) philosophy it doesn't provide every feature under the sun. To broaden dwl's functionality, one needs to get familiar with the concept of patching. To get your feet wet, consult [the hacking page](https://suckless.org/hacking/) of the suckless website.

Since dwl is still taking shape, patches may need to be updated after larger changes to the code. Feel free to [contribute](instructions) updated versions!

*Note: These external patches are user-submitted content, and the authors of dwl cannot monitor them. Please download and review a patch before using it!*

## Reporting Issues
- Issues with existing patches can be generated here in the dwl-patches [issues]. Please be sure to "@" reference the patch author in your issue.

## Creating Patches
1. Create a [Codeberg] account and fork the [dwl] repository.
2. Create a branch in your Codeberg `dwl` repository for the patch you are generating and maintaining.

## Contributing Patches to `dwl-patches`
1. If you do not have it already, add the remote for the main dwl repository in your local copy and fetch it:
    `git remote add --fetch upstream https://codeberg.org/dwl/dwl`
2. In your local repository of dwl, create a .patch file
    `git format-patch upstream/main...<branch-name> --stdout > PATCHNAME.patch`
3. Fork [https://codeberg.org/dwl/dwl-patches][dwl-patches]
4. Configure your repository
    `git config --local pull.rebase true`
5. In your local copy, add a directory called `patches/PATCHNAME`. Place the `PATCHNAME.patch` you created in step three into the `patches/PATCHNAME` directory.
6. Use the Codeberg web interface to send a pull request to [dwl-patches] (NOT to [dwl]) (Codeberg nicely will generate a URL for you)
7. Add a `README.md` page to the `PATCHNAME` directory using this template (add/remove sections as you like):
    ```markdown
    ### Description
    Insert a short summary of changes that your patch implements.

    ### Download
    - [git branch](https://codeberg.org/USERNAME/dwl/src/branch/PATCHNAME)
    - [yyyy-mm-dd](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/PATCHNAME/PATCHNAME.patch)
                                               USE THE ^raw^ PATCH LINK HERE
    ### Authors [Codeberg nick is mandatory; other contact methods optional]
    - [YOUR_NICK](https://codeberg.org/USERNAME)
      your_email@if_you_wish_to.share.it
      your_irc_nick at [Libera IRC dwl channel](https://web.libera.chat/?channels=#dwl)
      your_discord_handle at [dwl Discord](https://discord.gg/jJxZnrGPWN)
    ```
    You may choose to include screenshots (hosted in your patch's subdirectory) in your `README.md`. The process is described [here](https://docs.codeberg.org/markdown/using-images/).

8. WHEN YOUR PULL REQUEST IS APPROVED, your Codeberg account will also be granted commit access to [dwl-patches]. Once you have write access, you can make direct modifications/upates to your patches instead of pull requests.

## Updating/Modifying Existing Patches
- If the existing patch is already being maintained by another author, do not make modifications to it without permission.
- Create an issue at [issues] @mentioning the current maintainer
- If you receive no reply for seven days, you may adopt the patch. If you are adopting the patch, you need to maintain a `dwl` branch in your Codeberg repository.
- Modify the `README.md` with new links for your raw patch and for your git branch.
    - **LEAVE PREVIOUS AUTHOR(S)' NICKS/LINKS INTACT UNDER THE "Authors" HEADING!**
    - Add your own nick/link to the top of the "Authors" list.

## Deprecating Existing Patches
- Patches will not be removed from this archive but may instead be deprecated if the author(s)/maintainer(s) of a patch so desire.
- Please do not open issues or contact maintainers to request deprecation of a patch.
- Deprecation of a patch will only occur if *all* authors or current maintainers of the patch agree to the decision to deprecate.
- In such a circumstance the author(s)/maintainer(s):
    - Will create a commit moving the patch to the `_STALE_PATCHES` directory
    - May explain in the associated `README.md` any relevant details of the decision to deprecate the patch.
- This process allows current or future users of the patch the option to adopt, modify, or integrate stale/historical code or portions thereof.


[dwl-patches]: https://codeberg.org/dwl/dwl-patches
[Codeberg]: https://codeberg.org
[dwl]: https://codeberg.org/dwl/dwl
[dwl-patches]: https://codeberg.org/dwl/dwl-patches
[issues]: https://codeberg.org/dwl/dwl-patches/issues
[_STALE_PATCHES]:https://codeberg.org/dwl/dwl-patches/src/branch/main/_STALE_PATCHES
