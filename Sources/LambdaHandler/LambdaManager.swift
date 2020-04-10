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
        self.handle = client.makeClient()
    }
}

public protocol LambdaInvocable {
    func invoke(_ query: Lambda.InvocationRequest) -> EventLoopFuture<Lambda.InvocationResponse>
    func invokeForProxy(_ query: Lambda.InvocationRequest) -> EventLoopFuture<APIGatewayProxyResult>
}

extension LambdaManager: LambdaInvocable {
    public func invoke(_ query: Lambda.InvocationRequest) -> EventLoopFuture<Lambda.InvocationResponse> {
        return handle.invoke(query)
    }
    
    public func invokeForProxy(_ query: Lambda.InvocationRequest) -> EventLoopFuture<APIGatewayProxyResult> {
        return handle.invoke(query).flatMapThrowing { (result) -> APIGatewayProxyResult in
            guard let data = result.payload else {
                throw LambdaHandlerError.emptyLambdaPayload
            }
            let value: APIGatewayProxyResult = try data.decode()
            return value
        }
    }
}

