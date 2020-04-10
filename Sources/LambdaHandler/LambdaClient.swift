import Lambda
import Vapor

public final class LambdaClient {
    public typealias Connection = LambdaManager
    public typealias Query = Lambda.InvocationRequest
    public typealias Output = Lambda.InvocationResponse

    private let config: LambdaConfiguration

    internal func makeClient() -> Lambda {
        return Lambda(
            accessKeyId: config.accessKeyId,
            secretAccessKey: config.secretAccessKey,
            region: config.region,
            endpoint: config.endpoint
        )
    }

    public func make(on eventloop: EventLoop) -> LambdaManager {
        return LambdaManager(client: self, on: eventloop)
    }
    
    public init(config: LambdaConfiguration) {
        self.config = config
    }
}

