//
//  TCANetworkReducersExamplesApp.swift
//  TCANetworkReducersExamples
//
//  Created by Gleb Kovalenko on 26.07.2023.
//

import SwiftUI
import TCA
import Main

@main
struct TCANetworkReducersExamplesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView(
                    store: Store(
                        initialState: MainState(),
                        reducer: MainFeature()
                    )
                )
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
