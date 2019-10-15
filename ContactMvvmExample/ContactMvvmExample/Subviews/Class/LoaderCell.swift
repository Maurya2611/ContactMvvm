//
//  LoaderCell.swift
//  FourSquare
//
//  Created by Chandresh Maurya  on 02/02/2019.
//  Copyright © 2019 Chandresh Maurya . All rights reserved.
//

import UIKit
class LoaderCell: BaseCell {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
}
extension LoaderCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
