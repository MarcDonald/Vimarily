import Foundation
import SafariServices.SFSafariApplication

class SettingsViewModel: ObservableObject {
	@Published var excludedUrls: [String]!
	@Published var linkHintCharacters: String!
	@Published var detectByCursorStyle: Bool!
	@Published var scrollSize: Int!
	@Published var scrollDuration: Int!
	@Published var smoothScroll: Bool!
	@Published var openTabUrl: String!
	@Published var modifier: String!
	@Published var transparentBindings: Bool!

	init() {
		populate()
	}

	public func populate() {
		excludedUrls = UserDefaults.INSTANCE.stringArray(forKey: .generalKey(.excludedUrls)) ?? []
		linkHintCharacters = UserDefaults.INSTANCE.string(forKey: .generalKey(.linkHintCharacters)) ?? ""
		detectByCursorStyle = UserDefaults.INSTANCE.bool(forKey: .generalKey(.detectByCursorStyle))
		scrollSize = UserDefaults.INSTANCE.integer(forKey: .generalKey(.scrollSize)) ?? 0
		scrollDuration = UserDefaults.INSTANCE.integer(forKey: .generalKey(.scrollDuration)) ?? 0
		smoothScroll = UserDefaults.INSTANCE.bool(forKey: .generalKey(.smoothScroll))
		openTabUrl = UserDefaults.INSTANCE.string(forKey: .generalKey(.openTabUrl)) ?? ""
		modifier = UserDefaults.INSTANCE.string(forKey: .generalKey(.modifier)) ?? ""
		transparentBindings = UserDefaults.INSTANCE.bool(forKey: .generalKey(.transparentBindings))
	}

	public func save() {
        scrollSize = scrollSize ?? 0
        scrollDuration = scrollDuration ?? 0
		UserDefaults.INSTANCE.set(excludedUrls, forKey: .generalKey(.excludedUrls))
		UserDefaults.INSTANCE.set(linkHintCharacters, forKey: .generalKey(.linkHintCharacters))
		UserDefaults.INSTANCE.set(detectByCursorStyle, forKey: .generalKey(.detectByCursorStyle))
		UserDefaults.INSTANCE.set(scrollSize, forKey: .generalKey(.scrollSize))
		UserDefaults.INSTANCE.set(scrollDuration, forKey: .generalKey(.scrollDuration))
		UserDefaults.INSTANCE.set(smoothScroll, forKey: .generalKey(.smoothScroll))
		UserDefaults.INSTANCE.set(openTabUrl, forKey: .generalKey(.openTabUrl))
		UserDefaults.INSTANCE.set(modifier, forKey: .generalKey(.modifier))
		UserDefaults.INSTANCE.set(transparentBindings, forKey: .generalKey(.transparentBindings))
	}

	public func reset() {
		UserDefaults.INSTANCE.resetGeneralSettings()
		populate()
	}
}
