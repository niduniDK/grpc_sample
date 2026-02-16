import ballerina/grpc;
import ballerina/protobuf;

public const string HELLOWORLD_DESC = "0A1068656C6C6F776F726C642E70726F746F120A68656C6C6F776F726C6422220A0C48656C6C6F5265717565737412120A046E616D6518012001280952046E616D6522260A0A48656C6C6F5265706C7912180A076D65737361676518012001280952076D65737361676522350A0B557365724D65737361676512120A046E616D6518012001280952046E616D6512120A047465787418022001280952047465787422410A0B4368617444657461696C73121E0A0A73656E6465724E616D65180120012809520A73656E6465724E616D6512120A0474657874180220012809520474657874221F0A09526563657069656E7412120A046E616D6518012001280952046E616D65221E0A08426461795769736812120A047769736818012001280952047769736832470A0747726565746572123C0A0873617948656C6C6F12182E68656C6C6F776F726C642E48656C6C6F526571756573741A162E68656C6C6F776F726C642E48656C6C6F5265706C79327C0A0443686174123B0A0773656E644D736712172E68656C6C6F776F726C642E557365724D6573736167651A172E68656C6C6F776F726C642E4368617444657461696C7312370A08626461795769736812152E68656C6C6F776F726C642E526563657069656E741A142E68656C6C6F776F726C642E4264617957697368620670726F746F33";

public isolated client class GreeterClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, HELLOWORLD_DESC);
    }

    isolated remote function sayHello(HelloRequest|ContextHelloRequest req) returns HelloReply|grpc:Error {
        map<string|string[]> headers = {};
        HelloRequest message;
        if req is ContextHelloRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("helloworld.Greeter/sayHello", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <HelloReply>result;
    }

    isolated remote function sayHelloContext(HelloRequest|ContextHelloRequest req) returns ContextHelloReply|grpc:Error {
        map<string|string[]> headers = {};
        HelloRequest message;
        if req is ContextHelloRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("helloworld.Greeter/sayHello", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <HelloReply>result, headers: respHeaders};
    }
}

public isolated client class ChatClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, HELLOWORLD_DESC);
    }

    isolated remote function sendMsg(UserMessage|ContextUserMessage req) returns ChatDetails|grpc:Error {
        map<string|string[]> headers = {};
        UserMessage message;
        if req is ContextUserMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("helloworld.Chat/sendMsg", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ChatDetails>result;
    }

    isolated remote function sendMsgContext(UserMessage|ContextUserMessage req) returns ContextChatDetails|grpc:Error {
        map<string|string[]> headers = {};
        UserMessage message;
        if req is ContextUserMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("helloworld.Chat/sendMsg", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ChatDetails>result, headers: respHeaders};
    }

    isolated remote function bdayWish(Recepient|ContextRecepient req) returns BdayWish|grpc:Error {
        map<string|string[]> headers = {};
        Recepient message;
        if req is ContextRecepient {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("helloworld.Chat/bdayWish", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <BdayWish>result;
    }

    isolated remote function bdayWishContext(Recepient|ContextRecepient req) returns ContextBdayWish|grpc:Error {
        map<string|string[]> headers = {};
        Recepient message;
        if req is ContextRecepient {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("helloworld.Chat/bdayWish", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <BdayWish>result, headers: respHeaders};
    }
}

public isolated client class GreeterHelloReplyCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendHelloReply(HelloReply response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextHelloReply(ContextHelloReply response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ChatChatDetailsCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendChatDetails(ChatDetails response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextChatDetails(ContextChatDetails response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ChatBdayWishCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendBdayWish(BdayWish response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextBdayWish(ContextBdayWish response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextHelloRequest record {|
    HelloRequest content;
    map<string|string[]> headers;
|};

public type ContextHelloReply record {|
    HelloReply content;
    map<string|string[]> headers;
|};

public type ContextChatDetails record {|
    ChatDetails content;
    map<string|string[]> headers;
|};

public type ContextBdayWish record {|
    BdayWish content;
    map<string|string[]> headers;
|};

public type ContextUserMessage record {|
    UserMessage content;
    map<string|string[]> headers;
|};

public type ContextRecepient record {|
    Recepient content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type ChatDetails record {|
    string senderName = "";
    string text = "";
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type BdayWish record {|
    string wish = "";
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type HelloRequest record {|
    string name = "";
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type UserMessage record {|
    string name = "";
    string text = "";
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type HelloReply record {|
    string message = "";
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type Recepient record {|
    string name = "";
|};
