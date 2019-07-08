//
//  MovieCollectionViewCell.swift
//  TheMovieIos
//
//  Created by Medios Digitales on 7/6/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    private let sizePoster: Int = 185

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setImageCell(pathUrl: String?){
        if Connectivity.isConnectedToInternet {
            let urlSize = String(format: ApiEndPoints.IMG_BASEURL, sizePoster)
            let urlPathImage = "\(urlSize)\(pathUrl ?? "")"
            guard let url = URL(string: urlPathImage) else { return }
            self.imageView.af_setImage(withURL: url,
                                       placeholderImage: UIImage(named: "crispetas"),
                                       imageTransition: UIImageView.ImageTransition.crossDissolve(1) ,
                                       runImageTransitionIfCached: false) { response in
            }
        }
    }

}
