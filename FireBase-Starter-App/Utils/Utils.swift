//
//  Utils.swift
//  FireBase-Starter-App
//
//  Created by Abdulrahman on 17/03/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func createAlertDialog(title: String , message: String ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .destructive)
        alert.addAction(dismissAction)
        present(alert, animated: true)
    }
    
}
