//
//  alert.swift
//  alertViewTest
//
//  Created by Pooja Negi on 08/11/17.
//  Copyright © 2017 ReadyAssist. All rights reserved.
//

import Foundation
import UIKit

protocol Modal {
    func show(animated:Bool)
    func dismiss(animated:Bool)
    var backgroundView:UIView {get}
    var dialogView:UIView {get set}
    var imageView:UIImageView {get set}
}

extension Modal where Self:UIView{
    
    func show(animated:Bool){
        DispatchQueue.main.async(execute: {
            self.backgroundView.alpha  = 0
            UIApplication.shared.delegate?.window??.rootViewController?.view.addSubview(self)
            if animated {
                self.imageView.rotate360Degrees()
                UIView.animate(withDuration: 0.33, animations: {
                    self.backgroundView.alpha = 0.66
                })
                UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                    self.dialogView.center   = self.center
                }, completion: { (completed) in
                })
                
            }else{
                self.backgroundView.alpha  = 0.66
                self.dialogView.center  = self.center
            }
        })
    }
    
    func dismiss(animated:Bool){
      DispatchQueue.main.async(execute: {
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha  = 0
            }, completion: { (completed) in
                
            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
//                self.dialogView.center  = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
                 self.dialogView.center  = self.center
                
            }, completion: { (completed) in
                self.removeFromSuperview()
            })
        }else{
            self.removeFromSuperview()
        }
      })
    }
}
