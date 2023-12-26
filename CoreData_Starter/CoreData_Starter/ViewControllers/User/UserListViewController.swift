//
//  UserListViewController.swift
//  CoreData_Starter
//

import UIKit

class UserListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateAllCells(self.fetchCoreData())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let userSaveViewController = segue.destination as? UserSaveViewController else { return }
        userSaveViewController.userDataDelegate = self
        userSaveViewController.userViewDelegate = self
    }
    
    @IBSegueAction func showJokeList(_ coder: NSCoder, sender: Any?) -> JokeTabBarController? {
        let user = sender as! User
        return JokeTabBarController(user: user, coder: coder)
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedUser = users[indexPath.row]
        performSegue(withIdentifier: "showJokeList", sender: selectedUser)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let updateActionHandler = { (
            _: UIContextualAction,
            _: UIView,
            completion: @escaping (Bool) -> Void
        ) in
            completion(true)
            self.showUserInputAlert() { userInput in
                guard let userInput = userInput else { return }
                var userToUpdate = self.users[indexPath.row]
                userToUpdate.name = userInput
                self.updateCoreData(userToUpdate)
                self.reloadCell(userToUpdate)
            }
        }
        
        let deleteActionHandler = { (
            _: UIContextualAction,
            _: UIView,
            completion: @escaping (Bool) -> Void
        ) in
            completion(true)
            let userToDelete = self.users[indexPath.row]
            self.deleteCoreData(userToDelete)
            self.deleteCell(userToDelete)
        }
        
        let updateAction = UIContextualAction(style: .normal, title: nil, handler: updateActionHandler)
        let deleteAction = UIContextualAction(style: .destructive, title: nil, handler: deleteActionHandler)
        
        updateAction.image = UIImage(systemName: "pencil")
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
    }
    
    private func showUserInputAlert(_ completionHandler: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: "이름 수정", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        let submit = UIAlertAction(title: "수정", style: .default) { _ in
            completionHandler(alert.textFields?.first?.text)
        }
        
        alert.addTextField { textField in textField.placeholder = "수정할 이름을 입력해주세요." }
        alert.addAction(cancel)
        alert.addAction(submit)
        
        self.present(alert, animated: true)
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { users.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}

extension UserListViewController: CellUpdatable {
    func updateAllCells(_ data: [User]) {
        self.users = data
        guard let tableView = self.tableView else { return }
        tableView.reloadData()
    }
    
    func insertCell(_ data: User) {
        self.users.append(data)
        let indexPath = self.getCurrentIndexPath(data)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func reloadCell(_ data: User) {
        let indexPath = self.getCurrentIndexPath(data)
        self.users[indexPath.row] = data
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func deleteCell(_ data: User) {
        let indexPath = self.getCurrentIndexPath(data)
        self.users.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func getCurrentIndexPath(_ data: User) -> IndexPath {
        guard let userIndex = self.users.firstIndex(where: { user in
            user.id == data.id
        }) else { return IndexPath() }
        
        return IndexPath(row: userIndex, section: 0)
    }
}
