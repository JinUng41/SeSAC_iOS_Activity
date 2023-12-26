//
//  ViewController.swift
//  LazyLoadingTest
//
//  Created by 김진웅 on 11/22/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var testTableView: UITableView!
    
    private let nsCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testTableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        
        cell.imageView?.image = UIImage(systemName: "photo")
        cell.textLabel?.text = "\(indexPath.section) : \(indexPath.row)"
        
        if indexPath.row == 3 {
            cell.backgroundColor = .systemPink
        } else {
            cell.backgroundColor = .white
        }
        // URLCache 사용할 때
        let url: URL?
        switch indexPath.row {
        case 0: url = URL(string: "https://wallpaperaccess.com/download/europe-4k-1369012")!
        case 1: url = URL(string: "https://wallpaperaccess.com/download/europe-4k-1318341")!
        case 2: url = URL(string: "https://wallpaperaccess.com/download/europe-4k-1379801")!
        default: url = nil
        }
        
        // NSCache 사용할 때
//        let url: String?
//        switch indexPath.row {
//        case 0: url = "https://wallpaperaccess.com/download/europe-4k-1369012"
//        case 1: url = "https://wallpaperaccess.com/download/europe-4k-1318341"
//        case 2: url = "https://wallpaperaccess.com/download/europe-4k-1379801"
//        default: url = nil
//        }
//        
        guard let url = url else {
            return cell
        }
        
        let request = URLRequest(url: url)
        urlCaching(request: request, indexPath: indexPath, cell: cell)
        
//        nsCaching(url: url, indexPath: indexPath, cell: cell)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
}

extension ViewController {
    func urlCaching(request: URLRequest, indexPath: IndexPath, cell: UITableViewCell) {
        if let cachedResponse = URLCache.shared.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            DispatchQueue.main.async { [weak self] in
                if indexPath == self?.testTableView.indexPath(for: cell) {
                    cell.imageView?.image = image
                }
            }
        } else {
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                guard let response = response as? HTTPURLResponse else { return }
                guard (200...299).contains(response.statusCode) else {
                    print("\(response.statusCode) response error")
                    return
                }
                
                guard let safeData = data else {
                    print("No Data!")
                    return
                }
                
                let cachedResponse = CachedURLResponse(response: response, data: safeData)
                URLCache.shared.storeCachedResponse(cachedResponse, for: request)
                
                let image = UIImage(data: safeData)
                DispatchQueue.main.async { [weak self] in
                    if indexPath == self?.testTableView.indexPath(for: cell) {
                        cell.imageView?.image = image
                    }
                }
            }.resume()
        }
    }
    
    func nsCaching(url: String, indexPath: IndexPath, cell: UITableViewCell) {
        let key = NSString(string: url)
        if let cachedImage = nsCache.object(forKey: key) {
            DispatchQueue.main.async { [weak self] in
                if indexPath == self?.testTableView.indexPath(for: cell) {
                    cell.imageView?.image = cachedImage
                    return
                }
            }
            
        }
        
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            guard (200...299).contains(response.statusCode) else {
                print("\(response.statusCode) response error")
                return
            }
            
            guard let safeData = data else {
                print("No Data!")
                return
            }
            
            let image = UIImage(data: safeData)
            DispatchQueue.main.async { [weak self] in
                if indexPath == self?.testTableView.indexPath(for: cell) {
                    cell.imageView?.image = image
                    self?.nsCache.setObject(image!, forKey: key)
                }
            }
        }.resume()
    }
}
