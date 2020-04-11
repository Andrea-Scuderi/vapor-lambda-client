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

import Foundation
import Lambda
import Vapor

public extension Application {
    func lambdaClient() throws -> LambdaClient {
        guard let client = storage[LambdaClientKey.self] else {
            throw LambdaHandlerError.notInUse
        }
        return client
    }
}

public extension Request {
    func lambda() throws -> LambdaManager {
        let client = try application.lambdaClient()
        return client.make(on: eventLoop.next())
    }
}

public extension Lambda.InvocationRequest {
    static func makeInvocation(functionName: String, json: String = "{}") -> Lambda.InvocationRequest {
        let payload = json.data(using: .utf8)
        let invocationRequest = Lambda.InvocationRequest(
            clientContext: nil,
            functionName: functionName,
            invocationType: Lambda.InvocationType.requestresponse,
            logType: Lambda.LogType.tail,
            payload: payload,
            qualifier: nil
        )
        return invocationRequest
    }
}

internal extension Data {
    func decode<T: Decodable>() throws -> T {
        let jsonDecoder = JSONDecoder()
        let input = try jsonDecoder.decode(T.self, from: self)
        return input
    }
}
