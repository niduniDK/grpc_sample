import ballerina/grpc;
// import devant/service_info_extractor as _;

listener grpc:Listener ep = new (9096);

@grpc:Descriptor {value: HELLOWORLD_DESC}
service "Greeter" on ep {

    remote function sayHello(HelloRequest value) returns HelloReply|error {
        return {
            message: "Hi"
        };
    }
}
