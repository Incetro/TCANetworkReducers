//
//  CatFactServiceImplementation.swift
//  ReloadableExample
//
//  Created by Gleb Kovalenko on 27.07.2023.
//

import Foundation
import HTTPTransport
import SDAO
import ServiceCore
import Codex
import Models

// MARK: - CatFactServiceImplementation

public final class CatFactServiceImplementation: WebService {
    
    public init() {
        super.init(
            baseURL: URL(string: "https://cat-fact.herokuapp.com").unsafelyUnwrapped,
            transport: HTTPTransport()
        )
    }
}

// MARK: - CatService

extension CatFactServiceImplementation: CatFactService {
    
    public func obtainRandomFact() -> ServiceCall<CatFactPlainObject> {
        createCall {
            let request = HTTPRequest(
                httpMethod: .get,
                endpoint: "/facts/random",
                base: self.baseRequest
            )
            let result = self.transport.send(request: request)
            switch result {
            case .success(let response):
                do {
                    let data = response.body.unsafelyUnwrapped
                    let result = try data.decoded() as CatFactPlainObject
                    return .success(result)
                } catch {
                    return .failure(error)
                }
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    public func readRandomFact() -> ServiceCall<CatFactPlainObject?> {
        createCall {
            return .success(nil)
        }
    }
    
    public func obtainRandomFacts(limit: Int) -> ServiceCall<[CatFactPlainObject]> {
        createCall {
            return .success([])
        }
    }
    
    public func readRandomFacts(limit: Int) -> ServiceCall<[CatFactPlainObject]?> {
        createCall {
            return .success(nil)
        }
    }
    
    
}
