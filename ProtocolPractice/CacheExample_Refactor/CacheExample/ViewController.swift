//
//  ViewController.swift
//  CacheExample
//
//  Created by kawoou on 2023/02/10.
//

import UIKit

class ViewController: UIViewController {

    private let normalCache: Cache
    private let cryptCache: Cache

    init(
        normalCache: Cache,
        cryptCache: Cache
    ) {
        self.normalCache = normalCache
        self.cryptCache = cryptCache

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        test1()
        test2()
    }

    private func test1() {
        let data = cryptCache.get(for: "test-1") ?? Data()
        print("test1: \(String(data: data, encoding: .utf8) ?? "")")

        try? cryptCache.store(
            data + ("1".data(using: .utf8) ?? Data()),
            for: "test-1"
        )
    }

    private func test2() {
        let data = normalCache.get(for: "test-2") ?? Data()
        print("test2: \(String(data: data, encoding: .utf8) ?? "")")

        try? normalCache.store(
            data + ("2".data(using: .utf8) ?? Data()),
            for: "test-2"
        )
    }
}

