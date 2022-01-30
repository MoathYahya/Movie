//
//  MovieViewModel.swift
//  Movie Challenge
//
//  Created by Moath Yahia on 1/27/22.
//

import UIKit

class MovieViewModel: NSObject {
    
    func fetchMovie(completionHandler: @escaping(GetMoviesQueryQuery.Data) -> () ) {
        let query = GetMoviesQueryQuery()
        Network.shared.apollo.fetch(query: query) { [weak self] result in
          switch result {
            case .success(let graphQLResult):
              DispatchQueue.main.async {                  
                  guard let dataMovie = graphQLResult.data else {
                      return
                  }
                  completionHandler(dataMovie)
              }
            
            case .failure(let error):
              print("Error getting movies: \(error.localizedDescription)")
              self?.showAlert(title: "Error", message: error.localizedDescription)
          }
        }
    }
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let scenes = UIApplication.shared.connectedScenes
            let windowScenes = scenes.first as? UIWindowScene
            let window = windowScenes?.windows.first
            window?.rootViewController?.displayAlertViewMessage(title: title, message: message)
        }
    }
}
