//
//  ExamVC.swift
//  ExamApp
//
//  Created by Fahhad Ashour on 10/21/17.
//  Copyright © 2017 Fahhad Ashour. All rights reserved.
//

import UIKit

class ExamVC: UIViewController, CellSelectedDelegate{
	// Add the text fields for the Exam data
	// @IBOutlet weak var titleLabel: UILabel!
	// @IBOutlet weak var senderLabel: UILabel!
	// @IBOutlet weak var contentsLabel: UILabel!
	
	
	// var dataDictionary: [String:Array<Email>] = [:]
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// Comply to the cellselectedProtocol to read Exams
	
	func read(Exam: Exam){
		//read this Exam
		// Assign each exam data to its correct label
	/*
		titleLabel.text = email.subject
		senderLabel.text = email.sender
		contentsLabel.text = email.contents
*/
}
	/*
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Destination for data coming from the Exam agenda
		var DestEAVC : ExamAgenda1 = segue.destination as! ExamAgenda1
	}
*/
}
