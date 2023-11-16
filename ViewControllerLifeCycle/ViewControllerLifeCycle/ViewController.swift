//
//  ViewController.swift
//  ViewControllerLifeCycle
//
//  Created by 김진웅 on 2023/11/02.
//

import UIKit

class ViewController: UIViewController {

    private let first = "First"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(">>> \(first) : \(#function)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(">>> \(first) : \(#function)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(">>> \(first) : \(#function)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(">>> \(first) : \(#function)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(">>> \(first) : \(#function)")
    }
    
    
    @IBAction func pushBtnTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Second") as? SecondViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func presentBtnTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Second") as? SecondViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

