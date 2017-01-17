//
//  LeftSegue.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-16.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit

class LeftSegue: UIStoryboardSegue {
    
        override func perform(){
            let src=source
            let dst=destination
            let slide_view=destination.view
            
            src.view.addSubview(slide_view!)
            slide_view?.transform=CGAffineTransform.init(translationX: src.view.frame.size.width, y: 0)
            
            UIView.animate(withDuration: 0.25,
                                       delay: 0.0,
                                       options: UIViewAnimationOptions.curveEaseInOut,
                                       animations: {
                                        slide_view?.transform=CGAffineTransform.identity
            }, completion: {finished in
                src.present(dst, animated: false, completion: nil)
                slide_view?.removeFromSuperview()
            })
        }
    
}
