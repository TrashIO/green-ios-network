//
//  NetworkMonitorViewController.swift
//  ios-network-module
//
//  Created by Abhishek on 13/06/21.
//

import UIKit

class UserApiRequest: ApiRequestContract {
    
    var verb: HttpVerb
    var headers: [String: String]
    var body: [String: Any]?
    var path: URL
    
    init(getRequest url: URL) {
        self.verb = .GET
        self.headers = ["Content-Type": "application/json"]
        self.body = nil
        self.path = url
    }
    
    init(postRequest url: URL) {
        self.verb = .POST
        self.headers = ["Content-Type": "application/json"]
        self.body = ["name":"morpheus", "job": "leader"]
        self.path = url
    }
}

class NetworkMonitorViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var buttonRefresh: UIButton!
    
    var dataSource: [ApiLogRequestModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get Request
        let getUserRequest = UserApiRequest(getRequest: URL(string: "https://reqres.in/api/users/3")!)
        NetworkManager.shared.request(getUserRequest) { (result: Result<UserResponseModel, Error>) -> Void in
            switch result {
            case .success(let userData):
                print("GET Response : \(userData)")
            case .failure(let error):
                print("Error on GET Request: \(error)")
            }
        }
        
        // Post Request
        let createUserRequest = UserApiRequest(postRequest: URL(string: "https://reqres.in/api/users")!)
        NetworkManager.shared.request(createUserRequest) { (result: Result<CreateUserResponseModel, Error>) -> Void in
            switch result {
            case .success(let data):
                print("Post Response: \(data)")
            case .failure(let error):
                print("Post Error: \(error)")
            }
        }
        
        initialize()
        
    }
    
    func initialize() {
        setupTable()
        getLogs()
    }
    
    func setupTable() {
        tableView.register(UINib(nibName: "RequestItemCell", bundle: nil), forCellReuseIdentifier: "RequestItemCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func getLogs() {
        self.dataSource?.removeAll()
        self.dataSource = RequestLogger.shared.dataSource
        
        print(self.dataSource?.count)
    }
   
    @IBAction func buttonLeftAction(_ sender: Any) {
        //TODO:
    }
    
    @IBAction func buttonRefreshAction(_ sender: Any) {
        getLogs()
    }
    
}

extension NetworkMonitorViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = dataSource?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestItemCell", for: indexPath) as! RequestItemCell
        cell.setup(data)
        return cell
    }
    
}
