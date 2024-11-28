function diary
    set dateString "$(date -u +%d-%m-%Y)"
    set noteDir "$HOME/notes/free"
    test ! -d $noteDir && echo "Directory \"$noteDir\" does not exist" && return
    set filePath "$noteDir/$dateString.typ"

    begin # 
        begin
            test ! -f "$filePath"
            or test ! -s "$filePath"
        end
        and echo "= $dateString" >"$filePath"
    end

    $EDITOR "$filePath"
end
