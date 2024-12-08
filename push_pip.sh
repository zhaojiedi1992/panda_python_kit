#!/usr/bin/env bash
function update_version(){
  FILE="$1"
  version_string=$(grep -o 'version="[0-9]\+\.[0-9]\+\.[0-9]\+"' $FILE)
  version_number=$(echo $version_string | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
  IFS='.' read -r -a version_parts <<< "$version_number"
  new_patch_version=$((${version_parts[2]}+1))
  new_version="${version_parts[0]}.${version_parts[1]}.$new_patch_version"
  sed -i "s@version=\"$version_number\"@version=\"$new_version\"@g" $FILE
}
update_version setup.py
source .venv/bin/activate
rm -rf dist
python3 -m build
twine upload  dist/*