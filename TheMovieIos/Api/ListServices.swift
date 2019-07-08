//
//  ListServices.swift
//  TheMovieIos
//
//  Created by Medios Digitales on 7/6/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

enum TypeMovie : String {
    case Popular   = "popular"
}

class ListServices {
    
    // trae listado de peliculas depende al tipo seleccionado (por defecto las POPULARES)
    func getListMovies(page: Int, typeList: TypeMovie, success:@escaping ([Movie]) -> Void, failure:@escaping (Error) -> Void?) {
        let url: String = String(format: MovieEndPoints.getPopularList, page)
        
        Alamofire.request(url).responseObject {(response: DataResponse<MovieList>) in
            if response.result.isSuccess {
                if let nMovie = response.result.value{
                    success(nMovie.movies)
                    return
                }
                success([Movie]())
            }
            if response.result.isFailure {
                guard let error = response.result.error else { return }
                failure(error)
            }
        }
    }
}

