//
//  MenuTVC.swift
//  ExamApp
//
//  Created by Fahhad Ashour on 10/21/17.
//  Copyright © 2017 Fahhad Ashour. All rights reserved.
//

import UIKit

var selectedRowMTVC = ""

var ExamDictionary = ["Exam Folder": [Exam](),"Trash": [Exam]()]
class MenuTVC: UITableViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 2
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath)

        // Configure the cell...
		let  FoldersArray =  Array(ExamDictionary.keys)
		cell.textLabel?.text = FoldersArray[indexPath.row]

        return cell
    }
    
 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	//TODO: react to user selecting row
	//I want the detail view controller to update based on the row that I selected
	
	print("In didSelectRowAt")
	//TODO: get cell information
	
	let  FoldersArray =  Array(ExamDictionary.keys)
	print("\(FoldersArray)")
	
	selectedRowMTVC = FoldersArray[indexPath.row]

	print("\(selectedRowMTVC)")
	performSegue(withIdentifier: "pushTitle", sender: self)
	
	}

	
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
	
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

   //  In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
	
	let DestVC2 = segue.destination as! ExamAgenda1
	
	DestVC2.navigationItem.title = selectedRowMTVC
	print("\(selectedRowMTVC)")
	
	if( selectedRowMTVC == "Exam Folder"){
		let Addition = UIBarButtonItem(barButtonSystemItem: .add, target: DestVC2, action: #selector(DestVC2.AddExamButton(_:)))
		DestVC2.navigationItem.rightBarButtonItem = Addition
		ExamDictionary[selectedRowMTVC] = ExamArray
		
	}  else if( selectedRowMTVC == "Trash"){
		DestVC2.navigationItem.rightBarButtonItem = DestVC2.editButtonItem

		ExamDictionary[selectedRowMTVC] = DeletedExams
		
	}
	
	
	}
	
	
}
