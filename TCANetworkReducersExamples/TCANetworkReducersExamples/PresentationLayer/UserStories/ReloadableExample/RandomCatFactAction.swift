//
//  RandomCatFactAction.swift
//  AllThings
//
//  Created by Gleb Kovalenko on 24.07.2023.
//

import TCANetworkReducers
import Models

// MARK: - RandomCatFactAction

public enum RandomCatFactAction: Equatable {
    
    // MARK: - Cases
    
    /// General action that calls when view appears
    case onAppear
    
    /// An action that calls when user taps on the `GetRandomFact` button
    case getRandomFactButtonTapped
    
    /// An action that calls when user taps on the `dismiss` button on the alert
    case alertDismissed
    
    // MARK: - Reloadable
    
    /// Reloadable action instance
    case reloadableRandomFact(ReloadableAction<CatFactPlainObject, CatFactError>)
    
    // MARK: - Service
    
    case catFactsService
}
