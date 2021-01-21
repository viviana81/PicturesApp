//
//  ImageDetailViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 21/01/21.
//

import UIKit

class ImageDetailViewController: UIViewController {

    @IBOutlet weak var fullImage: UIImageView!
    private let image: UIImage
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullImage.image = image

        let secondTap = UITapGestureRecognizer(target: self, action: #selector(ImageDetailViewController.onImageTap(_:)))
        fullImage.addGestureRecognizer(secondTap)
        fullImage.isUserInteractionEnabled = true
    }
    
    @objc
    func onImageTap(_ recognizer: UIGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
