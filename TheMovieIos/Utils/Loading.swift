//
//  Loading.swift
//  TheMovieIos
//
//  Created by Medios Digitales on 7/6/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class Loading: UIView {
    
    static var get = Loading()
    
    let animView = AnimationView()
    
    private var isShow: Bool = false
    
    static func createView() {
        get.frame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height:  UIScreen.main.bounds.height)
        
        //view.addSubview(animView)
        //animView.frame = view.frame
        
        let blur = UIVisualEffectView()
        blur.effect = UIBlurEffect(style: .dark)
        blur.alpha = 0.2
        
        blur.frame = get.frame
        
        get.addSubview(blur)
        get.addSubview(get.animView)
        
        get.animView.topAnchor.constraint(equalTo: get.topAnchor, constant: 100).isActive = true
        get.animView.bottomAnchor.constraint(equalTo: get.bottomAnchor, constant: 0).isActive = true
        get.animView.leadingAnchor.constraint(equalTo: get.leadingAnchor, constant: 0).isActive = true
        get.animView.trailingAnchor.constraint(equalTo: get.trailingAnchor, constant: 0).isActive = true
        
        get.animView.animation = Animation.named("loading")
        get.animView.loopMode = .loop
        get.animView.frame = Loading.get.frame
        get.animView.contentMode = .scaleAspectFit
        
        get.backgroundColor = UIColor(white: 0, alpha: 0.5)
    }
    
    static func Show(){
        guard !get.isShow else { return }
        
        let vWindow = UIApplication.shared.keyWindow
        createView()
        get.animView.play()
        vWindow?.addSubview(get)
        
        UIView.animate(withDuration: 0.2, animations: {
            get.alpha = 1
        }) { (_) in
            get.isShow = true
        }
    }
    
    
    static func hide(){
      //  guard get.isShow else { return }
        
        UIView.animate(withDuration: 1, animations: {
            get.alpha = 0
        }) { (complete) in
            get.isShow = false
            get.removeFromSuperview()
        }
    }
}
