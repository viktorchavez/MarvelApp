//
//  CharacterDetailPresenter.swift
//  MarvelApp
//
//  Created by Viktor on 09/11/21.
//

import Domain

final class CharacterDetailPresenter: CharactersDetailPresenterProtocol {
    var view: CharactersDetailViewProtocol?
    
    var interactor: CharactersDetailInteractorInputProtocol?
    
    var wireframe: CharactersDetailWireframeProtocol?
    
    func viewDidLoad() {
        view?.set(state: .loading)
    }
    
    func fetchCharacter(id: Int) {
        interactor?.fetchCharacter(id: id)
    }
    
    func shareCharacter(character: MarvelCharacter) {
        view?.showShareCharacter(character: character)
    }
}

extension CharacterDetailPresenter: CharactersDetailInteractorOutputProtocol {
    func returnedCharacter(character: MarvelCharacter) {
        view?.set(state: .loaded(character))
    }
    
    func showError(error: String) {
        view?.set(state: .error(error))
    }
}
