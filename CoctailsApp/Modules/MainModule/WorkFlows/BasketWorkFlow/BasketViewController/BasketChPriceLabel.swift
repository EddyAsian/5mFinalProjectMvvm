//
//  Constants.swift
//  CoctailsApp
//
//  Created by Eldar on 21/2/23.
//

import UIKit

class BasketChPriceLabel: UILabel {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.move(to: CGPoint(x: 0, y: rect.height * 0.5))
        ctx?.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.5))
        ctx?.strokePath()
    }
}

