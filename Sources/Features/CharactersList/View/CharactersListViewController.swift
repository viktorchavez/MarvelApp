//
//  CharactersListView.swift
//  Data
//
//  Created by Viktor on 09/11/21.
//

import UIKit
import Domain
import SDWebImage
import SkeletonView

final class CharactersListViewController: UIViewController, Errorable {
    private let CharacterCellIdentifier = "CharacterCellIdentifier"
    private let CellSpacing = 10.0
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var presenter: CharactersListPresenterProtocol?
    private var characters = [CharacterViewModel]()
    private var isLoadingData = false
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
        presenter?.viewDidLoad()
    }
    
    //MARK: - IBActions
    
    @objc func refreshAction() {
        presenter?.fetchCharacters(namePrefix: navigationItem.searchController?.searchBar.text)
    }
    
    //MARK: - Private
    
    private func setUIElements() {
        self.title = "characters_list.title".localized
        
        collectionView.contentInset = UIEdgeInsets(top: CellSpacing, left: CellSpacing, bottom: CellSpacing, right: CellSpacing)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(CharactersListViewController.refreshAction), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "characters_list.search_placeholder".localized
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension CharactersListViewController: CharactersListViewProtocol {
    func set(state: CharactersListViewState) {
        switch state {
        case .loading:
            self.isLoadingData = true
        case .loaded(let characters):
            self.isLoadingData = false
            self.characters = characters
        case .error(let message):
            self.isLoadingData = false
            self.showError(message: message)
        }
        collectionView.refreshControl?.endRefreshing()
        collectionView.reloadData()
    }
}

extension CharactersListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isLoadingData {
            return (presenter?.numberOfItemsWhileLoading() ?? 0)
        }
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCellIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
            fatalError()
        }
        
        if isLoadingData {
            cell.contentView.showAnimatedGradientSkeleton()
            return cell
        }
        cell.contentView.hideSkeleton()
        
        let character = characters[indexPath.row]
        cell.show(character: character)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns = CGFloat((UIWindow.isLandscape ? presenter?.numberOfColumnsLandscape() : presenter?.numberOfColumnsPortrait()) ?? 1)
        let spacesWidth = CGFloat((numberOfColumns + 1)) * CellSpacing
        let width = (collectionView.bounds.width - spacesWidth) / numberOfColumns
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !isLoadingData && indexPath.item + (presenter?.numberOfItemsToLoadMore() ?? 0) > characters.count {
            presenter?.loadMore()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        presenter?.showCharacterDetail(id: character.id)
    }
}

extension CharactersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter?.fetchCharacters(namePrefix: searchController.searchBar.text)
    }
}
