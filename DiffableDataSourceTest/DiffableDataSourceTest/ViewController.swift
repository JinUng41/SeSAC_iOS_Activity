//
//  ViewController.swift
//  DiffableDataSourceTest
//
//  Created by 김진웅 on 12/12/23.
//

import UIKit

enum Section {
    case main
}

struct Item: Hashable {
    let id: UUID = UUID()
    var title: String
    
    // Hashable 구현
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}

final class ViewController: UIViewController {
    
    private lazy var testView: UICollectionView = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.backgroundColor = .clear
        let compositionalLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
//        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("ㅗㅗㅗㅗ", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    private var data: [[Item]] = [
        (1...5).map { Item(title: "Item \($0)") },
        (6...10).map { Item(title: "Item \($0)") },
        (11...15).map { Item(title: "Item \($0)") },
        (16...20).map { Item(title: "Item \($0)") },
        (21...25).map { Item(title: "Item \($0)") },
        (26...30).map { Item(title: "Item \($0)") },
        (31...35).map { Item(title: "Item \($0)") },
        (36...40).map { Item(title: "Item \($0)") },
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        configureCollectionView()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.updateDataSource()
//        }
    }
    
    @objc
    private func buttonTapped() {
        print("버튼 눌렀다!")
        updateDataSource()
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            testView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            testView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            testView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            testView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            testButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            testButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
        ])
    }
    
    private func configureCollectionView() {
        let cellRegistration = UICollectionView.CellRegistration
        <CustomCell, Item> { (cell, indexPath, item) in
            // Populate the cell with our item description.
            cell.titleLabel.text = item.title
        }
        
        // 데이터 소스 초기화
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: testView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Item) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        // 초기 스냅샷 생성
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(data.flatMap { $0 })
        
        // 데이터 소스에 스냅샷 적용
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    private func updateDataSource() {
        data[0][1] = Item(title: "asafsfdas")
        
        // 스냅샷 업데이트
        var snapshot = dataSource.snapshot()
        print(snapshot.itemIdentifiers(inSection: .main))
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(data.flatMap { $0 })
        
        // 새로운 스냅샷 적용
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

final class CustomCell: UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 30)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
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
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
    }
}
