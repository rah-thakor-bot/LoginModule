//
//  DetailDataViewController.swift
//  LoginModule
//
//  Created by Rahul Thakor on 12/05/16.
//  Copyright © 2016 Rahul Thakor. All rights reserved.
//

import UIKit

class DetailDataViewController: UIViewController {

    @IBOutlet weak var lblAmt: UILabel!
    @IBOutlet weak var lblPolish: UILabel!
    @IBOutlet weak var lblPcs: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var dayDetail:ProductionReport!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView()->(){
        lblDate.text = dayDetail.date
        lblPcs.text =  dayDetail.pcs!
        lblPolish.text = dayDetail.polish!
        if let tAmt = dayDetail.dollarValue {
            lblAmt.text =  tAmt
        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
