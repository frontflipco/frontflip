//
//  ShadowView.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-09.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit


//A Semi Transparent Round Cornered View
class ShadowView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: SHADOW_GREY).cgColor
        layer.shadowRadius = 0
        layer.shadowOpacity = 5.0
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.cornerRadius = 8.0
        self.alpha = 0.8
    }
}
