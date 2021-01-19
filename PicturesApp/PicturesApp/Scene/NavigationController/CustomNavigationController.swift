//
//  CustomNavigationController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 19/01/21.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 24)]
        
        navigationBar.setGradientBackground(colors: [
                   UIColor.orange.cgColor,
                   UIColor.systemPink.cgColor
                   ])
     
    }
}
