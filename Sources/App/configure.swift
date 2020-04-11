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

import Vapor
import VaporLambdaClient

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
