//
//  MovieCell.swift
//  Movie Challenge
//
//  Created by Moath Yahia on 1/27/22.
//

import UIKit
import SDWebImage
import Cosmos

class MovieCell: UITableViewCell {

    @IBOutlet private weak var containerView   : UIView!
    @IBOutlet private weak var movieImg        : UIImageView!
    @IBOutlet private weak var titleLbl        : UILabel!
    @IBOutlet private weak var cosmosView      : CosmosView!

    private let viewModel = MovieViewModel()

    var movie: GetMoviesQueryQuery.Data.Movie? {
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
        movieImg.layer.cornerRadius = 12
        movieImg.layer.masksToBounds = true
    }
    
    private func fillData() {
        titleLbl.text = movie?.title
        cosmosView.rating = (movie?.voteAverage ?? 3.5) / 2.0

        movieImg.sd_setImage(with: URL(string: movie?.posterPath ?? ""), placeholderImage: UIImage(systemName: "film"), options: [.progressiveLoad, .refreshCached])
    }
}
