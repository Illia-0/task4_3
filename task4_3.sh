#!/bin/bash

set -o errexit

target_dir="/tmp/backups"
mkdir -p -- "$target_dir"

if (( $# != 2 )); then
  echo "Illegal number of parameters" >&2
  exit 1
fi

backup_directory=$1
backups_number=""

if [ -n "$2" -a $2 -eq $2 2> /dev/null ]; then
  backups_number=$2
else
  echo "Number of backups is illegal" >&2
  exit 1
fi

archive_name=$backup_directory
archive_name=${archive_name#/}
archive_name=${archive_name//\//-}
archive_name="$archive_name-$(date --utc --iso-8601=seconds).tar.gz"

tar --create --gzip --file "$target_dir/$archive_name" -C "/" -- "${backup_directory#/}" > /dev/null
