//
//  String.swift
//  MarvelApp
//
//  Created by Viktor on 09/11/21.
//

import Foundation

public extension String {
    var localized: String {
        return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
    }
}
