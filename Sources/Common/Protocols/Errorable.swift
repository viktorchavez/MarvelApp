//
//  Errorable.swift
//  MarvelApp
//
//  Created by Viktor on 09/11/21.
//

import UIKit

public protocol Errorable {
    func showError(message: String)
}

public extension Errorable where Self: UIViewController {
    func showError(message: String) {
        let alertController = UIAlertController(title: "error".localized, message: message, preferredStyle: .alert)
        alertController.view.tintColor = UIColor.red
        
        let alertAction = UIAlertAction(title: "ok".localized, style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        if self.presentedViewController != nil {
            self.presentedViewController?.present(alertController, animated: true, completion: nil)
        } else {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
