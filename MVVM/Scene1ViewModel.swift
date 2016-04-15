//
//  Scene1ViewModel.swift
//  MVVM
//
//  Created by Xavier on 08/04/16.
//  Copyright © 2016 XL Software Solutions. MIT License
//

// KEYPOINT 4

// - View Model belong to the Data Model hierarchy, and are always instantiated
// - View Models have 3 sections
//
// Input Section
//     1: Update Data Model
//     2: Update Context Mgr and Trigger UI Refresh
//
// Refresh Section:
//     Update matching VC if present
//
// Accessor:
//     Process read request toward DataModel and/or Context Mgr
//
// Remark: there is a 1 to 1 relationship between View Model and View Controller
// Maintained by weak reference on both sides
// I don't use protocol because it is extra lines with little gain because of this 1 to 1 relationship.

import Foundation
import AppKit

class Scene1ViewModel: NSObject
{
    // MARK: Interfaces
    unowned var dataModel : DataModel
    weak var viewController : Scene1ViewController?

    weak var contextMgr : ContextMgr? {
        return self.dataModel.document?.contextMgr
    }

    init(dataModel : DataModel)
    {
        self.dataModel = dataModel
        super.init()
    }

    // MARK: - View Controller - View Model Registration
    func register(viewController: Scene1ViewController)
    {
        self.viewController = viewController
    }

    func unregister(viewController: Scene1ViewController)
    {
        if self.viewController == viewController
        {
            // Clear Memory if needed
            self.viewController = nil
        }
    }

    // MARK: - Input Processing
    // 1: First update data model variable without UI refresh
    // 2: Then update context variable with UI Refresh

    func updateValue(numberStr: String, focus: NSObject?)
    {
        let formatter = NSNumberFormatter()
        if let val = formatter.numberFromString(numberStr)?.integerValue
        {
            // 1: Update Data Model if needed
            if val != self.dataModel.number1
            {
                self.dataModel.number1 = val
            }

            // 2: Update Context Manager
            self.contextMgr?.refreshWithFocus(focus)
        } else {
            NSBeep()
        }
    }

    func toggleLeftView()
    {
        self.contextMgr?.toggleLeftView()
    }

    func toggleRightView()
    {
        self.contextMgr?.toggleRightView()
    }

    // MARK: - Refresh Request from Context Manager
    // No data model update allowed
    func refreshView(focus: NSObject?)
    {
        self.viewController?.refreshView(focus)
    }

    
    // MARK: - Get Data Model - Read Only request
    var value1: String {
        get {
            let formatter = NSNumberFormatter()
            let val = self.dataModel.number1
            return  formatter.stringFromNumber(val) ?? "Error"
        }
    }

    func getSum() -> Int?
    {
        return self.dataModel.getSum()
    }

}