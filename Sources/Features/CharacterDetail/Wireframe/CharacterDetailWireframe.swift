//
//  CharacterDetailWireframe.swift
//  MarvelApp
//
//  Created by Viktor on 09/11/21.
//

import UIKit

final class CharacterDetailWireframe: CharactersDetailWireframeProtocol {
    weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func createCharacterDetailModule(id: Int) -> UIViewController {
        guard let view = UIStoryboard(name: "Characters", bundle: nil).instantiateViewController(withIdentifier: "CharacterDetailViewController") as? CharacterDetailViewController else {
            return UIViewController()
        }
        
        let presenter: CharactersDetailPresenterProtocol &
            CharactersDetailInteractorOutputProtocol = CharacterDetailPresenter()
        let interactor: CharactersDetailInteractorInputProtocol = CharacterDetailInteractor()
        let wireframe: CharactersDetailWireframeProtocol = CharacterDetailWireframe(view)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        view.characterID = id
        
        return view
    }
}
