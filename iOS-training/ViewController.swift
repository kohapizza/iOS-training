//
//  ViewController.swift
//  iOS-training
//
//  Created by 佐伯小遥 on 2024/07/20.
//

import UIKit
import YumemiWeather
import Foundation

class ViewController: UIViewController {
    // 画像を設定
    let sunnyImage = UIImage(named: "sunny.jpg")
    let rainyImage = UIImage(named: "rainy.jpg")
    let cloudyImage = UIImage(named: "cloudy.jpg")
    
    // JSON 入力文
    let jsonInput = """
{
    "area": "Tokyo",
    "date": "2020-04-01T12:00:00+09:00"
}
"""
    
    
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var redLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textAlignment = .center
        label.textColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var blueLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textAlignment = .center
        label.textColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reload", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var alert = UIAlertController(
        title: "天気取得に失敗しました",
        message: "もう一度お試しください",
        preferredStyle: UIAlertController.Style.alert)
    
    
    
    // ボタンが押された時に呼ばれるメソッド
    @objc func buttonEvent(_ sender: UIButton) {
        // 天気を取得してコンソールに出力する
        // simple ver.
//         let weather = YumemiWeather.fetchWeatherCondition()
        
        // Throws ver
        // エラーをもつ関数を実行するには、try を使う
        
        do {
            let weatherJSON = try YumemiWeather.fetchWeather(jsonInput)
            
//             let weather = try YumemiWeather.fetchWeatherCondition(at: "tokyo")
            
            // JSON文字列をDarta型にする
            if let data = weatherJSON.data(using: .utf8){
                // JSONEncoder クラスのインスタンスを生成
                let decoder = JSONDecoder()
                
                // Weather型を定義 Countableプロトコルに準拠させる
                struct Weather: Codable{
                    var min_temperature: Int
                    var weather_condition: String
                    var date: String
                    var max_temperature: Int
                }
                
                // デコードする
                let decoded = try decoder.decode(Weather.self, from: data)
                
                let weatherCondition = decoded.weather_condition
                switch weatherCondition {
                case "sunny":
                    imageView.image = sunnyImage
                case "rainy":
                    imageView.image = rainyImage
                case "cloudy":
                    imageView.image = cloudyImage
                default:
                    imageView.image = nil
                }
                print("天気: \(weatherCondition)")
                
                    
                let maxTemperature = decoded.max_temperature
                redLabel.text = String(maxTemperature)
                
                    
                let minTemperature = decoded.min_temperature
                blueLabel.text = String(minTemperature)
                
            }
        } catch{
            present(alert, animated: true, completion: nil)
            print(error)
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // アラート
        alert.addAction(UIAlertAction(title: "トップ画面に戻る", style: .default, handler: nil))
        
        // デバッグ 画像のロード確認
        // print(sunnyImage != nil ? "Sunny image loaded" : "Sunny image not found")
        // print(rainyImage != nil ? "Rainy image loaded" : "Rainy image not found")
        // print(cloudyImage != nil ? "Cloudy image loaded" : "Cloudy image not found")
 
        self.view.addSubview(imageView)
        self.view.addSubview(redLabel)
        self.view.addSubview(blueLabel)
        self.view.addSubview(rightButton)
        self.view.addSubview(leftButton)
        
        rightButton.addTarget(self, action: #selector(buttonEvent(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor), // 縦・横幅を等しくする
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: blueLabel.intrinsicContentSize.height/2),
            
            redLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5),
            redLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            redLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            
            blueLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5),
            blueLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            blueLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            
            leftButton.topAnchor.constraint(equalTo: blueLabel.bottomAnchor, constant: 80),
            leftButton.leadingAnchor.constraint(equalTo: blueLabel.leadingAnchor),
            leftButton.centerXAnchor.constraint(equalTo: blueLabel.centerXAnchor),
            
            rightButton.topAnchor.constraint(equalTo: redLabel.bottomAnchor, constant: 80),
            rightButton.trailingAnchor.constraint(equalTo: redLabel.trailingAnchor),
            rightButton.centerXAnchor.constraint(equalTo: redLabel.centerXAnchor)
        ])

    }

    
    

}

