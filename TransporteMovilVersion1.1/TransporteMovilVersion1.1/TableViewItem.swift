//
//  TableViewItem.swift
//  TransporteMovilVersion1.1
//
//  Created by SSiOS on 5/14/19.
//  Copyright © 2019 SSiOS. All rights reserved.
//

import UIKit

class TableViewItem: UITableViewCell {
    
    
    
    
    @IBOutlet weak var imageColor: UIImageView!
    
    @IBOutlet weak var name: UIButton!
    
    @IBOutlet weak var baseOne: UILabel!
    
    @IBOutlet weak var baseTwo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageColor.layer.cornerRadius = imageColor.frame.size.width / 2
        imageColor.clipsToBounds = true
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
