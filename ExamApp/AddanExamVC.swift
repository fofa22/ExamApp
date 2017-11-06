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
	let datePicker = UIDatePicker()
	
	var UserData = false
	var ExamTitleInput = ""
	var ExamLocationInput = ""
	var ExamDateInput = ""
	var components = DateComponents()
	
	override func viewDidLoad() {
	
		
		super.viewDidLoad()
		
		UNUserNotificationCenter.current().delegate = self

		createDatePicker()
		
		
		
		// Do any additional setup after loading the view, typically from a nib.
		ExamTitle.delegate = self as? UITextFieldDelegate
		ExamLocation.delegate = self as? UITextFieldDelegate
		ExamDate.delegate = self as? UITextFieldDelegate
		
		
		
	}
	
		func createDatePicker(){
		// Formating for the date picker
		datePicker.datePickerMode = .dateAndTime
		
		// Creating toolbar
		let toolBar = UIToolbar()
		toolBar.sizeToFit()
		
		// Creating bar button
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(DonePressed))
		toolBar.setItems([doneButton], animated: false)
		
		
		// adding tool bar to the date Picker variable
		ExamDate.inputAccessoryView = toolBar
		
		// Assiging ate picker to text feild
		ExamDate.inputView = datePicker
		
	}
	
	// creating the function for Done button in date picker
	
	func DonePressed(){
		// formating the date in text feild
		let dateFormater = DateFormatter()
		dateFormater.dateStyle = .short
		dateFormater.timeStyle = .short
		ExamDate.text = dateFormater.string(from: datePicker.date)
		self.view.endEditing(true)
	}
	
	

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func ConfirmButton(_ sender: Any) {
		
	
		// Appending text to ExamAgenda1 & testing for data presence:
		TextView.text = "Exam Title: \(ExamTitle.text!)\nExam Location: \(ExamLocation.text!)\nExam Date: \(ExamDate.text!)\n"
		
		
		
	
		
		if ExamTitle.text! == "" {
			ExamTitle.backgroundColor = UIColor.red
			ExamLocation.backgroundColor = UIColor.white
			ExamDate.backgroundColor = UIColor.white
		}else if ExamLocation.text == "" {
			ExamLocation.backgroundColor = UIColor.red
			ExamTitle.backgroundColor = UIColor.white
			ExamDate.backgroundColor = UIColor.white
		} else if ExamDate.text! == "" {
			ExamDate.backgroundColor = UIColor.red
			ExamTitle.backgroundColor = UIColor.white
			ExamLocation.backgroundColor = UIColor.white
		} else {
			ExamTitle.backgroundColor = UIColor.white
			ExamLocation.backgroundColor = UIColor.white
			ExamDate.backgroundColor = UIColor.white
			ExamTitleInput.append(ExamTitle.text!)
			ExamLocationInput.append(ExamLocation.text!)
			ExamDateInput.append(ExamDate.text!)
			UserDefaults.standard.set(ExamTitleInput, forKey: "ExamTitle")
			UserDefaults.standard.set(ExamLocationInput, forKey: "ExamLocation")
			UserDefaults.standard.set(ExamDateInput, forKey: "ExamDate")
			UserDefaults.standard.synchronize();
			
			
			var Examz = Exam(ExamTitle: ExamTitleInput, Location: ExamLocationInput, Date: ExamDateInput)
			
			ExamArray.append(Examz)
			
			// uncomment the following line to allow VC dismiss
			/*
			//performSegue(withIdentifier: "CON", sender: self)
			*/
			
			dismiss(animated: true, completion: nil)
			
			

			
		}

		
		var alertView = UIAlertController(title: "Confirmation", message: "Your Exam: \(ExamTitleInput) has been added", preferredStyle: UIAlertControllerStyle.alert)
		alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
			self.dismiss(animated: true, completion: nil)
		}))
		
		self.present(alertView, animated: true, completion: nil);
		
		// the below section is originally right afer the button !
		// creating the notification
		
		let content = UNMutableNotificationContent()
		content.title = "Your Exam: \(ExamTitle.text!) is up!"
		content.subtitle = "Your Exam location is: \(ExamLocation.text!)"
		content.body =  "Your Exam date is on the \(ExamDate.text!)"
		content.badge = 1
		content.categoryIdentifier = "AnswerCategory"
		
			// define a triger that will turn on the notification based on user date input
		
		// first get the date:
		
		var dateFormater = DateFormatter()
		
		dateFormater.dateFormat = "MM - dd - yyyy'T'HH:mm.ss.SSSZ"
		dateFormater.timeZone = TimeZone.current
		let dateForm = dateFormater.date(from: ExamDateInput)
		print("\(dateForm)")
