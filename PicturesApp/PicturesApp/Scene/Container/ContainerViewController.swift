//
//  ContainerViewController.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 26/01/21.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    let firstChild = CollectionsViewController()
    let secondChild = MyCollectionViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(firstChild)
        self.containerView.addSubview(firstChild.view)
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
        let addCollection = AddCollectionViewController()
         navigationController?.pushViewController(addCollection, animated: true)
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
