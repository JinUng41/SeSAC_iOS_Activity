//
//  StackViewController.swift
//  SampleAutoLayout
//
//  Created by 김진웅 on 2023/10/17.
//

import UIKit

class StackViewController: UIViewController {
    private lazy var vertical: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .cyan
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var horizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(addButton)
        stackView.addArrangedSubview(removeButton)
        return stackView
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        button.addTarget(self, action: #selector(addView), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        button.addTarget(self, action: #selector(removeView), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        NSLayoutConstraint.activate([
            horizontal.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            horizontal.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            horizontal.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            vertical.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vertical.bottomAnchor.constraint(equalTo: horizontal.topAnchor),
            vertical.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            vertical.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc func addView() {
        let myView: UIView = {
            let view = UIView()
            view.backgroundColor = .black
            view.isHidden = true

            return view
        }()
        
        vertical.addArrangedSubview(myView)
        UIView.animate(withDuration: 0.3) {
            myView.isHidden = false
        }
    }
    
    @objc func removeView() {
        guard let last = vertical.arrangedSubviews.last else { return }
        UIView.animate(withDuration: 0.3) {
            last.isHidden = true
        } completion: { _ in
            self.vertical.removeArrangedSubview(last)
        }
    }
}
