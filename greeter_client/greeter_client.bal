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

import ballerina/os;
import ballerina/log;
import grpc_sample.greeter_service;

public function main() returns error? {
    string greeterService = os:getEnv("GREETER_SERVICE");
    if greeterService == "" {
        greeterService = "http://localhost:8080";
    }

    greeter_service:GreeterClient greeterClient = check new (greeterService);
    
    greeter_service:HelloRequest request = {
        name: "Choreo"
    };
    
    greeter_service:HelloReply|error response = greeterClient->SayHello(request);
    
    if response is greeter_service:HelloReply {
        log:printInfo("Greeting: " + response.message);
    } else {
        log:printError("Could not greet", response);
    }
}