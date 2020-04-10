
import Vapor
import AWSSDKSwiftCore
import Lambda

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
        application.storage[LambdaClientKey.self] = LambdaClient(config:config)
    }
    
    public func didBoot(_ application: Application) throws {
        print(config)
    }
    
    public func shutdown(_ application: Application) {

    }
    
    public init(config: LambdaConfiguration) {
        self.config = config
    }
}
