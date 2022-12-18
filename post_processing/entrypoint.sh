#!/bin/bash

echo "hello"
echo "now current folder content:"
ls -lathr

echo "ls data folder"
ls -la ./01_data

echo "ls code folder"
ls -la ./02_code

echo "ls output folder"
ls -la ./03_output

data_dir=./01_data
for single_data_dir in "$data_dir"/*
do

  for json_file_path in $(ls $single_data_dir/*.json)
  do
    docker_compose_file=$(basename ${single_data_dir})
    json_file=$(basename ${json_file_path})
    filename="${json_file%.*}"

    mkdir "./03_output/$docker_compose_file/"

    Rscript 02_code/generate_plot_json.r \
      --file $json_file_path \
      --technology "$json_file" \
      --title "$json_file" \
      --ylab "[Value]" \
      --destination "./03_output/$docker_compose_file/$filename.png"

  done

done