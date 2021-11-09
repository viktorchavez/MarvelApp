//
//  CharactersProviderMock.swift
//  DomainTests
//
//  Created by Viktor on 09/11/21.
//

import Foundation
@testable import Domain

final class MockCharactersProvider: CharactersProviderContract {
    private let idData = 1
    private let nameData = ""
    private let descriptionData = ""
    private let thumbnailData = URL(string: "")
    
    func characters(namePrefix: String?, offset: Int?, completion: @escaping CharactersListCompletion) {
        let character = MarvelCharacter(id: idData, name: nameData, description: descriptionData, thumbnailURL: thumbnailData)
        completion(.success([character]))
    }
    
    func character(id: Int, completion: @escaping CharacterCompletion) {
        let character = MarvelCharacter(id: idData, name: nameData, description: descriptionData, thumbnailURL: thumbnailData)
        completion(.success(character))
    }
}
