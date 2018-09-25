//
//  UICustomView.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation
import Foundation
import UIKit

@IBDesignable
class CornerRadiusView: UIView {
    private var _cornerRadius: CGFloat = 0.0
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set (newValue) {
            _cornerRadius = newValue
            layer.cornerRadius = _cornerRadius
        } get {
            return _cornerRadius
        }
    }
}

class UILabelChecked: UILabel {
    // Images
    let checkedImage = UIImage(named: "img_checked")! as UIImage
    let uncheckedImage = UIImage(named: "img_notcheck")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                //self.setImage(checkedImage, for: UIControlState.normal)
            } else {
               // self.setImage(uncheckedImage, for: UIControlState.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.uiLabelCheck)))
        self.isChecked = false
    }
    
    @objc func uiLabelCheck() {
        isChecked = !isChecked
        self.text = self.text
    }
}

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "img_checked")! as UIImage
    let uncheckedImage = UIImage(named: "img_notcheck")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControlState.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControlState.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}

extension UIView {
    func applyGradient(colours: [UIColor], transForm: Bool) -> Void {
        self.applyGradient(colours: colours, locations: nil, transForm: transForm)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?, transForm: Bool) -> Void {
        let gradient: CAGradientLayer   = CAGradientLayer()
        gradient.frame                  = self.bounds
        gradient.colors                 = colours.map { $0.cgColor }
        gradient.locations              = locations
        if transForm{
            gradient.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat.pi))
            gradient.affineTransform()
        }
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary     = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func setConerRaiousFollowWidth(width: CGFloat){
        self.layer.cornerRadius     = width
        self.layer.masksToBounds    = true
    }
    
    func setShadow() {
        //        self.layer.shadowColor = .gray.CGColor;
        //        self.layer.shadowOffset = CGSize(5, 5);
        self.layer.shadowOpacity = 0.1;
        self.layer.shadowRadius = 1.0;
    }
    
    func setConerRaious(){
        self.layer.masksToBounds    = true
        self.layer.cornerRadius     = self.frame.height/2
    }
    
    func setBorderColor(borderWidth: CGFloat, borderCorlor: String){
        self.layer.masksToBounds    = true
        self.layer.borderWidth      = borderWidth
        self.layer.borderColor      = hexStringToUIColor(hex: borderCorlor).cgColor
    }
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}


class CornerRadiusButton: UIButton {
    private var _cornerRadius: CGFloat = 0.0
    
    private var _borderColor: UIColor = .white
    @IBInspectable
    var cornerRadius: CGFloat {
        set (newValue) {
            _cornerRadius = newValue
            layer.cornerRadius = _cornerRadius
        } get {
            return _cornerRadius
        }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        set (newValue) {
            _borderColor = newValue
            layer.borderColor = _borderColor.cgColor
            layer.borderWidth = 0.5
        } get {
            return _borderColor
        }
    }
}
