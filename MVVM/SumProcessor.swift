//
//  SumProcessor.swift
//  MVVM
//
//  Created by Xavier on 09/04/16.
//  Copyright © 2016 XL Software Solutions. MIT License
//

// Owned by Data Model
// Example of performing processing in background
// After background update, update data model on the main thread
//  and triggers UI refresh via Context Mgr


import Foundation

class SumProcessor: NSObject
{

    weak var dataModel : DataModel?

    override init()
    {
        super.init()
    }

    func startProcessing()
    {

        let completionHandler = { (numVal:Int)->() in
            dispatch_async(dispatch_get_main_queue()) {[weak self] _ in
                // No locking needed. 
                // Modifications are performed while on the main thread which serialize update
                self?.dataModel?.sumOfNumber = numVal
                self?.dataModel?.contextMgr?.refresh()
            }
        }

        if let number1 = self.dataModel?.number1,
            let number2 = self.dataModel?.number2
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                // DO SOMETHING ON THE BACKGROUND THREAD
                // Avoid threading conflict with Data Model
                sleep(2)
                let sumVal = number1 + number2
                completionHandler(sumVal)
            }
        }
    }
}