//
//  JobViewData.swift
//  UsaJobs
//
//  Created by Viviana Capolvenere on 23/03/21.
//

import Foundation

class JobViewData {
    
    private let job: Job
    
    init(job: Job) {
        self.job = job
    }
    
    var jobTitle: String {
        return job.details.positionTitle
    }
    
    var jobStartDate: String {
        return job.details.positionStartDate
    }
    
    var jobEndDate: String {
        return job.details.positionEndDate
    }
    
    var location: String {
        return job.details.positionLocation
    }
    
    var jobDescription: String {
        return job.details.description.details.jobDescription
    }
}
