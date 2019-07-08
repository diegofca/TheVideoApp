//
//  DetailMoviePresenter.swift
//  TheMovieIos
//
//  Created by Medios Digitales on 7/7/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import Foundation
import UIKit

class DetailMoviePresenter {
    
    //constans
    lazy var workerInteractor = DetailMovieInteractor()
    
    //variables
    private let sizePoster: Int = 500
    let heigthPosterInView: CGFloat = UIScreen.main.bounds.height / 1.6
    
    // closure
    var listenerMovieDetails: ((Movie)-> Void)?
    var listenerPosterUrl: ((URL)-> Void)?
    var listenerTrailerUrl: ((URL)-> Void)?
    var listenerTitleMovie: ((String?)-> Void)?
    
    func getMovieDetail(_ id: Int? ) {
        if let movie = workerInteractor.getCurrentMovieDetail(id) {
            self.listenerMovieDetails?(movie)
            self.listenerTitleMovie?(movie.title)
            self.loadPoster(movie.backdrop_path)
            self.loadTrailer(movie.path_trailer)
        }
    }
    
    private func loadPoster(_ path: String?){
        let urlPathImage = "\(ApiEndPoints.IMG_BASE_ORIGINAL_URL)\(path ?? "")"
        if let url = URL(string: urlPathImage) {
            self.listenerPosterUrl?(url)
        }
    }
    
    private func loadTrailer(_ path: String?){
        //let urlPathImage = "\(ApiEndPoints.BASEURL)\(path ?? "")"
        if let url = URL(string: path ?? "") {
            self.listenerTrailerUrl?(url)
        }
    }
    
}
