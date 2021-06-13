//
//  DetailViewController.swift
//  ios-network-module
//
//  Created by Abhishek on 13/06/21.
//

import UIKit

enum DetailViewType: Equatable {
    case heading(String)
    case curl(String)
    case responseJSON(String)
    
    func getTitle() -> String {
        switch self {
        case .heading(_): return "Endpoint"
        case .curl(_): return "Request cURL"
        case .responseJSON(_): return "Response JSON"
        }
    }
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var buttonDismiss: UIButton!
    @IBOutlet weak var buttonShare: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [DetailViewType]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intializeView()
    }
    
    private func intializeView() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "DetailItemLabelCell", bundle: nil), forCellReuseIdentifier: "DetailItemLabelCell")
        tableView.register(UINib(nibName: "HeadingSectionLabelCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeadingSectionLabelCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func buttonDimissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonShareAction(_ sender: Any) {
        let cURLType = dataSource?.filter({ (viewType) -> Bool in
            return viewType == .curl("")  //FIXME:
        })
        
        if case .curl(let text) = cURLType?.first {
            self.shareIntent([text])
        }
    }
    
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let data = dataSource?[section] else { return nil }
        let section = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeadingSectionLabelCell") as! HeadingSectionLabelCell
        section.setup(data.getTitle())
        return section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = dataSource?[indexPath.section] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailItemLabelCell") as! DetailItemLabelCell
        
        switch data {
        case .heading(let heading):
            cell.setup(content: heading, delegate: self)
        case .curl(let curlString):
            cell.setup(content: curlString, delegate: self)
        case .responseJSON(let json):
            cell.setup(content: json, delegate: self)
        }
        
        return cell
    }
    
}

extension DetailViewController: DetailItemLabelDelegate {
    func onCopyAction(_ content: String) {
        //TODO: Show Toast
        Utility.copyToClipboard(content)
    }
}
