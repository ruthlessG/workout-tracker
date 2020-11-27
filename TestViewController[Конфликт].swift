//
//  ViewController.swift
//  Workout3
//
//  Created by 108 on 23.03.16.
//
//

import UIKit

class TestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var exTableView: UITableView!
   
    @IBOutlet weak var controlView: UIView!
    
    @IBOutlet weak var pickerControl: UIPickerView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!

    // link constraints to hide pickerview
    @IBOutlet weak var controlViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pickerControlHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pickerControlTopConstraint: NSLayoutConstraint!

    
    /*
    This value is either passed by `DayTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new workout.
    */
    var workout: Workout?
    
    // 
    var exercises = [Exercise]()
    
    //
    var weight = Array(0...500)
    var reps = Array(1...100)

    // buffer to store weight and reps from picker for current set
    var buff_weight:String = ""
    var buff_reps:String = ""
    
    
    // array to store 'weight x reps' for current exercise
    // TODO: keep track of exercises to provide a personal set array for each
    var set:[String] = []
    
    
    // trying to get acces to the current weightxrepsLabel by knowing the corresponding exTextField
    var activeTextField = UITextField()
    var activeLabel = UILabel()
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        self.activeTextField = textField
        
        print("textFieldDidBeginEditing! textField = \(textField)")
    }
    
    
    // disable user interraction for text field after exercise name was written
    func textFieldDidEndEditing(textField: UITextField) {
        
        textField.userInteractionEnabled = false
        
        
        // show addSetButton
        self.controlViewHeightConstraint.constant = 48
        
        self.pickerControlHeightConstraint.constant = 0
        self.pickerControlTopConstraint.constant = 0
        
    }
    
    // this should hide keyboard when returned is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exTableView.delegate = self
        exTableView.dataSource = self
        
        pickerControl.delegate = self
        pickerControl.dataSource = self

        
        // hide the whole controlView
        self.controlViewHeightConstraint.constant = 0
        self.pickerControlHeightConstraint.constant = 0
        self.pickerControlTopConstraint.constant = 0
        
        
        
        // Set up views if editing an existing Workout.
        if let workout = workout {
            
            self.title = workout.name
            exercises = workout.exercises
            
        }
        else {
            // Set title
            self.title = "Workout \(day_counter + 1)"
            //self.title = "Workout \(workout.count)"
        }
        
        //loadSampleExercises()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadSampleExercises() {
        
        let exercise1 = Exercise(name: "Dead Lift", setsxreps: " 100 x 8, 110 x 6, 115 x 4")!
        let exercise2 = Exercise(name: "Bench Press", setsxreps: " 80 x 10, 85 x 8")!
        
        exercises += [exercise1, exercise2]
    }

    
    /*
    // method to append data in tableview
    
    func insertData(appendExercises:[Exercise]) {
        var currentCount = 0
        var indexesPath = [NSIndexPath]()
        for _ in appendExercises {
            let index = NSIndexPath(forRow: currentCount, inSection: 0)
            indexesPath.append(index)
            currentCount++
        }
        
        self.exTableView.beginUpdates()
        self.exTableView.insertRowsAtIndexPaths(indexesPath, withRowAnimation: UITableViewRowAnimation.Bottom)
        self.exTableView.endUpdates()
    }
    */
    
    
    // MARK: Setup UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return exercises.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ExTableViewCell"
        
        // тут поменял tableView на exTableView
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ExTableViewCell
        
        // Fetches the appropriate exercise for the data source layout.
        let exercise = exercises[indexPath.row]
        
        cell.exTextField.text = exercise.name
        cell.weightxrepsLabel.text = exercise.setsxreps


        return cell
    }
    
    // set different colors for even and odd rows
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        if (indexPath.row % 2 == 0)
        {
            cell.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.whiteColor()
        }
    }
    
    
    // configure row's onclick performance
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow!
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as! ExTableViewCell
        
        print("\(currentCell.weightxrepsLabel!.text)")
        
        
        currentCell.exTextField.userInteractionEnabled = true
        currentCell.exTextField.becomeFirstResponder()

    }

    
    
    // MARK: Setup UIPickerViewDataSource
    
    // configure columns
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        if component == 0 {
            return String(weight[row])
        }
        else if component == 1 {
            return "kg"
        }
        else if component == 2 {
            return String(reps[row])
        }
        else {
            return "reps"
        }
    }
    
    // configure rows
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return weight.count
        }
        else if component == 2 {
            return reps.count
        }
        else {
            return 1
        }
    }
    
    // set number of columns to display
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 4
    }
    
    
    // 
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            if row > 0 {
                buff_weight = String(row)
            }
            else {
                buff_weight = ""
                //buff_weight = "bodyweight"
            }
        }
        else if component == 2 {
            buff_reps = String(row + 1)
        }
    }
    
    // MARK: Actions
    @IBAction func addSetButton(sender: AnyObject) {

        
        // show picker
        self.controlViewHeightConstraint.constant = 160
        
        self.pickerControlTopConstraint.constant = 8
        
        self.pickerControlHeightConstraint.constant = 104
        


        // if a row is selected - change setsxrepsLabel
        if exTableView.indexPathForSelectedRow != nil {

            
            
            // check if anything was selected
            if buff_weight != "" || buff_reps != "" {
                

                
                set.append(" \(buff_weight) x \(buff_reps)")
                
                let indexPath = exTableView.indexPathForSelectedRow!
                
                let currentCell = exTableView.cellForRowAtIndexPath(indexPath)! as! ExTableViewCell
                
                if [set] != "" {
                    currentCell.weightxrepsLabel!.text = "\(set.joinWithSeparator(","))"
                }
                
            }
        }

        /*
        print("\(self.activeTextField.text)")
        //self.activeTextField.text = "foobar"
        //print("\(self.activeTextField.text)")
        */
        
    }
    
    // 'add exercise' button
    @IBAction func addEx(sender: AnyObject) {

        // hide whole controlTable
        self.controlViewHeightConstraint.constant = 0
        self.pickerControlHeightConstraint.constant = 0
        self.pickerControlTopConstraint.constant = 0
        
        
        // add finished exercises to object array
        if exTableView.indexPathForSelectedRow != nil {
        
            
            let indexPath = exTableView.indexPathForSelectedRow!
            let currentCell = exTableView.cellForRowAtIndexPath(indexPath)! as! ExTableViewCell
        
            let curr_ex = Exercise(name: "\(currentCell.exTextField.text!)", setsxreps: "\(currentCell.weightxrepsLabel.text!)")
        
            //exercises.append(curr_ex!)
           
            /*
            print("exercises.count = \(exercises.count)")
            print("exercises: \(exercises)")
            exercises[exercises.count-1] = curr_ex!
            
            // Update Table Data (end edit of current ex)
            exTableView.beginUpdates()
            
            exTableView.insertRowsAtIndexPaths([
                NSIndexPath(forRow: exercises.count-1, inSection: 0)
                ], withRowAnimation: .Automatic)
            exTableView.endUpdates()
            */
            
            
            /*
            // removing last added ex from array
            exercises.removeLast()
            print("just used removeLast() and now exercises = \(exercises)")
            */
            
            exercises[exercises.endIndex - 1] = curr_ex!
            print("tried to modify last member of exercises = \(exercises)")
            
            
            exTableView.beginUpdates()
            /*
            exTableView.insertRowsAtIndexPaths([
                NSIndexPath(forRow: exercises.count-1, inSection: 0)
                ], withRowAnimation: .Automatic)
            
            //exTableView.reloadData()
           */
            exTableView.endUpdates()
            
        }


        // reset 'set buffer' when the next exercise is added
        set = []
        buff_reps = ""
        buff_weight = ""
        
        
        // add a 'blank' for the new exercise to the array
        let blank = Exercise(name: "", setsxreps: "")!
        exercises.append(blank)

        // Update Table Data (when inser new 'blank' exercise
        exTableView.beginUpdates()
        exTableView.insertRowsAtIndexPaths([
            NSIndexPath(forRow: exercises.count-1, inSection: 0)
            ], withRowAnimation: .Automatic)
        exTableView.endUpdates()
        
        //print("set: \(set)")
        print("just added exercise and exercises = \(exercises)")
    
    }
    
    
    // MARK: Navigation
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            
            let name = self.title ?? ""
            let date = curr_time()
            let exercises = self.exercises
            
            
            workout = Workout(name: name, date: date, exercises: exercises)
            
            //day_counter++
            
            // Set the meal to be passed to MealTableViewController after the unwind segue.
        }
    }

    
}
