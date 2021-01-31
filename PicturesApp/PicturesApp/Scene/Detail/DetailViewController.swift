//
//  DetailViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 19/01/21.
//

import UIKit
import Kingfisher

protocol DetailViewControllerDelegate: class {
    func onTappedImage()
    func onTapLike(onPhoto photo: Photo)
    func onDeleteLike(onPhoto photo: Photo)
    func openCollections()
}

class DetailViewController: UIViewController {
    
    // MARK: - Vars
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var sizeImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var addLike: UIButton!
    
    weak var delegate: DetailViewControllerDelegate?
    private let photo: Photo
    private let formatter: DateFormatter
    
    init(photo: Photo) {
        self.photo = photo
        formatter = DateFormatter()
        formatter.dateStyle = .medium
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var collections: [Collection] = []
    // MARK: - Viewcontroller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "tray.and.arrow.down"), style: .done, target: self, action: #selector(openListCollection))
        
        if let imageProfile = URL(string: photo.user?.imageProfile.small ?? "") {
            userImage.kf.setImage(with: imageProfile)
        }
        
        if let color = photo.color {
            view.backgroundColor = UIColor(hexFromString: color)
        }
        if let photo = URL(string: photo.urls.regular) {
            photoImage.kf.setImage(with: photo, placeholder: UIImage(named: "placeholder"))
        }
        
        userLabel.text = photo.user?.name
        userLocation.text = photo.user?.location
        sizeLabel.isHidden = false
        if let width = photo.width,
           let height = photo.height {
            sizeLabel.text = "\(width) x \(height)"
        } else {
            sizeLabel.isHidden = true
        }
        
        if let likes = photo.likes {
            likeLabel.text = "\(likes)"
        } else {
            likeLabel.text = "0"
        }
        
        if let date = photo.created {
            dateLabel.text = "Created: \(formatter.string(from: date))"
        }
        
        descriptionLabel.isHidden = false
        descriptionTitleLabel.isHidden = false
        
        if let description = photo.description {
            descriptionLabel.text = description
        } else {
            descriptionLabel.isHidden = true
            descriptionTitleLabel.isHidden = true
        }
        
        let color = UIColor(hexFromString: photo.color ?? "")
        if color.isLight {
            descriptionLabel.textColor = UIColor.darkGray
            userLabel.textColor = UIColor.darkGray
            userLocation.textColor = UIColor.darkGray
            downloadButton.tintColor = UIColor.darkGray
            descriptionTitleLabel.textColor = UIColor.darkGray
            likeLabel.textColor = UIColor.darkGray
            dateLabel.textColor = UIColor.darkGray
            sizeLabel.textColor = UIColor.darkGray
            sizeImage.tintColor = UIColor.darkGray
            likeImage.tintColor = UIColor.darkGray
        } else {
            descriptionLabel.textColor = UIColor.white
            userLabel.textColor = UIColor.white
            userLocation.textColor = UIColor.white
            downloadButton.tintColor = UIColor.white
            descriptionTitleLabel.textColor = UIColor.white
            likeLabel.textColor = UIColor.white
            dateLabel.textColor = UIColor.white
            sizeLabel.textColor = UIColor.white
            sizeImage.tintColor = UIColor.white
            likeImage.tintColor = UIColor.white
        }
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.onImageTap(_:)))
        photoImage.addGestureRecognizer(imageTap)
        photoImage.isUserInteractionEnabled = true
        
        if photo.userLiked == true {
            addLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    @objc
    func openListCollection() {
        delegate?.openCollections()
    }
   
    @objc
    func onImageTap(_ recognizer: UIGestureRecognizer) {
        delegate?.onTappedImage()
    }
    
    @IBAction func download (_ sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(photoImage.image!, self, #selector(saveImage(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc
    func saveImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @IBAction func putLike() {
        if photo.userLiked == false {
            delegate?.onTapLike(onPhoto: photo)
        } else {
            delegate?.onDeleteLike(onPhoto: photo)
        }
    }
}
