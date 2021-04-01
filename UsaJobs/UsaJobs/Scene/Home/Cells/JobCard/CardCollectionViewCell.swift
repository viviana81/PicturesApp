//
//  CardCollectionViewCell.swift
//  UsaJobs
//
//  Created by Viviana Capolvenere on 22/03/21.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(withJobVD jobVD: JobViewData) {
        title.text = jobVD.jobTitle
        startDate.text = jobVD.jobStartDate
        endDate.text = jobVD.jobEndDate
        descriptionLabel.text = jobVD.jobDescription
    }
}
