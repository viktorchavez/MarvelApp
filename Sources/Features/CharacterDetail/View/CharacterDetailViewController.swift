//
//  CharacterDetailViewController.swift
//  MarvelApp
//
//  Created by Viktor on 09/11/21.
//

import UIKit
import Domain
import SDWebImage

final class CharacterDetailViewController: UIViewController, Errorable, Shareable {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var presenter: CharactersDetailPresenterProtocol?
    var characterID: Int?
    private var character: MarvelCharacter? {
        didSet {
            self.updateUIElements()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        if let id = characterID {
            presenter?.fetchCharacter(id: id)
        }
    }
    
    //MARK: - IBActions
    
    @objc func shareAction() {
        if let character = character {
            presenter?.shareCharacter(character: character)
        }
    }
    
    //MARK: - Private
    
    private func updateUIElements() {
        imageView.sd_setImage(with: character?.thumbnailURL, placeholderImage: UIImage.thumbnailPlaceholder())
        titleLabel.text = character?.name
        descriptionLabel.text = character?.description
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(CharacterDetailViewController.shareAction))
        
        showLoading(isLoading: false)
    }
    
    private func showLoading(isLoading: Bool) {
        if (isLoading) {
            imageView.showAnimatedGradientSkeleton()
            titleLabel.showAnimatedGradientSkeleton()
            descriptionLabel.showAnimatedGradientSkeleton()
        } else {
            imageView.hideSkeleton()
            titleLabel.hideSkeleton()
            descriptionLabel.hideSkeleton()
        }
    }
}

extension CharacterDetailViewController: CharactersDetailViewProtocol {
    func set(state: CharactersDetailViewState) {
        switch(state) {
        case .loading:
            showLoading(isLoading: true)
        case .loaded(let character):
            self.character = character
        case .error(let error):
            showError(message: error)
        }
    }
    
    func showShareCharacter(character: MarvelCharacter) {
        var shareItems: [Any] = [character.name, character.description]
        if let thumbnailUrl = character.thumbnailURL {
            shareItems.append(thumbnailUrl)
        }
        self.share(items: shareItems)
    }
}
