//
//  ColorsDetailVC.swift
//  RandomColors
//
//  Created by dev22 jumpa on 18/11/22.
//

import UIKit

class ColorsDetailVC: UIViewController {
	
	var color: UIColor?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = color ?? UIColor.systemBlue
	}
}
