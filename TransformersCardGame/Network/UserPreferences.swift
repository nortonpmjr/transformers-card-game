import Foundation

static class UserPreferences {
    static func addKey(token: String) {
        UserDefaults.standard.set(token, forKey: "JWT")
    }

    static func getKey() {
        UserDefaults.standard.value(forKey: "JWT")
    }
}
