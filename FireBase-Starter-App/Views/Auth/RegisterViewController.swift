//
//  RegisterViewController.swift
//  FireBase-Starter-App
//
//  Created by Abdulrahman on 16/03/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func register(_ sender: Any) {
        performRegister()
    }
    
    @IBAction func signin(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}


extension RegisterViewController {
    
    private func performRegister(){
        
        if checkData() {
            
            Register()
        }
    }
    
    private func Register (){
        
        FBAuthController().createAccount(email: emailTextField.text!, Password: passwordTextField.text!){
            result , error  in
            
            if result{
                self.navigationController?.popViewController(animated: true)
            }else {
                self.createAlertDialog(title: "Register Failed", message: error)
            }
            print(result)
        }
        
    }
    
    private func checkData () ->Bool{
        
        if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty && !confirmPasswordTextField.text!.isEmpty{
            if passwordTextField.text! == confirmPasswordTextField.text!{
                
                return true
                
            }else
            {
                self.createAlertDialog(title: "Password not match", message: "please rechek enterd password & confirm it")
            }
        }
        self.createAlertDialog(title: "Error!", message: "Both fields are manadatory")
        return false
        
    }
    
    
}
