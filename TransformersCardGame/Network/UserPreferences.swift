import Foundation

class UserPreferences {
    static var preferences = UserDefaults.standard

    static func addKey(token: String) {
        preferences.set(token, forKey: "JWT")
    }

    static func getKey() -> String {
        return preferences.value(forKey: "JWT") as! String
    }
}
