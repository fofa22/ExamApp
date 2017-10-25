//
//  ExamAgenda.swift
//  ExamApp
//
//  Created by Fahhad Ashour on 10/19/17.
//  Copyright © 2017 Fahhad Ashour. All rights reserved.
//

import UIKit

class ExamAgenda: UITableViewController{
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	@IBAction func addExam(_ sender: UIBarButtonItem) {
		
		let ExamAdded = Exam(ExamTitle: String, Location: String, Date: String)
		
		Exam.append(ExamAdded)
	}

	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	


}
