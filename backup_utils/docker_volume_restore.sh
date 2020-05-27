#!/bin/bash
#https://gist.github.com/kiview/5ff58ed69366e2d591d19ac34d8f8616
compose_file_path=$1
project_name=$2
backup_path=$3



function restore_volume {
  volume_name=$1
  backup_destination=$2
  echo "backing up volume..."
  echo $volume_name

  docker run --rm -v $volume_name:/data ubuntu find /data -mindepth 1 -delete
  docker run --rm -v $volume_name:/data -v $backup_destination:/backup ubuntu tar -xvf /backup/$volume_name.tar -C .
}

echo "Creating containers without running"
docker-compose up --no-start

echo "Stopping running containers"
docker-compose -f $compose_file_path stop

echo "Mounting volumes and performing restore for volumes..."
volumes=($(docker volume ls -f name=$project_name | awk '{if (NR > 1) print $2}'))
echo "$volumes"
echo "end of volumes list"
for v in "${volumes[@]}"
do
  restore_volume $v $backup_path
done

echo "Restarting containers"
docker-compose -f $compose_file_path start