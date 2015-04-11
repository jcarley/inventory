#!/usr/bin/env bash

resolve_link() {
  $(type -p greadlink readlink | head -1) "$1"
}

abs_dirname() {
  local cwd="$(pwd)"
  local path="$1"

  while [ -n "$path" ]; do
    cd "${path%/*}"
    local name="${path##*/}"
    path="$(resolve_link "$name" || true)"
  done

  pwd
  cd "$cwd"
}

script_path="$(abs_dirname "$0")"
app_root="$(abs_dirname "$script_path")"

# echo $script_path
# echo $app_root

echo "Syncing with 104.236.23.194 ..."
rsync -rt --verbose --progress --stats --compress --links --delete --exclude-from=$app_root/exclude.txt $app_root root@104.236.23.194:~/apps
