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
