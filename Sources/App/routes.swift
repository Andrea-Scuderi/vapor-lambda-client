//    Copyright 2020 (c) Andrea Scuderi - https://github.com/swift-sprinter
//
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
//
//        http://www.apache.org/licenses/LICENSE-2.0
//
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

import Lambda
import Vapor
import VaporLambdaClient

public func routes(_ app: Application) throws {
    // Lambda invocation example
    app.get { req -> EventLoopFuture<String> in

        let invocationRequest = Lambda.InvocationRequest.makeInvocation(
            functionName: "Hello.hello"
        )

        return try req.lambda()
            .invokeForProxy(invocationRequest)
            .map { (result) -> String in
                result.body
            }
    }

    // Basic "Hello, world!" example
    app.get("hello") { _ in
        "Hello, world!"
    }
}
