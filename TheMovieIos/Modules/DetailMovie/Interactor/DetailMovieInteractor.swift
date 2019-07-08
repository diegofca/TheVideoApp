//
//  DetailMovieInteractor.swift
//  TheMovieIos
//
//  Created by Medios Digitales on 7/7/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import Foundation
import RealmSwift

class DetailMovieInteractor {
    
    private let serviceManager = ListServicesManager.get
    var delegate: PopularListProtocol?
    
    func getCurrentMovieDetail(_ id: Int?) -> Movie? {
        guard let safeId = id else { return nil }
        let currentMovie = RealmManager.get.dbGetMovie(safeId)
        return currentMovie
    }
    
    
    
}
