//
//  CatFactPlainObject.swift
//  TCANetworkReducersExamples
//
//  Created by Gleb Kovalenko on 24.07.2023.
//

import SDAO

// MARK: - CatFactPlainObject

public struct CatFactPlainObject: Codable, Equatable, Plain {
    
    // MARK: - Plain
    
    public var uniqueId: UniqueID {
        UniqueID(rawValue: text)
    }
    
    // MARK: - Properties
    
    /// Fact text
    public let text: String
    
    // MARK: - Initializer
    
    public init(text: String) {
        self.text = text
    }
}
