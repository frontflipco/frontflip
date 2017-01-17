//
//  MaterialTextField.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-07.
//  Copyright © 2017 Frontflip. All rights reserved.
//  Custom Material TextField

import UIKit
import Material


//Inheirts from the Material by CosmicMind Framework
class MaterialTextField: TextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
                // Set the color of the material textfield to grey
                self.placeholderNormalColor = Color.grey.base
                self.placeholderActiveColor = Color.grey.base
                self.dividerNormalColor = Color.grey.base
                self.dividerActiveColor = Color.grey.base   }

}
