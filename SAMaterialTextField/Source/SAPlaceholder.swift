//
//  Placeholder.swift
//  SAMaterialTextField
//
//  Created by Saqib Saud on 19/7/19.
//  Copyright © 2019 Saqib Saud. All rights reserved.
//

import Foundation
import UIKit

public protocol SAMaterialTextFieldView {
    func materialTextFieldDidBeginEditing(_ textField: SAMaterialTextField)
    func materialTextFieldDidEndEditing(_ textField: SAMaterialTextField)
    func materialTextFieldDidUpdateText(_ textField: SAMaterialTextField)
    func configure(forMaterialTextField textField: SAMaterialTextField)
}
/*
 * Optional Methods
 */
extension SAMaterialTextFieldView {
    public func materialTextFieldDidBeginEditing(_ textField: SAMaterialTextField) {
    }
    public func materialTextFieldDidEndEditing(_ textField: SAMaterialTextField) {
    }
    public func materialTextFieldDidUpdateText(_ textField: SAMaterialTextField) {
    }
}
public protocol SAMaterialTextPlaceholder: SAMaterialTextFieldView {
    var placeholder: String? { get set}
    var maxHeight: CGFloat { get set}
    var minHeight: CGFloat { get set}
    var titleColor: UIColor { get set}
    var titleFont: UIFont { get set}
    var placeholderColor: UIColor { get set}
    var placeholderFont: UIFont { get set}
    var isEditing: Bool { get set}
}

public class SAPlaceHolder: UILabel, SAMaterialTextPlaceholder {
    public var maxHeight: CGFloat = 0.0
    public var minHeight: CGFloat = 14.0
    
    public var placeholderColor: UIColor = .lightGray {
        didSet {
            self.textColor = placeholderColor
        }
    }
    public var titleColor: UIColor = .darkGray
    
    public var titleFont = UIFont.systemFont(ofSize: 12.0)
    public var placeholderFont = UIFont.systemFont(ofSize: 17.0)
    
    public var placeholder: String? {
        set {
            self.text = newValue
        }
        get {
            return self.text
        }
    }
    public var isEditing = false {
        didSet {
            updateTitleVisibility(true)
        }
    }
    @objc dynamic open var titleFadeInDuration: TimeInterval = 0.2
    @objc dynamic open var titleFadeOutDuration: TimeInterval = 0.3

    public func materialTextFieldDidUpdateText(_ textField: SAMaterialTextField) {
        if textField.text?.count ?? 0 > 0 {
            isEditing = true
        } else {
            isEditing = false
        }
        updateTitleVisibility(true)
    }
    public func configure(forMaterialTextField textField: SAMaterialTextField) {
        self.font = textField.font
        
        self.textColor = placeholderColor
        maxHeight = textField.textRect(forBounds: textField.bounds).height
        self.backgroundColor = .clear
        self.adjustsFontSizeToFitWidth = true
        self.frame = titleLabelRectForBounds(textField.bounds, editing: false)
    }
    
    fileprivate func updateTitleVisibility(_ animated: Bool = false, completion: ((_ completed: Bool) -> Void)? = nil) {
        let alpha: CGFloat = isEditing ? 1.0 : 1.0
        let activeColor = isEditing ? titleColor : placeholderColor
        let font = isEditing ? titleFont : placeholderFont
        let frame: CGRect = titleLabelRectForBounds(bounds, editing: isEditing)
        let updateBlock = { () -> Void in
            self.alpha = alpha
            self.frame = frame
            self.font = font
            self.textColor = activeColor
        }
        if animated {
            let animationOptions: UIView.AnimationOptions = .curveEaseOut
            let duration = isEditing ? titleFadeInDuration : titleFadeOutDuration
            UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: { () -> Void in
                updateBlock()
            }, completion: completion)
        } else {
            updateBlock()
            completion?(true)
        }
    }
    
    open func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRect(x: 0, y: 3, width: bounds.size.width, height: minHeight)
        }
        return CGRect(x: 0, y: 0, width: bounds.size.width, height: maxHeight - 10)
    }
    
}


