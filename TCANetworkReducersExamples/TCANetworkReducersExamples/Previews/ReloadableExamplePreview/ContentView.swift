//
//  ContentView.swift
//  ReloadableExamplePreview
//
//  Created by Gleb Kovalenko on 27.07.2023.
//

import SwiftUI
import TCA
import ServiceCore
import SDAO
import ReloadableExample
import BusinessLayer

public struct ContentView: View {
    public var body: some View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
