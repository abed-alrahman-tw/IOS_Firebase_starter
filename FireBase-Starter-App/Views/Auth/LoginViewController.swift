//
//  LoginViewController.swift
//  FireBase-Starter-App
//
//  Created by Abdulrahman on 16/03/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinWithGoogle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()

        
        if FBAuthController().loggedIn{
            enterApp()
        }
        
        
    }
    
    @IBAction func SignIn(_ sender: Any) {
        
        performLogin()
        
    }
    @IBAction func signIn(_ sender: Any) {
        
        FBAuthController().signInWithGoogle(vc : self){
            result , error in
    
            self.enterApp()
        }
    }
    
    @IBAction func createAccount(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func signinAsGuest(_ sender: Any) {
        
            FBAuthController().signinAnonymous{
                result , error in
                
                self.enterApp()
                
        }
    }
}


extension LoginViewController {
    
    private func performLogin(){
        if checkData() {
            login()
        }
        
    }
    
    private func login (){
        
        FBAuthController().login(email: emailTextField.text!, Password: passwordTextField.text!){
            result,error  in
            
            if !result {
                
                self.createAlertDialog(title: "Login failed", message:  error)
                
            }else {
                
                self.enterApp()
            }
            print(result)
            
        }
    }
    
    private func checkData() ->Bool{
        
        if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty{
            return true
        }
        self.createAlertDialog(title: "Error!", message: "All fields are manadatory")
        return false
    }
    
    func enterApp (){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController")
        navigationController?.pushViewController(vc, animated: false)

        
    }
    
    
}

extension LoginViewController {
    //MARK: configureUI
    
    private func configureButton(){
        
        signinWithGoogle.configuration = .tinted()
        signinWithGoogle.configuration?.title = "sign in with google"
        signinWithGoogle.configuration?.image = UIImage(systemName:"g.circle")
        signinWithGoogle.configuration?.imagePadding = 6
        signinWithGoogle.configuration?.imagePlacement = .leading
        
    }
}
