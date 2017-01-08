//
//  LoginVC.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-07.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    //OUTLETS
    @IBOutlet weak var emailField: MaterialTextField!
    @IBOutlet weak var passwordField: MaterialTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //ACTIONS
    //Check Firebase Auth for user and Login
    @IBAction func logInBtnPressed(_ sender: Any) {
        
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("Menan: Login was successful using email")
                    if let user = user {
                        //TODO: Save the user to keychain and log him in.
                    }
                } else {
                    print("Menan: Login Unsuccessful: \(error)")
                }
            })
        }
    }

}
