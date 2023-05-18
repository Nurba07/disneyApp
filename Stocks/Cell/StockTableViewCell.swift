//
//  StockTableViewCell.swift
//  Stocks
//
//  Created by Nurbakhyt on 05.05.2023.
//wrflwjehfowlbfwljb

import UIKit

class StockTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    static let identifier = "StockTableViewCell"
    static let nib = UINib(nibName: String(describing: StockTableViewCell.self), bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
