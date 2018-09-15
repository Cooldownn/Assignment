//
//  Line.swift
//  Assignment
//
//  Created by Cooldown on 15/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

class Line: UIView {
    
    var line = UIBezierPath()
    var line1 = UIBezierPath()
    var line2 = UIBezierPath()
    var line3 = UIBezierPath()
    var line4 = UIBezierPath()
    var line5 = UIBezierPath()
    
    func graph()
    {
        line.move(to: .init(x: 0, y: 333))
        line.addLine(to: .init(x: bounds.width, y: 333))
        UIColor.black.setStroke()
        line.lineWidth = 0.1
        line.stroke()
        
        line1.move(to: .init(x: 0, y: 383))
        line1.addLine(to: .init(x: bounds.width, y: 383))
        UIColor.black.setStroke()
        line1.lineWidth = 0.1
        line1.stroke()
        
        line2.move(to: .init(x: 0, y: 433))
        line2.addLine(to: .init(x: bounds.width, y: 433))
        UIColor.black.setStroke()
        line2.lineWidth = 0.1
        line2.stroke()
        
        line3.move(to: .init(x: 0, y: 483))
        line3.addLine(to: .init(x: bounds.width, y: 483))
        UIColor.black.setStroke()
        line3.lineWidth = 0.1
        line3.stroke()
        
        line4.move(to: .init(x: 0, y: 533))
        line4.addLine(to: .init(x: bounds.width, y: 533))
        UIColor.black.setStroke()
        line4.lineWidth = 0.1
        line4.stroke()
        
        line4.move(to: .init(x: 0, y: 583))
        line4.addLine(to: .init(x: bounds.width, y: 583))
        UIColor.black.setStroke()
        line4.lineWidth = 0.1
        line4.stroke()
        
    }
    override func draw(_ rect: CGRect) {
        graph()
    }
    
    
}
