//
//  Placeholder.swift
//  SAMaterialTextField
//
//  Created by Saqib Saud on 19/7/19.
//  Copyright © 2019 Saqib Saud. All rights reserved.
//

import Foundation
import UIKit

protocol SAMaterialTextFieldView {
    func materialTextFieldDidBeginEditing(_ textField: SAMaterialTextField)
    func materialTextFieldDidEndEditing(_ textField: SAMaterialTextField)
    func materialTextFieldDidUpdateText(_ textField: SAMaterialTextField)
    func configure(forMaterialTextField textField: SAMaterialTextField)
}
/*
 * Optional Methods
 */
extension SAMaterialTextFieldView {
    func materialTextFieldDidBeginEditing(_ textField: SAMaterialTextField) {
    }
    func materialTextFieldDidEndEditing(_ textField: SAMaterialTextField) {
    }
    func materialTextFieldDidUpdateText(_ textField: SAMaterialTextField) {
    }
}
protocol SAMaterialTextPlaceholder: SAMaterialTextFieldView {
    var placeholder: String? { get set}
    var maxHeight: CGFloat { get set}
    var minHeight: CGFloat { get set}
}

class SAPlaceHolder: UILabel, SAMaterialTextPlaceholder {
    var maxHeight: CGFloat = 0.0
    var minHeight: CGFloat = 14.0
    
    var placeholderColor: UIColor = .lightGray
    var titleColor: UIColor = .darkGray
    
    var titleFont = UIFont.systemFont(ofSize: 12.0)
    var placeholderFont = UIFont.systemFont(ofSize: 17.0)
    
    var placeholder: String? {
        set {
            self.text = newValue
        }
        get {
            return self.text
        }
    }
    var isEditing = false
    @objc dynamic open var titleFadeInDuration: TimeInterval = 0.2
    @objc dynamic open var titleFadeOutDuration: TimeInterval = 0.3

    func materialTextFieldDidUpdateText(_ textField: SAMaterialTextField) {
        if textField.text?.count ?? 0 > 0 {
            isEditing = true
        } else {
            isEditing = false
        }
        updateTitleVisibility(true)
    }
    func configure(forMaterialTextField textField: SAMaterialTextField) {
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
        return CGRect(x: 0, y: 3, width: bounds.size.width, height: maxHeight)
    }
    
}


