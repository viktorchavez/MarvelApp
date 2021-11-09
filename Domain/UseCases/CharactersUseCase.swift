//
//  CharactersUseCase.swift
//  Domain
//
//  Created by Viktor on 09/11/21.
//

public final class CharactersUseCase {
    private let provider: CharactersProviderContract
    
    public init(_ provider: CharactersProviderContract) {
        self.provider = provider
    }
    
    public func execute(namePrefix: String? = nil, offset: Int? = nil, completion: @escaping CharactersListCompletion) {
        provider.characters(namePrefix: namePrefix, offset: offset, completion: completion)
    }
}
