# removes previous query, downloads a new image json
# changes it in fastfetch config
# returns to original folder where this was called
retfolder=$(pwd)
tarfolder=~/.config/fastfetch
cd "$tarfolder"
echo "selection: $1/$2"
# rm "$2"*
rm *.jpg
rm *.jpeg
rm *.png
rm *.gif
sleep 0.5
excl="excludedTags=oppai&excludedTags=selfies&excludedTags=paizuri&excludedTags=genshin-impact&excludedTags=raiden-shogun&excludedTags=marin-kitagawa&excludedTags=mori-calliope&excludedTags=kamisato-ayaka&excludedTags=black-clover&excludedTags=arknights&excludedTags=milf"
nsfw=$([[ "$1" == "nsfw" ]] && echo True || echo False)
gif=$([[ "$2" == "gif" ]] && echo True || echo False)
# imurl=$(curl "https://api.waifu.im/images?IsNsfw=$nsfw&IncludedTags=$2&Orientation=Landscape&IsAnimated=All" | grep -oP '(?<="url":")[^"]*')
imurl=$(curl "https://api.waifu.im/images?IsNsfw=$nsfw&IsAnimated=$gif&orientation=Landscape&$excl" | grep -oP '(?<="url":")[^"]*')
wget "$imurl"
sleep 0.5
filename=$(basename "$imurl")

color=$(magick "$filename" \
  -resize 100x100 \
  -colors 5 \
  -format "%c" histogram:info:- \
  | sort -nr | head -n 1 \
  | grep -o '#[0-9A-Fa-f]\{6\}')
magick "$filename" -coalesce -bordercolor "$color" -border 10x10 "$filename"
python update_waifu.py config.jsonc logo.source $tarfolder $imurl
cd "$retfolder"

