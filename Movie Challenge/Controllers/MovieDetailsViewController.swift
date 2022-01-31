//
//  MovieDetailsViewController.swift
//  Movie Challenge
//
//  Created by Moath Yahia on 1/27/22.
//

import UIKit
import Cosmos
import SDWebImage
import Popover
import ImageViewer_swift

class MovieDetailsViewController: UIViewController {

    var movieModel : GetMoviesQueryQuery.Data.Movie?
    
    @IBOutlet private weak var movieLbl     : UILabel!
    @IBOutlet private weak var cosmosView   : CosmosView!
    @IBOutlet private weak var movieImg     : UIImageView!
    @IBOutlet private weak var overViewLbl  : UILabel!
    @IBOutlet private weak var genreLbl     : UILabel!
    @IBOutlet private weak var directorLbl  : UILabel!
    @IBOutlet private weak var castBtn      : UIButton!
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        castBtn.setupBorderView()
        setupImage()
    }
   
    private func fillData() {
        movieLbl.text = movieModel?.title
        overViewLbl.text = movieModel?.overview
        cosmosView.rating = (movieModel?.voteAverage ?? 3.5) / 2.0
        
        movieImg.sd_setImage(with: URL(string: movieModel?.posterPath ?? ""), placeholderImage: nil, options: [.progressiveLoad, .refreshCached])

        directorLbl.text = "Director: \(movieModel?.director.name ?? "")"
        genreLbl.text = "Genre: \(getListOfGenre(movieModel?.genres))"
    }
    
    private func getListOfGenre(_ genres: [String]?) -> String {
        var listOfGenres = ""
        var count = 0
        if let genres = movieModel?.genres {
            for genre in genres {
                if count == 0 {
                    listOfGenres = genre
                } else if count == (movieModel?.genres.count ?? 0) - 1 {
                    listOfGenres = "\(listOfGenres) and \(genre)"
                } else {
                    listOfGenres = "\(listOfGenres), \(genre)"
                }
                count += 1
            }
        }
        return listOfGenres
    }

    private func setupListView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 350))
        let options = [
          .type(.up),
          .animationIn(0.6),
          .arrowSize(CGSize.zero),
          .cornerRadius(10),
          .overlayBlur(.systemMaterialLight),
          ] as [PopoverOption]
        let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CastCell", bundle: nil), forCellReuseIdentifier: "castCell")
        tableView.estimatedRowHeight = 130
        view.addSubview(tableView)
        popover.show(view, fromView: self.castBtn)
    }
    
    @IBAction private func showListOfCastBtn(_ sender: UIButton) {
        setupListView()
    }
    
    private func setupImage() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openMovieImage))
        movieImg.isUserInteractionEnabled = true
        movieImg.addGestureRecognizer(tapGesture)
    }
    
    @objc private func openMovieImage(_ sender: UIGestureRecognizer) {
        movieImg.setupImageViewer()
    }
}

extension MovieDetailsViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieModel?.cast.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "castCell") as! CastCell
        
        if let tempData = movieModel?.cast[indexPath.row] {
            cell.castModel = tempData
        }
        return cell
    }
}
