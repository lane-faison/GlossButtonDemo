//
//  Drawing.swift
//  GlossButtonDemo
//
//  Created by Lane Faison on 3/1/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit
import CoreGraphics

extension UIView {
    func createRoundedRectPath(for rect: CGRect, radius: CGFloat) -> CGMutablePath {
        let path = CGMutablePath()
        
        // 1
        let midTopPoint = CGPoint(x: rect.midX, y: rect.minY)
        path.move(to: midTopPoint)
        
        // 2
        let topRightPoint = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRightPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeftPoint = CGPoint(x: rect.minX, y: rect.maxY)
        let topLeftPoint = CGPoint(x: rect.minX, y: rect.minY)
        
        // 3
        path.addArc(tangent1End: topRightPoint, tangent2End: bottomRightPoint, radius: radius)
        path.addArc(tangent1End: bottomRightPoint, tangent2End: bottomLeftPoint, radius: radius)
        path.addArc(tangent1End: bottomLeftPoint, tangent2End: topLeftPoint, radius: radius)
        path.addArc(tangent1End: topLeftPoint, tangent2End: topRightPoint, radius: radius)
        
        // 4
        path.closeSubpath()
        
        return path
    }
    
    func drawLinearGradient(context: CGContext, rect: CGRect, startColor: CGColor, endColor: CGColor) {
        // 1
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 2
        let colorLocations: [CGFloat] = [0.0, 0.1]
        
        // 3
        let colors: CFArray = [startColor, endColor] as CFArray // API requires a CFArray
        
        // 4
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: colorLocations)!
        
        // 5
        let startPoint = CGPoint(x: rect.midX, y: rect.minY)
        let endPoint = CGPoint(x: rect.midX, y: rect.maxY)
        
        context.saveGState()
        
        // 6
        context.addRect(rect)
        
        // 7
        context.clip()
        
        // 8
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        
        context.restoreGState()
    }
    
    func drawGlossAndGradient(context: CGContext, rect: CGRect, startColor: CGColor, endColor: CGColor) {
        // 1
        drawLinearGradient(context: context, rect: rect, startColor: startColor, endColor: endColor)
        
        let glossColor1 = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.35)
        let glossColor2 = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
        
        let topHalf = CGRect(origin: rect.origin, size: CGSize(width: rect.width, height: rect.height / 2))
        
        drawLinearGradient(context: context, rect: topHalf, startColor: glossColor1.cgColor, endColor: glossColor2.cgColor)
    }
}
