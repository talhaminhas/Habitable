//
//  ShadowView.swift
//  Habitable
//
//  Created by Mian Saram on 07/10/2020.
//  Copyright © 2020 Habitable. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowView: UIView {
    //Shadow
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            self.updateView()
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            self.updateView()
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 3, height: 3) {
        didSet {
            self.updateView()
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 15.0 {
        didSet {
            self.updateView()
        }
    }
    @IBInspectable var borderColor: CGColor = UIColor(red: 1.00, green: 0.66, blue: 0.00, alpha: 1.00).cgColor{
        didSet {
            self.updateView()
        }
    }
    @IBInspectable var borderWidth: CGFloat = 1.5 {
        didSet {
            self.updateView()
        }
    }

    //Apply params
    func updateView() {
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.shadowOpacity = self.shadowOpacity
        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowRadius = self.shadowRadius
        self.layer.borderColor = self.borderColor
        self.layer.borderWidth = self.borderWidth
    }
}
