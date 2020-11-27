//
//  DayTableViewController.swift
//  Workout3
//
//  Created by 108 on 24.03.16.
//
//

import UIKit

class DayTableViewController: UITableViewController {
    
    
    // MARK: Properties
    
    // storage for all workouts
    var workouts = [Workout]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

       // loadSampleWorkouts()
        
    }
    
    
    // same func to load exercises to sample workout
     var exercises1 = [Exercise]()
    
    func loadSampleExercises() {
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 15))
        label1.layer.borderWidth = 1
        label1.layer.borderColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0).cgColor
        label1.layer.cornerRadius = 5
        label1.center = CGPoint(x: 36, y: 8)
        label1.textAlignment = NSTextAlignment.center
        label1.text = "50 x 14"
        
        let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 15))
        label2.layer.borderWidth = 1
        label2.layer.borderColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0).cgColor
        label2.layer.cornerRadius = 5
        label2.center = CGPoint(x: 108, y: 8)
        label2.textAlignment = NSTextAlignment.center
        label2.text = "55 x 12"
        
        let label3 = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 15))
        label3.layer.borderWidth = 1
        label3.layer.borderColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0).cgColor
        label3.layer.cornerRadius = 5
        label3.center = CGPoint(x: 180, y: 8)
        label3.textAlignment = NSTextAlignment.center
        label3.text = "60 x 10"
        
        let exercise1 = Exercise(name: "Bench Press", setsxreps: " 50 x 14, 55 x 12, 60 x 10", xlabel: 236, ylabel: 0, labelRows: 1, labelArray: [label1, label2, label3])!

        
        let exercise2 = Exercise(name: "Tricep Pulldown", setsxreps: " 20 x 14, 25 x 12, 30 x 10", xlabel: 20, ylabel: 0, labelRows: 1, labelArray: [])!
        
        exercises1 += [exercise1, exercise2]
    }
    
    func loadSampleWorkouts() {
       
        loadSampleExercises()
        let workout1 = Workout(name: "Workout 1", date: "Apr 09, 2016", exercises: exercises1)!
        
        workouts += [workout1]
        
        day_counter = workouts.count
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DayTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DayTableViewCell
        
        // Fetches the appropriate exercise for the data source layout.
        let workout = workouts[(indexPath as NSIndexPath).row]
        
        cell.dayLabel.text = workout.name
        
        
        cell.dateLabel.text = workout.date

        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetail" {
            
            let workoutDetailViewController = segue.destination as! TestViewController
            // Get the cell that generated this segue.
            if let selectedWorkoutCell = sender as? DayTableViewCell {
                
                let indexPath = tableView.indexPath(for: selectedWorkoutCell)!
                let selectedWorkout = workouts[(indexPath as NSIndexPath).row]
                workoutDetailViewController.workout = selectedWorkout
                
                print("Openining selected workout..")
            }
            
        }
        else if segue.identifier == "AddWorkout" {
            print("Adding new workout.")
        }
    }
    
    
    
    // row deleting 
    

    // this method handles row deletion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // remove the item from the data model
            workouts.remove(at: indexPath.row)
            
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Not used in our example, but if you were adding a new row, this is where you would do it.
        }
    }
    
    
    
    

    
    @IBAction func unwindToWorkoutList(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? TestViewController, let workout = sourceViewController.workout {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                workouts[(selectedIndexPath as NSIndexPath).row] = workout
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            
            else {
                // Add a new Workout.
                // adjust workouts counter
                day_counter += 1
                
                let newIndexPath = IndexPath(row: workouts.count, section: 0)
                workouts.append(workout)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
        }
    }
    
    
    
}
