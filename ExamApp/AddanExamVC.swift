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
	
	override func viewDidLoad() {
	
		
		super.viewDidLoad()
		
		createDatePicker()
		
		UNUserNotificationCenter.current().delegate = self
		
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
		
		// probe into this ?? why is the user data rewritten permiantly ??
		UserData = true
		UserDefaults.standard.set(UserData, forKey: "UserData" )
		
		
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
			
	//performSegue(withIdentifier: "CON", sender: self)
			
			//dismiss(animated: true, completion: nil)
			if selectedRowMTVC == "Exam Folder"{
			ExamDictionary[selectedRowMTVC] = ExamArray
				print("The Date now is \(ExamDate.text!)")
				
				
			}else if selectedRowMTVC == "Trash"{
				ExamDictionary[selectedRowMTVC] = DeletedExams
				print("The Deleted Date now is \(ExamDate.text!)")
				
				
			}

			// Tried to append email directly but failed because default NS function cannot transfer exams class
			//ExamArray.append(Exam(ExamTitle: ExamTitle.text!, Location: ExamLocation.text!, Date: ExamDate.text!))
			//UserDefaults.standard.set(ExamArray, forKey: "TheExamArray" )
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
	
		// define a triger that will turn o the notification
		
		// first get the date:
		
			var dateFormater = DateFormatter()
			
			dateFormater.dateFormat = "MM - dd - yyyy'T'HH:mm.ss.SSSZ"
			dateFormater.timeZone = NSTimeZone(name: "UTC") as! TimeZone
			let dateForm = dateFormater.date(from: ExamDateInput)
		print("\(dateForm)")
		
		 var date = DateComponents()
		 //date.hour = 8
		 //date.minute = 30
		date.second = 5
		
		let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
		
		
		let request = UNNotificationRequest(identifier: "its Exam time", content: content, trigger: trigger)
		
		UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
		
		// intialising the notification:
		// first option
		let FirstRespond = UNNotificationAction(identifier: "FirstRespond", title: "Got it!", options: UNNotificationActionOptions.foreground)
		// secound option
		let SecondRespond = UNNotificationAction(identifier: "SecondRespond", title: "Remind me in 2 mins", options: UNNotificationActionOptions.foreground)
		
		
		// setting up the notification category
		
		let AnswerCategory = UNNotificationCategory(identifier: "myCategory", actions: [FirstRespond,SecondRespond], intentIdentifiers: [], options: [])
		
		// installing the category into the current notification center
		
		UNUserNotificationCenter.current().setNotificationCategories([AnswerCategory])
		
		
		
		
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

