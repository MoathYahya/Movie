//
//  CastCell.swift
//  Movie Challenge
//
//  Created by Moath Yahia on 1/30/22.
//

import UIKit

class CastCell: UITableViewCell {

    @IBOutlet private weak var containerView   : UIView!
    @IBOutlet private weak var profileImg      : UIImageView!
    @IBOutlet private weak var nameLbl         : UILabel!
    @IBOutlet private weak var characterLbl    : UILabel!

    var castModel: GetMoviesQueryQuery.Data.Movie.Cast? {
        didSet {
            self.fillData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        containerView.setupBorderView()
        profileImg.layer.cornerRadius = 12
        profileImg.layer.masksToBounds = true
    }
    
    private func fillData() {
        nameLbl.text = "Name: \(castModel?.name ?? "")"
        characterLbl.text = "Character: \(castModel?.character ?? "")"

        profileImg.sd_setImage(with: URL(string: castModel?.profilePath ?? ""), placeholderImage: UIImage(systemName: "person.crop.circle"), options: [.progressiveLoad, .refreshCached])
    }
}
