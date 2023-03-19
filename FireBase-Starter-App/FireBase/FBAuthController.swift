//
//  FBController.swift
//  FireBase-Starter-App
//
//  Created by Abdulrahman on 16/03/2023.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import Firebase
import GoogleSignIn

class FBAuthController {
    //MARK: sign in with email & pass
    
    var fbAuth: Auth = Auth.auth ()
    typealias CallBack = (Bool,String) -> Void
    
    var loggedIn : Bool {
        if let _ = fbAuth.currentUser{
            
            return true
            
        }else {
            
            return false
        }
    }
    
    
    public func createAccount(email : String , Password : String , callBack : @escaping CallBack){
        
        fbAuth.createUser(withEmail: email, password: Password){ result , error in
            
            if let _error = error{
                
                callBack(false , _error.localizedDescription.description )
            }else {
                result?.user.sendEmailVerification()
                callBack(true,"Success")
            }
        }
    }
    
    public func login(email : String , Password : String , callBack : @escaping CallBack){
        
        fbAuth.signIn(withEmail: email, password: Password){ result , error in
            
            if let _error = error{
                
                callBack(false,_error.localizedDescription.description)
                
            }else if let _result = result{
                
                if _result.user.isEmailVerified{
                    
                    callBack(true,"Success")
                    
                }else {
                    callBack(false, "sign in failed , verify your email")
                }
            }
            
        }
    }
    
    public func logOut()-> Bool{
        
        do {
            try fbAuth.signOut()
            
            return true
        }
        catch let error as NSError{
            print(error)
            return false
        }
    }
    
}
extension FBAuthController {
    
    //MARK: SignIn With Google
    
    public func signInWithGoogle ( vc : UIViewController , callback :@escaping CallBack ) {
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let vc : UIViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: vc ) { result, error in
            guard error == nil else {
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in

              // At this point, our user is signed in
                callback(true , error?.localizedDescription ?? "no error")
            }
        }
    }
}

extension FBAuthController {
    
    //MARK: sign in with anonymous
    func signinAnonymous (callback : @escaping CallBack){
        fbAuth.signInAnonymously(){result , error in
            
            if let _error = error {
                callback(false , _error.localizedDescription)
            }else {
                callback(true , "success")
            }
            
        }
    }
}

extension FBAuthController{
    //Mark: Authinticate with facebook
   
}
