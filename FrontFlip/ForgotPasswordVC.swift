//
//  ForgotPasswordVC.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-08.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit
import Firebase
class ForgotPasswordVC: UIViewController {

    
    //OUTLETS
    
    @IBOutlet weak var emailField: MaterialTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //ACTIONS
    

    @IBAction func submitBtnPressed(_ sender: Any) {
        
        if let userInput = emailField.text {
        
            FIRAuth.auth()?.sendPasswordReset(withEmail: userInput) { (error) in
                //TODO: Notify the error to the user
            }
        
        }
    }


    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


}
