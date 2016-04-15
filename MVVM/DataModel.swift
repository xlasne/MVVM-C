//
//  DataModel.swift
//  MVVM
//
//  Created by Xavier on 08/04/16.
//  Copyright © 2016 XL Software Solutions. MIT License
//

//KEYPOINT 1:
// Manage stored data hierarchy and dependencies
// Unaware of View Controllers
// After external Stored Data update, does not trigger refresh because unaware of the context of these updates
// After progress / background update, triggers UI refresh via Context Mgr (ex: Sum Processor)

import Foundation
import AppKit

class DataModel : NSObject, NSCoding
{

    // MARK: Interfaces
    weak var document: Document?
    lazy var vm: ViewModels = ViewModels(dataModel:self)
    
    var contextMgr: ContextMgr? {
        return self.document?.contextMgr
    }

    // MARK: Stored Content
    var number1 : Int {
        didSet {
            self.document?.updateChangeCount(NSDocumentChangeType.ChangeDone)
            self.sumProcessor.startProcessing()
        }
    }
    var number2 : Int {
        didSet {
            self.document?.updateChangeCount(NSDocumentChangeType.ChangeDone)
            self.sumProcessor.startProcessing()
        }
    }

    // MARK: Computed Content
    var sumOfNumber : Int?
    var sumProcessor: SumProcessor = SumProcessor()


    // MARK: Standard Initialization
    override init()
    {
        self.number1 = 1
        self.number2 = 2
        super.init()
        self.endOfInit()
    }

    func endOfInit()
    {
        self.sumProcessor.dataModel = self
        self.sumProcessor.startProcessing()
    }

    //MARK: NSCoding Initialization
    private struct SerializationKeys {
        static let number1  = "number1"
        static let number2  = "number2"
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(number1, forKey: SerializationKeys.number1)
        aCoder.encodeInteger(number2, forKey: SerializationKeys.number2)
    }

    required init?(coder aDecoder: NSCoder) {
        self.number1 = aDecoder.decodeIntegerForKey(SerializationKeys.number1)
        self.number2 = aDecoder.decodeIntegerForKey(SerializationKeys.number2)
        super.init()
        self.endOfInit()
    }
}


//MARK: - Data Model Processing
extension DataModel
{
    func getSum() -> Int?
    {
        return self.sumOfNumber
    }
}










