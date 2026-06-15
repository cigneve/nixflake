function diary
    set dateString "$(date -u +%Y-%m-%d)"
    set noteDir "$HOME/notes/diary/"
    test ! -d $noteDir && echo "Directory \"$noteDir\" does not exist" && return
    set filePath "$noteDir/$dateString.typ"

    begin # Create if empty
        begin
            test ! -f "$filePath"
            or test ! -s "$filePath"
        end
        and echo "= $dateString" >"$filePath"
    end

    $EDITOR "$filePath"
end
