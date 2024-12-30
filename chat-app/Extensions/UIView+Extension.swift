//
//  Extension.swift
//  Mock
//
//  Created by DungHM on 22/11/24.
//

import UIKit
enum GradientOrientation {
    case vertical
    case horizontal
    case downDiagonal
    case upDiagonal
}

extension UIView {
    func roundEachCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 4.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func dropShadow(shadowOpacity: Float = 0.5, shadowColor: CGColor = UIColor.gray.cgColor, shadowRadius: CGFloat = 5){
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = shadowRadius
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    func setGradient(borderColors: [UIColor], lineWidth: CGFloat, orientation: GradientOrientation) {
        _ = self.layer.sublayers?.map {
            if $0 is CAGradientLayer {
                $0.removeFromSuperlayer()
            }
        }
        let gradient = CAGradientLayer()
        gradient.colors = borderColors.map { $0.cgColor }
        gradient.frame =  CGRect(origin: .zero, size: self.frame.size)
        gradient.cornerRadius = self.cornerRadius
        gradient.masksToBounds = true
        switch orientation {
        case .vertical:
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        case .downDiagonal:
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
        case .upDiagonal:
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 1, y: 0)
        }
        
        let shape = CAShapeLayer()
        shape.lineWidth = lineWidth
        shape.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        
        gradient.mask = shape
        
        self.layer.addSublayer(gradient)
    }
    
    func setGradient(fillColors: [UIColor], orientation: GradientOrientation) {
        _ = self.layer.sublayers?.map {
            if $0 is CAGradientLayer {
                $0.removeFromSuperlayer()
            }
        }
        let gradient = CAGradientLayer()
        gradient.colors = fillColors.map { $0.cgColor }
        gradient.frame =  CGRect(origin: .zero, size: self.frame.size)
        gradient.cornerRadius = self.cornerRadius
        gradient.masksToBounds = true
        switch orientation {
        case .vertical:
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        case .downDiagonal:
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
        case .upDiagonal:
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 1, y: 0)
        }
        self.layer.insertSublayer(gradient, at: 0)
    }
}
