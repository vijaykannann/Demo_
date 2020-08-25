//
//  ViewController.swift
//  Demo
//
//  Created by VJ's iMAC on 25/08/20.
//  Copyright © 2020 VJ's. All rights reserved.
//

import UIKit
import ObjectMapper

class ViewController: UIViewController {
    
    @IBOutlet weak var _tabelView: UITableView!
    var refreshControl: UIRefreshControl!
    var autherModel : [AutherModel] = [] {
        didSet {
            if (self.autherModel != oldValue) {
                DispatchQueue.main.async {
                    self._tabelView.reloadData()
                }
            }
            
        } willSet (newValue) {
            self.autherModel = newValue
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupInitial()
        
    }
    
    @objc func didPullToRefresh() {
        
        self.autherService()
        self.refreshControl?.endRefreshing()
        
        
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autherModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getAuther(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func getAuther(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.AutherCell, for: indexPath) as? TableViewCell
        let authModel = self.autherModel[indexPath.row]
        DispatchQueue.main.async {
            cell?.descriptionLabel.text = authModel.author
            cell?.titleLabel.text = authModel.author
            cell?.img.clipsToBounds = true
        }
        tableView.separatorStyle = .none
        cell?.selectionStyle = .none
        cell?.img.imageFromServerURL(authModel.download_url!, placeHolder:
            #imageLiteral(resourceName: "photo"))
        cell?.buttonAction = { index in
            self.downloadTapped(url: authModel.download_url ?? "")
        }
        
        
        //cell?.downloadButton.addTarget(self, action: #selector(downloadTapped(url:)), for: UIControl.Event.touchUpInside)
        return cell ?? UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = self.autherModel[indexPath.row]
        return UIAlertController.showAlert(title: "Description", description: selectedCell.author ?? "", controller: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func downloadTapped(url: String) {
        
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        if let url = URL(string: url) {
            URLSession.shared.downloadTask(with: url) { location, response, error in
                guard let location = location else {
                    print("download error:", error.debugDescription)
                    return
                }
                
                do {
                    try FileManager.default.moveItem(at: location, to: documents.appendingPathComponent(response?.suggestedFilename ?? url.lastPathComponent))
                } catch {
                    print("vjerror\(error.localizedDescription)")
                    if error.localizedDescription == "couldn’t be moved to “Documents” because an item with the same name already exists" {
                        return UIAlertController.showAlert(title: "Alert", description:"couldn’t be moved to “Documents” because an item with the same name already exists", controller: self)
                    }
                }
            }.resume()
        }
        
    }
    
}

extension ViewController {
    
    func autherService() {
        AutherServices.shared.candidate_question_answer_service { (response, error) in
            guard error == nil else {return}
            let workDetaile = Mapper<AutherModel>().mapArray(JSONArray: response as! [[String : Any]])
            
            workDetaile.forEach { (auth) in
                self.autherModel.append(auth)
                print(self.autherModel.count)
            }
            
        }
        
    }
    
}

extension ViewController {
    
    func setupInitial() {
        self._tabelView.register(UINib(nibName: Cell.AutherCell, bundle: nil), forCellReuseIdentifier: Cell.AutherCell)
        self._tabelView.estimatedRowHeight = 60.0
        self._tabelView.rowHeight = UITableView.automaticDimension
        self.autherService()
        _tabelView.alwaysBounceVertical = true
        _tabelView.bounces  = true
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self._tabelView.addSubview(refreshControl)
    }
    
}


struct Cell {
    static var AutherCell = "TableViewCell"
}
