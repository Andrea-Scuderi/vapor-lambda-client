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

import AWSSDKSwiftCore
import Lambda
import Vapor

/// 💧 The Handler expected to be registered to easily allow
/// usage of Lambda from within a Vapor application

struct LambdaConfigurationKey: StorageKey {
    typealias Value = LambdaConfiguration
}

struct LambdaClientKey: StorageKey {
    typealias Value = LambdaClient
}

public struct LambdaHandler: LifecycleHandler {
    let config: LambdaConfiguration

    public func willBoot(_ application: Application) throws {
        application.storage[LambdaConfigurationKey.self] = config
        application.storage[LambdaClientKey.self] = LambdaClient(config: config)
    }

    public func didBoot(_ application: Application) throws {
        print(config)
    }

    public func shutdown(_ application: Application) {}

    public init(config: LambdaConfiguration) {
        self.config = config
    }
}
