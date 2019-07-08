//
//  ListServicesManager.swift
//  TheMovieIos
//
//  Created by Medios Digitales on 7/6/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import Foundation
import Alamofire

class ListServicesManager {
    
    static let get = ListServicesManager()
    private let services = ListServices()
    
    func requestPopularList(page: Int, success:@escaping ([Movie]) -> Void, failure:@escaping (Error) -> Void ){
        services.getListMovies(page: page, typeList: .Popular, success: success, failure: failure)
    }
}

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}
