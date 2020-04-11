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

@_exported import enum AWSSDKSwiftCore.Region

public struct LambdaConfiguration {
    /// Hardcoded Access Key identifying a user in IAM
    public let accessKeyId: String?

    /// Corresponding Secret Keys
    public let secretAccessKey: String?

    /// Specific region in AWS to connect to
    /// Defaults to us-east-1
    public let region: Region?

    /// Optional endpoint to connect to
    public let endpoint: String?

    public init(accessKeyId: String? = nil,
                secretAccessKey: String? = nil,
                region: Region? = .useast1,
                endpoint: String? = nil) {
        self.accessKeyId = accessKeyId
        self.secretAccessKey = secretAccessKey
        self.region = region
        self.endpoint = endpoint
    }
}
