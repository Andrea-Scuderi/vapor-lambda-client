# Vapor Lambda Client

 [![Swift 5.2.1](https://img.shields.io/badge/Swift-5.2.1-blue.svg)](https://swift.org/download/) ![](https://img.shields.io/badge/💧Vapor-4.0.0-violet)  ![](https://img.shields.io/badge/version-1.0.0.alpha-orange) 

Support for Amazon's Lambda with [Vapor 4.0](https://github.com/vapor/vapor)
using [aws-sdk-swift](https://github.com/swift-aws/aws-sdk-swift)

## Usage

In the 💧Vapor 4.0 project update the following files:

### configure.swift

- Add the LambdaHandler to the app lifecycle.
    - accessKeyID: `<AWS_ACCESS_KEY_ID>`
    - secretAccessKey: `<AWS_SECRET_ACCESS_KEY>`
    - region: `<AWS_REGION>`
    - endpoint: `nil` or a custom endpoint for local test

- Optional Add the HTMLResponseMiddleware to convert the response to HTML

```swift
public func configure(_ app: Application) throws {
    // Register routes to the router
    try routes(app)

    // Register middleware
    let htmlMiddleware = HTMLResponseMiddleware()
    app.middleware.use(htmlMiddleware)

    // Register LambdaHandler
    let lambdaConfig = LambdaConfiguration(
        accessKeyId: "123456",
        secretAccessKey: "789012",
        region: .useast1,
        endpoint: "http://localhost:9001"
    )

    let lambdaHandler = LambdaHandler(config: lambdaConfig)
    app.lifecycle.use(lambdaHandler)
}
```

### routes.swift

- Add the lambda invocation in the route.

```swift
import Lambda
import LambdaHandler
import Vapor

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
}
```


- The invoke function can return different results:
    - Lambda.InvocationResponse: 
    
    `func invoke(_ query: Lambda.InvocationRequest) -> EventLoopFuture<Lambda.InvocationResponse>`

    - APIGatewayProxyResult:
    
     `func invokeForProxy(_ query: Lambda.InvocationRequest) -> EventLoopFuture<APIGatewayProxyResult>`
