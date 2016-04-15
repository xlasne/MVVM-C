//
//  MainViewModel.swift
//  MVVM
//
//  Created by Xavier on 13/04/16.
//  Copyright © 2016 XL Software Solutions. MIT License
//

import Cocoa

class MainViewModel: NSObject
{

    // MARK: Interfaces
    unowned var dataModel : DataModel
    weak var viewController : MainViewController?
    weak var contextMgr : ContextMgr? {
        return self.dataModel.document?.contextMgr
    }

    init(dataModel : DataModel)
    {
        self.dataModel = dataModel
        super.init()
    }

    // MARK: - View Controller - View Model Registration
    func register(viewController: MainViewController)
    {
        self.viewController = viewController
    }

    func unregister(viewController: MainViewController)
    {
        if self.viewController == viewController
        {
            // Clear Memory if needed
            self.viewController = nil
        }
    }

    func refreshUI() {
        self.viewController?.refreshUI()
    }
}

