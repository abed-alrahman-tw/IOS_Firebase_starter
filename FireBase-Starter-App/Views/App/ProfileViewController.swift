//
//  ProfileViewController.swift
//  FireBase-Starter-App
//
//  Created by Abdulrahman on 17/03/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeNavTitle()
        
    }
    
    
    func customizeNavTitle(){
        
        navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = createBarButton()
    }
    
    func createBarButton () -> UIBarButtonItem{
        
        let button = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(barAction))
        
        return button
    }
    
    @objc func barAction(){
        
        if FBAuthController().logOut(){
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
