//
//  NetworkReachability.swift
//  ios-network-module
//
//  Created by Abhishek on 13/06/21.
//

import Foundation
import Alamofire

class NetworkReachability {
 
    static let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
 
    static func startNetworkMonitoring() {
      reachabilityManager?.startListening { status in
        switch status {
        case .notReachable:
          print("Not Connected 🔴")
        case .reachable(.cellular):
            print("Connected via Cellular 🟢")
        case .reachable(.ethernetOrWiFi):
            print("Connected via Wifi 🟢")
        case .unknown:
            print("Unkown Error 🚨")
        }
      }
    }
}
