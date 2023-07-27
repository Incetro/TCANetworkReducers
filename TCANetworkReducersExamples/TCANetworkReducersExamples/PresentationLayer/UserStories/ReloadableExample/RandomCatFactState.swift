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
    
    // MARK: - RandomCatFactResponse
    
    public enum RandomCatFactResponse {
        
        // MARK: - Cases
        
        case none
        case network
        case cache
        
        // MARK: - Useful
        
        public var message: String? {
            switch self {
            case .none:
                return nil
            case .network:
                return "This is network response"
            case .cache:
                return "This is cache response"
            }
        }
    }
    
    // MARK: - Properties
    
    /// Fact text instance
    public var factText: String
    
    /// Indicates which response is got(just for clarity)
    public var randomCatFactResponse: RandomCatFactResponse
    
    /// Indicates which `GetFact` button active
    public var isGetFactButtonActive: Bool {
        reloadableRandomFact.status != .loading && reloadableRandomFact.status != .reloading
    }
    
    // MARK: - Children
    
    /// Alert state value
    public var alert: AlertState<RandomCatFactAction>?
    
    // MARK: - Reloadable
    
    /// Reloadable state instance
    public var reloadableRandomFact = ReloadableState<CatFactPlainObject, CatFactError>(shouldDisplayLoaderWhileReloading: true)
}

// MARK: - Initializer

extension RandomCatFactState {
    
    public init() {
        self.factText = ""
        self.randomCatFactResponse = .none
    }
}
