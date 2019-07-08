//
//  Movie.swift
//  TheMovieIos
//
//  Created by Medios Digitales on 7/6/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Movie: Mappable {
    
    var id: Int?
    var title: String?
    var poster_path: String?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var overview: String?
    var vote_count: Int?
    var vote_average: Float?
    var popularity: Float?
    var release_date: String?
    var path_trailer: String = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4" // Deje el link quemado porque la lista que descargo no tiene ningun campo que retorne un link para video
    
    init() {}
    
    required init (map: Map) {
        self.id <- map["id"]
        self.title <- map["title"]
        self.poster_path <- map["poster_path"]
        self.backdrop_path <- map["backdrop_path"]
        self.genre_ids <- map["genre_ids"]
        self.overview <- map["overview"]
        self.vote_count <- map["vote_count"]
        self.vote_average <- map["vote_average"]
        self.popularity <- map["popularity"]
        self.release_date <- map["release_date"]
    }
    
    func mapping(map: Map) {}
   
}

// Clase para base de datos local REALM IO
class MovieObject: Object {
    @objc dynamic var uId = 0
    @objc dynamic var id: String!
    @objc dynamic var title: String!
    @objc dynamic var poster_path: String!
    @objc dynamic var backdrop_path: String!
    @objc dynamic var overview: String!
    @objc dynamic var vote_count: String!
    @objc dynamic var vote_average: String!
    @objc dynamic var popularity: String!
    @objc dynamic var release_date: String!
    @objc dynamic var path_trailer: String!

    override class func primaryKey() -> String? {
        return "uId"
    }
}

// Clase para mapeo de list del objecto MOVIE
class MovieList : Mappable{
    var movies : [Movie]!
    var total_results: Int?
    required init?(map: Map) {}
    func mapping(map: Map) {
        movies <- map["results"]
        total_results <- map["total_results"]
    }
}
