//
//  HamburgerView.swift
//  CoreGraphicsTest
//
//  Created by 김진웅 on 12/20/23.
//

import UIKit

final class HamburgerView: UIView {
    
    lazy var minX = bounds.minX
    lazy var minY = bounds.minY
    lazy var maxX = bounds.maxX
    lazy var maxY = bounds.maxY
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        backgroundColor = .white
        
        // Drawing code
        drawRoundBread()
        drawCheese()
        drawTomato()
        drawLettuce()
        drawPatties()
        drawRectBread()
    }
    
    private func drawRoundBread() {
        let breadPath = UIBezierPath()
        breadPath.lineWidth = 10
        breadPath.lineCapStyle = .round
        breadPath.lineJoinStyle = .round
        UIColor.systemBrown.setStroke()
        
        breadPath.move(
            to: CGPoint(x: minX + 100, y: minY + 100)
        )
        
        breadPath.addCurve(
            to: CGPoint(x: maxX - 100, y: minY + 100),
            controlPoint1: CGPoint(x: minX + 75, y: minY + 10),
            controlPoint2: CGPoint(x: maxX - 75 , y: minY + 10)
        )
        
        breadPath.addLine(
            to: CGPoint(x: maxX - 100, y: minY + 100)
        )
        
        breadPath.close()
        breadPath.stroke()
    }
    
    private func drawCheese() {
        let cheesePath = UIBezierPath()
        cheesePath.lineWidth = 3
        UIColor.systemYellow.setStroke()
        
        let start = CGPoint(x: minX + 90, y: minY + 110)
        var count: CGFloat = 0
        
        for _ in 0...10 {
            let point = CGPoint(x: start.x + count, y: start.y)
            cheesePath.move(
                to: point
            )
            
            cheesePath.addLine(
                to: CGPoint(x: point.x + 20, y: start.y + 20)
            )
            
            cheesePath.close()
            cheesePath.stroke()
            
            count += 20
        }
    }
    
    private func drawTomato() {
        let tomatoPath = UIBezierPath()
        tomatoPath.lineWidth = 10
        UIColor.systemRed.setStroke()
        
        let start = CGPoint(x: minX + 100, y: minY + 140)
        
        tomatoPath.move(to: start)
        
        tomatoPath.addLine(
            to: CGPoint(x: start.x + 90, y: start.y)
        )
        
        tomatoPath.move(
            to: CGPoint(x: start.x + 110, y: start.y)
        )
        
        tomatoPath.addLine(
            to: CGPoint(x: start.x + 200, y: start.y)
        )
        
        tomatoPath.close()
        tomatoPath.stroke()
    }
    
    private func drawLettuce() {
        let lettucePath = UIBezierPath()
        lettucePath.lineWidth = 10
        lettucePath.lineCapStyle = .round
        lettucePath.lineJoinStyle = .round
        UIColor.green.setStroke()
        
        let start = CGPoint(x: minX + 90, y: minY + 160)
        lettucePath.move(
            to: start
        )
        
        var count: CGFloat = 0
        for _ in 0...3 {
            let point = CGPoint(x: start.x + count, y: start.y)
            lettucePath.addCurve(
                to: CGPoint(x: point.x + 60, y: point.y),
                controlPoint1: CGPoint(x: point.x + 20, y: point.y + 20),
                controlPoint2: CGPoint(x: point.x + 40, y: point.y - 20)
            )
            
            count += 60
        }
        
        lettucePath.stroke()
    }
    
    private func drawPatties() {
        let pattiesPath = UIBezierPath()
        pattiesPath.lineWidth = 30
        pattiesPath.lineCapStyle = .round
        UIColor.brown.setStroke()
        
        let start = CGPoint(x: minX + 80, y: minY + 190)
        pattiesPath.move(to: start)
        pattiesPath.addLine(
            to: CGPoint(x: start.x + 250, y: start.y)
        )
        pattiesPath.stroke()
    }
    
    private func drawRectBread() {
        let breadPath = UIBezierPath(
            roundedRect: CGRect(x: minX + 100, y: minY + 220, width: CGFloat(Int(bounds.width * 0.5)), height: 60),
            cornerRadius: 10
        )
        breadPath.lineWidth = 10
        UIColor.systemBrown.setStroke()
        
        breadPath.stroke()
    }

}
