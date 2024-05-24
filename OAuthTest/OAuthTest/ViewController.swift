//
//  ViewController.swift
//  OAuthTest
//
//  Created by 김진웅 on 1/22/24.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - UI Components

    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "person.circle")
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = "nickname"
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("click plz", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 20
        
        stack.addArrangedSubview(iconView)
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(loginButton)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let manager: GithubManager
    
    // MARK: - didSet

    var code: String? {
        didSet {
            guard let code = code else { return }
            
            manager.requestAccessToken(with: code) { self.accessToken = $0 }
        }
    }
    
    var accessToken: String? {
        didSet {
            guard let token = accessToken else { return }
            
            manager.getUser(accessToken: token) { (url, name) in
                self.manager.loadImageFromURL(url: url) { self.icon = $0 }
                self.text = name
            }
        }
    }
    
    var icon: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.iconView.image = self.icon
            }
        }
    }
    
    var text: String? {
        didSet {
            DispatchQueue.main.async {
                self.nameLabel.text = self.text
            }
        }
    }
    
    // MARK: - Initializer

    init(manager: GithubManager) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Configure UI

    private func configureUI() {
        view.backgroundColor = .white
        setConstraints()
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: safeArea.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            iconView.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor, multiplier: 1.0),
            
            loginButton.widthAnchor.constraint(equalTo: vStack.widthAnchor),
        ])
    }
    
    @objc
    private func loginButtonTapped(_ sender: UIButton) {
        manager.requestCode()
    }
    
    // MARK: - Swift Concurrency

    func fetchGithubUserInfo(with code: String) {
        Task {
            let token = try await manager.requestAccessToken(with: code)!
            let (imageURL, name) = try await manager.getUser(accessToken: token)!
            let icon = try await manager.loadImageFromURL(url: imageURL)!
            
            Task { @MainActor in
                iconView.image = icon
                nameLabel.text = name
            }
        }
    }
}

final class GithubManager {
    
    // TODO: 사용자 입력 필수!
    
    private let clientID = ""
    private let clientSecret = ""
    
    // 클라이언트 정보를 가지고 코드 받아오기
    func requestCode() {
        var urlComponents = URLComponents(string: "https://github.com/login/oauth/authorize")
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: clientID)
        ]
        guard let url = urlComponents?.url else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: - URLSession Completion

    // client 정보와 임시 코드를 가지고 토큰 받아오기
    func requestAccessToken(with code: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: "https://github.com/login/oauth/access_token") else { return }
        let parameters = ["client_id": clientID, "client_secret": clientSecret, "code": code]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any],
                  let token = json["access_token"] as? String
            else {
                return
            }
            completion(token)
        }.resume()
    }
    
    // github api에 요청하여 유저 정보 받아오기
    func getUser(accessToken: String, completion: @escaping ((URL, String)) -> Void) {
        guard let url = URL(string: "https://api.github.com/user") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let avatar_url = json["avatar_url"] as? String,
                  let imageURL = URL(string: avatar_url),
                  let name = json["name"] as? String
            else {
                return
            }
            completion((imageURL, name))
        }.resume()
    }
    
    // url로 이미지 받아오기
    func loadImageFromURL(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let image = UIImage(data: data)
            else {
                return
            }
            completion(image)
        }.resume()
    }
    
    // MARK: - Swift Concurrency
    
    // client 정보와 임시 코드를 가지고 토큰 받아오기 - Swift Concurrency
    func requestAccessToken(with code: String) async throws -> String? {
        guard let url = URL(string: "https://github.com/login/oauth/access_token") else { return nil }
        let parameters = ["client_id": clientID, "client_secret": clientSecret, "code": code]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let token = json["access_token"] as? String
        else {
            return nil
        }
        
        return token
    }
    
    // github api에 요청하여 유저 정보 받아오기 - Swift Concurrency
    func getUser(accessToken: String) async throws -> (URL, String)? {
        guard let url = URL(string: "https://api.github.com/user") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let avatar_url = json["avatar_url"] as? String,
              let imageURL = URL(string: avatar_url),
              let name = json["name"] as? String
        else {
            return nil
        }
        
        return (imageURL, name)
    }
        
    // url로 이미지 받아오기 - Swift Concurrency
    func loadImageFromURL(url: URL) async throws -> UIImage? {
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    }
}
