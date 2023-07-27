//
//  ReloadableExamplePreviewApp.swift
//  ReloadableExamplePreview
//
//  Created by Gleb Kovalenko on 27.07.2023.
//

import SwiftUI
import TCA
import ReloadableExample
import BusinessLayer

@main
struct ReloadableExamplePreviewApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
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
    }
}

// MARK: - Preview

struct RandomCatFactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
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
}
