//
//  ViewController.swift
//  UsaJobs
//
//  Created by Viviana Capolvenere on 21/03/21.
//

import UIKit
import Anchorage

protocol HomeViewControllerDelegate: class {
    func changeLayout()
    func searchByFilter(filter: Filter)
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var filtersView: FiltersView! {
        didSet {
            filtersView.onTap = { [ weak self] filter in
                self?.delegate?.searchByFilter(filter: filter)
            }
        }
    }
    @IBOutlet weak var jobsCollectionView: UICollectionView! {
        didSet {
            jobsCollectionView.setCollectionViewLayout(collectionLayout.layout, animated: false)
            jobsCollectionView.backgroundColor = .clear
            jobsCollectionView.register(ListCollectionViewCell.self)
            jobsCollectionView.register(CardCollectionViewCell.self)

        }
    }
    
    @IBOutlet weak var placeholder: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!
    
     var collectionLayout: CollectionLayout = .list {
        didSet {
            jobsCollectionView.setCollectionViewLayout(collectionLayout.layout, animated: true)
            jobsCollectionView.reloadSections([0])
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: collectionLayout == .card ?  "list.dash" : "square.grid.3x2")
            view.backgroundColor = collectionLayout == .list ? .systemIndigo : #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            navigationItem.rightBarButtonItem?.tintColor = collectionLayout == .list ? .systemIndigo : #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            filtersView.backgroundColor = collectionLayout == .list ? .systemIndigo : #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            
        }
    }

    weak var delegate: HomeViewControllerDelegate?
     let homeVM: HomeViewModel
    
    init(homeVM: HomeViewModel) {
        self.homeVM = homeVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Jobs"
        
        placeholder.isHidden = false
        searchLabel.isHidden = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.grid.3x2"), style: .done, target: self, action: #selector(changeView))
        view.backgroundColor = collectionLayout == .list ? .systemIndigo : #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        navigationItem.rightBarButtonItem?.tintColor = collectionLayout == .list ? .systemIndigo : #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        filtersView.backgroundColor = collectionLayout == .list ? .systemIndigo : #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        
        homeVM.reloadData = {
            self.jobsCollectionView.reloadData()
            self.placeholder.isHidden = true
            self.searchLabel.isHidden = true
        }
    }
    
    @objc
    func changeView() {
        delegate?.changeLayout()
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVM.jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionLayout == .card {
            let cell: CardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let job = homeVM.jobs[indexPath.item]
            cell.configure(withJobVD: JobViewData(job: job))
            return cell
        } else {
            let cell: ListCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let job = homeVM.jobs[indexPath.item]
            cell.configure(withJobVD: JobViewData(job: job))
            return cell
        }
    }
}
