function blog
    set blogDir "$HOME/pj/blog/"
    test ! -d $blogDir && echo "Directory \"$blogDir\" does not exist" && return
    set filePath "$blogDir/$(fd --base-directory "$blogDir" | fzf)"

    begin # Create if empty
        test ! -f "$filePath" && return
    end

    # This may be useful for vscode?
    # Maybe make this a toggle?
    fish -c "echo -n \"$filePath\" | fish_clipboard_copy" &
    $EDITOR "$filePath"
end
