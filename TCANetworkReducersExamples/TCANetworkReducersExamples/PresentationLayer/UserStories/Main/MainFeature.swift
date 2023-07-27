//
//  MainFeature.swift
//  TCANetworkReducersExamples
//
//  Created by Gleb Kovalenko on 26.07.2023.
//

import TCA
import ReloadableExample
import BusinessLayer

// MARK: - MainFeature

public struct MainFeature: ReducerProtocol {
    
    // MARK: - Initializer
    
    public init() {}
    
    // MARK: - Feature
    
    public var body: some ReducerProtocol<MainState, MainAction> {
        Scope(state: \.reloadableExample, action: /MainAction.reloadableExample) {
            RandomCatFactFeature(
                catFactService: CatFactServiceImplementation()
            )
        }
        Reduce { state, action in
            switch action {
            default:
                break
            }
            return .none
        }
    }
}
