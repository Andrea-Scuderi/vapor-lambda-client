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

public enum DynamoConnectionError: Error {
    case improperlyFormattedQuery(String)
    case notImplementedYet
}

/// 💫 `LambdaConnection` for direct queries to Lambda.
public final class LambdaManager {
    public let eventLoop: EventLoop

    private let client: LambdaClient

    public var logger: Logger?

    internal private(set) var handle: Lambda!

    internal init(client: LambdaClient, on eventLoop: EventLoop) {
        self.client = client
        self.eventLoop = eventLoop
        handle = client.makeClient()
    }
}

public protocol LambdaInvocable {
    func invoke(_ query: Lambda.InvocationRequest) -> EventLoopFuture<Lambda.InvocationResponse>
    func invokeForProxy(_ query: Lambda.InvocationRequest) -> EventLoopFuture<APIGatewayProxyResult>
}

extension LambdaManager: LambdaInvocable {
    public func invoke(_ query: Lambda.InvocationRequest) -> EventLoopFuture<Lambda.InvocationResponse> {
        return handle.invoke(query).hop(to: eventLoop)
    }

    public func invokeForProxy(_ query: Lambda.InvocationRequest) -> EventLoopFuture<APIGatewayProxyResult> {
        return handle.invoke(query)
                .hop(to: eventLoop)
                .flatMapThrowing { (result) -> APIGatewayProxyResult in
            guard let data = result.payload else {
                throw LambdaHandlerError.emptyLambdaPayload
            }
            let value: APIGatewayProxyResult = try data.decode()
            return value
        }
    }
}
