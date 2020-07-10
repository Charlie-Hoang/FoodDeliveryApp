//
//  HomeRouter.swift
//  FoodDeliveryApp
//
//  Created by Charlie on 8/7/20.
//  Copyright © 2020 C. All rights reserved.
//

import UIKit

protocol HomeRouterProtocol {
    //PRESENTER -> ROUTER
    func presentCartScreenFrom(view: HomeViewProtocol, buyFoods: [FoodsRes.Food])
    func presentDetailScreenFrom(view: HomeViewProtocol, data: String?)
}
final class HomeRouter: Routerable{
    static func createModule() -> UIViewController {
        //TODO: create module
        let view = mainStoryboard.instantiateViewController(withIdentifier: "HomeView")
        if let view = view as? HomeView {
            var presenter: HomePresenterVProtocol & HomePresenterIProtocol = HomePresenter()
            var interactor: HomeInteractorProtocol = HomeInteractor()
            let router: HomeRouterProtocol = HomeRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            return view
        }
        return UIViewController()
    }
}
extension HomeRouter: HomeRouterProtocol{
    
    func presentDetailScreenFrom(view: HomeViewProtocol, data: String?){
        //TODO: push view
//        let viewController = NormalDetailRouter.createModule()
//        
//        if let sourceView = view as? UIViewController {
//            sourceView.navigationController?.pushViewController(viewController, animated: true)
//        }
    }
    func presentCartScreenFrom(view: HomeViewProtocol, buyFoods: [FoodsRes.Food]){
        let vc = CartRouter.createModule(buyFoods: buyFoods)
        if let sourceView = view as? UIViewController{
            sourceView.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
