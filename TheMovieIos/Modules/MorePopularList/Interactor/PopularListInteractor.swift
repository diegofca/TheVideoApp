//
//  PopularListInteractor.swift
//  TheMovieIos
//
//  Created by Medios Digitales on 7/6/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import Foundation
import RealmSwift

protocol PopularListProtocol : class {
    func getMoviesToLocalDb(_ movies: [Movie])
}

class PopularListInteractor {
    
    private let serviceManager = ListServicesManager.get
    private let realmManager = RealmManager.get
    
    var delegate: PopularListProtocol?
    
    func getPopularList(page: Int = 1, success:@escaping ([Movie]) -> Void, failure:@escaping (Error) -> Void){
        if Connectivity.isConnectedToInternet {
            serviceManager.requestPopularList(page: page, success: { movies in
                self.saveMovies(movies)
                success(movies)
            }) { error in
                failure(error)
            }
            return
        }
        getPopularListToDb()
    }
    
    func getSearchedList(query: String, success:@escaping ([Movie]) -> Void, failure:@escaping (Error) -> Void){
        if Connectivity.isConnectedToInternet {
            serviceManager.requestSearchQuery(query: query, success: { movies in
                self.saveMovies(movies)
                success(movies)
            }) { error in
                failure(error)
            }
            return
        }
    }
    
    private func getPopularListToDb(){
        if let movies = RealmManager.get.dbAllMovies(), movies.count > 0 {
            delegate?.getMoviesToLocalDb(movies)
        }
    }
    
    private func saveMovies(_ list: [Movie]){
        for nMovie in list {
            let oMovie = realmManager.mapMovieObject(nMovie)
            try! realmManager.realm.write {
                realmManager.realm.add(oMovie, update: .all)
            }
        }
    }
}
