//
//  RadioAndCheckboxButton.swift
//  RadioAndCheckboxButtonDemo
//
//  Created by Manish Bhande on 11/02/18.
//  Copyright © 2018 Manish. All rights reserved.
//

import Foundation
import UIKit

public class RadioAndCheckboxButton: UIButton {
    
    private var sizeChangeObserver: NSKeyValueObservation?
    
    internal var allowDeselection: Bool {
        return false
    }
    
    @objc dynamic public var isActive = false {
        didSet {
            updateSelectionState()
            //   callDelegate()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public convenience init?(type buttonType: UIButtonType) {
        return nil
    }
    
    internal func setup() {
        // Add action here
        addTarget(self, action: #selector(selectionAction), for: .touchUpInside)
        contentHorizontalAlignment = .left
        addObserverSizeChange()
        setupLayer()
    }
    
    @objc internal func selectionAction(_ sender: RadioButton) {
        // If toggle enable, change selection state
        if allowDeselection {
            isActive = !isActive
        } else {
            isActive = true
        }
    }
    
    public func updateSelectionState() {
        if isActive {
            updateActiveLayer()
        } else {
            updateInactiveLayer()
        }
    }
    
    internal func setupLayer() {
        updateSelectionState()
    }
    
    internal func updateActiveLayer() { }
    
    internal func updateInactiveLayer() { }
}

//MARK:- frame change handler
extension RadioAndCheckboxButton {
    
    private func addObserverSizeChange() {
        sizeChangeObserver = observe(\RadioAndCheckboxButton.center, changeHandler: sizeChangeObseveHandler)
    }
    
    private func sizeChangeObseveHandler(_ object: RadioAndCheckboxButton, _ change: NSKeyValueObservedChange<CGPoint>) {
        setupLayer()
    }
    
}
