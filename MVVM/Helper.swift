//
//  Helper.swift
//  MVVM
//
//  Created by Xavier on 08/04/16.
//  Copyright © 2016 XL Software Solutions. MIT License
//

import AppKit


class Helper
{

    class func addToContainerView(myView: NSView, subView subViewZ: NSView?) {
        if let subView = subViewZ
        {
            myView.addSubview(subView)

            let views = ["view": myView, "subView": subView]

            subView.translatesAutoresizingMaskIntoConstraints = false

            let constH = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[subView]-0-|", options: .AlignAllCenterY, metrics: nil, views: views)
            myView.addConstraints(constH)
            let constW = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[subView]-0-|", options: .AlignAllCenterX, metrics: nil, views: views)
            myView.addConstraints(constW)
        }
    }
}
