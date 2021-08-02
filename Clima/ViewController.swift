//
//  ViewController.swift
//  Clima
//
//  Created by Sai Reddy on 02/08/21.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempValue: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var textInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

