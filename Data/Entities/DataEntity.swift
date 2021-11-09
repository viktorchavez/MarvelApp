//
//  DataEntity.swift
//  Data
//
//  Created by Viktor on 09/11/21.
//

import Domain

struct DataEntity: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [CharacterEntity]
    
    func toDomain() throws -> [MarvelCharacter] {
        try results.map { try $0.toDomain() }
    }
}
