//
//  InfoDetailTableViewCell.swift
//  TheMovieIos
//
//  Created by Medios Digitales on 7/7/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import UIKit

class InfoDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var textCell: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setData(_ title: String?,_ text: String?){
        titleCell.text = title
        textCell.text = text
    }
    
}
