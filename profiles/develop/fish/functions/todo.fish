function todo
    set noteDir "$HOME/notes/"
    test ! -d $noteDir && echo "Directory \"$noteDir\" does not exist" && return
    set filePath "$noteDir/TODO.typ"

    begin # Create if empty
        begin
            test ! -f "$filePath"
            or test ! -s "$filePath"
        end
        and echo "= TODO" >"$filePath"
    end

    $EDITOR "$filePath"
end
