//
//  HeaderDetailView.swift
//  TheMovieIos
//
//  Created by Medios Digitales on 7/7/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class HeaderDetailView: UIView {
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var closeViewBtn: UIButton!
    @IBOutlet weak var playTrailerBtn: UIButton!
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var playerContainerView: UIView!
    
    @IBOutlet weak var closeViewCtr: NSLayoutConstraint!

    var playerView: AVPlayer!
    var playerLayer = AVPlayerLayer()

    private var urlTrailer: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        closeViewBtn.addAction(for: .touchUpInside) {
            guard let _ = self.playerView else { return }
            self.playerView.pause()
            self.playerView = nil
            self.playerLayer.removeFromSuperlayer()
        }
    }
    
    private func configurationPlayerView(){
        playerLayer.frame = playerContainerView.bounds
        playerLayer.videoGravity = .resizeAspect
        playerLayer.needsDisplayOnBoundsChange = true
        playerContainerView.layer.addSublayer(playerLayer)
    }
    
    func setTrailerUrl(_ urlTrailer: URL){
        self.urlTrailer = urlTrailer
    }
    
    func playTrailer() {
        guard let movieURL = urlTrailer else { return }
        playerView = AVPlayer(url: movieURL)
        playerLayer = AVPlayerLayer(player: playerView)
        playerContainerView.isHidden = false
        configurationPlayerView()
        playerView.play()
    }
}
