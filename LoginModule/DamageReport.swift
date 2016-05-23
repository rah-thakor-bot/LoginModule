//
//  DamageReport.swift
//  LoginModule
//
//  Created by Rahul Thakor on 20/05/16.
//  Copyright © 2016 Rahul Thakor. All rights reserved.
//

import UIKit

class DamageReport: ReportBase {
    
    override func loadReportByMonth(monthValue:String)->JSON{
        return super.jsonResult
    }
    
    override func loadReportDateWise(frDate:String,toDate:String)->JSON{
        return super.jsonResult
    }
}
