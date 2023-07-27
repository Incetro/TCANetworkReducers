//
//  RandomCatFactView.swift
//  AllThings
//
//  Created by Gleb Kovalenko on 24.07.2023.
//

import SwiftUI
import TCA
import BusinessLayer
import PresentationLayer
import TCANetworkReducers

// MARK: - RandomCatFactView

public struct RandomCatFactView: View {
    
    // MARK: - Properties
    
    /// The store powering the `RandomCatFact` feature
    public let store: StoreOf<RandomCatFactFeature>
    
    // MARK: - Initializer
    
    public init(store: StoreOf<RandomCatFactFeature>) {
        self.store = store
    }
    
    // MARK: - View
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            ReloadableView(
                store: store.scope(
                    state: \.reloadableRandomFact,
                    action: RandomCatFactAction.reloadableRandomFact
                ),
                loader: {
                    ActivityIndicator(color: .white)
                        .padding(16)
                        .background(.gray)
                        .cornerRadius(8)
                }
            ) {
                Form {
                    Section(header: Text("")) {
                        if let message = viewStore.randomCatFactResponse.message {
                            Text(message)
                                .font(.system(size: 17, weight: .bold))
                        }
                        Text(viewStore.factText)
                        Button {
                            viewStore.send(.getRandomFactButtonTapped)
                        } label: {
                            Text("Get new fact")
                        }
                        .disabled(!viewStore.isGetFactButtonActive)
                    }
                    .textCase(nil)
                }
                .navigationTitle("Reloadable")
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
