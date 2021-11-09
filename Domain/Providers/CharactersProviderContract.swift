//
//  CharactersProviderContract.swift
//  Domain
//
//  Created by Viktor on 09/11/21.
//

public enum CharactersError: Error {
    case api(code: String, message: String)
    case related(Error)
    case characterNotFound
    
    public var localizedDescription: String {
        switch self {
        case .api(_, let message):
            return message
        case .related:
            return "An error ocurred"
        case .characterNotFound:
            return "The character was not found"
        }
    }
}

public typealias CharactersListCompletion = (_ result: Result<[MarvelCharacter], CharactersError>) -> Void

public typealias CharacterCompletion = (_ result: Result<MarvelCharacter, CharactersError>) -> Void

public protocol CharactersProviderContract {
    func characters(namePrefix: String?, offset: Int?, completion: @escaping CharactersListCompletion)
    func character(id: Int, completion: @escaping CharacterCompletion)
}
