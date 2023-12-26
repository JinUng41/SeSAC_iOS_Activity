//
//  ViewController.swift
//  CompositionalLayoutPractice
//
//  Created by 김진웅 on 12/6/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var testView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        configureUI()
        testView.delegate = self
        testView.dataSource = self
    }
}

extension ViewController {
    private func configureUI() {
        testView = UICollectionView(frame: .zero, collectionViewLayout: createBasicListLayout())
        testView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseIdentifier)
        testView.register(ReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReusableView.reuseIdentifier)
        setConstraints()
    }
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(testView)
        testView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            testView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            testView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            testView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            testView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }
    
    private func createBasicListLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.headerMode = .supplementary
        let compositionalLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        return compositionalLayout
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 150.0)
    }
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.reuseIdentifier, for: indexPath) as? CustomCell else { return UICollectionViewCell() }
        let content = "\(indexPath.row)"
        cell.configuration(content)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReusableView.reuseIdentifier, for: indexPath) as? ReusableView 
        else {
            return UICollectionReusableView()
        }
        
        return view
    }
}
