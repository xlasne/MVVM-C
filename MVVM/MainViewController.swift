//
//  ViewController.swift
//  MVVM
//
//  Created by Xavier on 08/04/16.
//  Copyright © 2016 XL Software Solutions. MIT License
//


// Parent View Controller shall create and initialize their child view controller
// with their matching view models, then let them handle their live via their own view model

import Cocoa

class MainViewController: NSViewController {

    // MARK: Interfaces
    weak var document: Document?
    weak var contextMgr : ContextMgr? {
        return self.document?.contextMgr
    }
    weak var viewModel: MainViewModel?

    @IBOutlet weak var viewTop : NSView!
    @IBOutlet weak var viewBottomLeft : NSView!
    @IBOutlet weak var viewBottomRight : NSView!

    var vc1 : Scene1ViewController?
    var vc2 : Scene2ViewController?
    var vc3 : Scene2ViewController?

    override func viewWillAppear() {
        super.viewWillAppear()
        // Do any additional setup after loading the view.

        guard let window = self.view.window else { return }
        guard let document = NSDocumentController.sharedDocumentController().documentForWindow(window) as? Document else { return }

        self.document = document

        self.viewModel = document.dataModel.vm.mainViewModel
        self.viewModel?.register(self)

        self.refreshUI()
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        self.viewModel?.unregister(self)
    }

    func refreshUI()
    {
        self.displayTopView()
        self.displayLeftView()
        self.displayRightView()
    }

    func displayTopView()
    {
        if self.vc1 == nil {
            let vc1 = Scene1ViewController()
            vc1.viewModel = self.document?.dataModel.vm.scene1ViewModel
            self.vc1 = vc1
            Helper.addToContainerView(self.viewTop, subView: vc1.view)
            self.addChildViewController(vc1)
        }
    }

    func displayLeftView()
    {
        guard let isPresent = self.contextMgr?.leftViewPresent else { return }
        if isPresent
        {
            if let vc = self.vc2 {
                vc.view.removeFromSuperview()
                vc.removeFromParentViewController()
                self.vc2 = nil
            }
        } else {
            if self.vc2 == nil {
                let vc2 = Scene2ViewController()
                vc2.viewModel = self.document?.dataModel.vm.scene2ViewModel
                self.vc2 = vc2
                self.addChildViewController(vc2)
                Helper.addToContainerView(self.viewBottomLeft, subView: vc2.view)
            }
        }
    }

    func displayRightView()
    {
        guard let isPresent = self.contextMgr?.rightViewPresent else { return }
        if isPresent
        {
            if let vc = self.vc3 {
                vc.view.removeFromSuperview()
                vc.removeFromParentViewController()
                self.vc3 = nil
            }
        } else {
            if self.vc3 == nil {
                let vc3 = Scene2ViewController()
                vc3.viewModel = self.document?.dataModel.vm.view3ViewModel
                self.vc3 = vc3
                self.addChildViewController(vc3)
                Helper.addToContainerView(self.viewBottomRight, subView: vc3.view)
            }
        }
    }

}


