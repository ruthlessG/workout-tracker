//
//  TestViewController.swift
//  This is a view controller for workout details view
//  "Workout tracker app"
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
    
    @IBOutlet weak var addSetButton: UIButton!
    
    
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
    var gramm = Array(0...9)
    
    // buffer to store weight and reps from picker for current set
    var buff_weight:String = ""
    var buff_reps:String = ""
    var buff_gramm:String = ""
    
    
    // TODO: keep track of exercises to provide a personal array for each
    var set:[String] = []
    
    
    // trying to get acces to the current weightxrepsLabel by knowing the corresponding exTextField
    var activeTextField = UITextField()
    var activeLabel = UILabel()
    
    
    
    // label array
    
    var cellLabelArray:[String] = []
    
    var spacer: CGFloat = 20
    
    var ySpacer:CGFloat = 0
    
    var row_count: CGFloat = 1
    
    var labelArrayBuff: [UILabel] = []
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.activeTextField = textField
        
        print("textFieldDidBeginEditing! textField = \(textField)")
    }
    
    
    // disable user interraction for text field after exercise name was written
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.isUserInteractionEnabled = false
        
        
        /// Here changed that picker appear instead of button when text editing is finished
        
        /*
        // show addSetButton
        self.controlViewHeightConstraint.constant = 48
        
        self.pickerControlHeightConstraint.constant = 0
        self.pickerControlTopConstraint.constant = 0
        */
 
        // show picker if it was hidden
        
        self.controlViewHeightConstraint.constant = 160
        
        self.pickerControlTopConstraint.constant = 8
        
        self.pickerControlHeightConstraint.constant = 104

 
    }
    
    
    
    
    // hide keyboard when 'return' is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        
        textField.resignFirstResponder()
        
        // add finished exercise as last member of exercises array
        if exTableView.indexPathForSelectedRow != nil {
            
            let indexPath = exTableView.indexPathForSelectedRow!
            let currentCell = exTableView.cellForRow(at: indexPath)! as! ExTableViewCell
            
            //let curr_ex = Exercise(name: "\(currentCell.exTextField.text!)", setsxreps: "\(currentCell.weightxrepsLabel.text!)")
            let curr_ex = Exercise(name: "\(currentCell.exTextField.text!)", setsxreps: "(currentCell.weightxrepsLabel.text!)", xlabel: 20, ylabel: 0, labelRows: 1, labelArray: [])
            
            /////// ^ pomenyal spacer na 20
            
            
            exercises[exercises.endIndex - 1] = curr_ex!
            print("'return' button just modified last member of exercises array! Now exercises = \(exercises)")
            
            exTableView.beginUpdates()
            exTableView.endUpdates()
            
        }
        
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
        
        // Set up views if editing an existing workout
        if let workout = workout {
            self.title = workout.name
            exercises = workout.exercises
        }
        else {
            // Set title
            self.title = "Workout \(day_counter + 1)"
        }
        
        //loadSampleExercises()
        
        // set border color for 'addSetButton'
        addSetButton.layer.borderColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0).cgColor
        
        
        // set auto height for tableview
        // exTableView.rowHeight = UITableViewAutomaticDimension
        exTableView.rowHeight = 70
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     func loadSampleExercises() {
     
        let exercise1 = Exercise(name: "Dead Lift", setsxreps: " 100 x 8, 110 x 6, 115 x 4", xlabel: 20, ylabel: 0, labelRows: 1, labelArray: [])!
     let exercise2 = Exercise(name: "Bench Press", setsxreps: " 80 x 10, 85 x 8", xlabel: 20, ylabel: 0, labelRows: 1, labelArray: [])!
     
     exercises += [exercise1, exercise2]
     }
    
    
    // MARK: Setup UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ExTableViewCell"
        
        // тут поменял tableView на exTableView
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ExTableViewCell
        
        // Fetches the appropriate exercise for the data source layout.
        let exercise = exercises[(indexPath as NSIndexPath).row]
        
        cell.exTextField.text = exercise.name
        
        // TODO: here get labels from labelArray
        
        if (exercise.labelArray != []) {
            for items in exercise.labelArray {
                cell.weightxrepsView.addSubview(items)
            }
        }
        
        //cell.weightxrepsLabel.text = exercise.setsxreps
        //cell.weightxrepsView.
        
        return cell
    }
    
    
    
    
    // configure row's onclick performance
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("row selected!")
        
        //set spacer to default value each time a row is selected
        //spacer = 20
        
        // spacer = exercise.spacer
        // exercise.spacer = 20 и изменяется, когда добавляются подходы
        
        // Fetches the appropriate exercise for the data source layout.
        let exercise = exercises[(indexPath as NSIndexPath).row]
        
        spacer = exercise.xlabel
        ySpacer = exercise.ylabel
        
        print("Just selected a row: exercise.xlabel = \(exercise.xlabel) = spacer = \(spacer). exercise.labelRows = \(exercise.labelRows) && row_count = \(row_count)")
        
        let indexPath = tableView.indexPathForSelectedRow!
        
        let currentCell = tableView.cellForRow(at: indexPath)! as! ExTableViewCell
        
        print("Row on-click info: labelsArray = \(exercise.labelArray), spacer=exercise.xlabel = \(exercise.xlabel)")
        
        //print("'weightxreps' of selected cell is: \(currentCell.weightxrepsLabel!.text)")
        
        /*
         // clean set and copy current 'weightxreps' value of the cell to 'set' buffer (not to loose previously done sets)
         set = []
         if currentCell.weightxrepsLabel.text != "" {
         set.append("\(currentCell.weightxrepsLabel.text!)")
         }
         */
        
        // enable user's interraction for the text field and set it as the first responder if cell is clicked
        currentCell.exTextField.isUserInteractionEnabled = true
        currentCell.exTextField.becomeFirstResponder()
        
    }


    
    // set different colors for even and odd rows
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath)
    {
        if ((indexPath as NSIndexPath).row % 2 == 0)
        {
            cell.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
    
    // adjust row height depending on it's 'spacer' (exercise.xlabel) value
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let exercise = exercises[(indexPath as NSIndexPath).row]
        //print("WTF!? exercise.labelRows = \(exercise.labelRows)")
        
        return (70 + (exercise.labelRows - 1) * 23)
        
        /*
         //if exercise.xlabel >= 236
         if (exercise.labelRows > 1) {
         //return 93
         return (70 + (exercise.labelRows - 1) * 23)
         } else {
         return 70
         }
         */
    }
    
    
    
    
    // MARK: Setup UIPickerViewDataSource
    
    // configure columns
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return String(weight[row])
        }
        else if component == 1 {
            return String(".")
        }
        else if component == 2 {
            return String(gramm[row])
        }
        else if component == 3 {
            return "kg"
        }
        else if component == 4 {
            return String(reps[row])
        }
        else {
            return "reps"
        }
    }
    
    // configure rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return weight.count
        }
        else if component == 1 {
            return 1
        }
        else if component == 2 {
            return gramm.count
        }
        else if component == 3 {
            return 1
        }
        else if component == 4 {
            return reps.count
        }
        else {
            return 1
        }
    }
    
    // set number of columns to display
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 6
    }
    
    
    //
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            if row > 0 {
                buff_weight = String(row)
            }
            else {
                //buff_weight = ""
                buff_weight = "bodyweight"
            }
        }
            
        else if component == 2 {
            if row > 0 {
                buff_gramm = String(row)
            }
            else {
                buff_gramm = ""
            }
        }
            
        else if component == 4 {
            buff_reps = String(row + 1)
        }
    }
    
    // set space between components
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        // weight
        if component == 0 {
            return 48.0
        }
            // dot separator
        else if component == 1 {
            return 18.0
        }
            // gramms
        else if component == 2 {
            return 22
        }
            // 'kg'
        else if component == 3 {
            return 48.0
        }
            // reps
        else if component == 4 {
            return 48
        }
            // 'reps'
        else {
            return 66.0
        }
    }
    
    // MARK: Actions
    
    
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // remove the item from the data model
            exercises.remove(at: indexPath.row)
            
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Not used in our example, but if you were adding a new row, this is where you would do it.
        }
    }
    
    
    
    
    
    
    @IBAction func addSetButton(_ sender: AnyObject) {
        
        
        
        if self.pickerControlHeightConstraint.constant == 0 {
            buff_weight = ""
            buff_reps = ""
            buff_gramm = ""
        }
        
        
        // show picker if it was hidden
        
        self.controlViewHeightConstraint.constant = 160
        
        self.pickerControlTopConstraint.constant = 8
        
        self.pickerControlHeightConstraint.constant = 104
        
        
        // if a row is selected - change setsxrepsLabel
        if exTableView.indexPathForSelectedRow != nil {
            
            let indexPath = exTableView.indexPathForSelectedRow!
            let currentCell = exTableView.cellForRow(at: indexPath)! as! ExTableViewCell
            
            
            // check if anything was selected
            if buff_weight != "" || buff_reps != "" {
                
                //set.append(" \(buff_weight).\(buff_gramm) x \(buff_reps)")
                
                // label size depending on device
                // iphone 4s   screen is 320 x 480 points - >>>> label: 70 x 15
                // iphone 5s/c screen is 320 x 586 points - >>>> label: 70 x 15
                // iphone 6    screen is 375 × 667 points - >>>> label: 82 x 18
                // iphone 6s   screen is 414 × 736 points - >>>> label: 90 x 20
                
                print("\(screenWidth)")
                print("\(screenHeight)")
                
                
                //var label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 15))
                let labelWidth = 0.22*screenWidth
                var label = UILabel(frame: CGRect(x: 0, y: 0, width: labelWidth, height: 0.3*labelWidth))

                
                label.layer.borderWidth = 1
                label.layer.borderColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0).cgColor
                label.layer.cornerRadius = 5
                
                /*
                // +++
                label.translatesAutoresizingMaskIntoConstraints = false
                
                
                //
                let leadingSpaceConstraint: NSLayoutConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: currentCell.weightxrepsView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0);
                
                let topSpaceConstraint: NSLayoutConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: currentCell.weightxrepsView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 10);
                
                
                
                currentCell.weightxrepsView.addConstraint(leadingSpaceConstraint)
                currentCell.weightxrepsView.addConstraint(topSpaceConstraint)
                */
                
                let exercise = exercises[(indexPath as NSIndexPath).row]
                
                
                print("xlabel = \(exercise.xlabel)")
                
                //let xx = screenWidth*0.05
              
                
                
                //label.center = CGPoint(x: 14 + exercise.xlabel, y: 8 + ySpacer)
                label.center = CGPoint(x: 14 + exercise.xlabel, y: 8 + exercise.ylabel)
                
                
                
                //label.center.y = self.view.center.y
                //label.center.x = self.view.center.x
                
                
                label.textAlignment = NSTextAlignment.center
                
                if buff_gramm != "" {
                    label.text = "\(buff_weight).\(buff_gramm) x \(buff_reps)"
                }
                else {
                    label.text = "\(buff_weight) x \(buff_reps)"
                }
                
                
                if (exercise.xlabel >= 236) {
                    
                    exercise.xlabel = -52
                    
                    //ySpacer = ySpacer + 23
                    ySpacer = exercise.ylabel + 23
                }
                
                
                print("exercise.ylabel = \(exercise.ylabel)")
                
                //if (ySpacer >= 23 && exercise.xlabel == 20) {
                if (exercise.ylabel >= 23 && exercise.xlabel == 20) {
            
                exercise.labelRows += 1
                print("exercise.labelRows++ and now = \(exercise.labelRows)")
                row_count = exercise.labelRows
                }
                
                
                /*
                if (exercise.xlabel >= 236 && ySpacer > 23) {
                    exercise.labelRows += 1
                    print("!!!!!!!exercise.labelRows++ and now = \(exercise.labelRows)")
                    row_count = exercise.labelRows
                }
                */
                
                //self.view.addSubview(label)
                currentCell.weightxrepsView.addSubview(label)
                
                

                
                
                // TEST. add this label to label array
                exercise.labelArray.append(label)
                labelArrayBuff = exercise.labelArray
                print("Added label to array and labelsArray now = \(exercise.labelArray)")
                
                
                /*
                if (exercise.xlabel >= 236) {
                    exercise.xlabel = -52
                    
                    /*
                    exercise.labelRows += 1
                    print("exercise.labelRows++ and now = \(exercise.labelRows)")
                    row_count = exercise.labelRows
                    */
 
                    ySpacer = ySpacer + 23
                }
                */
                
                exercise.xlabel = exercise.xlabel + 72
                spacer = exercise.xlabel
                print("Added 72, now xlabel = \(exercise.xlabel)")
                
                //
                row_count = exercise.labelRows
                
                
                print("label text is \(label.text)")
                
                
                
                // add finished exercise as last member of exercises array
                if exTableView.indexPathForSelectedRow != nil {
                    
                    let indexPath = exTableView.indexPathForSelectedRow!
                    let currentCell = exTableView.cellForRow(at: indexPath)! as! ExTableViewCell
                    
                    //let curr_ex = Exercise(name: "\(currentCell.exTextField.text!)", setsxreps: "\(currentCell.weightxrepsLabel.text!)")
                    let curr_ex = Exercise(name: "\(currentCell.exTextField.text!)", setsxreps: "(currentCell.weightxrepsLabel.text!)", xlabel: spacer, ylabel: ySpacer, labelRows: row_count, labelArray: labelArrayBuff)
                    
                    
                    exercises[exercises.endIndex - 1] = curr_ex!
                    
                    /*  WTF IS IT ???
                     print("'addSetButton' just modified last member of exercises array! Now exercises = \(exercises).spacer = xlabel = \(spacer)")
                     */
                    
                    exTableView.beginUpdates()
                    exTableView.endUpdates()
                }
                
                
            }
        }
        
    }
    
    // 'add exercise' button
    @IBAction func addEx(_ sender: AnyObject) {
        
        // hide whole controlTable
        self.controlViewHeightConstraint.constant = 0
        self.pickerControlHeightConstraint.constant = 0
        self.pickerControlTopConstraint.constant = 0
        
        
        // reset picker's buffer
        buff_weight = ""
        buff_reps = ""
        buff_gramm = ""
        
        
        // reset label's Y coordinate
        ySpacer = 0
        
        
        // add finished exercise as last member of exercises array
        if exTableView.indexPathForSelectedRow != nil {
            
            let indexPath = exTableView.indexPathForSelectedRow!
            let currentCell = exTableView.cellForRow(at: indexPath)! as! ExTableViewCell
            
            //let curr_ex = Exercise(name: "\(currentCell.exTextField.text!)", setsxreps: "\(currentCell.weightxrepsLabel.text!)")
            let curr_ex = Exercise(name: "\(currentCell.exTextField.text!)", setsxreps: "(currentCell.weightxrepsLabel.text!)", xlabel: spacer, ylabel: ySpacer, labelRows: row_count, labelArray: labelArrayBuff)
            
            
            exercises[exercises.endIndex - 1] = curr_ex!
            print("'addEx' button just modified last member of exercises array! Now exercises = \(exercises)")
            
            exTableView.beginUpdates()
            exTableView.endUpdates()
            
        }
        
        // clean 'set' buffer when the next exercise is added
        set = []
        buff_reps = ""
        buff_weight = ""
        
        
        // add a 'blank' for the new exercise to the array
        let blank = Exercise(name: "", setsxreps: "", xlabel: 20, ylabel: 0, labelRows: 1 , labelArray: [])!
        exercises.append(blank)
        
        // Update Table Data when new 'blank' exercise is inserted
        exTableView.beginUpdates()
        exTableView.insertRows(at: [
            IndexPath(row: exercises.count-1, section: 0)
            ], with: .automatic)
        
        exTableView.endUpdates()
        
        print("just added exercise and exercises = \(exercises)")
        
        
        // TODO: select textfield
        
       
    }

    
    //var tappy = UITapGestureRecognizer()
    
    
    
    @IBAction func longPressed(_ sender: UILongPressGestureRecognizer) {
        
        print("here is the long press! and it should add border for current label...")
        
        // if a row is selected - change setsxrepsLabel
        if exTableView.indexPathForSelectedRow != nil {
            let indexPath = exTableView.indexPathForSelectedRow!
            let currentCell = exTableView.cellForRow(at: indexPath)! as! ExTableViewCell
            
            let exercise = exercises[(indexPath as NSIndexPath).row]
            
            if (exercise.labelArray != []) {
                for items in exercise.labelArray {
                    items.layer.borderWidth = 2
                    items.layer.borderColor = UIColor(red: 0.78, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
                    
                    items.isUserInteractionEnabled = true
                    
                    /*
                     let aSelector : Selector = "lblTapped"
                     let tap = UITapGestureRecognizer(target: self, action: "aSelector:")
                     //tap.delegate = self
                     tap.numberOfTapsRequired = 1
                     items.addGestureRecognizer(tap)
                     */
                    
                    /*
                     var tappy = UITapGestureRecognizer(target:items, action:"score:")
                     items.addGestureRecognizer(tappy)
                     */
                    
                }
                
            }
            
        }
        
        /*
         
         func score(sender:UITapGestureRecognizer!) {
         
         print("tapped")
         
         }
         */
        
        /*
         // if a row is selected - change setsxrepsLabel
         if exTableView.indexPathForSelectedRow != nil {
         
         
         
         let indexPath = exTableView.indexPathForSelectedRow!
         let currentCell = exTableView.cellForRowAtIndexPath(indexPath)! as! ExTableViewCell
         
         currentCell.weightxrepsLabel.layer.borderWidth = 1
         currentCell.weightxrepsLabel.layer.cornerRadius = 5
         
         exTableView.beginUpdates()
         exTableView.endUpdates()
         
         }
         */
        
    }
    
    
    // MARK: Navigation
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender as AnyObject? === saveButton {
            
            let name = self.title ?? ""
            let date = curr_time()
            let exercises = self.exercises
            
            workout = Workout(name: name, date: date, exercises: exercises)
            
            // Set the meal to be passed to MealTableViewController after the unwind segue.
        }
    }
    
    
}
