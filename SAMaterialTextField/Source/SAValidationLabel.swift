//
//  ValidationLabel.swift
//  SAMaterialTextField
//
//  Created by Saqib Saud on 19/7/19.
//  Copyright © 2019 Saqib Saud. All rights reserved.
//

import Foundation
import UIKit
import Validator

class SAValdationLabel: UILabel, SAMaterialTextFieldView {
    func configure(forMaterialTextField textField: SAMaterialTextField) {
        
    }
    var validatorPattern: ValidationRulePattern?
    func materialTextFieldDidEndEditing(_ textField: SAMaterialTextField) {
        guard let validationPattern = validatorPattern else { return }
        guard let text = textField.text else { return }
        switch text.validate(rule: validationPattern) {
        case .valid:
            self.isHidden = true
        case .invalid(let failures):
            self.isHidden = false
            self.text = failures.first?.message
        }
    }
}

extension SAValdationLabel {
    class func emailValidator() -> SAValdationLabel {
        let validationLabel = SAValdationLabel()
        validationLabel.validatorPattern = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: SAValidationError("Invalid email address"))
        return validationLabel
    }
}
