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
    private var localMovies: Bool = false
    private var isSearchMovies: Bool = false
    private var heightClearFilterBtn: Int = 50
    
    //closureReactive
    var listenerMovies: (([Movie])-> Void)?
    var listenerError: ((Error) -> Void)?
    var listenerEnableClearButtonFilter: ((Int) -> Void)?
    var listenerClearSerchText: (() -> Void)?
    
    init() {
        workerInteractor.delegate = self
    }
    
    func getSearchedMovies(query: String){
        workerInteractor.getSearchedList(query: query, success: { filterMovies in
            self.listenerMovies?(filterMovies)
        }) { error in
             self.listenerError?(error)
        }
        setSearchStatus(true)
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
    
    func getPaginationMovies(){
        if !self.isSearchMovies {
            getPopularList()
            listenerClearSerchText?()
            return
        }
    }
    
    func setSearchStatus(_ status : Bool){
        isSearchMovies = status
        page = 1
        validateFilters()
    }
    
    private func validateFilters(){
        let height = isSearchMovies ? heightClearFilterBtn : 0
        self.listenerEnableClearButtonFilter?(height)
        getPaginationMovies()
    }
}

extension PopularListPresenter : PopularListProtocol {
    func getMoviesToLocalDb(_ movies: [Movie]) {
        guard !localMovies else { return }
        self.listenerMovies?(movies)
        self.movies = movies
        self.localMovies = !localMovies
    }
}
