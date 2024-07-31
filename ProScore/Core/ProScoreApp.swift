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
//        printDeviceInfo()
        
        return true
    }
    
    func collectDeviceInfo() {
        
            #warning("Доделать ВПН, скриншот, скринкаст, установленные приложения")
        
            // VPN
            deviceInfo["vivisWork"] = isVPNConnected()
            
            // Имя девайса
            deviceInfo["gfdokPS"] = UIDevice.current.name
            
            // Имя модели
            deviceInfo["gdpsjPjg"] = UIDevice.current.model
            
            // Уник номер
            deviceInfo["poguaKFP"] = UIDevice.current.identifierForVendor?.uuidString
            
            // Wi-Fi
            deviceInfo["gpaMFOfa"] = fetchWiFiAddress()
            
            // Сим-карта
            deviceInfo["gciOFm"] = fetchCarrierName()
            
            // Версия iOS
            deviceInfo["bcpJFs"] = UIDevice.current.systemVersion
            
            // Язык девайса
            deviceInfo["GOmblx"] = Locale.current.languageCode
            
            // Тайм-зона
            deviceInfo["G0pxum"] = TimeZone.current.identifier
            
            // Заряжается ли
            UIDevice.current.isBatteryMonitoringEnabled = true
            deviceInfo["Fpvbduwm"] = UIDevice.current.batteryState == .charging || UIDevice.current.batteryState == .full
            
            // Объем памяти
            deviceInfo["Fpbjcv"] = fetchMemorySize()
            
            // Скриншот ли ???????
            deviceInfo["StwPp"] = false
            
            // Скринкаст ли ???????
            deviceInfo["KDhsd"] = false
            
            // Наличие прил
            deviceInfo["bvoikOGjs"] = fetchInstalledApps()
            
            // Уровень заряда
            deviceInfo["gfpbvjsoM"] = Int(UIDevice.current.batteryLevel * 100)
            
            // Клавиатуры
            deviceInfo["gfdosnb"] = fetchKeyboards()
            
            // Регион
            deviceInfo["bpPjfns"] = Locale.current.regionCode
            
            // Метрическая ли
            deviceInfo["biMpaiuf"] = Locale.current.usesMetricSystem
            
            // Полная ли зарядка
            deviceInfo["oahgoMAOI"] = UIDevice.current.batteryState == .full
        }
        
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
        
        func fetchCarrierName() -> String? {
            let networkInfo = CTTelephonyNetworkInfo()
            
            guard let serviceId = networkInfo.dataServiceIdentifier else {
                return nil
            }

            let providers = networkInfo.serviceSubscriberCellularProviders

            return providers?[serviceId]?.carrierName
        }
        
        func fetchMemorySize() -> String? {
            let memory = ProcessInfo.processInfo.physicalMemory
            return ByteCountFormatter.string(fromByteCount: Int64(memory), countStyle: .memory)
        }
        
        func fetchInstalledApps() -> [String: String] {
            return [:]
        }
        
        func fetchKeyboards() -> [String] {
            let keyboardSettings = UserDefaults.standard.object(forKey: "AppleKeyboards") as? [String] ?? []
            return keyboardSettings
        }
    
        func printDeviceInfo() {
                for (key, value) in deviceInfo {
                    print("\(key): \(value)")
                }
            }
        
        func isVPNConnected() -> Bool {
            // Метод для определения состояния VPN
            // Примечание: это может требовать прав доступа и конфиденциальности.
            return false
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
        }
    }
}
