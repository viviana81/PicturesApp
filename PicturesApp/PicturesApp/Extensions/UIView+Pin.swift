//
//  UIView+Pin.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 15/01/21.
//

import UIKit

extension UIView {
    
    func pin(to view: UIView, insets: UIEdgeInsets = .zero) {

        removeFromSuperview()
        translatesAutoresizingMaskIntoConstraints = false
    
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right),
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
        ])
    }
}
