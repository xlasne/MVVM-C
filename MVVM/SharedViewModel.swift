//
//  Scene2ViewModel.swift
//  MVVM
//
//  Created by Xavier on 08/04/16.
//  Copyright © 2016 XL Software Solutions. MIT License
//

import Foundation
import AppKit

class SharedViewModel: NSObject
{
    // MARK: Interfaces
    unowned var dataModel : DataModel

    weak var contextMgr : ContextMgr? {
        return self.dataModel.document?.contextMgr
    }

    init(dataModel : DataModel)
    {
        self.dataModel = dataModel
        super.init()
    }


    // MARK: - Input Processing
    func setValue2(numberStr: String, focus: NSObject?)
    {
        let formatter = NSNumberFormatter()
        if let val = formatter.numberFromString(numberStr)?.integerValue
        {
            // 1: Update Data Model if needed
            if val != self.dataModel.number2
            {
                self.dataModel.number2 = val
            }

            // 2: Update Context Manager
            self.contextMgr?.refreshWithFocus(focus)
        } else {
            NSBeep()
        }
    }

    // MARK: - Get Data Model
    func getValue2() -> String {
        let formatter = NSNumberFormatter()
        let val = self.dataModel.number2
        return  formatter.stringFromNumber(val) ?? "Error"
    }

    func getSum() -> Int?
    {
        return self.dataModel.getSum()
    }

}