# Make PDF document look scanned
function lookscanned
    convert $1 -colorspace gray \( +clone -blur 0x1 \) +swap -compose divide -composite -linear-stretch 5%x0% -rotate 1.5 -
end
