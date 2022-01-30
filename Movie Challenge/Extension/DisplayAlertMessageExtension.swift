//
//  DisplayAlertMessageExtension.swift
//  Movie Challenge
//
//  Created by Moath Yahia on 1/29/22.
//

import UIKit

extension UIViewController {
    
    func displayAlertViewMessage(title: String, message: String) {
        if !message.isEmpty {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
