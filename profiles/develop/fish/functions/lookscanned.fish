# Make PDF document look scanned
function lookscanned
    # convert $1 -colorspace gray \( +clone -blur 0x1 \) +swap -compose divide -composite -linear-stretch 5%x0% -rotate 1.5 -
    magick -density 150 $1 -rotate "$([ $(math $(random) % 2) -eq 1 ] && echo -)0.$(math $(random) % 4 + 5)" -attenuate 0.4 +noise Multiplicative -attenuate 0.03 +noise Multiplicative -sharpen 0x1.0 -colorspace Gray out$1
end
