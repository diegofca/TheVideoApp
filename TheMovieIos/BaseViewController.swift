//
//  ViewController.swift
//  TheMovieIos
//
//  Created by Medios Digitales on 7/6/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationUi()
    }
    
    func setNavigationUi(){
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    
    func alertError(tittle: String, body: String,_ handler:(Void)?){
        let alertController = UIAlertController(title: tittle, message: body, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func creatingSearhBarToTable() -> UISearchController {
        let searchController : UISearchController!
        searchController = UISearchController(searchResultsController: nil)
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .red
        searchController.searchBar.placeholder = "Busca tu pelicula favorita"
        return searchController
    }
    
}

