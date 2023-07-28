//
//  ChuckNorisView.swift
//  AllThings
//
//  Created by Gleb Kovalenko on 24.07.2023.
//

import SwiftUI
import TCA
import BusinessLayer
import PresentationLayer
import TCANetworkReducers

// MARK: - ChuckNorisView

public struct ChuckNorisView: View {
    
    // MARK: - Properties
    
    /// The store powering the `ChuckNoris` feature
    public let store: StoreOf<ChuckNorisReducer>
    
    // MARK: - Initializer
    
    public init(store: StoreOf<ChuckNorisReducer>) {
        self.store = store
    }
    
    // MARK: - View
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            ReloadableView(
                store: store.scope(
                    state: \.reloadableChuckNoris,
                    action: ChuckNorisAction.reloadableChuckNoris
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
                        if let message = viewStore.chuckNorisResponse.message {
                            Text(message)
                                .font(.system(size: 17, weight: .bold))
                        }
                        Text(viewStore.jokeText)
                        Button {
                            viewStore.send(.getRandomFactButtonTapped)
                        } label: {
                            Text("Get new joke")
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
