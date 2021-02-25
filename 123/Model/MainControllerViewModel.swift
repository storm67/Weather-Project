//
//  WeatherRequestViewModel.swift
//  123
//
//  Created by gdml on 13/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//
import Foundation
import SwiftyJSON
import UIKit

final class MainControllerViewModel: ViewModelProtocol {

    var completion: Completion?
    var weather = [Convertible]()
    var dates = [String]()
    var networkService: Routing<WeatherAPI>
    
    init(networkService: Routing<WeatherAPI>) {
        self.networkService = networkService
        returnit()
    }

    private let dateFormatter: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "RU-ru")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()

    func newDebug(key: Int?, lat: Double?, lon: Double?, completion: @escaping (Completion)) {
        DispatchQueue.global().async {
            if key != nil && key != 0 {
                guard let key = key else { return }
                self.weatherFiveDayRequest(key: key) { (first, second, quality)  in
                    completion(first,second, quality)
                }
            } else {
                guard let lat = lat, let lon = lon else { return }
                self.networkService.request(.getCityByLocation(lat: lat, lon: lon)) { [weak self] data in
                    if let key = JSON(data)["Key"].string {
                        guard let int = Int(key) else { return }
                        self?.weatherFiveDayRequest(key: int) { [weak self] item, one, quality  in
                            self?.weather = item
                            self?.formation(item)
                            completion(item,one, quality)
                        }
                    }
                }
            }
        }
    }

    func returnit() {
        dates.append("Сегодня")
        dates.append("Завтра")
        for item in 2...4 {
            let data = Calendar.current.date(byAdding: .day, value: item, to: Date(), wrappingComponents: .random())!
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.locale = Locale(identifier: "RU-ru")
            dateFormatterPrint.dateFormat = "EEEE"
            let finish = dateFormatterPrint.string(from: data)
            dates.append(finish)
        }
    }

    func cellViewModel(index: Int) -> Convertible? {
        return weather[index]
    }

    @discardableResult
    func formation(_ get: [Convertible]) -> [Int] {
        var int = [Int]()
        get.forEach { item in
            int.append(item.temperature)
        }
        return int
    }

    func weatherFiveDayRequest(key: Int,completion: @escaping (Completion)) {
        DispatchQueue.global().async {
            self.networkService.request(.getFiveDayWeather(city: String(key))) { [unowned self] data in
                let array = JSON(data)["DailyForecasts"].arrayValue.map { DailyForecast(dictionary: $0) }
                let quality = JSON(data)["DailyForecasts"].arrayValue[0]["AirAndPollen"].arrayValue.map { AirQuality(decoder: $0) }
                let weatherX = zip(array,self.dates).map { [unowned self] (first,second) -> Convertible in
                    Convertible(date: self.format(data: first.date),
                                temperature: first.temperature,
                                dayIcon: first.dayIcon,
                                dayIconPhrase: first.dayIconPhrase,
                                nightIconPhrase: first.nightIconPhrase,
                                realFeel: first.realFeel,
                                wind: first.wind,
                                standardDate: second,
                                air: first.airQuality,
                                temperatureMax: first.temperatureMax)
                }
                self.weather = weatherX
                completion(weatherX, weatherX[0], quality)
            }
        }
    }
}

extension MainControllerViewModel {

    func format(data: String) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "RU-ru")
        dateFormatterPrint.dateFormat = "dd MMM"
        guard let date: Date = dateFormatter.date(from: data) as Date? else { return String() }
        let finish = dateFormatterPrint.string(from: date).capitalized
        return finish
    }
}
