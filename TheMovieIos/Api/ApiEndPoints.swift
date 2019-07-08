//
//  ApiEndPoints.swift
//  TheMovieIos
//
//  Created by Medios Digitales on 7/6/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import Foundation

class ApiEndPoints {
    
    static let BASEURL = "https://api.themoviedb.org/3/"
    static let IMG_BASEURL = "http://image.tmdb.org/t/p/w%d"
    static let IMG_BASE_ORIGINAL_URL = "http://image.tmdb.org/t/p/original"
    
    static let GET_MOVIE_LIST = "movie/"
    static let GET_SEARCH = "search/"
    static let GET_GENDER_LIST = "genre/movie/list"
    static let API_KEY_V3 = "?api_key=b0e3cab3aba2ea9d7d5271d0f6e03d53"
    static let ES_LANGUAGE = "&language=es-ES"
    static let PAGE = "&page=%d"
    static let QUERY = "&query=%@"
    //https://api.themoviedb.org/3/search/collection?api_key=b0e3cab3aba2ea9d7d5271d0f6e03d53&language=en-US&query=spider&page=1
}

class MovieEndPoints: ApiEndPoints {
    
    static let popularListEndPoint = "popular"

    static var getPopularList: String {
        return "\(BASEURL)\(GET_MOVIE_LIST)\(popularListEndPoint)\(API_KEY_V3)\(ES_LANGUAGE)\(PAGE)"
    }
    
    static var getSearchList: String {
        return "\(BASEURL)\(GET_SEARCH)\(GET_MOVIE_LIST)\(API_KEY_V3)\(ES_LANGUAGE)\(QUERY)"
    }
    
}
