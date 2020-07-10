//
//  CartFoodCell.swift
//  FoodDeliveryApp
//
//  Created by Charlie on 11/7/20.
//  Copyright © 2020 C. All rights reserved.
//

import RxSwift

class CartFoodCell: UITableViewCell, CellConfigurable {
    @IBOutlet weak var ol_imageView: UIImageView!
    @IBOutlet weak var ol_nameLabel: UILabel!
    @IBOutlet weak var ol_priceLabel: UILabel!
    
    typealias Presenter = CartFoodCellPresentable
    private(set) var disposeBag = DisposeBag()
    
    func configCell(presenter: CartFoodCellPresentable) {
            ol_imageView.imageFromURL(urlString: presenter.imgURL ?? "")
            ol_nameLabel.text = presenter.name
        ol_priceLabel.text = "$ \(presenter.price ?? 0)"
    }
    override func prepareForReuse() {
       super.prepareForReuse()
       disposeBag = DisposeBag() // because life cicle of every cell ends on prepare for reuse
    }
}
