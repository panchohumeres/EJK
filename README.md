# docker-elastic-kibana-jupyter

#iniciar con este comando
sudo sysctl -w vm.max_map_count=262144

#matar todos los contenedores
docker kill $(docker ps -q)