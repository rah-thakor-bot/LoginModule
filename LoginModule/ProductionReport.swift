//
//  ReportData.swift
//  LoginModule
//
//  Created by Rahul Thakor on 13/05/16.
//  Copyright © 2016 Rahul Thakor. All rights reserved.
//

import UIKit

class ProductionReport : ReportBase {
    
    var date:String!
    var dollarValue:String!
    var pcs:String!
    var polish:String!
    
    override func loadReportByMonth(month : String)->JSON{
        let jsonResult :JSON = ["Eggs","Milk","Butter","Cheese"]
        return jsonResult
    }
    
    override func loadReportDateWise(frDate :String , toDate : String) ->JSON{
        let jsonResult :JSON = ["Eggs","Milk","Butter","Cheese"]
        return jsonResult
    }
    
}
