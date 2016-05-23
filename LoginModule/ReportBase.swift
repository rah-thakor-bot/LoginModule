//
//  ReportBase.swift
//  LoginModule
//
//  Created by Rahul Thakor on 20/05/16.
//  Copyright © 2016 Rahul Thakor. All rights reserved.
//

import UIKit

class ReportBase {
    
    var month:String?
    var fr_date : String?
    var to_date : String?
    var jsonResult : JSON = ["Eggs","Milk"]
    
    func loadReportByMonth(monthValue:String)->JSON{
        return jsonResult
    }
    
    func loadReportDateWise(frDate:String,toDate:String)->JSON{
        return jsonResult
    }

}
