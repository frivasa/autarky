# removes previous query, downloads a new image json
# changes it in fastfetch config
# returns to original folder where this was called
retfolder=$(pwd)
tarfolder=~/.config/fastfetch
cd "$tarfolder"
echo "selection: $1/$2"
rm "$2"*
rm *.jpg
rm *.png
rm *.gif
sleep 0.5
wget https://api.waifu.pics/$1/$2
imurl=$(grep -oP '(?<="url":")[^"]*' $2)
wget "$imurl"
sleep 0.5
python update_waifu.py config.jsonc logo.source $tarfolder $imurl
cd "$retfolder"
