//
//  Coordinator.swift
//  Septa
//
//  Created by Viviana Capolvenere on 18/02/21.
//

import Foundation

protocol Coordinator {
    var coordinators: [Coordinator] { get set }
    func start()
}
