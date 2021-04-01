//
//  ListCollectionViewCell.swift
//  UsaJobs
//
//  Created by Viviana Capolvenere on 22/03/21.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(withJobVD jobVD: JobViewData) {
        
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.6
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = 6
        
        titleLabel.text = jobVD.jobTitle
        locationLabel.text = jobVD.location
    
    }
}
