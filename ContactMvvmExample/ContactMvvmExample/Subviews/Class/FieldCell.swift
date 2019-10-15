//
//  FieldCell.swift
//  ContactMvvmExample
//  Created by Chandresh Maurya  on 04/07/2019.
//  Copyright © 2019 Chandresh Maurya . All rights reserved.
//
import UIKit
class FieldCell: BaseCell {
    @IBOutlet weak var descriptor: BaseLabel?
    @IBOutlet weak var textField: UITextField?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        descriptor?.font = Fonts.helveticaNeue
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
