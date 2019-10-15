//
//  DeleteCell.swift
//  ContactMvvmExample
//  Created by Chandresh Maurya  on 05/07/2019.
//  Copyright © 2019 Chandresh Maurya . All rights reserved.
//
import UIKit
protocol DeleteCellDelegate: class {
    func didTapDelete()
}
class DeleteCell: BaseCell {
    @IBOutlet weak var deleteButton: UIButton?
    weak var delegate: DeleteCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel?.textColor = Colors.destructiveRed
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @IBAction func didTapDeleteButton(_ sender: UIButton) {
        
        delegate?.didTapDelete()
    }
}
