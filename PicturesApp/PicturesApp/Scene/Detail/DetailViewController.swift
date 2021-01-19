//
//  DetailViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 19/01/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Vars
    private let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Viewcontroller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let color = photo.color {
            view.backgroundColor = UIColor(hexFromString: color)
        }
    }
}
