//
//  File.swift
//  
//
//  Created by Andrea Scuderi on 10/04/2020.
//

import Foundation


enum LambdaHandlerError: LocalizedError {
    case notInUse
    case emptyLambdaPayload
    
    var errorDescription: String? {
        switch self {
            case .notInUse:
                return "LambdaHandler is not configured."
        case .emptyLambdaPayload:
                return "The payload is nil"
        }
    }
}

