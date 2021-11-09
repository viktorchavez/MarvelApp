//
//  ThumbnailEntity.swift
//  Data
//
//  Created by Viktor on 09/11/21.
//

import Foundation

struct ThumbnailEntity: Decodable {
    let path: String
    let `extension`: String

    func toDomain() throws -> URL? {
        guard let url = URL(string: "\(path).\(`extension`)") else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: [CodingKeys.path,CodingKeys.extension],
                                      debugDescription: "Invalid Thumbnail URL.")
            )
        }
        if path.contains("image_not_available") {
            return nil
        }
        return url
    }
}
