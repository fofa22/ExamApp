//
//  AddanExamVC.swift
//  ExamApp
//
//  Created by Fahhad Ashour on 10/21/17.
//  Copyright © 2017 Fahhad Ashour. All rights reserved.
//

import UIKit
import UserNotifications
class AddanExamVC: UIViewController, UNUserNotificationCenterDelegate {
	
	
	@IBOutlet weak var ExamTitle: UITextField!
	@IBOutlet weak var ExamLocation: UITextField!
	@IBOutlet weak var ExamDate: UITextField!
	@IBOutlet weak var TextView: UITextView!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		UNUserNotificationCenter.current().delegate = self
		
		// Do any additional setup after loading the view, typically from a nib.
		ExamTitle.delegate = self as? UITextFieldDelegate
		ExamLocation.delegate = self as? UITextFieldDelegate
		ExamDate.delegate = self as? UITextFieldDelegate
		var ExamTitleInput = ExamTitle.text
		var ExamLocationInput = ExamLocation.text
		var ExamDateInput = ExamDate.text
		
		 func prepare(for segue: UIStoryboardSegue, sender: Any?) {
			
			
			let DestVC : ExamAgenda1 = segue.destination as! ExamAgenda1
			
			if ExamTitleInput == nil{
				print("A7eah 2")
			}
			 else{
			var Exams: Exam
			Exams = Exam(ExamTitle: ExamTitleInput!, Location: ExamLocationInput!, Date: ExamDateInput!)
			
			var ExamLabel = DestVC.ExamCell.detailTextLabel
			 ExamLabel?.text = ExamTitleInput
			
			var ExamDateLabel = DestVC.ExamCell.textLabel
			ExamDateLabel?.text = ExamDateInput
			print(ExamTitleInput as Any,ExamLocationInput as Any,ExamDateInput as Any)
		}
		
		}

		
	}
	
	

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	

	@IBAction func ConfirmButton(_ sender: Any) {
		TextView.text = "Exam Title: \(ExamTitle.text!)\nExam Location: \(ExamLocation.text!)\nExam Date: \(ExamDate.text!)\n"
		
		// first option
		let FirstRespond = UNNotificationAction(identifier: "FirstRespond", title: "Got it!", options: UNNotificationActionOptions.foreground)
		// secound option
		let SecondRespond = UNNotificationAction(identifier: "SecondRespond", title: "Remind me in 2 mins", options: UNNotificationActionOptions.foreground)
		
		
		// setting up the notification category
		
		let AnswerCategory = UNNotificationCategory(identifier: "myCategory", actions: [FirstRespond,SecondRespond], intentIdentifiers: [], options: [])
		
		// installing the category into the current notification center
		
		UNUserNotificationCenter.current().setNotificationCategories([AnswerCategory])
		
		// creating the notification
		let content = UNMutableNotificationContent()
		content.title = ExamTitle.text!
		content.subtitle = ExamLocation.text!
		content.body = ExamDate.text!
		content.badge = 1
		
		// define a triger that will turn o the notification
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
		let request = UNNotificationRequest(identifier: "Timer done!", content: content, trigger: trigger)
		UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
		
			// Setting up the response function
		
		func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
			
			if response.actionIdentifier == "FirstRespond"{
				print ("Alright")
			}
				
			else{
				
				// re-creating the notification
				
				let content = UNMutableNotificationContent()
				content.title = ExamTitle.text!
				content.subtitle = ExamLocation.text!
				content.body = ExamDate.text!
				content.badge = 1
				let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
				let request = UNNotificationRequest(identifier: "Timer done!", content: content, trigger: trigger)
				UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
			}
		}

	}
	

	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		ExamDate.resignFirstResponder()
	}
		}

extension ViewController : UITextFieldDelegate{
	
	func textFieldShouldReturn(_ textFeild: UITextField) -> Bool{
		textFeild.resignFirstResponder()
		return true
}
	
}
