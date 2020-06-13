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
	private var actions3: [String] = []
	private var actions4: [String] = []
	private var actions5: [String] = []
	private var actions6: [String] = []

	private var timer: Timer?
	private var status: String?

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

		actions1.append("Animation - No text")
		actions1.append("Animation - Short text")
		actions1.append("Animation - Longer text")

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

		actions6.append("Heart")
		actions6.append("Doc")
		actions6.append("Bookmark")
		actions6.append("Moon")
		actions6.append("Star")
		actions6.append("Exclamation")
		actions6.append("Flag")
		actions6.append("Message")
		actions6.append("Question")
		actions6.append("Bolt")
		actions6.append("Shuffle")
		actions6.append("Eject")
		actions6.append("Card")
		actions6.append("Rotate")
		actions6.append("Like")
		actions6.append("Dislike")
		actions6.append("Privacy")
		actions6.append("Cart")
		actions6.append("Search")

		ProgressHUD.colorAnimation = .systemBlue
		ProgressHUD.colorProgress = .systemBlue
	}

	// MARK: - Progress methods
	//---------------------------------------------------------------------------------------------------------------------------------------------
	func actionProgressStart(_ status: String? = nil) {

		timer?.invalidate()
		timer = nil

		var intervalCount: CGFloat = 0.0
		ProgressHUD.showProgress(status, intervalCount/100)

		timer = Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { timer in
			intervalCount += 1
			ProgressHUD.showProgress(status, intervalCount/100)
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

		return 8
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		if (section == 0) { return 3				}
		if (section == 1) { return actions1.count	}
		if (section == 2) { return types.count		}
		if (section == 3) { return actions2.count	}
		if (section == 4) { return actions3.count	}
		if (section == 5) { return actions4.count	}
		if (section == 6) { return actions5.count	}
		if (section == 7) { return actions6.count	}

		return 0
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		if (indexPath.section == 0) && (indexPath.row == 0) { return cellText	}

		if (indexPath.section == 0) && (indexPath.row == 1) { return self.tableView(tableView, cellWithText: "Dismiss Keyboard")	}
		if (indexPath.section == 0) && (indexPath.row == 2) { return self.tableView(tableView, cellWithText: "Dismiss HUD")			}

		if (indexPath.section == 1) { return self.tableView(tableView, cellWithText: actions1[indexPath.row])	}
		if (indexPath.section == 2) { return self.tableView(tableView, cellWithText: types[indexPath.row])		}
		if (indexPath.section == 3) { return self.tableView(tableView, cellWithText: actions2[indexPath.row])	}
		if (indexPath.section == 4) { return self.tableView(tableView, cellWithText: actions3[indexPath.row])	}
		if (indexPath.section == 5) { return self.tableView(tableView, cellWithText: actions4[indexPath.row])	}
		if (indexPath.section == 6) { return self.tableView(tableView, cellWithText: actions5[indexPath.row])	}
		if (indexPath.section == 7) { return self.tableView(tableView, cellWithText: actions6[indexPath.row])	}

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

		if (section == 1) { return "Animation"			}
		if (section == 2) { return "Animation Types"	}
		if (section == 3) { return "Progress"			}
		if (section == 4) { return "Progress"			}
		if (section == 5) { return "Action - Static"	}
		if (section == 6) { return "Action - Animated"	}
		if (section == 7) { return "Icons - Static"		}

		return nil
	}
}

// MARK: - UITableViewDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension ViewController {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		tableView.deselectRow(at: indexPath, animated: true)

		if (indexPath.section == 0) && (indexPath.row == 1) { view.endEditing(true) 			}
		if (indexPath.section == 0) && (indexPath.row == 2) { ProgressHUD.dismiss()				}

		if (indexPath.section == 1) {
			if (indexPath.row == 0) { ProgressHUD.show();			status = nil				}
			if (indexPath.row == 1) { ProgressHUD.show(textShort);	status = textShort			}
			if (indexPath.row == 2) { ProgressHUD.show(textLong);	status = textLong			}
		}

		if (indexPath.section == 2)	{
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
			ProgressHUD.show(status)
		}

		if (indexPath.section == 3) {
			if (indexPath.row == 0) { actionProgressStart()										}
			if (indexPath.row == 1) { actionProgressStart(textShort)							}
			if (indexPath.row == 2) { actionProgressStart(textLong)								}
		}

		if (indexPath.section == 4) {
			if (indexPath.row == 0) { ProgressHUD.showProgress(0.1, interaction: true)			}
			if (indexPath.row == 1) { ProgressHUD.showProgress(0.4, interaction: true)			}
			if (indexPath.row == 2) { ProgressHUD.showProgress(0.6, interaction: true)			}
			if (indexPath.row == 3) { ProgressHUD.showProgress(0.9, interaction: true)			}
		}

		if (indexPath.section == 5) {
			if (indexPath.row == 0) { ProgressHUD.showSuccess()									}
			if (indexPath.row == 1) { ProgressHUD.showSuccess(textSuccess)						}
			if (indexPath.row == 2) { ProgressHUD.showError()									}
			if (indexPath.row == 3) { ProgressHUD.showError(textError)							}
		}

		if (indexPath.section == 6) {
			if (indexPath.row == 0) { ProgressHUD.showSucceed()									}
			if (indexPath.row == 1) { ProgressHUD.showSucceed(textSucceed)						}
			if (indexPath.row == 2) { ProgressHUD.showFailed()									}
			if (indexPath.row == 3) { ProgressHUD.showFailed(textFailed)						}
			if (indexPath.row == 4) { ProgressHUD.showAdded()									}
			if (indexPath.row == 5) { ProgressHUD.showAdded(textAdded)							}
		}

		if (indexPath.section == 7) {
			if (indexPath.row == 0) { ProgressHUD.show(icon: .heart)							}
			if (indexPath.row == 1) { ProgressHUD.show(icon: .doc)								}
			if (indexPath.row == 2) { ProgressHUD.show(icon: .bookmark)							}
			if (indexPath.row == 3) { ProgressHUD.show(icon: .moon)								}
			if (indexPath.row == 4) { ProgressHUD.show(icon: .star)								}
			if (indexPath.row == 5) { ProgressHUD.show(icon: .exclamation)						}
			if (indexPath.row == 6) { ProgressHUD.show(icon: .flag)								}
			if (indexPath.row == 7) { ProgressHUD.show(icon: .message)							}
			if (indexPath.row == 8) { ProgressHUD.show(icon: .question)							}
			if (indexPath.row == 9) { ProgressHUD.show(icon: .bolt)								}
			if (indexPath.row == 10) { ProgressHUD.show(icon: .shuffle)							}
			if (indexPath.row == 11) { ProgressHUD.show(icon: .eject)							}
			if (indexPath.row == 12) { ProgressHUD.show(icon: .card)							}
			if (indexPath.row == 13) { ProgressHUD.show(icon: .rotate)							}
			if (indexPath.row == 14) { ProgressHUD.show(icon: .like)							}
			if (indexPath.row == 15) { ProgressHUD.show(icon: .dislike)							}
			if (indexPath.row == 16) { ProgressHUD.show(icon: .privacy)							}
			if (indexPath.row == 17) { ProgressHUD.show(icon: .cart)							}
			if (indexPath.row == 18) { ProgressHUD.show(icon: .search)							}
		}
	}
}
