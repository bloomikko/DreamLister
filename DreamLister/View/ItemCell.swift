//
//  ItemCell.swift
//  DreamLister
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    func configureCell(item: Item) {
        titleLabel.text = item.title
        priceLabel.text = "$\(item.price)"
        detailLabel.text = item.details
        thumbnail.image = item.toImage?.image as? UIImage
    }
}
