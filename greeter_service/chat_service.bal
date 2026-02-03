import ballerina/grpc;

listener grpc:Listener ep = new (9091);

@grpc:Descriptor {value: CHAT_DESC}
service "Chat" on ep {

    remote function sayHi() returns HiMsg|error {
        return {
            Himsg: "Hi there from Ballerina gRPC"
        };
    }

    remote function sendReply(ChatChatReplyCaller caller, stream<ChatRequest, grpc:Error?> clientStream) returns error? {
        check from ChatRequest chatRequest in clientStream
            do {
                ChatReply chatReply = {msgReply: "Server received: " + chatRequest.msg};
                check caller->sendChatReply(chatReply);
            };
    }
}
