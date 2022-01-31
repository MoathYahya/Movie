import UIKit
import JGProgressHUD

class MovieViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var movieModel   : [GetMoviesQueryQuery.Data.Movie?]?
    private var topFiveArray : [GetMoviesQueryQuery.Data.Movie?]?
    private var genresList   : [String] = []

    private let topFiveSection        = 0
    private let genresSection         = 1
    private let exploreMoviesSection  = 2
    private let numberOfSection       = 3
  override func viewDidLoad() {
    super.viewDidLoad()
      setupView()
      fetchData()
  }
    
    private func setupView() {
        self.title = "Movies"
        self.tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.register(UINib(nibName: "GenresCell", bundle: nil), forCellReuseIdentifier: "genresCell")
    }
    
    private func fetchData() {
        let viewModel = MovieViewModel()
        let progress = JGProgressHUD()
        progress.show(in: self.view)
        viewModel.fetchMovie { tempData in
            guard let movies = tempData.movies else {
                return
            }
            self.movieModel = movies
            self.genresList = tempData.genres
            self.filterTopFive()
            self.tableView.reloadData()
            progress.dismiss(animated: true)
        }
    }
    
    func filterTopFive() {
        topFiveArray = movieModel?.sorted(by: {$0?.voteCount ?? 0 > $1?.voteCount ?? 0})
        topFiveArray = movieModel?.suffix(5)
    }
}

extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == topFiveSection {
            return topFiveArray?.count ?? 0
        } else if section == genresSection {
            return genresList.count
        } else {
            return self.movieModel?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! MovieCell
        
        if indexPath.section == topFiveSection {
            if let tempMovie = self.topFiveArray?[indexPath.row] {
                cell.movie = tempMovie
            }
        } else if indexPath.section == genresSection {
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "genresCell") as! GenresCell
            let tempGenre = self.genresList[indexPath.row]
            cell.genreName = tempGenre
            return cell
            
        } else {
            if let tempMovie = self.movieModel?[indexPath.row] {
                cell.movie = tempMovie
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == topFiveSection {
            return "Top 5 Movies"
        } else if section == genresSection {
            return "Explore List Of Genres"
        } else {
            return "Explore All Movies"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == topFiveSection {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
            if let tempModel = self.topFiveArray?[indexPath.row] {
                controller.movieModel = tempModel
            }
            self.navigationController?.pushViewController(controller, animated: true)

        } else if indexPath.section == exploreMoviesSection {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController

            if let tempModel = self.movieModel?[indexPath.row] {
                controller.movieModel = tempModel
            }
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == genresSection {
            return 60
        }
        
        return 130
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
