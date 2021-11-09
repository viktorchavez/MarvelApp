//
//  CharacterCollectionViewCell.swift
//  DataTests
//
//  Created by Viktor on 09/11/21.
//

import UIKit

final class CharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func show(character: CharacterViewModel) {
        self.titleLabel.text = character.name
        self.imageView.sd_setImage(with: character.thumbnailURL, placeholderImage: UIImage.thumbnailPlaceholder())
    }
}
