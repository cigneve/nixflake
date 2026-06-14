# Modularise this function
function bits
    set categories ultratips/programming/java ultratips/programming/general bits/
    set blogDir "$HOME/notes"
    test ! -d $blogDir && echo "Directory \"$blogDir\" does not exist" && return
    set filePath "$blogDir/$(string join \n $categories | fzf)"

    begin # Create if empty
        test ! -e "$filePath" && return
    end

    # This may be useful for vscode?
    # Maybe make this a toggle?
    fish -c "echo -n \"$filePath\" | fish_clipboard_copy" &
    $EDITOR "$filePath"
end
