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
import TCA
import Monreau

// MARK: - CatFactServiceImplementation

public final class CatFactServiceImplementation: WebService {
    
    // MARK: - Properties
    
    /// `CatFacts` dao instance
    public let catFactsDAO: CatFactsDAO
    
    // MARK: - Initializer
    
    public init() {
        catFactsDAO = CatFactsDAO(
            storage: RealmStorage<CatFactModelObject>(
                configuration: Dependency(\.realmConfiguration).wrappedValue
            ),
            translator: Models.CatFactsTranslator(
                configuration: Dependency(\.realmConfiguration).wrappedValue
            )
        )
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
                    try self.catFactsDAO.erase()
                    try self.catFactsDAO.persist(result)
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
            let catFact = try self.catFactsDAO.read().first
            return .success(catFact)
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
