// Copyright (c) 2023, WSO2 LLC. (https://www.wso2.com/) All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied. See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/grpc;

public isolated client class GreeterClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, GREETER_DESC);
    }

    isolated remote function SayHello(HelloRequest|ContextHelloRequest req) returns (HelloReply|grpc:Error) {
        map&lt;string|string[]&gt; headers = {};
        HelloRequest message;
        if (req is ContextHelloRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient-&gt;executeSimpleRPC("Greeter/SayHello", message, headers);
        [anydata, map&lt;string|string[]&gt;] [result, _] = payload;
        return &lt;HelloReply&gt;result;
    }
}

public client class GreeterHelloReplyResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendHelloReply(HelloReply response) returns grpc:Error? {
        return self.caller-&gt;send(response);
    }

    isolated remote function sendContextHelloReply(ContextHelloReply response) returns grpc:Error? {
        return self.caller-&gt;send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller-&gt;sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller-&gt;complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextHelloRequest record {
    HelloRequest content;
    map&lt;string|string[]&gt; headers;
};

public type HelloRequest record {
    string name = "";
};

public type ContextHelloReply record {
    HelloReply content;
    map&lt;string|string[]&gt; headers;
};

public type HelloReply record {
    string message = "";
};

const string ROOT_DESCRIPTOR_GREETER = "0A0D67726565746572";
const map&lt;string&gt; GREETER_DESC = {"greeter.proto": ROOT_DESCRIPTOR_GREETER};