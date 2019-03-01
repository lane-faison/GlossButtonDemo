//
//  CoolButton.swift
//  GlossButtonDemo
//
//  Created by Lane Faison on 3/1/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

class CoolButton: UIButton {
    
    var hue: CGFloat {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var saturation: CGFloat {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var brightness: CGFloat {
        didSet {
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.hue = 0.5
        self.saturation = 0.5
        self.brightness = 0.5
        
        super.init(coder: aDecoder)
        
        self.isOpaque = false
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // 1
        let outerColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
        let shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
        // 2
        let outerMargin: CGFloat = 5.0
        let outerRect = rect.insetBy(dx: outerMargin, dy: outerMargin)
        
        // 3
        let outerPath = createRoundedRectPath(for: outerRect, radius: 10.0)
        
        // 4
        if state != .highlighted {
            context.saveGState()
            context.setFillColor(outerColor.cgColor)
            context.setShadow(offset: CGSize(width: 0, height: 2), blur: 3.0, color: shadowColor.cgColor)
            context.addPath(outerPath)
            context.fillPath()
            context.restoreGState()
        }
        
        // 5
        let outerTop = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
        let outerBottom = UIColor(hue: hue, saturation: saturation, brightness: brightness * 0.8, alpha: 1.0)
        
        // 6
        context.saveGState()
        context.addPath(outerPath)
        context.clip()
        drawGlossAndGradient(context: context, rect: outerRect, startColor: outerTop.cgColor, endColor: outerBottom.cgColor)
        context.restoreGState()
    }
}