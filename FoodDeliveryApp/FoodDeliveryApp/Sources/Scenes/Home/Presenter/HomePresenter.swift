//
//  HomePresenter.swift
//  FoodDeliveryApp
//
//  Created by Charlie on 8/7/20.
//  Copyright © 2020 C. All rights reserved.
//

import RxSwift
import RxCocoa

protocol HomePresenterVProtocol {
    var view: HomeViewProtocol?{get set}
    var interactor: HomeInteractorProtocol?{get set}
    var router: HomeRouterProtocol?{get set}
    
    var addItem: PublishSubject<FoodsRes.Food>{get}
    var itemsCount: BehaviorRelay<String>{get}
    var listItems: BehaviorRelay<[FoodsRes.Food]>{get}
    
    var listFoods: BehaviorRelay<[FoodCellPresentable]>{get}
    var fetchedFoods: BehaviorRelay<[FoodsRes.Food]>{get}
    
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func viewDidAppear()
    func showDetail()
    func showCart()
    
}

protocol HomePresenterIProtocol: AnyObject {
    //INTERACTOR -> PRESENTER

//    func fetchFinished(foods: [Food])
    func fetchPromotionsFinished(promotionsURLs: [String])
    func fetchFoodsFinished(foods: [FoodCellPresentable])
    
    func gotFetchedFoods(foods: [FoodsRes.Food])
}

final class HomePresenter{
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    
    var addItem = PublishSubject<FoodsRes.Food>()
    var listItems = BehaviorRelay<[FoodsRes.Food]>(value: [])
    var itemsCount = BehaviorRelay<String>(value: "")
    
    var listFoods = BehaviorRelay<[FoodCellPresentable]>(value: [])
    var fetchedFoods = BehaviorRelay<[FoodsRes.Food]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    private var items: [FoodsRes.Food] = []
    init() {
        setupSubscribe()
    }
}

extension HomePresenter: HomePresenterVProtocol{
    func viewDidLoad() {
        DispatchQueue.main.async {
            self.interactor?.fetchPromotions()
        }
        interactor?.fetchFoods()
    }
    func viewDidAppear() {
    }
    func showDetail(){
        router?.presentDetailScreenFrom(view: view!, data: "example data")
    }
    func showCart() {
        router?.presentCartScreenFrom(view: view!, buyFoods:items)
    }
}

extension HomePresenter: HomePresenterIProtocol{
    func fetchPromotionsFinished(promotionsURLs: [String]){
        view?.displayPromotions(promotionsURLs: promotionsURLs)
    }
    func fetchFoodsFinished(foods: [FoodCellPresentable]){
        print("fetchFoodsFinished")
        listFoods.accept(foods)
//        view?.displayFoods(foods: foods)
    }
    func gotFetchedFoods(foods: [FoodsRes.Food]){
        fetchedFoods.accept(foods)
    }
}
//private
extension HomePresenter{
    private func setupSubscribe(){
        self.addItem.subscribe(onNext: { item in
            print("add item")
            self.items.append(item)
            self.listItems.accept(self.items)
            self.itemsCount.accept((self.items.count > 0) ? "\(self.items.count)" : "")
        }).disposed(by: disposeBag)
    }
}
