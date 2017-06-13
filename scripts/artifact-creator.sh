#!/bin/bash

if [[ $# -ne 4 ]]; then
  echo "Usage:"
  echo "$(basename $0) <block size> <block count> <number of files> <file name prefix>"
  echo
  echo "<block size> can use prefixes k, M, etc. see man dd."
  echo "resulting files will be written to the 'results' directory"
  echo "Example: $(basename $0) 1k 2048 10 medium"
  echo "         create 10 2M files, written 1k at a time"
  exit 0
fi

BLOCKSIZE=$1
BLOCKCOUNT=$2
FILECOUNT=$3
FILENAME=$4

mkdir -p results
for idx in $(eval echo {1..$FILECOUNT}); do
  outfile=./results/${FILENAME}.$idx
  dd if=/dev/urandom of=$outfile bs=$BLOCKSIZE count=$BLOCKCOUNT &> /dev/null
  ls -s $outfile
done
