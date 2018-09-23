//
//  ViewController.swift
//  TDSample
//
//  Created by Lingfei Gao on 2018/9/22.
//  Copyright © 2018年 Lingfei Gao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var topicTableView: UITableView!
    var transferUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        self.topicTableView.delegate = self
        self.topicTableView.dataSource = self
        self.topicTableView.rowHeight = UITableViewAutomaticDimension
        self.topicTableView.estimatedRowHeight = 300
        DataManager.sharedInstance.getJsonFromUrl(completion: {
            DispatchQueue.main.async {
                self.topicTableView.reloadData()
            }
        })
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < DataManager.sharedInstance.topicArray.count, let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TopicTableViewCell.self), for: indexPath) as? TopicTableViewCell {
            let topic = DataManager.sharedInstance.topicArray[indexPath.row]
            cell.configure(topic["text"] ?? "", topic["imageURL"] ?? "", topic["link"] ?? "")
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedInstance.topicArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TopicTableViewCell
        self.transferUrl = cell.linkString
        self.performSegue(withIdentifier: "openURLSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondViewController = segue.destination as! customWebViewController
        if segue.identifier == "openURLSegue" {
            secondViewController.url = self.transferUrl
        }
    }
    func registerNibs() {
        let cellNib = UINib(nibName: String(describing: TopicTableViewCell.self), bundle: nil)
        self.topicTableView.register(cellNib,
                                forCellReuseIdentifier:  String(describing: TopicTableViewCell.self))
        
    }
}

