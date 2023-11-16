//
//  AnchorViewController.swift
//  SampleAutoLayout
//
//  Created by 김진웅 on 2023/10/17.
//

import UIKit

class AnchorViewController: UIViewController {
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
//        setConstraintWithAnchor()
        setConstraintWithNSLayoutConstraint()
    }
    
    private func setConstraintWithAnchor() { // layout anchor
        let safeArea = view.safeAreaLayoutGuide
        
        button.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16).isActive = true
        button.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16).isActive = true
        
        let safeBottomAnchor = button.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        safeBottomAnchor.isActive = true
        safeBottomAnchor.priority = .defaultHigh // 750
        
        let viewBottomAnchor = button.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        viewBottomAnchor.isActive = true
    }
    
    private func setConstraintWithNSLayoutConstraint() { // NSLayoutConstraint
        let safeArea = view.safeAreaLayoutGuide
        
        let leading = NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: safeArea, attribute: .leading, multiplier: 1, constant: 16)
        
        let trailing = NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: safeArea, attribute: .trailing, multiplier: 1, constant: -16)
        
        let bottomSafeArea = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: safeArea, attribute: .bottom, multiplier: 1, constant: -16)
        bottomSafeArea.priority = .defaultHigh
        
        let bottomView = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: view, attribute: .bottom, multiplier: 1, constant: -20)
        
        NSLayoutConstraint.activate([leading, trailing, bottomView, bottomSafeArea])
    }
}
