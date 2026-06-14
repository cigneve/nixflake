{...}: {
  programs.zathura.enable = true;
  programs.zathura.extraConfig = ''
    # Zathura configuration file
    # See man `man zathurarc'

    # Open document in fit-width mode by default
    set adjust-open "best-fit"

    # One page per row by default
    set pages-per-row 1

    #stop at page boundries
    set scroll-page-aware "true"
    set smooth-scroll "true"
    set scroll-full-overlap 0.01
    set scroll-step 100

    #zoom settings
    set zoom-min 10
    set guioptions ""

    # zathurarc-dark

    set font "inconsolata 15"
    set default-bg "#292137" #00
    set default-fg "#DCDCCC" #01

    set statusbar-fg "#B0B0B0" #04
    set statusbar-bg "#202020" #01

    set inputbar-bg "#151515" #00 currently not used
    set inputbar-fg "#FFFFFF" #02

    set notification-error-bg "#AC4142" #08
    set notification-error-fg "#151515" #00

    set notification-warning-bg "#AC4142" #08
    set notification-warning-fg "#151515" #00

    set highlight-color "#F4BF75" #0A
    set highlight-active-color "#6A9FB5" #0D

    set completion-highlight-fg "#151515" #02
    set completion-highlight-bg "#90A959" #0C

    set completion-bg "#303030" #02
    set completion-fg "#E0E0E0" #0C

    set notification-bg "#90A959" #0B
    set notification-fg "#151515" #00

    set recolor "true"
    set recolor-lightcolor "#282828" #00
    set recolor-darkcolor "#DCDCCC" #06
    set recolor-reverse-video "true"
    set page-padding-h 3
    set page-padding-v 3
    set recolor-keephue "true"


    set render-loading "false"
    set scroll-step 50
    unmap f
    map f toggle_fullscreen
    map [fullscreen] f toggle_fullscreen
    map [ scroll full-down
    map ] scroll full-up
    map [fullscreen] [ scroll full-down
    map [fullscreen] ] scroll full-up
    '';
}
