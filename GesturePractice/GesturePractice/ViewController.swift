//
//  ViewController.swift
//  GesturePractice
//
//  Created by 김진웅 on 11/15/23.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Gesture Recognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func didPan(_ panGestureRecognizer: UIPanGestureRecognizer) {

        let point = panGestureRecognizer.location(in: view)
        pointLabel.text = "x: \(Int(point.x)), y: \(Int(point.y))"
        
        // transition은 변화량을 의미 -> x, y 좌표의 증감량
        let transition = panGestureRecognizer.translation(in: view)
        
        mainLabel.text = transition.x < 0 ? "왼쪽" : "오른쪽"
    }
    
    // 2. UIView's Touch Event Handling
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        // touch 객체가 가지는 이전 터치의 x 좌표 vs 현재 터치의 x 좌표
        let previous = touch.previousLocation(in: view)
        let now = touch.location(in: view)
        
        pointLabel.text = "x: \(Int(now.x)), y: \(Int(now.y))"
        
        mainLabel.text = previous.x < now.x ? "오른쪽" : "왼쪽"
    }
}
