//
//  File.swift
//  
//
//  Created by Andrea Scuderi on 10/04/2020.
//

import Foundation
import Lambda
import Vapor

public extension Application {
    func lambdaClient() throws -> LambdaClient {
        guard let client = storage[LambdaClientKey.self] else {
            throw LambdaHandlerError.notInUse
        }
        return client
    }
}

public extension Request {
    
    func lambda() throws -> LambdaManager {
        let client = try application.lambdaClient()
        return client.make(on: eventLoop.next())
    }
}

public extension Lambda.InvocationRequest {
    static func makeInvocation(functionName: String, json: String = "{}") -> Lambda.InvocationRequest {
        let payload = json.data(using: .utf8)
        let invocationRequest = Lambda.InvocationRequest(
            clientContext: nil,
            functionName: functionName,
            invocationType: Lambda.InvocationType.requestresponse,
            logType: Lambda.LogType.tail,
            payload: payload,
            qualifier: nil)
        return invocationRequest
    }
}

internal extension Data {
    func decode<T: Decodable>() throws -> T {
        let jsonDecoder = JSONDecoder()
        let input = try jsonDecoder.decode(T.self, from: self)
        return input
    }
}
