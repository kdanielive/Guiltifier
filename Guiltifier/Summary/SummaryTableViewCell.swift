//
//  SummaryTableViewCell.swift
//  Guiltifier
//
//  Created by Daniel Kim on 12/2/18.
//  Copyright © 2018 Daniel Kim. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
