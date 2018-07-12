//
//  ViewController.swift
//  CustomAlertPopupDEMO
//
//  Created by Anton Nechayuk on 12.07.18.
//  Copyright © 2018 Anton Nechayuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Actions
    
    @IBAction func showPopupOneButtonAction(_ sender: Any) {
        
        //NOTICE: using CustomPopupAlertAction is mandatory if you want to execute handler.
        let okAction = CustomPopupAlertAction.setupWith(title: "OK", style: .default) { (_) in
            print("OK action pressed")
        }
        
        CustomPopupViewController.showMessage(title: "Title for popup alert", message: "Here is some message to the user. \nNewLines supported", viewController: self, leftBtnAction: okAction, rightBtnAction: nil)
    }
    
    @IBAction func showPopupTwoButtonAction(_ sender: Any) {
        
        let okAction = CustomPopupAlertAction.setupWith(title: "OK", style: .default) { (_) in
            print("OK action pressed")
        }
        
        let cancelAction = CustomPopupAlertAction.setupWith(title: "Cancel", style: .cancel) { (_) in
            print("CANCEL action pressed")
        }
        
        CustomPopupViewController.showMessage(title: "Two buttons popup alert", message: "Here is some message to the user. \nNewLines supported", viewController: self, leftBtnAction: okAction, rightBtnAction: cancelAction)
    }
    
    // without buttons, just title, message and close-button in the left top corner
    @IBAction func showPopupDefaultButtonAction(_ sender: Any) {
        
        CustomPopupViewController.showMessage(title: "Info popup alert", message: "Example when have no any action buttons. Just inform users for something.", viewController: self, leftBtnAction: nil, rightBtnAction: nil)
    }
    
}

