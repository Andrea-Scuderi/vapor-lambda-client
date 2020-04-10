//
//  HTTPResponseMiddleware.swift
//  
//
//  Created by Andrea Scuderi on 10/04/2020.
//

import Foundation
import Vapor


public struct HTMLResponseMiddleware: Middleware {
    
    public func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        return next.respond(to: request).map { (reponse) -> (Response) in
            reponse.headers.add(contentsOf:  ["Content-Type": "text/html"])
            return reponse
        }
    }
    
    public init() {
        
    }
}
