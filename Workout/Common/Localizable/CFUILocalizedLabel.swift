//
//  CFUILocalizedLabel.swift
//  Workout
//
//  Created by ntq on 7/10/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import UIKit

final class CFUILocalizedLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let textLabel = text {
            text = NSLocalizedString(textLabel, comment: "")
        }
    }
}
