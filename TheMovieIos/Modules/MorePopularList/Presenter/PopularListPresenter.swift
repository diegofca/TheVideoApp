//
//  PopularListPresenter.swift
//  TheMovieIos
//
//  Created by Medios Digitales on 7/6/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import Foundation

class PopularListPresenter {
    
    //constans
    lazy var workerInteractor = PopularListInteractor()
    
    //variables
    private var movies = [Movie]()
    private var page: Int = 1
    
    //closureReactive
    var listenerMovies: (([Movie])-> Void)?
    var listenerError: ((Error) -> Void)?
    
    init() {
        workerInteractor.delegate = self
    }

    func getPopularList(){
        workerInteractor.getPopularList(page: page, success: { popularMoviesList  in
            self.movies.append(contentsOf: popularMoviesList)
            self.listenerMovies?(self.movies)
            self.page += 1
        }) { error in
            self.listenerError?(error)
        }
    }
}

extension PopularListPresenter : PopularListProtocol {
    func getMoviesToLocalDb(_ movies: [Movie]) {
        self.listenerMovies?(movies)
        self.movies = movies
    }
}
