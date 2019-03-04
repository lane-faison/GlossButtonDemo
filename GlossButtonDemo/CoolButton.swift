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
        
        var actualBrightness = brightness
        
        if state == .highlighted {
            actualBrightness -= 0.1
        }
        
        // 1
        let outerColor = UIColor(hue: hue, saturation: saturation, brightness: actualBrightness, alpha: 1.0)
        let shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
        // 2
        let outerMargin: CGFloat = 5.0
        let outerRect = rect.insetBy(dx: outerMargin, dy: outerMargin)
        let outerPath = createRoundedRectPath(for: outerRect, radius: 6.0)
        
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
        let outerTop = UIColor(hue: hue, saturation: saturation, brightness: actualBrightness, alpha: 1.0)
        let outerBottom = UIColor(hue: hue, saturation: saturation, brightness: actualBrightness * 0.8, alpha: 1.0)
        
        // 6
        context.saveGState()
        context.addPath(outerPath)
        context.clip()
        drawGlossAndGradient(context: context, rect: outerRect, startColor: outerTop.cgColor, endColor: outerBottom.cgColor)
        context.restoreGState()
        
        // 7
        let innerTop = UIColor(hue: hue, saturation: saturation, brightness: actualBrightness * 0.9, alpha: 1.0)
        let innerBottom = UIColor(hue: hue, saturation: saturation, brightness: actualBrightness * 0.7, alpha: 1.0)
        
        // 8
        let innerMargin: CGFloat = 3.0
        let innerRect = outerRect.insetBy(dx: innerMargin, dy: innerMargin)
        let innerPath = createRoundedRectPath(for: innerRect, radius: 6.0)
        
        // 9
        context.saveGState()
        context.addPath(innerPath)
        context.clip()
        drawGlossAndGradient(context: context, rect: innerRect, startColor: innerTop.cgColor, endColor: innerBottom.cgColor)
        context.restoreGState()
    }
    
    @objc func hesitateUpdate() {
        setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        setNeedsDisplay()
        
        perform(#selector(hesitateUpdate), with: nil, afterDelay: 0.1)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        setNeedsDisplay()
        
        perform(#selector(hesitateUpdate), with: nil, afterDelay: 0.1)
    }
}
