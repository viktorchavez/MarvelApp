//
//  MarvelService.swift
//  Data
//
//  Created by Viktor on 09/11/21.
//

import Foundation
import Moya

enum CharactersService: TargetType {
    case charactersList(namePrefix: String? = nil, offset: Int? = nil)
    case character(id: Int)
    
    var baseURL: URL { URL(string: "https://gateway.marvel.com:443/v1/public")! }
    
    var path: String {
        switch self {
        case .charactersList:
            return "/characters"
        case let .character(id):
            return "/characters/\(id)"
        }
    }
    
    var method: Moya.Method { .get }
    
    var sampleData: Data {
        guard let testBundle = Bundle(identifier: "com.pak.MarvelApp.dataTest"),
            let url = testBundle.url(forResource: "characters", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return Data()
        }
        return data
    }
    
    var task: Task {
        var parameters = (try? AuthEntity().toDictionary()) ?? [:]
        let encoding = URLEncoding.queryString
        
        switch self {
        case let .charactersList(namePrefix, offset):
            parameters["orderBy"] = "name"
            parameters["nameStartsWith"] = namePrefix
            parameters["offset"] = offset
            return .requestParameters(parameters: parameters,
                                      encoding: encoding)
        case .character:
            return .requestParameters(parameters: parameters,
                                      encoding: encoding)
        }
    }
    
    var headers: [String: String]? { ["Content-type": "application/json; charset=utf-8"] }
}
