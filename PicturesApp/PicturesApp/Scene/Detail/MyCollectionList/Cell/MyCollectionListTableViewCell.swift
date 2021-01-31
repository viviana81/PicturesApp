//
//  MyCollectionListTableViewCell.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 30/01/21.
//

import UIKit

class MyCollectionListTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(withCollection collection: Collection) {
    
        titleLabel.text = collection.title
    }
    
}
