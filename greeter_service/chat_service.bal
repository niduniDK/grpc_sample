import ballerina/grpc;

@grpc:Descriptor {value: HELLOWORLD_DESC}
service "Chat" on ep {

    remote function sendMsg(UserMessage value) returns ChatDetails|error {
        return {senderName: "Ballerina", text: "Hello " + value.text + "!"};
    }
    remote function bdayWish(Recepient value) returns BdayWish|error {
        return {wish: "Happy Birthday " + value.name + "!"};
    }
}
