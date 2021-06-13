//
//  HeadingSectionLabelCell.swift
//  ios-network-module
//
//  Created by Abhishek on 14/06/21.
//

import UIKit

class HeadingSectionLabelCell: UITableViewHeaderFooterView {
    
    @IBOutlet weak var labelTitle: UILabel!
    
    func setup(_ title: String) {
        self.labelTitle.text = title
    }
    
}
