//
//  FoodCell.swift
//  FoodDeliveryApp
//
//  Created by Charlie on 10/7/20.
//  Copyright © 2020 C. All rights reserved.
//

import UIKit
import RxSwift

class FoodCell: UITableViewCell, CellConfigurable {
    
    @IBOutlet weak var ol_imageView: UIImageView!
    @IBOutlet weak var ol_name: UILabel!
    @IBOutlet weak var ol_description: UILabel!
    @IBOutlet weak var ol_packageDescription: UILabel!
    @IBOutlet weak var ol_buy: UIButton!
    
    typealias Presenter = FoodCellPresentable
    private(set) var disposeBag = DisposeBag()
    
    func configCell(presenter: FoodCellPresentable) {
        ol_imageView.imageFromURL(urlString: presenter.imgURL ?? "")
        ol_name.text = presenter.name
        ol_description.text = presenter.description
        ol_packageDescription.text = presenter.packageDescription
        ol_buy.setTitle("$ \(presenter.price ?? "0")", for: .normal)
//        ol_buy.setBackgroundColor(color: .blue, forUIControlState: .highlighted)
    }
    override func prepareForReuse() {
       super.prepareForReuse()
       disposeBag = DisposeBag() // because life cicle of every cell ends on prepare for reuse
    }
}
