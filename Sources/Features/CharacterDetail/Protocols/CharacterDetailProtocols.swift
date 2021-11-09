//
//  CharacterDetailProtocols.swift
//  MarvelApp
//
//  Created by Viktor on 09/11/21.
//

import Domain

enum CharactersDetailViewState {
    case loading
    case loaded(MarvelCharacter)
    case error(String)
}

protocol CharactersDetailWireframeProtocol {
    // PRESENTER -> WIREFRAME
}

protocol CharactersDetailPresenterProtocol: AnyObject {
    var view: CharactersDetailViewProtocol? { get set }
    var interactor: CharactersDetailInteractorInputProtocol? { get set }
    var wireframe: CharactersDetailWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func fetchCharacter(id: Int)
    func shareCharacter(character: MarvelCharacter)
}

protocol CharactersDetailViewProtocol: AnyObject {
    var presenter: CharactersDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func set(state: CharactersDetailViewState)
    func showShareCharacter(character: MarvelCharacter)
}

protocol CharactersDetailInteractorInputProtocol: AnyObject {
    var presenter: CharactersDetailInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchCharacter(id: Int)
}

protocol CharactersDetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func returnedCharacter(character: MarvelCharacter)
    func showError(error: String)
}

