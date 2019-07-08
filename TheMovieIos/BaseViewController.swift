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
        let alert = UIAlertController(title: tittle, message: body, preferredStyle: .alert)
       // let action = UIAlertAction(title: "Aceptar", style: .default, handler: handler)
       // alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}

