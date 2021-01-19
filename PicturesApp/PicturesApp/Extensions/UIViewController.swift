//
//  UIViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 19/01/21.
//

import UIKit
extension UIViewController {
    
     func showAlert(withTitle title: String = "Attenzione", andMessage message: String, showCancel: Bool = false, completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
     
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            completion?()
        })
        
        if showCancel {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    
    }
}
