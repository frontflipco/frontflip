//
//  SignUpVC.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-07.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
import FBSDKLoginKit

class SignUpVC: UIViewController, UITextFieldDelegate {

    
    //OUTLETS
    @IBOutlet weak var emailField: MaterialTextField!
    @IBOutlet weak var passwordField: MaterialTextField!
    @IBOutlet weak var instagramUsername: MaterialTextField!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Textfield Delegate to self
        emailField.delegate = self
        passwordField.delegate = self
        instagramUsername.delegate = self
    }
    
    //TextField Delegate Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Remove Keyboard if touch outside
        self.view.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //If return is pressed in passwordField
        if textField == self.passwordField {
            instagramUsername.becomeFirstResponder()
        }
        //If return button is pressed in emailField
        if textField == self
            .emailField {
            passwordField.becomeFirstResponder()
        }
        //If return button is pressed in instagramUsernamField
        if textField == self
            .instagramUsername {
            instagramUsername.resignFirstResponder()
        }
        return true
    }

    //ACTIONS
    //Creating a user when signup is created
    @IBAction func signUpBtnPresssed(_ sender: Any) {
        //Check for empty Fields
        if let email = emailField.text, let password = passwordField.text {
            //Auth users to Firebase Auth
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("Menan: Creating a user was successfull")
                    if let user = user {
                        //Set data from the Sign up to add to database
                        if let instagramUsername = self.instagramUsername.text, let userPrice = self.priceLabel.text {
                            //Create userData to add to database
                            let userData = ["provider": user.providerID, "instagramUsername": instagramUsername, "userPrice": userPrice]
                            self.completeSignUp(uid: user.uid, userData: userData)
                        }
                        
                    }
                }
                else {
                    //TODO: Notify the user of the error
                    print("Menan: Creating a user failed: \(error)")
                }
            })
        }
    }
    
    
    //FB LOGIN PAUSED 
    
//    @IBAction func facebookSignUpPressed(_ sender: Any) {
//        
//        let fbLoginManager = FBSDKLoginManager()
//        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
//            
//            if error != nil {
//                print("menan: Error Auth Facebook Login")
//            } else if (result?.isCancelled)! {
//                print("menan: FB Auth was cancelled by the user")
//            } else {
//                print("menan: FB Auth was successful")
//                let creditionals = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//                self.fireBaseAuth(creditionals: creditionals)
//            }
//            
//        }
//     
//    }
    

    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func priceSliderMoved(_ sender: UISlider) {
        
        //Set Font of Dollar Label when move
        self.priceLabel.font = UIFont(name: priceLabel.font.fontName, size: 30.0)
        //Set Slider Value to Label Text
        self.priceLabel.text = "$ \(Int(sender.value))"
        
        //If Slide is at Zero, reshow label question text
        if Int(sender.value) == 0 {
            //Set Font of Oringial Label Text and display
            self.priceLabel.font = UIFont(name: priceLabel.font.fontName, size: 17)
            self.priceLabel.text = "How much would you post for?"
        }

    }

    
    //FUNCTIONS
    //FIREBASE AUTH with Creditionals, TEMP DISABLED: Only Enabling Email SignUp for temp
//    func fireBaseAuth(creditionals: FIRAuthCredential) {
//        FIRAuth.auth()?.signIn(with: creditionals, completion: { (user, error) in
//            if error != nil {
//                print("menan: Firebase Auth ERROR \(error)")
//            }else {
//                print("menan: Firebase Auth Successful")
//                if let user = user {
//                    //TODO: Ask for the instagram handle and add it to the user data
//                    let userData = ["provider": creditionals.provider]
//                    self.completeSignUp(uid: user.uid, userData: userData)
//                }
//            }
//        })
//    }
//    
    
    func completeSignUp(uid: String, userData: Dictionary <String, String>) {
        //Add user fields to the database using the Singleton Database Class Function
        DataService.ds.createNewUserInDatabase(uid: uid, userData: userData)
        //Send User Email Vertification
        FIRAuth.auth()?.currentUser?.sendEmailVerification(completion: { (error) in
            if error != nil {
                print("Menan: Error while sending confirmation email \(error)")
            }
        })
        //Add user to the keychain
        let saveSuccessful: Bool = KeychainWrapper.standard.set(uid, forKey: KEY_UID)
        
        //Add CurrentUser
        CURRENTUSER = KeychainWrapper.standard.string(forKey: KEY_UID)

        //TODO:Segue to the FinishSignUPVC
        performSegue(withIdentifier: GOTOFINISHSIGNUPVC , sender: nil)
    }

    
 

}
