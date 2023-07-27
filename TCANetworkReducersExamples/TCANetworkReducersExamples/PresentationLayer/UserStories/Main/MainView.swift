//
//  MainView.swift
//  TCANetworkReducersExamples
//
//  Created by Gleb Kovalenko on 26.07.2023.
//

import SwiftUI
import TCA
import ReloadableExample

// MARK: - MainView

public struct MainView: View {
    
    // MARK: - Properties
    
    /// The store powering the `Main` feature
    public let store: StoreOf<MainFeature>
    
    // MARK: - Initializer
    
    public init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    // MARK: - View
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            Form {
                Section(header: Text("Reloadable")) {
                    NavigationLink(
                        destination: RandomCatFactView(
                            store: store.scope(
                                state: \.reloadableExample,
                                action: MainAction.reloadableExample
                            )
                        )
                    ) {
                        Text("Deafult reloadable")
                            .font(.system(size: 17, design: .default))
                    }
                    NavigationLink(
                        destination: {
                            Text("Parameter reloadable")
                        }
                    ) {
                        Text("Parameter reloadable")
                            .font(.system(size: 17, design: .default))
                    }
                }
                
                Section(header: Text("Pagination")) {
                    NavigationLink(
                        destination: {
                            Text("Default pagination")
                        }
                    ) {
                        Text("Default pagination")
                            .font(.system(size: 17, design: .default))
                    }
                    NavigationLink(
                        destination: {
                            Text("Parameter pagination")
                        }
                    ) {
                        Text("Parameter pagination")
                            .font(.system(size: 17, design: .default))
                    }
                    NavigationLink(
                        destination: {
                            Text("Cursor pagination")
                        }
                    ) {
                        Text("Cursor pagination")
                            .font(.system(size: 17, design: .default))
                    }
                }
            }
        }
    }
}

// MARK: - Preview

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            store: Store(
                initialState: MainState(),
                reducer: MainFeature()
            )
        )
    }
}
