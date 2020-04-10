//
//  APIGatewayProxyResult.swift
//  
//
//  Created by Andrea Scuderi on 10/04/2020.
//

import Foundation
import Lambda
import Vapor

public struct APIGatewayProxyResult: Codable {
    
    public let isBase64Encoded: Bool?
    public let statusCode: Int
    public let headers: [String: String]?
    public let multiValueHeaders: [String: [String]]?
    public let body: String
    
    public init(isBase64Encoded: Bool? = false,
                statusCode: Int,
                headers: [String: String]? = ["Content-Type": "text/html"],
                multiValueHeaders: [String: [String]]? = nil,
                body: String) {
        self.isBase64Encoded = isBase64Encoded
        self.statusCode = statusCode
        self.headers = headers
        self.multiValueHeaders = multiValueHeaders
        self.body = body
    }
    
}
