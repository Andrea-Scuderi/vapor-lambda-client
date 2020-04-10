import Vapor
import Lambda
import LambdaHandler

public func routes(_ app: Application) throws {
    
    //Lambda invocation example
    app.get { req -> EventLoopFuture<String> in
        
        let invocationRequest = Lambda.InvocationRequest.makeInvocation(
            functionName: "Hello.hello"
        )
        
        return try req.lambda()
            .invokeForProxy(invocationRequest)
            .map { (result) -> String in
                return result.body
        }
    }
    
    // Basic "Hello, world!" example
    app.get("hello") { req in
        return "Hello, world!"
    }
}
