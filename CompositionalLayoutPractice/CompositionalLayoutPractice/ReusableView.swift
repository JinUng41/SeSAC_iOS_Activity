//
//  ReusableView.swift
//  CompositionalLayoutPractice
//
//  Created by 김진웅 on 12/6/23.
//

import UIKit

final class ReusableView: UICollectionReusableView, Reusable {
    private lazy var testLabel: UILabel = {
        let label = UILabel()
        label.text = "이것은 헤더입니다"
        label.textColor = .black
        label.backgroundColor = .cyan
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
//            testLabel.topAnchor.constraint(equalTo: topAnchor),
//            testLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            testLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    func configuration(_ content: String) {
        testLabel.text = content
    }
}
