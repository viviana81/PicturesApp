//
//  UIViewController.swift
//  MoMo
//
//  Created by DL Developer on 18/09/2020.
//  Copyright © 2020 DL Developer. All rights reserved.
//

import Foundation
import UIKit

@nonobjc
extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil, in container: UIView?) {
        addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }

        if let container = container {
            container.addSubview(child.view)
        } else {
            view.addSubview(child.view)
        }
        
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
