protocol ConfigurationModelProtocol {
	func getUserSettings() throws -> [String: Any]
}

import Foundation
import SafariServices

class ConfigurationModel: ConfigurationModelProtocol {
	func getUserSettings() throws -> [String: Any] {
		var result: [String: Any] = [:]
		var actionBindings: [String: String] = [:]

		UserDefaults.BindingKeys.allCases.forEach { actionKey in
			actionBindings[actionKey.rawValue] = SafariExtensionHandler.DEFAULTS_INSTANCE.string(forKey: actionKey.rawValue)
		}
		result["bindings"] = actionBindings

		UserDefaults.GeneralKeys.allCases.forEach { generalKey in
			result[generalKey.rawValue] = SafariExtensionHandler.DEFAULTS_INSTANCE.value(forKey: generalKey.rawValue)
		}

		return result
	}
}
