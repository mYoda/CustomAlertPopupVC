//
//  PopupAnimationPresentViewController.swift
//  
//
//  Created by Anton Nechayuk on 7.03.18.
//  Copyright © 2018 Anton Nechayuk. All rights reserved.
//

import UIKit

class PopupAnimationPresentViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView?
    @IBOutlet weak var popupView: UIView?
    @IBOutlet weak var popupViewCenterConstraint: NSLayoutConstraint?
    //call this in viewDidLoad
    func uiWillAnimate() {
        popupViewCenterConstraint?.constant = -self.view.frame.height
        backgroundView?.alpha = 0
        popupView?.isHidden = false
        self.view.layoutIfNeeded()
    }
    
    func animationPresent(_ mainView: UIView) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {
            self.popupViewCenterConstraint?.constant = 0
            self.backgroundView?.alpha = 0.8
            self.view.layoutIfNeeded()
        }, completion: {(_) -> Void in
        })
    }
    
    func dismissAnimation(completion: @escaping (() -> Void)) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {
            self.popupViewCenterConstraint?.constant = self.view.frame.height
            self.backgroundView?.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: {(_) -> Void in
            completion()
        })
    }
}
