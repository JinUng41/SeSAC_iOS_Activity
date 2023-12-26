//
//  ViewController.swift
//  CacheExample
//
//  Created by kawoou on 2023/02/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test1()
        test2()
    }

    private func test1() {
        let data = CacheManager.shared.getForAES(for: "test-1") ?? Data()
        print("test1: \(String(data: data, encoding: .utf8) ?? "")")

        try? CacheManager.shared.storeForAES(
            data + ("1".data(using: .utf8) ?? Data()),
            for: "test-1"
        )
    }

    private func test2() {
        let data = CacheManager.shared.get(for: "test-2") ?? Data()
        print("test2: \(String(data: data, encoding: .utf8) ?? "")")

        try? CacheManager.shared.store(
            data + ("2".data(using: .utf8) ?? Data()),
            for: "test-2"
        )
    }
}

