import SwiftUI
import OneSignalFramework
import ApphudSDK
import AppMetricaCore
import CoreTelephony
import SystemConfiguration.CaptiveNetwork

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    var deviceInfo: [String: Any] = [:]
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Apphud.start(apiKey: "app_v1NiMZzYu1UMJEs5YLM9JhoCHdZGs8")
        
        OneSignal.initialize("303253bd-57d4-423c-9536-831b573d8c69", withLaunchOptions: launchOptions)
        OneSignal.login(Apphud.userID())
        
        let configuration = AppMetricaConfiguration(apiKey: "f0174b9e-6837-480e-b512-57ac0ab60aa1")
        AppMetrica.activate(with: configuration!)
        
        collectDeviceInfo()
        
        return true
    }
    
    func collectDeviceInfo() {
  
        // Имя девайса
        deviceInfo["gfdokPS"] = UIDevice.current.name
        
        // Имя модели
        deviceInfo["gdpsjPjg"] = UIDevice.current.model
        
        // Уник номер
        deviceInfo["poguaKFP"] = UIDevice.current.identifierForVendor?.uuidString
        
        // Версия iOS
        deviceInfo["bcpJFs"] = UIDevice.current.systemVersion
        
        // Язык девайса
        deviceInfo["GOmblx"] = Locale.current.languageCode
        
        // Тайм-зона
        deviceInfo["G0pxum"] = TimeZone.current.identifier
        
        // Заряжается ли
        UIDevice.current.isBatteryMonitoringEnabled = true
        deviceInfo["Fpvbduwm"] = UIDevice.current.batteryState == .charging || UIDevice.current.batteryState == .full
        
        // Уровень заряда
        deviceInfo["gfpbvjsoM"] = Int(UIDevice.current.batteryLevel * 100)
        
        // Регион
        deviceInfo["bpPjfns"] = Locale.current.regionCode
        
        // Метрическая ли
        deviceInfo["biMpaiuf"] = Locale.current.usesMetricSystem
        
        // Полная ли зарядка
        deviceInfo["oahgoMAOI"] = UIDevice.current.batteryState == .full
        
        // Клавиатуры
        deviceInfo["gfdosnb"] = fetchKeyboards()
        
        // Объем памяти
        deviceInfo["Fpbjcv"] = fetchMemorySize()
        
        // Скриншот ли
        deviceInfo["StwPp"] = isTakingScreenshot()
        
        // Скринкаст ли
        deviceInfo["KDhsd"] = isScreenRecording()
        
        // Наличие прил
        deviceInfo["bvoikOGjs"] = fetchInstalledApps()
        
        // Wi-Fi
        deviceInfo["gpaMFOfa"] = fetchWiFiAddress()
        
        // Сим-карта
        deviceInfo["gciOFm"] = fetchCarrierName()
        
        // VPN
        deviceInfo["vivisWork"] = isVPNConnected()
    }
    
    // Wi-Fi
    func fetchWiFiAddress() -> String? {
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    return interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                }
            }
        }
        return nil
    }
    
    // Сим-карта
    func fetchCarrierName() -> String? {
        let networkInfo = CTTelephonyNetworkInfo()
        
        guard let serviceId = networkInfo.dataServiceIdentifier else {
            return nil
        }
        
        let providers = networkInfo.serviceSubscriberCellularProviders
        
        return providers?[serviceId]?.carrierName
    }
    
    
    // Память телефона
    func fetchMemorySize() -> String? {
        let memory = ProcessInfo.processInfo.physicalMemory
        return ByteCountFormatter.string(fromByteCount: Int64(memory), countStyle: .memory)
    }
    
    // Установленные прилы
    func fetchInstalledApps() -> [String: String] {
        return [:]
    }
    
    // Клавиатуры
    func fetchKeyboards() -> [String] {
        let keyboardSettings = UserDefaults.standard.object(forKey: "AppleKeyboards") as? [String] ?? []
        return keyboardSettings
    }
    
    // Состояние ВПН
    func isVPNConnected() -> Bool {
        return false
    }
    
    // Проверка на скриншот
    func isTakingScreenshot() -> Bool {
        return UIScreen.main.isCaptured
    }
    
    // Проверка на скринкаст
    func isScreenRecording() -> Bool {
        return UIScreen.main.isCaptured
    }
    
}

@main
struct ProScoreApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let persistenceController = PersistenceController.shared
    
    @State private var showOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding") == false
    
    var body: some Scene {
        WindowGroup {
            SplashScreen(showOnboarding: $showOnboarding, persistenceController: persistenceController)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(WebViewModel(appDelegate: appDelegate))
                
        }
    }
}
