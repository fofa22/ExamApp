//
//  ExamAgenda1.swift
//  ExamApp
//
//  Created by Fahhad Ashour on 10/20/17.
//  Copyright © 2017 Fahhad Ashour. All rights reserved.
//

import UIKit
var ExamArray = [Exam]() // An array of exams
// protocol to preview Exams
protocol CellSelectedDelegate{
	func read(Exam: Exam)
}

// Protocol to Add or delete Exams
protocol DataUpdateDelegate {
	func delete(Exam: [Exam], DeeletedExam: [Exam])
	func AddExam (Exam: [Exam])
	
}


// has to conform to , DataUpdateDelegate below!

class ExamAgenda1: UITableViewController {
	
	@IBOutlet weak var ExamCell: UITableViewCell!

	
    override func viewDidLoad() {
        super.viewDidLoad()
		var Exams: Exam
 // ExamCell.textLabel = ExamTitleLabel // ExamLabel equals the string of ExamCell
		
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
		
		
		
		
    }
	
	@IBAction func AddExamButton(_ sender: Any) {
		//var ExamAdded: Exam
		//	ExamArray.append(ExamAdded)
	}
	
	
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ExamArray.count
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExamCell", for: indexPath)

        // Configure the cell...
		var selectedExam = ExamArray.first
		cell.textLabel?.text = selectedExam?.ExamTitle2
		cell.detailTextLabel?.text = selectedExam?.Date
		

        return cell
    }
	

	
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
	

	
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
	

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

	
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		let destVC: AddanExamVC = segue.destination as! AddanExamVC
		
		if destVC.ExamTitle.text == nil{
			print("a7eah")
		}else{
		var ExamLabel = destVC.ExamTitle?.text
		
		var ExamDateLabel = destVC.ExamDate?.text
		
		var ExamLocationLabel = destVC.ExamLocation?.text
			
			var Exams: Exam
			Exams = Exam(ExamTitle: ExamLabel!, Location: ExamLocationLabel!, Date: ExamDateLabel!)
			
			ExamArray.append(Exams)
		}
		
		

    }
*/
	
	
    
}
