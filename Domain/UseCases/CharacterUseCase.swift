//
//  CharacterUseCase.swift
//  Domain
//
//  Created by Viktor on 09/11/21.
//

public final class CharacterUseCase {
    private let provider: CharactersProviderContract
    
    public init(_ provider: CharactersProviderContract) {
        self.provider = provider
    }
    
    public func execute(_ id: Int, completion: @escaping CharacterCompletion) {
        provider.character(id: id, completion: completion)
    }
}
