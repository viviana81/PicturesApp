//
//  FilmType.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Foundation

enum Section: CaseIterable {
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case genres
    
    var title: String {
        switch self {
        case .nowPlaying:
            return "Now playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top"
        case .upcoming:
            return "Upcoming"
        case .genres:
            return "Genres"
        }
    }
}

enum SectionLayout: CaseIterable {
    case image
    case reviews
    case overview
    case keywords
    case cast
    case crew
    case similar
    case recomended
    case otherImages
    
    var title: String {
        switch self {
        case .image:
            return ""
        case .reviews:
            return ""
        case .overview:
            return "Overview:"
        case .keywords:
            return "Keywords:"
        case .cast:
            return "Cast"
        case .crew:
            return "Crew"
        case .similar:
            return "Similar"
        case .recomended:
            return "Recomended"
        case .otherImages:
            return "Images"
        }
    }
}
