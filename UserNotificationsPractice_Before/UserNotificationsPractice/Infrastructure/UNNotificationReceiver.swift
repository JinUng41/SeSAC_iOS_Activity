//
//  UNNotificationReceiver.swift
//  UserNotificationsPractice
//

import NotificationCenter

final class UNNotificationReceiver: NSObject {
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
}

extension UNNotificationReceiver: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
//        completionHandler([.banner, .sound, .badge])
         completionHandler([.banner])
        // 둘이 바꿔치기도 해보세요~
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let content = response.notification.request.content
        let userInfo = response.notification.request.content.userInfo
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let tabBar = UIApplication.shared.windows.first?.rootViewController as? UITabBarController,
              let inner = storyboard.instantiateViewController(withIdentifier: "InnerViewController") as? InnerViewController
        else {
            return
        }
        if let index = userInfo["index"] as? Int {
            tabBar.selectedIndex = index
            let navi = tabBar.viewControllers?[index] as? UINavigationController
            navi?.pushViewController(inner, animated: true)
            
            inner.loadViewIfNeeded()
            inner.notificationTitle.text = content.title
            inner.notificationBody.text = content.body
        }
        
        completionHandler()
    }
}
