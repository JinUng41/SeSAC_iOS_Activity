//
//  SettingViewController.swift
//  UserNotificationsPractice
//

import UIKit

final class SettingViewController: UIViewController {
    
    @IBOutlet var notificationTitle: UITextField!
    @IBOutlet var notificationBody: UITextField!
    @IBOutlet var secondBeforeNotification: UITextField!
    
    let center = UNUserNotificationCenter.current()
    
    private func configureData() -> (String, String, TimeInterval)? {
        guard let title = notificationTitle.text,
              let body = notificationBody.text,
              let secondText = secondBeforeNotification.text,
              let second = TimeInterval(secondText)
        else {
            return nil
        }
        return (title, body, second)
    }
    
    @IBAction func sendLocalNotification(_ sender: UIButton) {
        guard let (title, body, second) = configureData() 
        else {
            return
        }
        center.getNotificationSettings { [weak self] setting in
            guard let self else { return }
            switch setting.authorizationStatus {
            case .authorized:
                self.sendLocalNotification(
                    title: title,
                    body: body,
                    second: second
                )
            default:
                self.requestNotificationAuthorization() { granted in
                    guard granted else { print("사용자가 원하지 않는데요 😢"); return }
                    self.sendLocalNotification(
                        title: "너 미쳤어?",
                        body: "이젠 나도 모르겠다~",
                        second: TimeInterval(1)
                    )
                }
            }
        }
    }
    
    private func requestNotificationAuthorization(completion: @escaping (Bool) -> Void) {
        center.requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { granted, error in
            if let error = error { fatalError(error.localizedDescription) }
            completion(granted)
        }
    }
    
    private func sendLocalNotification(title: String, body: String, second: TimeInterval) {
        let contents = UNMutableNotificationContent().then {
            $0.title = title
            $0.body = body
            $0.sound = UNNotificationSound.default
            $0.userInfo = ["index": 1]
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: second, repeats: false)
        
        let request = UNNotificationRequest(identifier: "이제는 우리가 헤어져야 할 시간", content: contents, trigger: trigger)

        center.add(request) { error in
            guard let error = error else { return }
            print(error)
        }
    }
}
