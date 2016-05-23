//
//  ReportViewController.swift
//  LoginModule
//
//  Created by Rahul Thakor on 11/05/16.
//  Copyright © 2016 Rahul Thakor. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var monthValue: UITextField!
    @IBOutlet weak var reportName: UIPickerView!
    @IBOutlet weak var erroMsg: UILabel!
    @IBOutlet weak var toDateTextField: UITextField!
    @IBOutlet weak var frDateTextField: UITextField!
    
    @IBAction func donePressed(sender: AnyObject) {
        
    }
    
    @IBAction func frDatePicker(sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("frDatePickerValueChanged:"),
            forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    @IBAction func toDatePicker(sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("toDatePickerValueChanged:"),
            forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func frDatePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        frDateTextField.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    func toDatePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        toDateTextField.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    let pickerData = ["Production Report","Damage Report"]
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        reportName.dataSource = self
        reportName.delegate = self
        // Do any additional setup after loading the view.
        reportName.selectRow(0, inComponent: 0, animated: true)
        
        erroMsg.text = pickerData[0]//Setting Default Value for Next Scene
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.title = "Search Details"
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "searchData"{
            /*For Navigation Embeded Destination Controller*/
            let destinationNavigationController = segue.destinationViewController as! UINavigationController
            let nextScene = destinationNavigationController.topViewController as! SearchDataTableViewController

            /*Direct Controller*/
            //let nextScene = segue.destinationViewController as! SearchDataTableViewController
            // Pass the selected object to the new view controller.
            nextScene.searchType = "Month"
            nextScene.criteria = monthValue.text!
            nextScene.navigationItem.title = "\(erroMsg.text!) Data"
            navigationItem.title = "Home"
        }
        
    }
    
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        erroMsg.text = pickerData[row]
    }
}
