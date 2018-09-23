//
//  TopicTableViewCell.swift
//  TDSample
//
//  Created by Lingfei Gao on 2018/9/23.
//  Copyright © 2018年 Lingfei Gao. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    var linkString = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ topic: String, _ icon: String, _ url: String) {
        self.topicLabel.text = topic
        self.linkString = url
        guard icon != ""  else {
            return
        }
        let imageUrl = URL(string: icon)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageUrl!)
            DispatchQueue.main.async {
                self.iconImage.
                self.iconImage.image = UIImage(data: data!)
            }
        }
    }
    
}
