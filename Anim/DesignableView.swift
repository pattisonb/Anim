//
//  DesignableView.swift
//  Anim
//
//  Created by Manov Jain on 11/2/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//
//  Purpose: Design of Application

import UIKit

@IBDesignable
class DesignableView: UIView {
    
    // setting a shadow color
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    // setting a radius
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    // setting a shadow opacity
    @IBInspectable var shadowOpacity: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }

    // setting a shadow offset
    @IBInspectable var shadowOffsetY: CGFloat = 0 {
        didSet {
            layer.shadowOffset.height = shadowOffsetY
        }
    }
}
