//
//  Services.swift
//  UsaJobs
//
//  Created by Viviana Capolvenere on 23/03/21.
//

import Foundation

protocol Services {
    
    func getJobs(query: String, completion: @escaping(JobResponse?, Error?) -> Void)
}
