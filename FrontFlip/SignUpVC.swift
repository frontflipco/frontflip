//
//  SignUpVC.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-07.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

    
    //OUTLETS
    @IBOutlet weak var emailField: MaterialTextField!
    @IBOutlet weak var passwordField: MaterialTextField!
    @IBOutlet weak var instagramUsername: MaterialTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

 
    //ACTIONS
    //Creating a user when signup is created
    @IBAction func signUpBtnPresssed(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            //Auth users to Firebase Auth
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("Menan: Creating a user was successfull")
                    //ADD the user to keychain and add other user info like IG handle, etc to database
                    if let user = user {
                        if let instagramUsername = self.instagramUsername.text {
                            let userData = ["provider": user.providerID, "instagramUsername": instagramUsername]
                            self.completeSignUp(uid: user.uid, userData: userData)
                        }
                        
                    }
                } else {
                    print("Menan: Creating a user failed: \(error)")
                }
            })
        }
    }
    
    func completeSignUp(uid: String, userData: Dictionary <String, String>) {
        DataService.ds.createNewUserInDatabase(uid: uid, userData: userData)
        //Add user to the keychain and segue to the MainVC
    }


}
