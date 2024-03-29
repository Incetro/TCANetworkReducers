//
//  PaginationReducer.swift
//  TheRun
//
//  Created by TraxxasWyls on 28/07/2022.
//  Copyright © 2022 Incetro Inc. All rights reserved.
//

import TCA
import Foundation
import Combine

// MARK: - PaginationReducer

public struct PaginationReducer<Element: Equatable & Codable, ErrorType: Error & Equatable>: ReducerProtocol {
    
    // MARK: - Properties
    
    /// Main queue scheduler instance
    @Dependency(\.mainQueueScheduler) var mainQueue: AnySchedulerOf<DispatchQueue>
    
    /// The fetchHandler is defined by the user, it defines the behaviour for how to fetch a given page.
    public var fetchHandler: (_ page: Int, _ pageSize: Int) -> AnyPublisher<Paginated<Element>, ErrorType>
    
    // MARK: - Initializers
    
    public init(
        fetchHandler: @escaping (_ page: Int, _ pageSize: Int) -> AnyPublisher<Paginated<Element>, ErrorType>
    ) {
        self.fetchHandler = fetchHandler
    }
    
    // MARK: - ReducerProtocol
    
    public func reduce(
       into state: inout PaginationState<Element>, action: PaginationAction<Element, ErrorType>
    ) -> EffectTask<PaginationAction<Element, ErrorType>> {
        switch action {
        case .reset:
            state.total = 0
            state.page = 0
            state.requestStatus = .none
            state.results = []
        case .paginate where !state.reachedLastPage:
            state.requestStatus = .inProgress
            return fetchHandler(state.page + 1, state.pageSize)
                .catchToEffect(PaginationAction<Element, ErrorType>.response)
        case .response(.success(let paginatedElement)):
            state.isNeededAutomaticButtonLoading = false
            state.results.append(contentsOf: paginatedElement.array)
            state.total = paginatedElement.pagination.totalCount
            state.page += 1
            state.requestStatus = .done
            if state.results.count >= state.total {
                return .value(.allElementsFetched)
            }
        case .response(.failure):
            state.requestStatus = .failed
        default:
            return .none
        }
        return .none
    }
}
