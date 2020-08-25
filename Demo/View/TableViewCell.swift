//
//  TableViewCell.swift
//  Demo
//
//  Created by VJ's iMAC on 25/08/20.
//  Copyright © 2020 VJ's. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var downloadButton : UIButton!
    
    var buttonAction: ((Any) -> Void)?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func download(sender: UIButton) {
        self.buttonAction?(sender)
        
    }
    
}
