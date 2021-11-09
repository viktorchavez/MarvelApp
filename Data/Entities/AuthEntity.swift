//
//  AuthEntity.swift
//  Data
//
//  Created by Viktor on 09/11/21.
//

import Foundation
import CryptoKit

struct AuthEntity: Encodable {
    private let apikey = "3daa8bfc6c3aa0377ce254cdb8a697a8"
    private let ts = Int(Date().timeIntervalSince1970)
    let hash: String?

    init() {
        let privateKey = "220a01262130b64700475d3715d889732b4bd15d"
        let hashString = String(ts) + privateKey + apikey
        if let hashData = hashString.data(using: .utf8) {
            hash = Insecure.MD5.hash(data: hashData).map { String(format: "%02hhx", $0) }.joined()
        } else {
            hash = nil
        }
    }

    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        guard let dictionary = jsonObject as? [String: Any] else {
            throw EncodingError.invalidValue(
                jsonObject, EncodingError.Context(codingPath: [CodingKeys.apikey, CodingKeys.ts, CodingKeys.hash],
                                                  debugDescription: "Invalid authentication format."))
        }
        return dictionary
    }
}
