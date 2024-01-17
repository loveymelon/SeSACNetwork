//
//  BookCollectionViewCell.swift
//  SeSACNetwork
//
//  Created by 김진수 on 1/17/24.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageNameLabel: UILabel!
    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(data: Document) {
        let url = data.thumbnail
        self.bookImageView.kf.setImage(with: URL(string: url))
        self.priceLabel.text = "\(data.price)"
        self.imageNameLabel.text = data.title
    }

}
