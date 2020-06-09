//
// Copyright (c) 2020 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

//-------------------------------------------------------------------------------------------------------------------------------------------------
class ViewController: UITableViewController {

	@IBOutlet var cellText: UITableViewCell!

	private var types: [String] = []
	private var actions1: [String] = []
	private var actions2: [String] = []
	private var icons1: [String] = []
	private var icons2: [String] = []

	private var timer: Timer?

	private let textShort	= "Please wait..."
	private let textLong	= "Please wait. We need some more time to work out this situation."

	private let textSuccess	= "That was awesome!"
	private let textError	= "Something went wrong."

	private let textSucceed	= "That was awesome!"
	private let textFailed	= "Something went wrong."
	private let textAdded	= "Successfully added."

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "ProgressHUD"

		types.append("System Activity Indicator")
		types.append("Horizontal Circles Pulse")
		types.append("Line Scaling")
		types.append("Single Circle Pulse")
		types.append("Multiple Circle Pulse")
		types.append("Single Circle Scale Ripple")
		types.append("Multiple Circle Scale Ripple")
		types.append("Circle Spin Fade")
		types.append("Line Spin Fade")
		types.append("Circle Rotate Chase")
		types.append("Circle Stroke Spin")

		actions1.append("Progress - Percentage")
		actions1.append("Progress - Short text")
		actions1.append("Progress - Longer text")

		actions2.append("Success - No text")
		actions2.append("Success - Short text")
		actions2.append("Error - No text")
		actions2.append("Error - Short text")

		icons1.append("Succeed - No text")
		icons1.append("Succeed - Short text")
		icons1.append("Failed - No text")
		icons1.append("Failed - Short text")
		icons1.append("Added - No text")
		icons1.append("Added - Short text")

		icons2.append("Heart")
		icons2.append("Doc")
		icons2.append("Bookmark")
		icons2.append("Moon")
		icons2.append("Star")
		icons2.append("Exclamation")
		icons2.append("Flag")
		icons2.append("Message")
		icons2.append("Question")
		icons2.append("Bolt")
		icons2.append("Shuffle")
		icons2.append("Eject")
		icons2.append("Card")
		icons2.append("Rotate")
		icons2.append("Like")
		icons2.append("Dislike")
		icons2.append("Privacy")
		icons2.append("Cart")
		icons2.append("Search")

		ProgressHUD.colorAnimation = .systemBlue
		ProgressHUD.colorProgress = .systemBlue
	}

	// MARK: - Helper methods
	//---------------------------------------------------------------------------------------------------------------------------------------------
	func actionProgressStart() {

		timer?.invalidate()
		timer = nil

		var intervalCount: CGFloat = 0.0
		ProgressHUD.showProgress(intervalCount/100)

		timer = Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { timer in
			intervalCount += 1
			ProgressHUD.showProgress(intervalCount/100)
			if (intervalCount >= 100) {
				self.actionProgressStop()
			}
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func actionProgressStop() {

		timer?.invalidate()
		timer = nil

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
			ProgressHUD.showSucceed(interaction: false)
		}
	}
}

// MARK: - UITableViewDataSource
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension ViewController {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func numberOfSections(in tableView: UITableView) -> Int {

		return 6
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		if (section == 0) { return 3				}
		if (section == 1) { return types.count		}
		if (section == 2) { return actions1.count	}
		if (section == 3) { return actions2.count	}
		if (section == 4) { return icons1.count		}
		if (section == 5) { return icons2.count		}

		return 0
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		if (indexPath.section == 0) && (indexPath.row == 0) { return cellText	}

		if (indexPath.section == 0) && (indexPath.row == 1) { return self.tableView(tableView, cellWithText: "Dismiss Keyboard")	}
		if (indexPath.section == 0) && (indexPath.row == 2) { return self.tableView(tableView, cellWithText: "Dismiss HUD")			}

		if (indexPath.section == 1) { return self.tableView(tableView, cellWithText: types[indexPath.row])		}
		if (indexPath.section == 2) { return self.tableView(tableView, cellWithText: actions1[indexPath.row])	}
		if (indexPath.section == 3) { return self.tableView(tableView, cellWithText: actions2[indexPath.row])	}
		if (indexPath.section == 4) { return self.tableView(tableView, cellWithText: icons1[indexPath.row])		}
		if (indexPath.section == 5) { return self.tableView(tableView, cellWithText: icons2[indexPath.row])		}

		return UITableViewCell()
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, cellWithText text: String) -> UITableViewCell {

		var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell")
		if (cell == nil) { cell = UITableViewCell(style: .default, reuseIdentifier: "cell") }
		cell.textLabel?.text = text

		return cell
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

		if (section == 1) { return "Animation Types"	}
		if (section == 2) { return "Actions - Animated"	}
		if (section == 3) { return "Actions - Static"	}
		if (section == 4) { return "Icons - Animated"	}
		if (section == 5) { return "Icons - Static"		}

		return nil
	}
}

