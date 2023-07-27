//
//  RandomCatFactFeature.swift
//  AllThings
//
//  Created by Gleb Kovalenko on 24.07.2023.
//

import TCA
import TCANetworkReducers
import BusinessLayer
import Foundation

// MARK: - RandomCatFactFeature

public struct RandomCatFactFeature: ReducerProtocol {
    
    // MARK: - Properties
    
    private let catFactService: CatFactService
    
    // MARK: - Initializer
    
    public init(catFactService: CatFactService) {
        self.catFactService = catFactService
    }
    
    // MARK: - Feature
    
    public var body: some ReducerProtocol<RandomCatFactState, RandomCatFactAction> {
        Scope(state: \.reloadableRandomFact, action: /RandomCatFactAction.reloadableRandomFact) {
            RelodableReducer {
                catFactService
                    .obtainRandomFact()
                    .publish()
            } cache: {
                catFactService
                    .readRandomFact()
                    .publish()
            }
        }
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .value(.reloadableRandomFact(.load))
            case .getRandomFactButtonTapped:
                return .value(.reloadableRandomFact(.reload))
            case .reloadableRandomFact(.response(.success(let plain))):
                state.randomCatFactResponse = .network
                state.factText = plain.text
            case .reloadableRandomFact(.cacheResponse(.success(let plain))):
                state.randomCatFactResponse = .cache
                state.factText = plain.text
            default:
                break
            }
            return .none
        }
    }
}
