//
//  SectionHeaderView.swift
//  MVVM-Example
//
//  Created by Chandresh on 1/10/19.
//  Copyright © 2019 Ivan Magda. All rights reserved.
//

import UIKit
class SectionHeaderView: BaseView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBOutlet weak var lblHeaderTittle: UILabel! {
        didSet {
            lblHeaderTittle.textColor = .black
            lblHeaderTittle.font = UIFont(name: "CourierNewPS-BoldMT", size: 18.0) ?? .systemFont(ofSize: 16.0)
        }
    }
}
