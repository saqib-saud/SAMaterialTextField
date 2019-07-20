//
//  SAMaterialTextFieldBuilder.swift
//  SAMaterialTextField
//
//  Created by Saqib Saud on 20/7/19.
//  Copyright © 2019 Saqib Saud. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

struct SAMaterialTextFieldBuilder {
    enum Style {
        case requestedAmount
        case duration
        case loanReason
        case title
        case firstName
        case lastName
        case datOfBirth
        case email
        case mobileNumber
    }
    func build(_ style: Style) -> SAMaterialTextField {
        let textField = SAMaterialTextField()
        return configure(field: textField, style: style)
    }
    fileprivate func configureFieldTitle(_ style: SAMaterialTextFieldBuilder.Style, _ field: SAMaterialTextField) {
        switch style {
        case .requestedAmount:
            field.placeholder = "Requested Amount"
        case .duration:
            field.placeholder = "Duration"
        case .loanReason:
            field.placeholder = "Loan Reason"
        case .title:
            field.placeholder = "Title"
        case .firstName:
            field.placeholder = "First Name"
        case .lastName:
            field.placeholder = "Last Name"
        case .datOfBirth:
            field.placeholder = "Date of birth"
        case .email:
            field.placeholder = "Your email"
        case .mobileNumber:
            field.placeholder = "Mobile number"
        }
    }
    
    func configure(field: SAMaterialTextField, style: Style) -> SAMaterialTextField {
        field.floatingPlaceHolder = buildFloatingPlaceholder(forField: field)
        field.rightView = buildRightView(forField: field, withStyle: style)
        configureFieldTitle(style, field)
        return field
    }
    private func buildFloatingPlaceholder(forField field: SAMaterialTextField) -> SAPlaceHolder {
        let placeholder = SAPlaceHolder()
        placeholder.configure(forMaterialTextField: field)
        return placeholder
    }
    private func buildRightView(forField field: SAMaterialTextField, withStyle style: Style) -> UILabel? {
        let icon = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 25, height: 25)))
        icon.font = UIFont.fontAwesome(ofSize: 25, style: .solid)
        icon.textColor = .black
        switch style {
        case .requestedAmount:
            icon.text = String.fontAwesomeIcon(name: .caretDown)
        case .duration:
            icon.text = String.fontAwesomeIcon(name: .caretDown)
        case .loanReason:
            icon.text = String.fontAwesomeIcon(name: .clone)
        default:
            return nil
            
        }
        return icon

    }
}
