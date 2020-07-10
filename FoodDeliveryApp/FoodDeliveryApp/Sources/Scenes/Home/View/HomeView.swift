//
//  HomeView.swift
//  FoodDeliveryApp
//
//  Created by Charlie on 8/7/20.
//  Copyright © 2020 C. All rights reserved.
//

import UIKit
import RxSwift

protocol HomeViewProtocol: AnyObject{
    //PRESENTER -> VIEW
    var presenter: HomePresenterVProtocol?{get set}
    
//    func display(foods: [Food]?)
    func displayPromotions(promotionsURLs: [String])
    func displayFoods(foods: [FoodCellPresentable])
}

final class HomeView: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var promotionsScrollView: UIScrollView!
    @IBOutlet weak var promotionsWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var promotionsPageControl: UIPageControl!
    @IBOutlet weak var foodsTableView: UITableView!
    @IBOutlet weak var foodsTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var buyItemCountLabel: UILabel!
    
    var presenter: HomePresenterVProtocol?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        initTableView()
        DispatchQueue.main.async {
            self.binding()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        foodsTableView.layer.removeAllAnimations()
        foodsTableViewHeightConstraint.constant = foodsTableView.contentSize.height
        UIView.animate(withDuration: 0.1) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
    }
    deinit {
        foodsTableView.removeObserver(self, forKeyPath: "contentSize", context: nil)
    }
    @IBAction func pageControlSelected(_ sender: UIPageControl) {
        let page: Int? = sender.currentPage
        var frame: CGRect = promotionsScrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page ?? 0)
        frame.origin.y = 0
        promotionsScrollView.scrollRectToVisible(frame, animated: true)
    }
    @IBAction func cartButtonClicked(_ sender: UIButton) {
        presenter?.showCart()
    }
}

extension HomeView: HomeViewProtocol{
    func displayPromotions(promotionsURLs: [String]){
        drawPromotions(arrString: promotionsURLs)
    }
    func displayFoods(foods: [FoodCellPresentable]){
        print(foods)
    }
}
//MARK: - Private
extension HomeView{
    private func initTableView(){
        foodsTableView.regCell(cell: FoodCell.self)
        foodsTableView.tableFooterView = UIView(frame: CGRect.zero)
        foodsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        foodsTableView.allowsSelection = false
    }
    
    private func binding(){
        //list foods
        presenter?.listFoods.asObservable().bind(to:foodsTableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.identifier) as! FoodCell
            cell.configCell(presenter: element)
            cell.ol_buy.rx.tap.subscribe({[unowned self] value in
                if let food = self.presenter?.interactor?.foods.filter({$0.itemId == element.id}).first{
                    
                    self.presenter?.addItem.onNext(food)
                }
            }).disposed(by: cell.disposeBag)
            return cell
        }.disposed(by: disposeBag)
        //cart
        presenter?.itemsCount.asObservable().bind(to: self.buyItemCountLabel.rx.text).disposed(by: disposeBag)
    }
    private func drawPromotions(arrString: [String]) {
        
        var xOffset: CGFloat = 0
        let buttonPadding: CGFloat = 0
        for urlString in arrString {
            let _imgV = UIImageView(frame: CGRect(x: xOffset, y: 0.0, width: UIScreen.main.bounds.width, height: promotionsScrollView.bounds.height))
            _imgV.contentMode = .scaleAspectFit
            _imgV.backgroundColor = .blue
            _imgV.imageFromURL(urlString: urlString)
            
            promotionsScrollView.addSubview(_imgV)
            xOffset = xOffset + _imgV.bounds.width + buttonPadding
        }
        promotionsWidthConstraint.constant = xOffset
        promotionsScrollView.contentSize = CGSize(width: xOffset, height: promotionsScrollView.bounds.height)
        promotionsPageControl.numberOfPages = arrString.count
        promotionsPageControl.currentPage = 0
    }
}
//MARK: - UIScrollViewDelegate
extension HomeView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        promotionsPageControl.currentPage = Int(pageIndex)
    }
}
