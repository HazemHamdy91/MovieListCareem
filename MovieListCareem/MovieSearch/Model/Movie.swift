//
//  Movie.swift
//  MovieListCareem
//
//  Created by Hazem Hamdy on 8/31/18.
//  Copyright © 2018 Hazem Hamdy. All rights reserved.
//

import UIKit
import ObjectMapper


class Movie: Mappable {
    // Variables
    var name : String!
    var releaseDate : String!
    var overview : String!
    var posterUrl : String!
    
    required init?(map: Map) {
    }
    
    init() {
    }
    
    // Mapping Keys
    func mapping(map: Map) {
        
        name <- map["title"]
        releaseDate <- map["release_date"]
        overview <- map["overview"]
        posterUrl <- map["poster_path"]
        
    }
}
