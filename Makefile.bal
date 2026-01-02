# Ballerina gRPC Sample Makefile
.PHONY: all clean build_server build_client serve test_client

all: build_server build_client

build_server:
	mkdir -p target
	bal build --target-dir target/server

build_client:
	mkdir -p target/client
	bal build client.bal --target-dir target/client

serve:
	bal run main.bal

test_client:
	GREETER_SERVICE=http://localhost:8080 bal run client.bal

docker_server:
	docker build -f Dockerfile.server.bal -t greeter-server-bal .

docker_client:
	docker build -f Dockerfile.client.bal -t greeter-client-bal .

docker_all: docker_server docker_client

clean:
	rm -rf target
	rm -rf Dependencies.toml

help:
	@echo "Available targets:"
	@echo "  all         - Build both server and client"
	@echo "  build_server - Build the Ballerina server"
	@echo "  build_client - Build the Ballerina client" 
	@echo "  serve       - Run the Ballerina server"
	@echo "  test_client - Run the Ballerina client"
	@echo "  docker_server - Build Docker image for server"
	@echo "  docker_client - Build Docker image for client"
	@echo "  docker_all  - Build both Docker images"
	@echo "  clean       - Clean build artifacts"