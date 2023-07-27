//
//  CatFactService.swift
//  TCANetworkReducersExamples
//
//  Created by Gleb Kovalenko on 24.07.2023.
//

import ServiceCore
import Models

// MARK: - CatFactServiceAction

public enum CatFactServiceAction: Equatable {
    
    // MARK: - Cases
    
    case randomFactObtained(CatFactPlainObject)
}

// MARK: - CatFactService

public protocol CatFactService {
    
    /// Obtain random fact
    /// - Returns: random cat fact plain object
    func obtainRandomFact() -> ServiceCall<CatFactPlainObject>
    
    /// Read random fact from local db
    /// - Returns: random cat fact plain object if exist
    func readRandomFact() -> ServiceCall<CatFactPlainObject?>
    
    /// Obtain random facts
    /// - Returns: array of random cat facts plain objects
    func obtainRandomFacts(limit: Int) -> ServiceCall<[CatFactPlainObject]>
    
    /// Read random facts from local db
    /// - Returns: array of random cat facts plain objects if exists
    func readRandomFacts(limit: Int) -> ServiceCall<[CatFactPlainObject]?>
}
