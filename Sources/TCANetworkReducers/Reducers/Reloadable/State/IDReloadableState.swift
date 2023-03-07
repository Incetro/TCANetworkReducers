//
//  IDReloadableState.swift
//  Ruvpro
//
//  Created by incetro on 7/17/22.
//

import TCA
import Foundation

// MARK: - IDReloadableState

/// `Reloadable` module state
///
/// Basically, `ReloadableState` is a type that describes the data
/// `Reloadable` feature needs to perform its logic and render its UI.
@dynamicMemberLookup
public struct IDReloadableState<Data: Equatable & Codable & Identifiable, ErrorType: Error & Equatable>: Equatable {

    // MARK: - Properties

    /// Identifier for loading
    public var id: Data.ID

    /// Reloadable composition instance
    public var reloadable = ReloadableState<Data, ErrorType>()

    // MARK: - DynamicMemberLookup

    public subscript<Dependency>(dynamicMember keyPath: WritableKeyPath<ReloadableState<Data, ErrorType>, Dependency>) -> Dependency {
        get { reloadable[keyPath: keyPath] }
        set { reloadable[keyPath: keyPath] = newValue }
    }
}

