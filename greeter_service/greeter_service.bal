import ballerina/grpc;

int port = 8082;

listener grpc:Listener grpcListener = new (port);

@grpc:Descriptor {value: HELLOWORLD_DESC}
service "Greeter" on grpcListener {

    remote function sayHello(HelloRequest value) returns HelloReply|error {
        return {message: "Hello " + value.name};
    }
}