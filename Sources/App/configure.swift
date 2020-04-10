import Vapor
import LambdaHandler

/// Called before your application initializes.
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
