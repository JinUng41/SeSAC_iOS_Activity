//
//  Category.swift
//  CoreData_Starter
//

enum Category: Int {
    case catchphrase
    case dadJoke
    
    var cellIdentifier: String {
        switch self {
        case .catchphrase: "CatchphraseCell"
        case .dadJoke: "DadJokeCell"
        }
    }
}
