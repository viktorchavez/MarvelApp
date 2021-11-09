//
//  CharactersListInteractor.swift
//  Data
//
//  Created by Viktor on 09/11/21.
//

import Domain
import Data
import Resolver

final class CharactersListInteractor: CharactersListInteractorInputProtocol {
    weak var presenter: CharactersListInteractorOutputProtocol?
    
    @Injected private var charactersUseCase: CharactersUseCase
    
    private var namePrefix: String?
    private var currentOffset: Int = 0
    
    private var charactersList: [MarvelCharacter]
    
    init() {
        charactersList = [MarvelCharacter]()
    }
    
    func fetchCharacters(namePrefix: String?) {
        self.currentOffset = 0
        self.charactersList.removeAll()
        self.namePrefix = namePrefix?.isEmpty ?? true ? nil : namePrefix
        charactersUseCase.execute(namePrefix: self.namePrefix, offset: self.currentOffset) { result in
            switch result {
            case .success(let characters):
                self.charactersList = characters
                self.presenter?.returnedCharacters(characters: characters)
            case .failure(let error):
                self.presenter?.showError(error: error.localizedDescription)
            }
        }
    }
    
    func loadMore() {
        if (currentOffset == charactersList.count) {
            return
        }
        
        currentOffset = charactersList.count
        charactersUseCase.execute(namePrefix: self.namePrefix, offset: charactersList.count) { result in
            switch result {
            case .success(let characters):
                self.charactersList.append(contentsOf: characters)
                self.presenter?.returnedCharacters(characters: self.charactersList)
            case .failure(let error):
                self.presenter?.showError(error: error.localizedDescription)
            }
        }
    }
}
