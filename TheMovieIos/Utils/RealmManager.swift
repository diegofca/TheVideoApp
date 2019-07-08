//
//  RealmManager.swift
//  TheMovieIos
//
//  Created by Medios Digitales on 7/7/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let get = RealmManager()
    
    lazy var realm: Realm = {
        return try! Realm()
    }()
    
    // Mapeo de Objecto 'Movie' a 'MovieObject'
    func mapMovieObject(_ movie: Movie) -> MovieObject {
        let oMovie           = MovieObject()
        oMovie.uId           = movie.id ?? 0
        oMovie.id            = String(movie.id ?? 0)
        oMovie.backdrop_path = movie.backdrop_path
        oMovie.title         = movie.title
        oMovie.overview      = movie.overview
        oMovie.vote_average  = String(movie.vote_average ?? 0)
        oMovie.vote_count    = String(movie.vote_count ?? 0)
        oMovie.path_trailer  = movie.path_trailer
        oMovie.poster_path   = movie.poster_path
        oMovie.popularity    = String(movie.popularity ?? 0)
        return oMovie
    }
    
    // Mapeo de Objecto 'MovieObject' a 'Movie'
    
    func dbAllMovies() -> [Movie]? {
        var resultMovies: [Movie] = []
        let movies = realm.objects(MovieObject.self)
        for movie in movies {
            let nMovie = RealmManager.get.mapMovie(movie)
            resultMovies.append(nMovie)
        }
        return resultMovies
    }
    
    func dbGetMovie(_ id: Int)-> Movie {
        let oMovie = realm.objects(MovieObject.self).filter("id = '\(id)'").first!
        let nMovie = RealmManager.get.mapMovie(oMovie)
        return nMovie
    }
    
    private func mapMovie(_ oMovie: MovieObject) -> Movie {
        let nMovie           = Movie()
        nMovie.id            = Int(oMovie.id)
        nMovie.title         = oMovie.title
        nMovie.backdrop_path = oMovie.backdrop_path
        nMovie.overview      = oMovie.overview
        nMovie.vote_average  = Float(oMovie.vote_average)
        nMovie.vote_count    = Int(oMovie.vote_count)
        nMovie.path_trailer  = oMovie.path_trailer!
        nMovie.poster_path   = oMovie.poster_path
        nMovie.popularity    = Float(oMovie.popularity)
        return nMovie
    }
}
