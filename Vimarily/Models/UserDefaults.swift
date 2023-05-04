import Foundation


extension UserDefaults {
	static let sharedAppGroup = "group." + (Bundle.main.object(forInfoDictionaryKey: "ParentAppBundleIdentifier") as? String ?? "")
	static let INSTANCE = UserDefaults(suiteName: UserDefaults.sharedAppGroup)!

	enum GeneralKeys: String, CaseIterable {
		case firstRunGone = "firstRunGone"
		case excludedUrls = "excludedUrls"
		case linkHintCharacters = "linkHintCharacters"
		case detectByCursorStyle = "detectByCursorStyle"
		case scrollSize = "scrollSize"
		case scrollDuration = "scrollDuration"
		case smoothScroll = "smoothScroll"
		case openTabUrl = "openTabUrl"
		case modifier = "modifier"
		case transparentBindings = "transparentBindings"
	}

	enum BindingKeys: String, CaseIterable {
		// Bindings
		case hintToggleBinding = "hintToggle"
		case newTabHintToggleBinding = "newTabHintToggle"
		case scrollUpBinding = "scrollUp"
		case scrollDownBinding = "scrollDown"
		case scrollLeftBinding = "scrollLeft"
		case scrollRightBinding = "scrollRight"
		case scrollUpHalfPageBinding = "scrollUpHalfPage"
		case scrollDownHalfPageBinding = "scrollDownHalfPage"
		case goToPageTopBinding = "goToPageTop"
		case goToPageBottomBinding = "goToPageBottom"
		case goToFirstInputBinding = "goToFirstInput"
		case goBackBinding = "goBack"
		case goForwardBinding = "goForward"
		case reloadBinding = "reload"
		case tabForwardBinding = "tabForward"
		case tabBackBinding = "tabBack"
		case closeTabBinding = "closeTab"
		case openTabBinding = "openTab"
		case duplicateTabBinding = "duplicateTab"
		case copyUrlBinding = "copyUrl"
	}

	enum Key {
		case generalKey(GeneralKeys)
		case bindingKey(BindingKeys)

		var rawValue: String {
			switch self {
			case .generalKey(let generalKey):
				return generalKey.rawValue
			case .bindingKey(let bindingKey):
				return bindingKey.rawValue
			}
		}
	}

	func set<T>(_ value: T, forKey key: Key) {
		set(value, forKey: key.rawValue)
	}

	func bool(forKey key: Key) -> Bool {
		bool(forKey: key.rawValue)
	}

	func string(forKey key: Key) -> String? {
		string(forKey: key.rawValue)
	}

	func integer(forKey key: Key) -> Int? {
		integer(forKey: key.rawValue)
	}

	func url(forKey key: Key) -> URL? {
		url(forKey: key.rawValue)
	}

	func stringArray(forKey key: Key) -> [String]? {
		stringArray(forKey: key.rawValue)
	}

	func tempGetSingleBinding(forKey key: BindingKeys) -> String? {
		stringArray(forKey: key.rawValue)?[0]
	}

	func resetGeneralSettings() {
		set([""], forKey: .generalKey(.excludedUrls))
		set("asdfghjklzxcvbnm", forKey: .generalKey(.linkHintCharacters))
		set(false, forKey: .generalKey(.detectByCursorStyle))
		set(150, forKey: .generalKey(.scrollSize))
		set(25, forKey: .generalKey(.scrollDuration))
		set(true, forKey: .generalKey(.smoothScroll))
		set("https://google.com", forKey: .generalKey(.openTabUrl))
		set("", forKey: .generalKey(.modifier))
		set(true, forKey: .generalKey(.transparentBindings))
	}

	func resetKeyBindings() {
		set("f", forKey: .bindingKey(.hintToggleBinding))
		set("shift+f", forKey: .bindingKey(.newTabHintToggleBinding))
		set("k", forKey: .bindingKey(.scrollUpBinding))
		set("j", forKey: .bindingKey(.scrollDownBinding))
		set("h", forKey: .bindingKey(.scrollLeftBinding))
		set("l", forKey: .bindingKey(.scrollRightBinding))
		set("u", forKey: .bindingKey(.scrollUpHalfPageBinding))
		set("d", forKey: .bindingKey(.scrollDownHalfPageBinding))
		set("g g", forKey: .bindingKey(.goToPageTopBinding))
		set("shift+g", forKey: .bindingKey(.goToPageBottomBinding))
		set("g i", forKey: .bindingKey(.goToFirstInputBinding))
		set("shift+j", forKey: .bindingKey(.goBackBinding))
		set("shift+k", forKey: .bindingKey(.goForwardBinding))
		set("r", forKey: .bindingKey(.reloadBinding))
		set("w", forKey: .bindingKey(.tabBackBinding))
		set("q", forKey: .bindingKey(.tabForwardBinding))
		set("x", forKey: .bindingKey(.closeTabBinding))
		set("t", forKey: .bindingKey(.openTabBinding))
		set("y t", forKey: .bindingKey(.duplicateTabBinding))
		set("y y", forKey: .bindingKey(.copyUrlBinding))
	}
}
