//
//  ResponseEntity.swift
//  Data
//
//  Created by Viktor on 09/11/21.
//

struct ResponseEntity: Decodable {
    let code: Int
    let status: String
    let data: DataEntity
}
