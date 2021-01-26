//
//  AddCollectionViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 26/01/21.
//

import UIKit

class AddCollectionViewController: UIViewController {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var privateSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "New collection"
        
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOpacity = 0.6
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = 6
    }
    
    @IBAction func saveCollection() {
        
    }
}