// MARK: - UITableViewDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension ViewController {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		tableView.deselectRow(at: indexPath, animated: true)

		if (indexPath.section == 0) && (indexPath.row == 1) { view.endEditing(true) }
		if (indexPath.section == 0) && (indexPath.row == 2) { ProgressHUD.dismiss() }

		if (indexPath.section == 1)	{
			if (indexPath.row == 0)	 { ProgressHUD.animationType = .systemActivityIndicator		}
			if (indexPath.row == 1)	 { ProgressHUD.animationType = .horizontalCirclesPulse		}
			if (indexPath.row == 2)	 { ProgressHUD.animationType = .lineScaling					}
			if (indexPath.row == 3)	 { ProgressHUD.animationType = .singleCirclePulse			}
			if (indexPath.row == 4)	 { ProgressHUD.animationType = .multipleCirclePulse			}
			if (indexPath.row == 5)	 { ProgressHUD.animationType = .singleCircleScaleRipple		}
			if (indexPath.row == 6)	 { ProgressHUD.animationType = .multipleCircleScaleRipple	}
			if (indexPath.row == 7)	 { ProgressHUD.animationType = .circleSpinFade				}
			if (indexPath.row == 8)	 { ProgressHUD.animationType = .lineSpinFade				}
			if (indexPath.row == 9)	 { ProgressHUD.animationType = .circleRotateChase			}
			if (indexPath.row == 10) { ProgressHUD.animationType = .circleStrokeSpin			}
			ProgressHUD.show()
		}

		if (indexPath.section == 2) {
			if (indexPath.row == 0) { actionProgressStart()					}
			if (indexPath.row == 1) { ProgressHUD.show(textShort)			}
			if (indexPath.row == 2) { ProgressHUD.show(textLong)			}
		}

		if (indexPath.section == 3) {
			if (indexPath.row == 0) { ProgressHUD.showSuccess()				}
			if (indexPath.row == 1) { ProgressHUD.showSuccess(textSuccess)	}
			if (indexPath.row == 2) { ProgressHUD.showError()				}
			if (indexPath.row == 3) { ProgressHUD.showError(textError)		}
		}

		if (indexPath.section == 4) {
			if (indexPath.row == 0) { ProgressHUD.showSucceed()				}
			if (indexPath.row == 1) { ProgressHUD.showSucceed(textSucceed)	}
			if (indexPath.row == 2) { ProgressHUD.showFailed()				}
			if (indexPath.row == 3) { ProgressHUD.showFailed(textFailed)	}
			if (indexPath.row == 4) { ProgressHUD.showAdded()				}
			if (indexPath.row == 5) { ProgressHUD.showAdded(textAdded)		}
		}

		if (indexPath.section == 5) {
			if (indexPath.row == 0) { ProgressHUD.show(icon: .heart)		}
			if (indexPath.row == 1) { ProgressHUD.show(icon: .doc)			}
			if (indexPath.row == 2) { ProgressHUD.show(icon: .bookmark)		}
			if (indexPath.row == 3) { ProgressHUD.show(icon: .moon)			}
			if (indexPath.row == 4) { ProgressHUD.show(icon: .star)			}
			if (indexPath.row == 5) { ProgressHUD.show(icon: .exclamation)	}
			if (indexPath.row == 6) { ProgressHUD.show(icon: .flag)			}
			if (indexPath.row == 7) { ProgressHUD.show(icon: .message)		}
			if (indexPath.row == 8) { ProgressHUD.show(icon: .question)		}
			if (indexPath.row == 9) { ProgressHUD.show(icon: .bolt)			}
			if (indexPath.row == 10) { ProgressHUD.show(icon: .shuffle)		}
			if (indexPath.row == 11) { ProgressHUD.show(icon: .eject)		}
			if (indexPath.row == 12) { ProgressHUD.show(icon: .card)		}
			if (indexPath.row == 13) { ProgressHUD.show(icon: .rotate)		}
			if (indexPath.row == 14) { ProgressHUD.show(icon: .like)		}
			if (indexPath.row == 15) { ProgressHUD.show(icon: .dislike)		}
			if (indexPath.row == 16) { ProgressHUD.show(icon: .privacy)		}
			if (indexPath.row == 17) { ProgressHUD.show(icon: .cart)		}
			if (indexPath.row == 18) { ProgressHUD.show(icon: .search)		}
		}
	}
}
