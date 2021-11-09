//
//  CharacterViewModel.swift
//  MarvelApp
//
//  Created by Viktor on 09/11/21.
//

import Foundation

public struct CharacterViewModel {
    public let id: Int
    public let name: String
    public let thumbnailURL: URL?

    public init(id: Int, name: String, description: String, thumbnailURL: URL?) {
        self.id = id
        self.name = name
        self.thumbnailURL = thumbnailURL
    }
}
