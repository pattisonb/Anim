//
//  SignUpViewController.swift
//  Anim
//
//  Created by Manov Jain on 11/5/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
class SignUpViewController: UIViewController, LoginButtonDelegate {
    
    ///@IBAction func unwind(_ segue: UIStoryboard){}
    
    @IBOutlet var googleSignInButton: GIDSignInButton!
    override func viewDidLoad() {
        
        let newCenter = CGPoint(x: 15, y: 20)
        
        let loginButton = FBLoginButton()
        loginButton.center = newCenter
        if let constraint = loginButton.constraints.first(where: { (constraint) -> Bool in
            return constraint.firstAttribute == .height
        }) {
            constraint.constant = 40.0
        }
        loginButton.center = view.center
        loginButton.delegate = self
        loginButton.permissions = ["email", "public_profile"]
        view.addSubview(loginButton)
        
        
        super.viewDidLoad()
        
        if let token = AccessToken.current, !token.isExpired {
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
            
            request.start(completionHandler: {connection, result, error in
                print("\(String(describing: result))")
            })
        }
        else {
//            let loginButton = FBLoginButton()
//            loginButton.center = view.center
//            loginButton.delegate = self
//            loginButton.permissions = ["email", "public_profile"]
//            view.addSubview(loginButton)
        }
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        if GIDSignIn.sharedInstance()?.currentUser != nil {
            
        }
        else {
            GIDSignIn.sharedInstance()?.signIn()
        }

        GIDSignIn.sharedInstance()?.presentingViewController = self
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
        
        request.start(completionHandler: {connection, result, error in
            print("\(String(describing: result))")
        })
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
