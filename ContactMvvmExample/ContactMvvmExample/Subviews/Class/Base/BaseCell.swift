//
//  BaseTableviewCell.swift
//  FourSquare
//
//  Created by Chandresh Maurya  on 02/02/2019.
//  Copyright © 2019 Chandresh Maurya . All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: BaseLabel?
    @IBOutlet weak var subTitleLabel: BaseLabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel?.font      = Fonts.helveticaNeue
    }
    
    internal func setProfileImageFrom(_ urlString: String,
                                      imageView: inout UIImageView?) {
        
        imageView?.setKFImage(with: urlString,
                              placeholder: Images.placeholderphoto,
                              shouldAnimate: true,
                              keepCurrentImageWhileLoading: false,
                              completion: nil)
    }
}
