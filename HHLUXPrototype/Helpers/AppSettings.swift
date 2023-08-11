/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Saving and Loading App defaults from file
*/

import Foundation

struct AppDefaults: Codable, Equatable {
    var name: String
}

extension AppDefaults {
    static let standard = AppDefaults(name: "Default")
}


@MainActor class AppSettings: ObservableObject {
    
    @Published var defaults = AppDefaults.standard
    private let settingsIO = SettingsIO()
    
}

// MARK: - AppSettings API

extension AppSettings {
        
    func load() async {
        defaults = await settingsIO.load()
    }

    func save() async {
        await settingsIO.save(defaults)
    }
}

// MARK: - AppSettings.IO

private extension AppSettings {
    actor SettingsIO {}
}

extension AppSettings.SettingsIO {

    func load() -> AppDefaults {
        do {
            let data = try Data(contentsOf: .fileURL(for: .setting))
            let defaults = try JSONDecoder().decode(AppDefaults.self, from: data)
            return defaults
        } catch {
            return AppDefaults.standard
        }
    }

    @discardableResult
    func save(_ defaults: AppDefaults) -> Bool {
        do {
            let data = try JSONEncoder().encode(defaults)
            try data.write(to: URL.fileURL(for: .setting))
            return true
        } catch {
            return false
        }
    }
}