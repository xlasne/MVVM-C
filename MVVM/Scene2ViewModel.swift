//
//  Scene2ViewModel.swift
//  MVVM
//
//  Created by Xavier on 08/04/16.
//  Copyright © 2016 XL Software Solutions. MIT License
//

// KEY POINTS
// - View Model belong to the Data Model hierarchy, and are always instantiated
// - View Models have 3 sections
// 
// Input Section
//     1: Update Data Model (here using a shared View Model)
//     2: Update Context Mgr and Trigger UI Refresh
//
// Refresh Section:
//     Update matching VC if present
//
// Accessor:
//     Process read request toward DataModel and/or Context Mgr (here using a shared View Model)
//

import Foundation
import AppKit

class Scene2ViewModel: NSObject
{
    // MARK: Interfaces
    unowned var dataModel : DataModel
    weak var viewController : Scene2ViewController?
    weak var contextMgr : ContextMgr? {
        return self.dataModel.document?.contextMgr
    }
    unowned var sharedVm : SharedViewModel {
        return self.dataModel.vm.sharedViewModel
    }

    init(dataModel : DataModel)
    {
        self.dataModel = dataModel
        super.init()
    }

    // MARK: - View Controller Registration
    func register(viewController: Scene2ViewController)
    {
        self.viewController = viewController
    }

    func unregister(viewController: Scene2ViewController)
    {
        if self.viewController == viewController
        {
            // Clear Memory if needed
            self.viewController = nil
        }
    }


    // MARK: - Input Processing
    // Could be replaced by a direct call to shared view model from view controller
    func setValue2(numberStr: String, focus: NSObject?)
    {
        self.sharedVm.setValue2(numberStr, focus: focus)
    }


    // MARK: - Refresh
    func refreshView(focus: NSObject?)
    {
        self.viewController?.refreshView(focus)
    }


    // MARK: - Data Model Accessor
    // Could be replaced by a direct call to shared view model from view controller
    func getValue2() -> String {
        return self.sharedVm.getValue2()
    }

    func getSum() -> Int?
    {
        return self.sharedVm.getSum()
    }

}