//
//  CartRouter.swift
//  FoodDeliveryApp
//
//  Created by Charlie on 11/7/20.
//  Copyright © 2020 C. All rights reserved.
//

import UIKit

protocol CartRouterProtocol {
    
}
final class CartRouter: Routerable {
    static func createModule() -> UIViewController {return UIViewController()}
        
    static func createModule(buyFoods: [FoodsRes.Food]) -> UIViewController {
        //TODO: create module
        let view = mainStoryboard.instantiateViewController(withIdentifier: "CartView")
        if let view = view as? CartView {
            var presenter: CartPresenterVProtocol & CartPresenterIProtocol = CartPresenter(buyFoods: buyFoods)
            var interactor: CartInteractorProtocol = CartInteractor()
            let router: CartRouterProtocol = CartRouter()
            
            
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

extension CartRouter: CartRouterProtocol{}
