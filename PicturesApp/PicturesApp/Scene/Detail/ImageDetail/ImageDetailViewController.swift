//
//  ImageDetailViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 21/01/21.
//

import UIKit
import Kingfisher

class ImageDetailViewController: UIViewController {

    @IBOutlet weak var fullImage: UIImageView!
    /*private let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

      /*  if let photo = URL(string: photo.urls.full) {
            fullImage.kf.setImage(with: photo, placeholder: UIImage(named: "placeholder"))
        }*/
    }
}
