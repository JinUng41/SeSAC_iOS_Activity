//
//  SecondViewController.swift
//  ViewControllerLifeCycle
//
//  Created by 김진웅 on 2023/11/02.
//

import UIKit

class SecondViewController: UIViewController {
    
    private let second = "Second"

    override func viewDidLoad() {
        super.viewDidLoad()
        print(">>> \(second) : \(#function)")

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(">>> \(second) : \(#function)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(">>> \(second) : \(#function)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(">>> \(second) : \(#function)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(">>> \(second) : \(#function)")
    }
    
    @IBAction func popBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
