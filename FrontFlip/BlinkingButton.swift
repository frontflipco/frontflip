//
//  blinkingButton.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-15.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit

//Button with Blinking Animation
class BlinkingButton: UIButton {
    
    var isBlinkedOut = false
    
    
    override func awakeFromNib() {
        let timer = Timer(timeInterval: 1.5, target: self, selector: #selector(BlinkingButton.blickAnimateStart), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    func blickAnimateStart(){
        if isBlinkedOut {
            UIView.animate(withDuration: 1.0, delay: 1.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                self.alpha = 1.0
                
            }, completion: nil)
            
            isBlinkedOut = false
            
        } else {
            UIView.animate(withDuration: 1.0, delay: 1.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                self.alpha = 0.0
                
            }, completion: nil)
            isBlinkedOut = true
        }
        
    }
    
    

}
