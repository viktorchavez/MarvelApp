//
//  CharacterEntity.swift
//  Data
//
//  Created by Viktor on 09/11/21.
//

import Domain

struct CharacterEntity: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: ThumbnailEntity

    func toDomain() throws -> MarvelCharacter {
        MarvelCharacter(id: id, name: name, description: description, thumbnailURL: try? thumbnail.toDomain())
    }
}
