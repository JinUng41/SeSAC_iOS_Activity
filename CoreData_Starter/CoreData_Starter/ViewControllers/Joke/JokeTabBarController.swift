//
//  JokeTabBarController.swift
//  CoreData_Starter
//

import UIKit

class JokeTabBarController: UITabBarController {
    var currentUser: User
    
    init?(user: User, coder: NSCoder) {
        self.currentUser = user
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewControllers?.forEach { viewController in
            guard let jokeListViewController = viewController as? JokeListViewController else { return }
            jokeListViewController.jokeDataDelegate = self
            let fetchedJokes: [Joke] = self.fetchWithPredicate(currentUser: currentUser, currentCategory: jokeListViewController.currentTabCategory)
            jokeListViewController.updateAllCells(fetchedJokes)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let jokeSaveViewController = segue.destination as? JokeSaveViewController else { return }
        jokeSaveViewController.jokeDataDelegate = self
        self.viewControllers?.forEach { viewController in
            guard let jokeListViewController = viewController as? JokeListViewController else { return }
            switch jokeListViewController.currentTabCategory {
            case .catchphrase:
                jokeSaveViewController.catchphraseViewDelegate = jokeListViewController
            case .dadJoke:
                jokeSaveViewController.dadJokeViewDelegate = jokeListViewController
            }
        }
    }
    
    @IBSegueAction func showJokeSaveView(_ coder: NSCoder) -> JokeSaveViewController? {
        return JokeSaveViewController(currentUser: self.currentUser, coder: coder)
    }
}
