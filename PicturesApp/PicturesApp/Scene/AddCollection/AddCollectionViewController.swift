//
//  AddCollectionViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 26/01/21.
//

import UIKit

protocol AddCollectionViewControllerDelegate: class {
    func onTapAdd(title: String, description: String, privacy: Bool)
}

class AddCollectionViewController: UIViewController {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var descriptionTxtField: UITextField!
    @IBOutlet weak var privateSwitch: UISwitch!
    
    weak var delegate: AddCollectionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "New collection"
        
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOpacity = 0.6
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = 6
    }
    
    @IBAction func saveCollection() {
        guard let title = titleTxtField.text,
              let description = descriptionTxtField.text else { return }
    
        delegate?.onTapAdd(title: title, description: description, privacy: privateSwitch.isOn)
    }
}
