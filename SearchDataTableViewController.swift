//
//  SearchDataTableViewController.swift
//  LoginModule
//
//  Created by Rahul Thakor on 12/05/16.
//  Copyright © 2016 Rahul Thakor. All rights reserved.
//

import UIKit
class SearchDataTableViewController: UITableViewController  {
    
    var searchType : String!
    var criteria : String!
    var fr_date : NSDate!
    var to_date : NSDate!
    var searchData = NSMutableArray()
    
    
    // 1 Raywenderlich Code
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    // 2
    var dataTask: NSURLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SearchDataTable Did Load")
        /*To register UITableViewDataSource Methods*/
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.navigationController!.navigationBar.tintColor = UIColor.blueColor();
        self.navigationController!.setNavigationBarHidden(false ,animated:true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        // 1
        if dataTask != nil {
            dataTask?.cancel()
        }
        // 2
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        // 3
        
        let expectedCharSet = NSCharacterSet.URLQueryAllowedCharacterSet()
        let criteriaTerm = criteria.stringByAddingPercentEncodingWithAllowedCharacters(expectedCharSet)!
        
        // 4
        let url = NSURL(string: "http://172.16.40.39:4000/getProduction?q=\(criteriaTerm)")
        // 5
        dataTask = defaultSession.dataTaskWithURL(url!) {
            data, response, error in
            // 6
            //Code Moved below dispatch_async
            // 7
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    //Code for Reloading Data on Screen
                    print("DataString :")
                    let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    if let dataFromString = dataString!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                        let jsonString = JSON(data: dataFromString)
                        //print(jsonString)
                        var indexValue = 0
                        for (key , _):(String,JSON) in jsonString{
                            print(key)
                            //print(subJson["POLISH_DATE"])
                            let cellDetails = ProductionReport()
                            cellDetails.date = jsonString[indexValue]["POLISH_DATE"].string
                            cellDetails.dollarValue = String(jsonString[indexValue]["DOLLAR"].int32)
                            cellDetails.polish = String(jsonString[indexValue]["CTS"].int32)
                            cellDetails.pcs = String(jsonString[indexValue]["TOTAL_PCS"].int32)
                            self.searchData.addObject(cellDetails)
                            indexValue++
                        }
                    }
                    print("Data Loaded")
                }
            }
            dispatch_async(dispatch_get_main_queue()) {
                print("dispatch_asyc")
                self.tableView.reloadData()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        }
        // 8
        dataTask?.resume()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("Search viewWillAppear")
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("numberOfSectionsInTableView \(self.searchData.count)")
        return self.searchData.count;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return 0
        print("numberOfRowsInSection \(self.searchData.count)")
        return self.searchData.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        print("TableCellConfiguration")

        let cell : ReportDataCellTableViewCell! = tableView.dequeueReusableCellWithIdentifier("reportDataCell", forIndexPath: indexPath) as! ReportDataCellTableViewCell
        let cellDetails:ProductionReport!  = self.searchData.objectAtIndex(indexPath.row) as! ProductionReport
        print("Date : \(cellDetails.date!) ")
        print("$ : \(cellDetails.dollarValue!)")
        print(cellDetails.dollarValue)
        print(cellDetails.dollarValue!)
        if let tDate = cellDetails.date {
            cell.date.text = tDate
        }
        if let tDollar = cellDetails.dollarValue {
            cell.dollarValue.text = "$ : \(tDollar)"
        }
        
        cell.pcs.text = "Pcs : \(cellDetails.pcs!)"
        cell.polish.text = "Cts : \(cellDetails.polish!)"
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "reportDetails"{
            /*For Navigation Embeded Destination Controller*/
            //let destinationNavigationController = segue.destinationViewController as! UINavigationController
            //let nextScene = destinationNavigationController.topViewController as! SearchDataTableViewController
            
            /*Direct Controller*/
            let nextScene = segue.destinationViewController as! DetailDataViewController
            // Pass the selected object to the new view controller.
            let currentItem = self.tableView.indexPathForSelectedRow
            nextScene.dayDetail = self.searchData.objectAtIndex(currentItem!.row) as! ProductionReport
            //nextScene.navigationItem.title = "\(self.title) Detail"
        }
    }
    

}
