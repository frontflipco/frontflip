//
//  LoginVC.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-07.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

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
                        let uid = user.uid
                        self.completeLogin(uid: uid)
                    }
                } else {
                    //TODO: Notify the user of the error
                    print("Menan: Login Unsuccessful: \(error)")
                }
            })
        }
    }
    
    func completeLogin(uid: String) {
        //Add user to the keychain
        let saveSuccessful: Bool = KeychainWrapper.standard.set(uid, forKey: KEY_UID)
        //Segue to the MainVC
        performSegue(withIdentifier: GOTOMAIN, sender: nil)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
