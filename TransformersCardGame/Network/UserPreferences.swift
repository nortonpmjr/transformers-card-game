import Foundation

class UserPreferences {
    static var preferences = UserDefaults.standard

    static func addKey(token: String) {
        if preferences.value(forKey: "JWT") == nil {
            preferences.set(token, forKey: "JWT")
        }
    }

    static func getKey() -> String {
        return preferences.value(forKey: "JWT") as! String
    }
}
