//
//  CharactersListProtocols.swift
//  Data
//
//  Created by Viktor on 09/11/21.
//

import Domain

enum CharactersListViewState {
    case loading
    case loaded([CharacterViewModel])
    case error(String)
}

protocol CharactersListWireframeProtocol {
    // PRESENTER -> WIREFRAME
    func showCharacterDetail(id: Int)
}

protocol CharactersListPresenterProtocol: AnyObject {
    var view: CharactersListViewProtocol? { get set }
    var interactor: CharactersListInteractorInputProtocol? { get set }
    var wireframe: CharactersListWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func fetchCharacters(namePrefix: String?)
    func loadMore()
    func showCharacterDetail(id: Int)
    func numberOfColumnsPortrait() -> Int
    func numberOfColumnsLandscape() -> Int
    func numberOfItemsToLoadMore() -> Int
    func numberOfItemsWhileLoading() -> Int
}

protocol CharactersListViewProtocol: AnyObject {
    var presenter: CharactersListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func set(state: CharactersListViewState)
}

protocol CharactersListInteractorInputProtocol: AnyObject {
    var presenter: CharactersListInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchCharacters(namePrefix: String?)
    func loadMore()
}

protocol CharactersListInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func returnedCharacters(characters: [MarvelCharacter])
    func showError(error: String)
}
