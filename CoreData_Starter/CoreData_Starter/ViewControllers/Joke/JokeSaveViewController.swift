//
//  JokeSaveViewController.swift
//  CoreData_Starter
//

import UIKit

class JokeSaveViewController: UIViewController {
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    @IBOutlet weak var jokeTextField: UITextField!
    
    weak var jokeDataDelegate: (any CoreDataManagable<Joke>)? = nil
    weak var catchphraseViewDelegate: (any CellUpdatable<Joke>)? = nil
    weak var dadJokeViewDelegate: (any CellUpdatable<Joke>)? = nil
    
    var currentUser: User
    var selectedCategory: Category {
        Category(rawValue: categorySegmentedControl.selectedSegmentIndex)!
    }
    
    init?(currentUser: User, coder: NSCoder) {
        self.currentUser = currentUser
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func saveJoke(_ sender: UIButton) {
        let newJoke = Joke(
            id: UUID(),
            content: jokeTextField.text!,
            category: selectedCategory
        )
        
        jokeDataDelegate?.saveCoreData(currentUser: currentUser, newJoke)
        
        switch selectedCategory {
        case .catchphrase:
            catchphraseViewDelegate?.insertCell(newJoke)
        case .dadJoke:
            dadJokeViewDelegate?.insertCell(newJoke)
        }

        self.dismiss(animated: true)
    }
}
