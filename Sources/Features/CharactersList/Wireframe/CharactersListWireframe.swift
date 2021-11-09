//
//  CharactersListWireframe.swift
//  Data
//
//  Created by Viktor on 09/11/21.
//

import UIKit

final class CharactersListWireframe: CharactersListWireframeProtocol {
    weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func createCharactersListModule() -> UIViewController {
        guard let view = UIStoryboard(name: "Characters", bundle: nil).instantiateViewController(withIdentifier: "CharactersListViewController") as? CharactersListViewController else {
            return UIViewController()
        }
        
        let presenter: CharactersListPresenterProtocol & CharactersListInteractorOutputProtocol = CharactersListPresenter()
        let interactor: CharactersListInteractorInputProtocol = CharactersListInteractor()
        let wireframe: CharactersListWireframeProtocol = CharactersListWireframe(view)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view
    }
    
    func showCharacterDetail(id: Int) {
        let viewController = CharacterDetailWireframe.createCharacterDetailModule(id: id)
        self.viewController?.show(viewController, sender: nil)
    }
}
