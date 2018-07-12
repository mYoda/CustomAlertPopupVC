//
//  CustomPopupViewController.swift
//  https://github.com/mYoda/CustomAlertPopupVC
//
//  Created by Anton Nechayuk on 30.01.18.
//  Copyright © 2018 Anton Nechayuk. All rights reserved.
//

import UIKit

final class CustomPopupAlertAction: UIAlertAction {
    
    private var handler: ((UIAlertAction) -> Swift.Void)?
    
    static func setupWith(title: String, style: UIAlertActionStyle, handler: ((UIAlertAction) -> Void)? = nil) -> CustomPopupAlertAction {
        let action = CustomPopupAlertAction(title: title, style: style, handler: handler)
        action.handler = handler
        return action
    }
    
    func execute() {
        handler?(self)
    }
    
}

class CustomPopupViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    static let identifier = "CustomPopupViewController"
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var frontViewCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftButton: CustomFireButton?
    @IBOutlet weak var rightButton: CustomFireButton?
    @IBOutlet weak var alertButtonsStackView: UIStackView!
    
    var titleForMessage: String?
    var message: String?
    
    var leftButtonAction: CustomPopupAlertAction?
    var rightButtonAction: CustomPopupAlertAction?
    
    
    class func showMessage(title: String?, message: String?, viewController: UIViewController, leftBtnAction: CustomPopupAlertAction?, rightBtnAction: CustomPopupAlertAction?) {
        let vc = CustomPopupViewController(nibName: CustomPopupViewController.identifier, bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.titleForMessage = title ?? "Alert"
        vc.message = message ?? ""
        vc.leftButtonAction = leftBtnAction
        vc.rightButtonAction = rightBtnAction
        DispatchQueue.main.async {
            viewController.present(vc, animated: false, completion: {
                vc.animationPresent()
            })
        }
    }
    
    
    override func viewDidLoad() {
        guard titleForMessage != nil,
            message != nil
            else {
                self.dismiss(animated: false, completion: nil)
                return
        }
        
        setupUI()
        uiWillAnimate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard titleForMessage != nil,
            message != nil
            else {
                self.dismiss(animated: false, completion: nil)
                return
        }
        
    }
    
    func setupUI() {
        titleLabel.text = titleForMessage
        messageLabel.text = message
        setupAlertActions()
    }
    
    func setupAlertActions() {
        
        if let leftAction = leftButtonAction  {
            leftButton?.caption = leftAction.title ?? "OK"
            
            let color: UIColor = {
                
                switch leftAction.style {
                case .default:
                    return #colorLiteral(red: 0, green: 0.4789616466, blue: 0.9017358422, alpha: 1)
                case UIAlertActionStyle.cancel:
                    return #colorLiteral(red: 1, green: 0.05771490932, blue: 0.2692775726, alpha: 1)
                case UIAlertActionStyle.destructive:
                    return #colorLiteral(red: 1, green: 0.05771490932, blue: 0.2692775726, alpha: 1)
                }
            }()
            
            leftButton?.borderColor = color
            leftButton?.borderWidth = 2
            leftButton?.textColor = color
            leftButton?.buttonColor = .clear
            
        } else {
            alertButtonsStackView?.removeFromSuperview()
        }
        
        if let rightAction = rightButtonAction {
            rightButton?.caption = rightAction.title ?? "Cancel"
            let color: UIColor = {
                
                switch rightAction.style {
                case .default:
                    return #colorLiteral(red: 0, green: 0.4789616466, blue: 0.9017358422, alpha: 1)
                case UIAlertActionStyle.cancel:
                    return #colorLiteral(red: 1, green: 0.05771490932, blue: 0.2692775726, alpha: 1)
                case UIAlertActionStyle.destructive:
                    return #colorLiteral(red: 1, green: 0.05771490932, blue: 0.2692775726, alpha: 1)
                }
            }()
            
            rightButton?.borderColor = color
            rightButton?.borderWidth = 2
            rightButton?.textColor = color
            rightButton?.buttonColor = .clear
        } else {
            rightButton?.removeFromSuperview()
        }
    }
    
    // MARK: - Actions
    
    
    @objc func closeAction(_ completion: (()->Void)?) {
        dismissAnimation(completion: {
            self.dismiss(animated: false, completion: completion)
        })
    }
    
    @IBAction func leftButtonAction(_ sender: Any) {
        
        closeAction {
            self.leftButtonAction?.execute()
        }
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        
        closeAction {
            self.rightButtonAction?.execute()
        }
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        closeAction(nil)
    }
    
    // MARK: - Animations
    
    func uiWillAnimate() {
        frontViewCenterConstraint.constant = -self.view.frame.height
        backgroundView.alpha = 0
        frontView.isHidden = false
    }
    
    func animationPresent() {
        uiWillAnimate()
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {
            self.frontViewCenterConstraint.constant = 0
            self.backgroundView.alpha = 0.8
            self.view.layoutIfNeeded()
        }, completion: {(_) -> Void in
        })
    }
    
    private func dismissAnimation(completion: @escaping (() -> Void)) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {
            self.frontViewCenterConstraint.constant = self.view.frame.height
            self.backgroundView.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: {(_) -> Void in
            completion()
        })
    }

    
}

