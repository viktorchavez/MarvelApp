//
//  CharacterDetailInteractor.swift
//  MarvelApp
//
//  Created by Viktor on 09/11/21.
//

import Domain
import Data
import Resolver

final class CharacterDetailInteractor: CharactersDetailInteractorInputProtocol {
    var presenter: CharactersDetailInteractorOutputProtocol?
    
    @Injected private var characterUseCase: CharacterUseCase
    
    func fetchCharacter(id: Int) {
        characterUseCase.execute(id) { result in
            switch result {
            case .success(let character):
                self.presenter?.returnedCharacter(character: character)
            case .failure(let error):
                self.presenter?.showError(error: error.localizedDescription)
            }
        }
    }
}
