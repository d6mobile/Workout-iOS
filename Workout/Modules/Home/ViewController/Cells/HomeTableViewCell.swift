//
//  HomeTableViewCell.swift
//  Workout
//
//  Created by ntq on 7/17/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak private var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fillDataToCell(model: Product) {
        self.lbName.text = model.name
    }
}