/*
		// assign the date components to a variable
		if dateForm == nil{
			print("Didnt get the date")
		}else{
			components = Calendar.current.dateComponents([.month,.day,.year, .hour, .minute, .second], from: dateForm!)
		}
		
		// creat a date component and intialise it with the user date input
		var date = DateComponents()
		date.month = components.month
		date.day = components.day
		date.year = components.year
		date.hour = components.hour
		date.minute = components.minute
		date.second = components.second


		let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)

		
		//let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
		
		
		let request = UNNotificationRequest(identifier: "ExamTime", content: content, trigger: trigger)
		
		 UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
		
		/*
		UNUserNotificationCenter.current().add(request) { (error: Error?) in
			if error == nil{
				print("notification scheduled", trigger.nextTriggerDate()?.addingTimeInterval(5) ?? "Date nil")
			}else{
				print("Error Scheduling the notification", error?.localizedDescription ?? "" )
			}
		}
		*/
		*/
		
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
		
		let request = UNNotificationRequest(identifier: "ExamTime", content: content, trigger: trigger)
		
		UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
		// Setting up the response function
		
		func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
			
			switch response.actionIdentifier {
				
				case "FirstRespond" :
				print ("1st")
				let alert = UIAlertController(title: "feedback", message: "will remind you in 2 mins", preferredStyle: .alert)
				let action = UIAlertAction(title: "Sure", style: .default, handler: nil)
				alert.addAction(action)
				
				present(alert, animated: true, completion: nil)
				
				case "SecondRespond" :
				print ("2nd")
				let alert = UIAlertController(title: "feedback", message: "sure!", preferredStyle: .alert)
				let action = UIAlertAction(title: "Sure", style: .cancel, handler: nil) // added ancel instead of default!
				alert.addAction(action)
				present(alert, animated: true, completion: nil)
				
				// regenrating a new notification based on user input
				// *****
				/*
				let content2 = UNMutableNotificationContent()
				content2.title = "Your Exam: \(ExamTitle.text!) is up!"
				content2.subtitle = "Your Exam location is: \(ExamLocation.text!)"
				content2.body =  "Your Exam date is on the \(ExamDate.text!)"
				content2.badge = 1
				
				let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
				
				
				let request2 = UNNotificationRequest(identifier: "its Exam time", content: content2, trigger: trigger2)
				
				UNUserNotificationCenter.current().add(request2, withCompletionHandler: nil)
				*/
				// *****

			default:
				break
			}
			
		}
		
	}

	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler:(UNNotificationPresentationOptions) -> Void) {
		completionHandler([.alert, .badge,.sound])
	}

	
	func getAllPendingNotifications(completion:@escaping ([UNNotificationRequest]?)->Void){
		
		
		UNUserNotificationCenter.current().getPendingNotificationRequests { (requests:[UNNotificationRequest]) in
			return completion(requests)
		}
		
		
	}
	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		ExamDate.resignFirstResponder()
	}
		}

// reviewing input extension:

extension ViewController : UITextFieldDelegate{
	
	func textFieldShouldReturn(_ textFeild: UITextField) -> Bool{
		textFeild.resignFirstResponder()
		return true
	}
	
}



func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	
	let destEAVC = segue.destination as! ExamAgenda1
	
	var	CurrentRow = ExamTitleInput.endIndex
	
	destEAVC.ExamCell.textLabel?.text = ExamArray[CurrentRow].ExamTitle2

	destEAVC.ExamCell.detailTextLabel?.text = ExamArray[CurrentRow].Date
	
			let backButton = UIBarButtonItem(barButtonSystemItem:.save, target: destEAVC, action: #selector(destEAVC.backAction(_:)))
			
			destEAVC.navigationItem.leftBarButtonItem = backButton

	 destEAVC.updateFocusIfNeeded()

}

