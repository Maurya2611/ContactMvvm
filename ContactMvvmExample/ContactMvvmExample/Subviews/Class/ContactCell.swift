//
//  ContactCell.swift
//  Contacts
//
//  Created by Chandresh Maurya  on 03/07/2019.
//  Copyright © 2019 Chandresh Maurya . All rights reserved.
//

import UIKit

class ContactCell: BaseCell {

    @IBOutlet weak var profileImageView: UIImageView?
    @IBOutlet weak var favoriteImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let profileRadius                     = profileImageView?.bounds.width ?? 0.0
        profileImageView?.layer.masksToBounds = true
        profileImageView?.layer.cornerRadius  = profileRadius / 2
        favoriteImageView?.image              = Images.favorite
        favoriteImageView?.isHidden           = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
extension ContactCell {
    internal func setImageFrom(_ urlString: String) {
        
        setProfileImageFrom(urlString,
                            imageView: &profileImageView)
    }
    
    internal func setNameFrom(_ name: String) {
        
        titleLabel?.text = name
    }
    
    internal func setFavoriteFrom(_ favorite: Bool) {
        favoriteImageView?.isHidden = !favorite
    }
}
