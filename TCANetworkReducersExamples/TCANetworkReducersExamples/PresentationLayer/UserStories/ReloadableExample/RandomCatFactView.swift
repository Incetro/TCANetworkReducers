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
                    ActivityIndicator()
                        .padding(16)
                        .background(.gray)
                        .cornerRadius(8)
                }
            ) {
                VStack {
                    Text("here")
                    Text(viewStore.factText)
                    Button {
                        viewStore.send(.getRandomFactButtonTapped)
                    } label: {
                        Text("Get other")
                    }
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

// MARK: - Preview

struct RandomCatFactView_Previews: PreviewProvider {
    static var previews: some View {
        RandomCatFactView(
            store: Store(
                initialState: RandomCatFactState(),
                reducer: RandomCatFactFeature(
                    catFactService: CatFactServiceImplementation()
                )
            )
        )
    }
}
