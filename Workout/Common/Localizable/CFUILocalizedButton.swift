//
//  CFUILocalizedButton.swift
//  Workout
//
//  Created by ntq on 7/10/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import UIKit

final class CFUILocalizedButton: UIButton {

   override func awakeFromNib() {
        super.awakeFromNib()
        
        if let text = self.title(for: .normal) {
            let title = NSLocalizedString(text, comment: "")
            setTitle(title, for: .normal)
        }
    }
}
