//
//  Utility.swift
//  ios-network-module
//
//  Created by Abhishek on 14/06/21.
//

import UIKit

class Utility {
    static func copyToClipboard(_ text: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = text

    }
    
}

extension UIViewController {
    
    func shareIntent(_ texts: [String]) {
        let ac = UIActivityViewController(activityItems: texts, applicationActivities: nil)
        present(ac, animated: true)
    }
    
}
