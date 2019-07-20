//
//  SAValidationError.swift
//  SAMaterialTextField
//
//  Created by Saqib Saud on 19/7/19.
//  Copyright © 2019 Saqib Saud. All rights reserved.
//

import Foundation
import Validator

struct SAValidationError: ValidationError {
    
    let message: String
    
    public init(_ message: String) {
        
        self.message = message
    }
}
