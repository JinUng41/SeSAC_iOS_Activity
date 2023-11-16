//
//  ViewController.swift
//  SampleAutoLayout
//
//  Created by 김진웅 on 2023/10/16.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var addButton: UIButton!
    
    private var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentScrollView.delegate = self
        print(contentStackView.bounds.origin)
    }


    @IBAction func addButtonTapped(_ sender: UIButton) {
        let imageView: UIImageView = {
            let imageView = UIImageView()
            let (color, image) = makeRandomColorImage()
            imageView.image = image
            imageView.tintColor = color
            imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
            imageView.isHidden = true
            return imageView
        }()
        
        let index = imageStackView.arrangedSubviews.endIndex
        self.imageStackView.insertArrangedSubview(imageView, at: index - 1)
        UIView.animate(withDuration: 0.3) {
            imageView.isHidden = false
        }
        
        if imageScrollView.bounds.width < imageScrollView.contentSize.width {
            let x = imageScrollView.contentSize.width - imageScrollView.frame.width
            UIView.animate(withDuration: 0.3) {
                self.imageScrollView.contentOffset = CGPoint(x: x, y: 0)
            }
        }
    }
    
    private func makeRandomColorImage() -> (UIColor, UIImage?) {
        let number = Int.random(in: 1...7)
        switch number {
        case 1:
            return (UIColor.systemRed, UIImage(systemName: "sun.max.fill"))
        case 2:
            return (UIColor.systemOrange, UIImage(systemName: "moon.fill"))
        case 3:
            return (UIColor.systemYellow, UIImage(systemName: "sparkles"))
        case 4:
            return (UIColor.systemGreen, UIImage(systemName: "hurricane"))
        case 5:
            return (UIColor.systemBlue, UIImage(systemName: "cloud.moon.bolt.fill"))
        case 6:
            return (UIColor.systemCyan, UIImage(systemName: "cloud.bolt.fill"))
        case 7:
            return (UIColor.systemPurple, UIImage(systemName: "cloud.drizzle.fill"))
        default:
            return (UIColor.black, UIImage(systemName: "person.fill"))
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        count += 1
        print("|-----------------------------------------|")
        print(">>> \(count) : \(#function)")
        print(">>> \(addButton.frame.origin) : \(#function)")
        print(">>> \(addButton.bounds.origin) : \(#function)")
        print("|-----------------------------------------|")
    }
}
