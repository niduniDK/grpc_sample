import ballerina/grpc;

listener grpc:Listener ep1 = new (9091);

@grpc:Descriptor {value: CHAT_DESC}
service "Chat" on ep1 {

    remote function sendMsg(UserMessage value) returns ChatDetails|error {
        return {senderName: "Ballerina", text: "Hello " + value.text + "!"};
    }
    remote function bdayWish(Recepient value) returns BdayWish|error {
        return {wish: "Happy Birthday " + value.name + "!"};
    }
}
