import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;

public const string CHAT_DESC = "0A0A636861742E70726F746F1204636861741A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F221F0A0B436861745265717565737412100A036D736718012001280952036D736722270A09436861745265706C79121A0A086D73675265706C7918012001280952086D73675265706C79221D0A0548694D736712140A0548696D7367180120012809520548696D736732650A0443686174122F0A0973656E645265706C7912112E636861742E43686174526571756573741A0F2E636861742E436861745265706C79122C0A05736179486912162E676F6F676C652E70726F746F6275662E456D7074791A0B2E636861742E48694D7367620670726F746F33";

public isolated client class ChatClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, CHAT_DESC);
    }

    isolated remote function sendReply(ChatRequest|ContextChatRequest req) returns ChatReply|grpc:Error {
        map<string|string[]> headers = {};
        ChatRequest message;
        if req is ContextChatRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("chat.Chat/sendReply", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ChatReply>result;
    }

    isolated remote function sendReplyContext(ChatRequest|ContextChatRequest req) returns ContextChatReply|grpc:Error {
        map<string|string[]> headers = {};
        ChatRequest message;
        if req is ContextChatRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("chat.Chat/sendReply", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ChatReply>result, headers: respHeaders};
    }

    isolated remote function sayHi() returns HiMsg|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeSimpleRPC("chat.Chat/sayHi", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <HiMsg>result;
    }

    isolated remote function sayHiContext() returns ContextHiMsg|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeSimpleRPC("chat.Chat/sayHi", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <HiMsg>result, headers: respHeaders};
    }
}

public isolated client class ChatChatReplyCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendChatReply(ChatReply response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextChatReply(ContextChatReply response) returns grpc:Error? {
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

public isolated client class ChatHiMsgCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendHiMsg(HiMsg response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextHiMsg(ContextHiMsg response) returns grpc:Error? {
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

public type ContextChatReply record {|
    ChatReply content;
    map<string|string[]> headers;
|};

public type ContextHiMsg record {|
    HiMsg content;
    map<string|string[]> headers;
|};

public type ContextChatRequest record {|
    ChatRequest content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: CHAT_DESC}
public type ChatReply record {|
    string msgReply = "";
|};

@protobuf:Descriptor {value: CHAT_DESC}
public type HiMsg record {|
    string Himsg = "";
|};

@protobuf:Descriptor {value: CHAT_DESC}
public type ChatRequest record {|
    string msg = "";
|};
