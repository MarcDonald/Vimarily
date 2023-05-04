import Foundation
import SafariServices.SFSafariApplication

class GeneralViewModel: ObservableObject {
	@Published var extensionStatus: String = ""

	func fetchExtensionStatus() {
		if SFSafariServicesAvailable() {
			SFSafariExtensionManager.getStateOfSafariExtension(
				withIdentifier: (Bundle.main.bundleIdentifier ?? "") + Constants.extensionIdentifierSuffix) { state, error in
				print("State", state as Any, "Error", error as Any, state?.isEnabled as Any)

				DispatchQueue.main.async {
					// TODO: handle this getting updated in the Safari preferences too.
					if let state = state {
						if state.isEnabled {
							self.extensionStatus = "Enabled"
						} else {
							self.extensionStatus = "Disabled"
						}
					}
					if let error = error {
						NSLog("Error fetching extension status: ", error.localizedDescription)
						self.extensionStatus = error.localizedDescription
					}
				}
			}
		} else {
			NSLog("SFSafariServices not available")
			extensionStatus = "Unavailable, Vimarily requires Safari 10 or greater."
		}
	}

	func openSafariExtensionPreferencesClick() {
		SFSafariApplication.showPreferencesForExtension(
			withIdentifier: (Bundle.main.bundleIdentifier ?? "") + Constants.extensionIdentifierSuffix) { error in
			if error != nil {
				NSLog("Error \(error?.localizedDescription ?? "Unknown")")
			}
		}
	}
}
