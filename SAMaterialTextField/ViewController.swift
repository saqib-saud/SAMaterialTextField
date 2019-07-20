//
//  ViewController.swift
//  SAMaterialTextField
//
//  Created by Saqib Saud on 19/7/19.
//  Copyright © 2019 Saqib Saud. All rights reserved.
//

import UIKit
import FontAwesome_swift

class ViewController: UIViewController {

    @IBOutlet weak var materialTextView: SAMaterialTextField!
    @IBOutlet weak var largeMaterialTextField: SAMaterialTextField!
    @IBOutlet weak var zards: UITextField!
    @IBOutlet weak var aikwari: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let placeholder = SAPlaceHolder()
        let placeholder2 = SAPlaceHolder()
        placeholder2.configure(forMaterialTextField: materialTextView)
        materialTextView.floatingPlaceHolder = placeholder2
        materialTextView.placeholder = "Testing 1 2 3"
        let icon = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 25, height: 25)))
        icon.textColor = .black
        icon.font = UIFont.fontAwesome(ofSize: 25, style: .solid)
        icon.text = String.fontAwesomeIcon(name: .caretDown)
        largeMaterialTextField.rightView = icon
        largeMaterialTextField.rightViewMode = .always
        placeholder.configure(forMaterialTextField: largeMaterialTextField)
        largeMaterialTextField.floatingPlaceHolder = placeholder
        largeMaterialTextField.placeholder = "Testing 1 2dsfdfsd3"
        
        let warning = SAValdationLabel.emailValidator()
        warning.text = "Some really serious warning"
        warning.textColor = .red
        warning.font = UIFont.systemFont(ofSize: 12)
        largeMaterialTextField.bottomView = warning
        // Do any additional setup after loading the view.
    }


}

