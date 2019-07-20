//
//  SAMaterialTextField.swift
//  SAMaterialTextField
//
//  Created by Saqib Saud on 19/7/19.
//  Copyright © 2019 Saqib Saud. All rights reserved.
//

import UIKit

class SAMaterialTextField: UITextField {
    var floatingPlaceHolder: (UIView & SAMaterialTextPlaceholder)? {
        didSet {
            guard let view = floatingPlaceHolder else { return }
            addSubview(view)
        }
    }
    var bottomView: (UIView & SAMaterialTextFieldView)? {
        didSet {
            guard let view = bottomView else { return }
            view.isHidden = true
            view.frame = CGRect(x: 0, y: bounds.size.height/2 + 10, width: bounds.size.width, height: bounds.size.height/2)
            addSubview(view)
        }
    }
    var titleHeight: CGFloat {
        if let placeholder = floatingPlaceHolder {
            return placeholder.maxHeight
        } else {
            return 0.0
        }
    }
    var bottomBorderHeight: CGFloat {
        return 1.0
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate final func setup() {
        addEditingChangedObserver()
        draw(textRect(forBounds: bounds))
        self.textColor = .darkText
    }
    fileprivate func addEditingChangedObserver() {
        self.addTarget(self, action: #selector(editingBegin), for: .editingChanged)
        self.addTarget(self, action: #selector(editingEnd), for: .editingDidEnd)
        self.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc open func editingBegin() {
        if let placeholder = floatingPlaceHolder {
            placeholder.materialTextFieldDidBeginEditing(self)
        }
        if let bottomContainer = bottomView {
            bottomContainer.materialTextFieldDidBeginEditing(self)
        }
    }
    @objc open func editingEnd() {
        if let placeholder = floatingPlaceHolder {
            placeholder.materialTextFieldDidEndEditing(self)
        }
        if let bottomContainer = bottomView {
            bottomContainer.materialTextFieldDidEndEditing(self)
        }
    }
    @objc open func editingChanged() {
        if let placeholder = floatingPlaceHolder {
            placeholder.materialTextFieldDidUpdateText(self)
        }
        if let bottomContainer = bottomView {
            bottomContainer.materialTextFieldDidUpdateText(self)
        }
    }
    
    fileprivate func updatedTextRect(_ textRect: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: textRect.origin.x, y: textRect.origin.y + (floatingPlaceHolder?.minHeight ?? 0)), size: CGSize(width: textRect.size.width, height: self.frame.size.height - (floatingPlaceHolder?.minHeight ?? 0) - bottomBorderHeight))
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let textRect = super.textRect(forBounds: bounds)
        return updatedTextRect(textRect)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let textRect = super.editingRect(forBounds: bounds)
        return updatedTextRect(textRect)
    }
    
    override var placeholder: String? {
        set {
            floatingPlaceHolder?.placeholder = newValue
        }
        get {
            return floatingPlaceHolder?.placeholder
        }
    }
    override func draw(_ rect: CGRect)
    {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.gray.cgColor)
        context.setLineWidth(1)
        context.move(to: CGPoint(x: 0, y: bounds.height/2 + 10 ))
        context.addLine(to: CGPoint(x: bounds.width, y: bounds.height/2 + 10))
        context.strokePath()
        
    }
}
