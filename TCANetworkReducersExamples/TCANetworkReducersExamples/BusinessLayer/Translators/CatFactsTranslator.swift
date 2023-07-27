//
//  CatFactsTranslator.swift
//  BusinessLayer
//
//  Created by Gleb Kovalenko on 27.07.2023.
//

import SDAO
import Monreau
import Models
import Foundation

// MARK: - CatFactsTranslator

public final class CatFactsTranslator {
    
    // MARK: - Aliases
    
    public typealias PlainModel = CatFactPlainObject
    public typealias DatabaseModel = CatFactModelObject
    
    /// CatFacts storage
    private lazy var catFactsStorage = RealmStorage<CatFactModelObject>(configuration: self.configuration)
    
    /// RealmConfiguration instance
    private let configuration: RealmConfiguration
    
    // MARK: - Initializers
    
    /// Default initializer
    /// - Parameters:
    ///   - configuration: current realm db config
    public init(configuration: RealmConfiguration) {
        self.configuration = configuration
    }
}

// MARK: - Translator

extension CatFactsTranslator: Translator {
    
    public func translate(model: DatabaseModel) throws -> PlainModel {
        CatFactPlainObject(
            text: model.text
        )
    }
    
    public func translate(plain: PlainModel) throws -> DatabaseModel {
        let model = try catFactsStorage.read(byPrimaryKey: plain.uniqueId.rawValue) ?? DatabaseModel()
        try translate(from: plain, to: model)
        return model
    }
    
    public func translate(from plain: PlainModel, to databaseModel: DatabaseModel) throws {
        if databaseModel.uniqueId.isEmpty {
            databaseModel.uniqueId = plain.uniqueId.rawValue
        }
        databaseModel.text = plain.text
    }
}
