//
//  Coordinator.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Foundation

protocol Coordinator {
    var coordinators: [Coordinator] { get set }
    func start()
}
