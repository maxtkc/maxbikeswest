#!/bin/bash
# Loop through all assets/img/file.jpg and create assets/img/web/file.webp and update references

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
REPO_DIR=$( dirname "$SCRIPT_DIR" )
IMG_DIR="$REPO_DIR/assets/img"

# Loop through each image
for file in "$IMG_DIR"/*.{jpg,jpeg};
do
    full_filename=$(basename -- "$file");
    filename="${full_filename%.*}"
    # Convert to webp
    cwebp "$file" -o "$IMG_DIR/webp/$filename.webp";
    # echo grep -R "![.*]({{ site.baseurl }}/assets/img/$full_filename)" "$REPO_DIR"
    gawk -i inplace "{gsub(/assets\/img\/$full_filename/,\"assets/img/webp/$filename.webp\");}1" "$REPO_DIR"/_posts/*.md;
    # for post in /home/maxk/Documents/maxbikeswest/_posts/*.md;
    # do
    #     awk "{gsub(/assets\/img\/$full_filename/,\"assets\/img\/webp\/$filename.webp\");}1" "$post";
    # done
done
