//
//  GenresCell.swift
//  Movie Challenge
//
//  Created by Moath Yahia on 1/30/22.
//

import UIKit

class GenresCell: UITableViewCell {
   
    @IBOutlet private weak var containerView   : UIView!
    @IBOutlet private weak var genreNameLbl    : UILabel!
    
    var genreName: String = "" {
        didSet {
            self.fillData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.setupBorderView()
    }
    
    private func fillData() {
        genreNameLbl.text = genreName
    }
}
