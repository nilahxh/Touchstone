//
//  ViewController.swift
//  PartyPLanner
//
//  Created by Anila Elisabetta Hoxha on 11/5/18.
//  Copyright © 2018 Anila Elisabetta Hoxha. All rights reserved.
import UIKit

class ViewController: UIViewController {
    
    @IBAction func meditation(_ sender: Any) {
        performSegue(withIdentifier: "meditation", sender: self)
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var plusButton: UIBarButtonItem!
    var toDoArray = ["Tuesday", "Wednesday", "Thursday"]
    var toDoNotesArray = ["Today was an amazing day, despite it being very very long.", "I was feeling a little bit overwhelmed with the homework, so I decided to cancel some plans in order to get everything done", "The code wasn't running, because I had accidentally deleted something, and it was stressing me out. Fortunately, I solved it."]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editItem"{
            let destination = segue.destination as!DetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            destination.toDoItem = toDoArray[index]
            destination.toDonoteItem = toDoNotesArray[index]
        } else{
            if let selectedPath = tableView.indexPathForSelectedRow{
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
        
    }
    
    @IBAction func unwindfromDetainViewController(segue: UIStoryboardSegue){
        let sourceViewController = segue.source as! DetailViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            toDoArray[indexPath.row] = sourceViewController.toDoItem!
            toDoNotesArray[indexPath.row] = sourceViewController.toDonoteItem!
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
            toDoArray.append(sourceViewController.toDoItem!)
            toDoNotesArray.append(sourceViewController.toDonoteItem!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
    }
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            plusButton.isEnabled = true
            editBarButton.title = "Edit"
        }else {
            tableView.setEditing(true, animated: true)
            plusButton.isEnabled = false
            editBarButton.title="Done"
        }
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    //we will put all our table view code here
    //tells the data source to return the nr of rows in a given section of the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    //asks the data source for a cell to insert in a particular location of the data view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        cell.detailTextLabel?.text = toDoNotesArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            toDoArray.remove(at: indexPath.row)
            toDoNotesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = toDoArray[sourceIndexPath.row]
        let noteToMove = toDoNotesArray[sourceIndexPath.row]
        toDoArray.remove(at: sourceIndexPath.row)
        toDoNotesArray.remove(at: sourceIndexPath.row)
        toDoArray.insert(itemToMove, at:destinationIndexPath.row)
        toDoNotesArray.insert(noteToMove, at:destinationIndexPath.row)
    }
}

