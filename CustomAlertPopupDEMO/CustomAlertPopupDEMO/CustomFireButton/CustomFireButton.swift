//
//  CustomFireButton.swift
//  https://github.com/mYoda/CustomFireButton
//
//  Created by Anton Nechayuk on 11.07.18.
//  Copyright © 2018 Anton Nechayuk. All rights reserved.
//

import UIKit

@IBDesignable
class CustomFireButton: UIControl {
    
    @IBOutlet var view: UIView!
    static let identifier = "CustomFireButton"
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var buttonView: UIControl!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var textLabelButton: UIButton!
    
    @IBOutlet weak var buttonViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonViewTrailingConstraint: NSLayoutConstraint!
    
    
    //Properties
    @IBInspectable var padding: Int = 5 {
        didSet {
            buttonViewTopConstraint.constant = CGFloat(max(0, padding))
            buttonViewLeadingConstraint.constant = CGFloat(max(0, padding))
            buttonViewBottomConstraint.constant = CGFloat(max(0, padding))
            buttonViewTrailingConstraint.constant = CGFloat(max(0, padding))
        }
    }
    
    @IBInspectable var buttonColor: UIColor = #colorLiteral(red: 0.1090076491, green: 0.808973074, blue: 0.1021158919, alpha: 1) {
        didSet {
            buttonView.backgroundColor = buttonColor
        }
    }
    
    @IBInspectable var cornerRadius: Int = 5 {
        didSet {
            buttonView.layer.cornerRadius = CGFloat(cornerRadius)
            shadowView.layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            buttonView.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: Int = 0 {
        didSet {
            buttonView.layer.borderWidth = CGFloat(borderWidth)
        }
    }
    
    @IBInspectable var textColor: UIColor = UIColor.white {
        didSet {
            textLabelButton.setTitleColor(textColor, for: .normal)
        }
    }
    
    @IBInspectable var textSize: CGFloat = 14 {
        didSet {
            textLabelButton.titleLabel?.font = textLabelButton.titleLabel?.font.withSize(textSize)
        }
    }
    
    @IBInspectable var caption: String = "Done" {
        didSet {
            textLabelButton.setTitle(caption, for: .normal)
        }
    }
    
    @IBInspectable var backColor: UIColor = UIColor.init(red: 248/255.0, green: 247/255.0, blue: 248/255.0, alpha: 1) {
        didSet {
            backgroundView.backgroundColor = backColor
        }
    }
    
    
    @IBInspectable var leftImageInset: CGFloat = 0 {
        didSet {
            textLabelButton.imageEdgeInsets.left = leftImageInset
        }
    }
    
    @IBInspectable var rightImageInset: CGFloat = 0 {
        didSet {
            textLabelButton.imageEdgeInsets.right = rightImageInset
        }
    }
    
    @IBInspectable var bottomImageInset: CGFloat = 0 {
        didSet {
            textLabelButton.imageEdgeInsets.bottom = bottomImageInset
        }
    }
    
    @IBInspectable var topImageInset: CGFloat = 0 {
        didSet {
            textLabelButton.imageEdgeInsets.top = topImageInset
        }
    }
    
    @IBInspectable var image: UIImage? = nil {
        didSet {
            textLabelButton.setImage(image, for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        view = loadFromNib()
        insertSubview(view, at: 0)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight , .flexibleWidth]
        defaultValues()
    }
    
    
    
    private func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: CustomFireButton.identifier, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    func defaultValues() {
        padding = 5
        cornerRadius = 5
        buttonColor = #colorLiteral(red: 0.1090076491, green: 0.808973074, blue: 0.1021158919, alpha: 1)
        caption = "Done"
        view.superview?.backgroundColor = .clear
        enableButton()
    }
    
    public func enableButton(_ flag: Bool = true) {
        if flag == true {
            buttonView.backgroundColor = buttonColor
            self.isEnabled = true
        } else {
            buttonView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            self.isEnabled = false
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        if buttonView.frame.contains(touch.location(in: self)) {
            shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            return true
        }
        return false
    }
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        shadowView.backgroundColor = UIColor.clear
    }
    override func cancelTracking(with event: UIEvent?) {
        shadowView.backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

