//
//  DetailItemLabelCell.swift
//  ios-network-module
//
//  Created by Abhishek on 13/06/21.
//

import UIKit
protocol DetailItemLabelDelegate: class {
    func onCopyAction(_ content: String)
}


class DetailItemLabelCell: UITableViewCell {
    
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var buttonCopy: UIButton!
    
    weak var delegate: DetailItemLabelDelegate?
    
    func setup(content: String, delegate: DetailItemLabelDelegate?) {
        self.delegate = delegate
        self.labelContent.text = content
    }
    
    @IBAction func buttonCopyAction(_ sender: Any) {
        delegate?.onCopyAction(self.labelContent.text ?? String())
    }
    
}
