//
//  CartView.swift
//  FoodDeliveryApp
//
//  Created by Charlie on 11/7/20.
//  Copyright © 2020 C. All rights reserved.
//

import RxSwift

protocol CartViewProtocol: AnyObject{
    //PRESENTER -> VIEW
    var presenter: CartPresenterVProtocol?{get set}
    
//    func display(foods: [Food]?)
//    func displayPromotions(promotionsURLs: [String])
//    func displayFoods(foods: [FoodCellPresentable])
}

final class CartView: UIViewController {

    @IBOutlet weak var foodsTableView: UITableView!
    
    var presenter: CartPresenterVProtocol?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cart"
        initTableView()
        binding()
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillDisappear(animated)
    }
}

extension CartView: CartViewProtocol{
    
}

//MARK: - Private
extension CartView{
    private func initTableView(){
        foodsTableView.regCell(cell: CartFoodCell.self)
        foodsTableView.tableFooterView = UIView(frame: CGRect.zero)
        foodsTableView.allowsSelection = false
    }
    private func binding(){
        //list foods
        presenter?.listFoods.asObservable().bind(to:foodsTableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: CartFoodCell.identifier) as! CartFoodCell
            cell.configCell(presenter: element)
            return cell
        }.disposed(by: disposeBag)
    }
}
