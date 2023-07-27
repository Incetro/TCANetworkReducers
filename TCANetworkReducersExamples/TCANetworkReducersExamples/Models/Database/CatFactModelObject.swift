//
//  CatFactModelObject.swift
//  TCANetworkReducersExamples
//
//  Created by Gleb Kovalenko on 27.07.2023.
//

import SDAO
import RealmSwift
import Foundation

// MARK: - CatFactModelObject

public final class CatFactModelObject: RealmModel {
    
    // MARK: - Properties
    
    @objc dynamic public var text = ""
}
