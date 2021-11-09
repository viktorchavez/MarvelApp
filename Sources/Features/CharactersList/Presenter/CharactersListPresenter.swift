//
//  CharactersListPresenter.swift
//  Data
//
//  Created by Viktor on 09/11/21.
//

import Domain

final class CharactersListPresenter: CharactersListPresenterProtocol {
    weak var view: CharactersListViewProtocol?
    var interactor: CharactersListInteractorInputProtocol?
    var wireframe: CharactersListWireframeProtocol?
    
    func viewDidLoad() {
        view?.set(state: .loading)
        interactor?.fetchCharacters(namePrefix: nil)
    }
    
    func fetchCharacters(namePrefix: String?) {
        interactor?.fetchCharacters(namePrefix: namePrefix)
    }
    
    func loadMore() {
        interactor?.loadMore()
    }
    
    func showCharacterDetail(id: Int) {
        wireframe?.showCharacterDetail(id: id)
    }
    
    func numberOfColumnsPortrait() -> Int {
        return 3
    }
    
    func numberOfColumnsLandscape() -> Int {
        return 4
    }
    
    func numberOfItemsToLoadMore() -> Int {
        return 3
    }
    
    func numberOfItemsWhileLoading() -> Int {
        return 15
    }
}

extension CharactersListPresenter: CharactersListInteractorOutputProtocol {
    func returnedCharacters(characters: [MarvelCharacter]) {
        let charactersViewModel = characters.map({ CharacterViewModel(id: $0.id, name: $0.name, description: $0.description, thumbnailURL: $0.thumbnailURL) })
        view?.set(state: .loaded(charactersViewModel))
    }
    
    func showError(error: String) {
        view?.set(state: .error(error))
    }
}
