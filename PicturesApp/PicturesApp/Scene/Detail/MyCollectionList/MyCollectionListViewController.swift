//
//  MyCollectionListViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 30/01/21.
//

import UIKit

protocol MyCollectionListViewControllerDelegate: class {
    func getMyCollections()
    func addToCollection(_ collection: Collection)
    
}

class MyCollectionListViewController: UIViewController {
    
    weak var delegate: MyCollectionListViewControllerDelegate?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyCollectionListTableViewCell.self)
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 10
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    var collections: [Collection] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.pin(to: view, insets: UIEdgeInsets(top: 200, left: 16, bottom: 0, right: 16))
        delegate?.getMyCollections()
    }
}
extension MyCollectionListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
     func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyCollectionListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let collection = collections[indexPath.row]
        cell.configure(withCollection: collection)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Choose collections"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        view.tintColor = UIColor.systemRed
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collection = collections[indexPath.row]
        delegate?.addToCollection(collection)
    }
}
