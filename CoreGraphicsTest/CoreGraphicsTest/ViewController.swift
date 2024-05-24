//
//  ViewController.swift
//  CoreGraphicsTest
//
//  Created by 김진웅 on 12/19/23.
//

import UIKit

final class ViewController: UIViewController {
    
//    private lazy var myButton: MyButton = MyButton(
//        frame: CGRect(x: view.center.x, y: view.center.y, width: 100, height: 100)
//    )
    
    private lazy var burgerView: HamburgerView = HamburgerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray6
        
//        view.addSubview(myButton)
        // 버튼이 터치 되었을 때 그리도록 하는 다른 방식
//        myButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        setConstraints()
    }
    
//    @objc
//    private func buttonTapped() {
//        myButton.isSelected.toggle()
//        view.setNeedsDisplay()
//    }
    
    private func setConstraints() {
        burgerView.backgroundColor = .white
        view.addSubview(burgerView)
        burgerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            burgerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            burgerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            burgerView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            burgerView.heightAnchor.constraint(equalTo: burgerView.widthAnchor, multiplier: 1)
        ])
    }
    

}

UITableViewDelegate {
    
}

