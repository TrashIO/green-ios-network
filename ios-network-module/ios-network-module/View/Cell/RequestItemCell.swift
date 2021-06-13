//
//  RequestItemCell.swift
//  ios-network-module
//
//  Created by Abhishek on 13/06/21.
//

import UIKit

class RequestItemCell: UITableViewCell {
    
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelFooter: UILabel!
    
    
    func setup(_ model: ApiLogRequestModel) {
        self.viewStatus.backgroundColor = (model.isSuccess ?? false) ? UIColor.green : UIColor.red
        self.labelTitle.text = model.endpoint
        self.labelSubtitle.text = model.statusCode
        self.labelFooter.text = model.timeStamp.getFormattedDate()
    }
    
}
