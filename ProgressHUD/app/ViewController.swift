//
// Copyright (c) 2023 Related Code - https://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

// MARK: - AnimationType
extension AnimationType {
	var text: String {
		switch self {
		case .none:							return "No Animation"
		case .systemActivityIndicator:		return "System Activity Indicator"
		case .horizontalCirclesPulse:		return "Horizontal Circles Pulse"
		case .lineScaling:					return "Line Scaling"
		case .singleCirclePulse:			return "Single Circle Pulse"
		case .multipleCirclePulse:			return "Multiple Circle Pulse"
		case .singleCircleScaleRipple:		return "Single Circle Scale Ripple"
		case .multipleCircleScaleRipple:	return "Multiple Circle Scale Ripple"
		case .circleSpinFade:				return "Circle Spin Fade"
		case .lineSpinFade:					return "Line Spin Fade"
		case .circleRotateChase:			return "Circle Rotate Chase"
		case .circleStrokeSpin:				return "Circle Stroke Spin"
		}
	}
}

// MARK: - AlertIcon
extension AlertIcon {
	var text: String {
		switch self {
		case .heart:		return "Heart"
		case .doc:			return "Doc"
		case .bookmark:		return "Bookmark"
		case .moon:			return "Moon"
		case .star:			return "Star"
		case .exclamation:	return "Exclamation"
		case .flag:			return "Flag"
		case .message:		return "Message"
		case .question:		return "Question"
		case .bolt:			return "Bolt"
		case .shuffle:		return "Shuffle"
		case .eject:		return "Eject"
		case .card:			return "Card"
		case .rotate:		return "Rotate"
		case .like:			return "Like"
		case .dislike:		return "Dislike"
		case .privacy:		return "Privacy"
		case .cart:			return "Cart"
		case .search:		return "Search"
		}
	}
}

// MARK: - ViewController
class ViewController: UITableViewController {

	@IBOutlet var cellText: UITableViewCell!

	var animations = AnimationType.allCases
	var alerticons = AlertIcon.allCases

	var actions1: [String] = []
	var actions2: [String] = []
	var actions3: [String] = []
	var actions4: [String] = []
	var actions5: [String] = []

	var timer: Timer?
	var status: String?
	var counter = 0.0

	let textShort	= "Please wait..."
	let textLong	= "Please wait. We need some more time to work out this situation."

	let textSuccess	= "That was awesome!"
	let textError	= "Something went wrong."

	let textSucceed	= "That was awesome!"
	let textFailed	= "Something went wrong."
	let textAdded	= "Successfully added."

	var boolText = false

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "ProgressHUD"

		actions1.append("Animation - No text")
		actions1.append("Animation - Short text")
		actions1.append("Animation - Longer text")

		actions2.append("Progress - No text")
		actions2.append("Progress - Short text")
		actions2.append("Progress - Longer text")

		actions3.append("Progress - 10%")
		actions3.append("Progress - 40%")
		actions3.append("Progress - 60%")
		actions3.append("Progress - 90%")

		actions4.append("Success - No text")
		actions4.append("Success - Short text")
		actions4.append("Error - No text")
		actions4.append("Error - Short text")

		actions5.append("Succeed - No text")
		actions5.append("Succeed - Short text")
		actions5.append("Failed - No text")
		actions5.append("Failed - Short text")
		actions5.append("Added - No text")
		actions5.append("Added - Short text")

		ProgressHUD.colorAnimation = .systemRed
		ProgressHUD.colorProgress = .systemRed
	}
}

// MARK: - Progress Methods
extension ViewController {

	func actionProgressStart(_ status: String? = nil) {
		counter = 0
		ProgressHUD.showProgress(status, counter/100)

		timer = Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { [weak self] _ in
			guard let self = self else { return }
			self.actionProgress(status)
		}
	}

	func actionProgress(_ status: String?) {
		counter += 1
		ProgressHUD.showProgress(status, counter/100)

		if (counter >= 100) {
			actionProgressStop(status)
		}
	}

	func actionProgressStop(_ status: String?) {
		timer?.invalidate()
		timer = nil

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
			ProgressHUD.showSucceed(status, interaction: false, delay: 0.75)
		}
	}
}

