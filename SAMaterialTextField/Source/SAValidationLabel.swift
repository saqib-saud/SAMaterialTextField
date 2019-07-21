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

public class SAValdationLabel: UILabel, SAMaterialTextFieldView {
    public func configure(forMaterialTextField textField: SAMaterialTextField) {
        
    }
    var validatorRules = ValidationRuleSet<String>()
    public func materialTextFieldDidEndEditing(_ textField: SAMaterialTextField) {
        guard let text = textField.text else { return }
        switch text.validate(rules: validatorRules) {
        case .valid:
            self.isHidden = true
        case .invalid(let failures):
            self.isHidden = false
            self.text = failures.first?.message
        }
    }
}

extension SAValdationLabel {
    public class func emailValidator() -> SAValdationLabel {
        let validationLabel = SAValdationLabel()
        validationLabel.validatorRules.add(rule: ValidationRulePattern(pattern: EmailValidationPattern.standard, error: SAValidationError("Invalid email address")))
        return validationLabel
    }
    public class func requiredFieldValidator() -> SAValdationLabel {
        let validationLabel = SAValdationLabel()
        let validationError = SAValidationError("Field is required")
        validationLabel.validatorRules.add(rule: ValidationRuleLength(min: 2, error: validationError))
        return validationLabel
    }
    public class func phoneNumberValidator() -> SAValdationLabel {
        let validationLabel = SAValdationLabel()
        let validationError = SAValidationError("Please enter valid phone number")
//        let validationErrorWrongNumber = SAValidationError("Please enter a valid mobile phone number starting with 04")
        let validationErrorNotNumber = SAValidationError("Please enter digits only")
        let digitRule = ValidationRulePattern(pattern: ContainsNumberValidationPattern(), error: validationErrorNotNumber)
        validationLabel.validatorRules.add(rule: ValidationRuleLength(min: 10, error: validationError))
//        validationLabel.validatorRules.add(rule: ValidationRulePattern(pattern: "04*", error: validationErrorWrongNumber))
        validationLabel.validatorRules.add(rule: digitRule)
        return validationLabel
    }
}
