//
//  Scene1ViewController.swift
//  MVVM
//
//  Created by Xavier on 08/04/16.
//  Copyright © 2016 XL Software Solutions. MIT License
//

// KEYPOINT 3
// - View Controller are not aware of the content / context of parent/child view controllers
// - View Controller belongs to the View Controller hierarchy, and may be present or not

// - View Controller only discuss with their matching View Model
// - View Controller are responsible for register/unregister with their matching view model

// - View Controller contains an Input Section with update toward view model and no UI refresh
// - View Controller contains a Refresh Section with UI refresh and no update

import Cocoa

class Scene1ViewController: NSViewController, NSTextFieldDelegate {

    override var nibName: String? {
        return "Scene1ViewController"
    }

    //View Model
    weak var viewModel : Scene1ViewModel?

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var label: NSTextField!

    @IBOutlet weak var showHideLeft: NSButton!
    @IBOutlet weak var showHideRight: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.textField.target = self
        self.textField.delegate = self
        self.textField.action = #selector(Scene1ViewController.numberFieldUpdated(_:))

        self.showHideLeft.target = self
        self.showHideLeft.action = #selector(Scene1ViewController.showHideView(_:))
        self.showHideRight.target = self
        self.showHideRight.action = #selector(Scene1ViewController.showHideView(_:))

    }

    override func viewWillAppear() {
        super.viewWillAppear()
        self.viewModel?.register(self)
        self.refreshView(nil)
    }

    override func viewWillDisappear() {
        self.viewModel?.unregister(self)
        super.viewWillDisappear()
    }


    //MARK: - Input Section

    override func controlTextDidChange(obj: NSNotification) {
        if let sender = obj.object as? NSTextField where  sender == self.textField
        {
            self.numberFieldUpdated(sender)
        }
    }

    func numberFieldUpdated(sender: NSTextField)
    {
        let numberStr = self.textField.stringValue
        self.viewModel?.updateValue(numberStr, focus: sender)
    }

    func showHideView(sender: NSButton)
    {
        if sender == self.showHideLeft
        {
            self.viewModel?.toggleLeftView()
        }
        if sender == self.showHideRight
        {
            self.viewModel?.toggleRightView()
        }
    }

    //MARK: - Refresh View
    func refreshView(focus: NSObject?)
    {
        if let vm = self.viewModel
        {
            if self.textField != focus
            {
                self.textField.stringValue = vm.value1
            }
            if let sumVal = vm.getSum()
            {
                self.label.stringValue = "Sum 1 + 2: \(sumVal)"
            } else {
                self.label.stringValue = "Sum 1 + 2: _"
            }
        }
    }
}


