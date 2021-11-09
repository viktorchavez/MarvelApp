//
//  Shareable.swift
//  MarvelApp
//
//  Created by Viktor on 09/11/21.
//

import UIKit

public protocol Shareable {
    func share(items: [Any])
}

public extension Shareable where Self: UIViewController {
    func share(items: [Any]) {
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}
