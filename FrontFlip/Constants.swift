//
//  Constants.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-08.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import Foundation
import UIKit
import SwiftKeychainWrapper

let KEY_UID = "uid"
let GOTOMAIN = "goToMain"
let GOTOLOGIN = "logOffSegue"
let GOTOCONFIRMVC = "goToConfirmImageVC"
let GOTOFINISHSIGNUPVC = "goToFinishSignUpVC"
let SHADOW_GREY = CGFloat(255/157)
var CURRENTUSER: String? = KeychainWrapper.standard.string(forKey: KEY_UID)