// MARK: - UITableViewDataSource
extension ViewController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 9
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if (section == 0) { return 2 }
		if (section == 1) { return 4 }

		if (section == 2) { return animations.count	}
		if (section == 3) { return actions1.count	}
		if (section == 4) { return actions2.count	}
		if (section == 5) { return actions3.count	}
		if (section == 6) { return actions4.count	}
		if (section == 7) { return actions5.count	}
		if (section == 8) { return alerticons.count	}

		return 0
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if (indexPath.section == 0) && (indexPath.row == 0) { return self.tableView(tableView, cellWithText: "Show Banner")	}
		if (indexPath.section == 0) && (indexPath.row == 1) { return self.tableView(tableView, cellWithText: "Hide Banner")	}

		if (indexPath.section == 1) && (indexPath.row == 0) { return cellText	}
		if (indexPath.section == 1) && (indexPath.row == 1) { return self.tableView(tableView, cellWithText: "Dismiss Keyboard") }
		if (indexPath.section == 1) && (indexPath.row == 2) { return self.tableView(tableView, cellWithText: "Dismiss HUD")	}
		if (indexPath.section == 1) && (indexPath.row == 3) { return self.tableView(tableView, cellWithText: "Remove HUD")	}

		if (indexPath.section == 2) { return self.tableView(tableView, cellWithText: animations[indexPath.row].text)	}
		if (indexPath.section == 3) { return self.tableView(tableView, cellWithText: actions1[indexPath.row])			}
		if (indexPath.section == 4) { return self.tableView(tableView, cellWithText: actions2[indexPath.row])			}
		if (indexPath.section == 5) { return self.tableView(tableView, cellWithText: actions3[indexPath.row])			}
		if (indexPath.section == 6) { return self.tableView(tableView, cellWithText: actions4[indexPath.row])			}
		if (indexPath.section == 7) { return self.tableView(tableView, cellWithText: actions5[indexPath.row])			}
		if (indexPath.section == 8) { return self.tableView(tableView, cellWithText: alerticons[indexPath.row].text)	}

		return UITableViewCell()
	}

	func tableView(_ tableView: UITableView, cellWithText text: String) -> UITableViewCell {
		var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell")
		if (cell == nil) { cell = UITableViewCell(style: .default, reuseIdentifier: "cell") }
		cell.textLabel?.text = text
		return cell
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if (section == 0) { return "Banner Actions"		}
		if (section == 1) { return "HUD Actions"		}
		if (section == 2) { return "Animation Types"	}
		if (section == 3) { return "Animation"			}
		if (section == 4) { return "Progress"			}
		if (section == 5) { return "Progress"			}
		if (section == 6) { return "Action - Static"	}
		if (section == 7) { return "Action - Animated"	}
		if (section == 8) { return "Alert Icons"		}
		return nil
	}
}

// MARK: - UITableViewDelegate
extension ViewController {

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)

		if (indexPath.section == 0) {
			if (indexPath.row == 0) { ProgressHUD.showBanner("Banner title", toggleText()) }
			if (indexPath.row == 1) { ProgressHUD.hideBanner() }
		}

		if (indexPath.section == 1) {
			if (indexPath.row == 1) { view.endEditing(true) }
			if (indexPath.row == 2) { ProgressHUD.dismiss()	}
			if (indexPath.row == 3) { ProgressHUD.remove()	}
		}

		if (indexPath.section == 2)	{
			ProgressHUD.animationType = animations[indexPath.row]
			ProgressHUD.show(status)
		}

		if (indexPath.section == 3) {
			if (indexPath.row == 0) { ProgressHUD.show();			status = nil		}
			if (indexPath.row == 1) { ProgressHUD.show(textShort);	status = textShort	}
			if (indexPath.row == 2) { ProgressHUD.show(textLong);	status = textLong	}
		}

		if (indexPath.section == 4) {
			if (indexPath.row == 0) { actionProgressStart()				}
			if (indexPath.row == 1) { actionProgressStart(textShort)	}
			if (indexPath.row == 2) { actionProgressStart(textLong)		}
		}

		if (indexPath.section == 5) {
			if (indexPath.row == 0) { ProgressHUD.showProgress(0.1, interaction: true)	}
			if (indexPath.row == 1) { ProgressHUD.showProgress(0.4, interaction: true)	}
			if (indexPath.row == 2) { ProgressHUD.showProgress(0.6, interaction: true)	}
			if (indexPath.row == 3) { ProgressHUD.showProgress(0.9, interaction: true)	}
		}

		if (indexPath.section == 6) {
			if (indexPath.row == 0) { ProgressHUD.showSuccess()				}
			if (indexPath.row == 1) { ProgressHUD.showSuccess(textSuccess)	}
			if (indexPath.row == 2) { ProgressHUD.showError()				}
			if (indexPath.row == 3) { ProgressHUD.showError(textError)		}
		}

		if (indexPath.section == 7) {
			if (indexPath.row == 0) { ProgressHUD.showSucceed()				}
			if (indexPath.row == 1) { ProgressHUD.showSucceed(textSucceed)	}
			if (indexPath.row == 2) { ProgressHUD.showFailed()				}
			if (indexPath.row == 3) { ProgressHUD.showFailed(textFailed)	}
			if (indexPath.row == 4) { ProgressHUD.showAdded()				}
			if (indexPath.row == 5) { ProgressHUD.showAdded(textAdded)		}
		}

		if (indexPath.section == 8) {
			let alerticon = alerticons[indexPath.row]
			ProgressHUD.show(randomText(), icon: alerticon)
		}
	}
}

// MARK: - Text Methods
extension ViewController {

	func randomText() -> String? {
		let array = [textShort, textLong, textSucceed, textFailed, textAdded, nil]
		let index = Int.random(in: 0..<array.count)
		return array[index]
	}

	func toggleText() -> String {
		boolText = !boolText
		return boolText ? textAdded : textLong
	}
}
