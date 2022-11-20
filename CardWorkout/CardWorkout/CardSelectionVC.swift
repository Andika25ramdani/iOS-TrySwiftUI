import UIKit

class CardSelectionVC: UIViewController {

	@IBOutlet weak var cardImageView: UIImageView!
	@IBOutlet var buttons: [UIButton]!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		for button in buttons {
			button.layer.cornerRadius = 8
		}
	}

	@IBAction func stoppedButtonTapped(_ sender: UIButton) {
	}
	@IBAction func restartButtonTapped(_ sender: UIButton) {
	}
	@IBAction func rulesButtonTapped(_ sender: UIButton) {
	}
}

