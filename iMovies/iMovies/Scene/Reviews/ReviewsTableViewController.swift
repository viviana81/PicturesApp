//
//  ReviewsTableViewController.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 05/03/21.
//

import UIKit

class ReviewsTableViewController: UITableViewController {
    
    let reviewsVM: ReviewsViewModel
    
    init(reviewsVM: ReviewsViewModel) {
        self.reviewsVM = reviewsVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Reviews"
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange, .font: UIFont.boldSystemFont(ofSize: 18)]
        tableView.register(ReviewTableViewCell.self)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         reviewsVM.reviews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReviewTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let review = reviewsVM.reviews[indexPath.row]
        cell.configure(withReviewVM: ReviewViewModel(review: review))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
