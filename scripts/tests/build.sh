cp 2.x/* ./
docker buildx build . --output type=docker,name=elestio4test/opensearch:latest | docker load
