//
//  MyButton.swift
//  CoreGraphicsTest
//
//  Created by 김진웅 on 12/19/23.
//

import UIKit

final class MyButton: UIButton {
    
    // MARK: - 1강: 원 그리기
    
    override func draw(_ rect: CGRect) {
        
        // 그림을 그릴 캔버스를 가져온다.
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // 선의 굵기
        context.setLineWidth(Constants.defaultLineWidth)
        
        // 선의 색깔
        context.setStrokeColor(Constants.circularColor)
        
        // 사각형 그리기
        context.addEllipse(
            in: CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.width, height: rect.height)
        )
        
        // 실제로 그린다.
        context.strokePath()
        
        // MARK: - 2강: 체크 마크 그리기
        
        if isSelected {
            // 선 굵기 설정
            context.setLineWidth(Constants.checkLineWidth)
            
            // 선 색깔 설정
            context.setStrokeColor(Constants.checkmarkColor)
            
            // 선의 끝은 둥글게
            context.setLineCap(.round)
            
            // 선의 만나는 지점이 둥글게
            context.setLineJoin(.round)
            
            // 선을 그릴 붓 위치 옮기기 (시작점)
            context.move(to: CGPoint(x: rect.width / 4, y: rect.height / 2))
            
            // 선 그리기 (첫 번째 목적지)
            context.addLine(to: CGPoint(x: rect.width / 2 - 5, y: rect.width / 4 * 3 ))
            
            // 선 그리기 (두 번째 목적지)
            context.addLine(to: CGPoint(x: rect.width / 4 * 3, y: rect.width / 3))
            
            // 실제로 그린다.
            context.strokePath()
        }
    }
    
    
    // MARK: - 3강: 버튼이 터치되었을 때만 그리기

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected.toggle()
        setNeedsDisplay()
    }
}

extension MyButton {
    struct Constants {
        static let defaultLineWidth: CGFloat = 2.0
        static let checkLineWidth: CGFloat = 4.0
        static let circularColor: CGColor = UIColor.black.cgColor
        static let checkmarkColor: CGColor = UIColor.systemIndigo.cgColor
    }
}
