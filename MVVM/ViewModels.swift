//
//  ViewModels.swift
//  MVVM
//
//  Created by Xavier on 09/04/16.
//  Copyright © 2016 XL Software Solutions. MIT License
//


// KEYPOINT 2: View Model factory
// Generate one view model per view controller

import Foundation

class ViewModels
{
    unowned var dataModel: DataModel

    private var mainVMPrivate     : MainViewModel?
    private var sharedVMPrivate   : SharedViewModel?
    private var scene1VMPrivate   : Scene1ViewModel?
    private var scene2_1VMPrivate : Scene2ViewModel?
    private var scene2_2VMPrivate : Scene2ViewModel?

    init(dataModel: DataModel)
    {
        self.dataModel = dataModel
    }

    var mainViewModel : MainViewModel {
        self.mainVMPrivate = self.mainVMPrivate ?? MainViewModel(dataModel: self.dataModel)
        return self.mainVMPrivate!
    }

    var scene1ViewModel : Scene1ViewModel {
        if let vm = self.scene1VMPrivate {
            return vm
        } else {
            let vm = Scene1ViewModel(dataModel: self.dataModel)
            self.scene1VMPrivate = vm
            return vm
        }
    }

    var scene2ViewModel : Scene2ViewModel {
        self.scene2_1VMPrivate = self.scene2_1VMPrivate ?? Scene2ViewModel(dataModel: self.dataModel)
        return self.scene2_1VMPrivate!
    }

    var view3ViewModel : Scene2ViewModel {
        self.scene2_2VMPrivate = self.scene2_2VMPrivate ?? Scene2ViewModel(dataModel: self.dataModel)
        return self.scene2_2VMPrivate!
    }

    var sharedViewModel : SharedViewModel {
        self.sharedVMPrivate = self.sharedVMPrivate ?? SharedViewModel(dataModel: self.dataModel)
        return self.sharedVMPrivate!
    }



}

