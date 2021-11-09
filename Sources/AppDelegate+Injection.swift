//
//  AppDelegate+Injection.swift
//  MarvelApp
//
//  Created by Viktor on 09/11/21.
//

import Resolver
import Domain
import Data

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerProviders()
        registerUsecases()
    }
}

extension Resolver {
    public static func registerUsecases() {
        register { CharactersUseCase(resolve()) }
        register { CharacterUseCase(resolve()) }
    }
    
    public static func registerProviders() {
        register { CharactersProvider() }
            .implements(CharactersProviderContract.self)
    }
}
