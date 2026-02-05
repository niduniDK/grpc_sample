import ballerina/grpc;

listener grpc:Listener ep1 = new (9080);

@grpc:Descriptor {value: CHAT_DESC}
service "Chat" on ep1 {

    remote function sendReply(ChatRequest value) returns ChatReply|error {
        return {
            msgReply: "Hello, Who is there?"
        };
    }

    remote function sayHi() returns HiMsg|error {
        return {
            Himsg: "Hi there! This is Ballerina gRPC.."
        };
    }
}
