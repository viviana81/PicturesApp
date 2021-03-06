//
//  ContainerViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 26/01/21.
//

import UIKit

protocol ContainerViewControllerDelegate: class {
    func onTapNewCollection()
}

class ContainerViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    let firstChild = CollectionsViewController()
    let secondChild = MyCollectionViewController()
    
    weak var delegate: ContainerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(firstChild)
        self.containerView.addSubview(firstChild.view)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.purple, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)], for: .normal)
        
        segmentedControl.isHidden = false
        
        if UserDefaultsConfig.token == nil {
            segmentedControl.isHidden = true
            title = "Collections"
            view.backgroundColor = UIColor(named: "mercury")
        }
        view.backgroundColor = UIColor(named: "mercury")
    }
    
    @IBAction func onCollectionChanged(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
                remove(asChildViewController: secondChild)
                add(asChildViewController: firstChild)
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = .clear
            } else {
                remove(asChildViewController: firstChild)
                add(asChildViewController: secondChild)
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .done, target: self, action: #selector(addCollection))
            }
    }
    
    @objc
    func addCollection() {
        delegate?.onTapNewCollection()
    }
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        containerView.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
    }
}
