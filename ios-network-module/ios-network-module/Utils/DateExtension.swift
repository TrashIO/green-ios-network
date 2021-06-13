//
//  DateExtension.swift
//  ios-network-module
//
//  Created by Abhishek on 13/06/21.
//

import UIKit

extension Date {
    
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy h:mm a"
        return dateFormatter.string(from: self)

    }
}
