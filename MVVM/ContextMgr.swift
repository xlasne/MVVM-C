//
//  ContextMgr.swift
//  MVVM
//
//  Created by Xavier on 08/04/16.
//  Copyright © 2016 XL Software Solutions. MIT License
//

//KEYPOINT 5
// Responsible for consistent refresh of UI
// Manage view controllers dependency
// Send request to View Models, who triggers view controllers UI refresh when their matching view controller is present


import Foundation


class ContextMgr
{
    // MARK: Interfaces
    unowned var document : Document
    weak var dataModel : DataModel?

    var currentFocus: NSObject?
    var leftViewPresent : Bool = false
    var rightViewPresent : Bool = false

    init(document: Document, dataModel: DataModel)
    {
        self.document = document
        self.dataModel = dataModel
    }

    func toggleLeftView()
    {
        leftViewPresent = !leftViewPresent
        dataModel?.vm.mainViewModel.refreshUI()
    }

    func toggleRightView()
    {
        rightViewPresent = !rightViewPresent
        dataModel?.vm.mainViewModel.refreshUI()
    }

    func refreshWithFocus(focus: NSObject?)
    {
        currentFocus = focus
        refresh()
    }

    func refresh()
    {
        dataModel?.vm.scene1ViewModel.refreshView(currentFocus)
        dataModel?.vm.scene2ViewModel.refreshView(currentFocus)
        dataModel?.vm.view3ViewModel.refreshView(currentFocus)
    }



}