//
//  ViewController.swift
//  ExamApp
//
//  Created by Fahhad Ashour on 10/19/17.
//  Copyright © 2017 Fahhad Ashour. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController, UNUserNotificationCenterDelegate {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
			if didAllow {
				print("Allowed")
			}else{
				print("a7eah")
			}
		})
		
	}
	@IBAction func GoToExamButton(_ sender: Any) {
		/*
		let content = UNMutableNotificationContent()
		content.title = "The 5 seconds are up!"
		content.subtitle = "They are up now!"
		content.body = "A7eah 3alena!"
		content.badge = 1
		
		// define a triger that will turn o the notification
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
		let request = UNNotificationRequest(identifier: "Timer done!", content: content, trigger: trigger)
		UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
*/
	}
	

	
	//func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable : Any]? = nil)
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

