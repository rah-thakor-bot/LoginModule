//
//  ReportDataCellTableViewCell.swift
//  LoginModule
//
//  Created by Rahul Thakor on 13/05/16.
//  Copyright © 2016 Rahul Thakor. All rights reserved.
//

import UIKit

class ReportDataCellTableViewCell: UITableViewCell {


    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var dollarValue: UILabel!
    @IBOutlet weak var pcs: UILabel!
    @IBOutlet weak var polish: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
