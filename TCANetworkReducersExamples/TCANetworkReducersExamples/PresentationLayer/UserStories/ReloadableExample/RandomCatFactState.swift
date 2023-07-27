//
//  RandomCatFactState.swift
//  AllThings
//
//  Created by Gleb Kovalenko on 24.07.2023.
//

import TCA
import TCANetworkReducers
import Models

// MARK: - RandomCatFactState

public struct RandomCatFactState: Equatable {
    
    // MARK: - Properties
    
    /// Fact text instance
    public var factText: String
    
    // MARK: - Children
    
    /// Alert state value
    public var alert: AlertState<RandomCatFactAction>?
    
    // MARK: - Reloadable
    
    /// Reloadable state instance
    public var reloadableRandomFact = ReloadableState<CatFactPlainObject, CatFactError>()
}

// MARK: - Initializer

extension RandomCatFactState {
    
    public init() {
        self.factText = ""
    }
}
