# Ballerina gRPC Greeter

This example shows how a gRPC service and client can be deployed in Choreo using Ballerina. The example demonstrates 
a simple greeter service that returns a greeting message. The client is a simple application deployed as a manual 
trigger on Choreo that calls the greeter service and prints the response.

This is a Ballerina conversion of the original Go gRPC example, providing the same functionality with Ballerina's 
native gRPC support.

## Project Structure

```
grpc_sample/
├── Ballerina.toml                    # Project configuration
├── main.bal                          # Main server entry point
├── client.bal                        # Client entry point
├── modules/
│   ├── greeter_service/
│   │   ├── greeter_pb.bal           # Generated protobuf types and client
│   │   └── greeter_service.bal      # Server implementation
│   └── greeter_client/
│       └── greeter_client.bal       # Client implementation
├── pkg/
│   └── greeter.proto                # Protocol buffer definition
├── Dockerfile.server.bal            # Docker configuration for server
├── Dockerfile.client.bal            # Docker configuration for client
└── Makefile.bal                     # Build automation
```

## Requirements

- Ballerina 2201.8.6 or later
- Docker (for containerization)

## Building and Running

### Using Make (Recommended)

```bash
# Build both server and client
make -f Makefile.bal all

# Build and run server
make -f Makefile.bal serve

# Run client (in another terminal)
make -f Makefile.bal test_client

# Build Docker images
make -f Makefile.bal docker_all
```

### Using Ballerina CLI

```bash
# Run the server
bal run main.bal

# Run the client (in another terminal)
bal run client.bal

# Build the project
bal build
```

## Environment Variables

- `GREETER_SERVICE`: URL of the greeter service (client only)
  - Default: `http://localhost:8080`
  - Example: `GREETER_SERVICE=http://greeter-service:8080 bal run client.bal`

## Steps to Deploy in Choreo

### Deploy the service
1. Select a project in Choreo or create a new one
2. Create a new service and give it a name
3. Input following for the server component:
    - Public Repository URL: Your repository URL
    - Branch: main
    - Buildpack: Dockerfile
    - Docker Context: grpc_sample
    - Dockerfile: grpc_sample/Dockerfile.server.bal

### Deploy the client
1. Create a manual task component on the same project
2. Input following for the client component:
    - Public Repository URL: Your repository URL
    - Branch: main
    - Buildpack: Dockerfile  
    - Docker Context: grpc_sample
    - Dockerfile: grpc_sample/Dockerfile.client.bal

3. Once created, navigate to the deploy view and add the following environment variable:
    - Key: `GREETER_SERVICE`
    - Value: The service URL from step 1 (e.g., `https://your-service-url`)

## Key Differences from Go Version

1. **Native gRPC Support**: Ballerina provides built-in gRPC support without needing external libraries
2. **Type Safety**: Ballerina's type system provides compile-time safety for gRPC message types
3. **Simplified Error Handling**: Uses Ballerina's union types for error handling
4. **Configuration**: Uses Ballerina.toml instead of go.mod for dependency management
5. **Deployment**: Compiles to JAR files that run on the JVM

## Protocol Buffer Definition

The service uses the same protobuf definition as the original Go version:

```protobuf
service Greeter {
  rpc SayHello (HelloRequest) returns (HelloReply) {}
}

message HelloRequest {
  string name = 1;
}

message HelloReply {
  string message = 1;
}
```

## Development Notes

- The generated Ballerina code from protobuf provides type-safe gRPC client and server stubs
- Server runs on port 8080 by default
- Client connects to `GREETER_SERVICE` environment variable or defaults to localhost:8080
- Both server and client include proper error handling and logging