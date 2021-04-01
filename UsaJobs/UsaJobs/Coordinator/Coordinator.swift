//
//  Coordinator.swift
//  UsaJobs
//
//  Created by Viviana Capolvenere on 22/03/21.
//

import Foundation

protocol Coordinator {
    var coordinators: [Coordinator] { get set }
    
    func start()
}
