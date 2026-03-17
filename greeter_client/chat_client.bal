import ballerina/io;

ChatClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    UserMessage sendMsgRequest = {name: "ballerina", text: "ballerina"};
    ChatDetails sendMsgResponse = check ep->sendMsg(sendMsgRequest);
    io:println(sendMsgResponse);

    Recepient bdayWishRequest = {name: "ballerina"};
    BdayWish bdayWishResponse = check ep->bdayWish(bdayWishRequest);
    io:println(bdayWishResponse);
}
