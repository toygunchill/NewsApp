//
//  ViewController.swift
//  MyAppcentApp
//
//  Created by Toygun Çil on 5.05.2022.
//

import UIKit




class ViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var llbText: UILabel!
    @IBOutlet weak var searchBarField: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchText = ""
    var selectedNewsRow = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarField.delegate = self

    }

    func getData() {
//        let url = URL(string: "https://newsapi.org/v2/everything?q=\(searchText)&apiKey=f830c611d9a643108f4573e5bc1dcb48")
//        let myData = try! Data(contentsOf: url!)
//        let jsonDecoder = JSONDecoder()
//
//        let dataC = try? jsonDecoder.decode(dataCont.self, from: myData)
//        if let dataCC = dataC{
//            print(dataCC)
//        }
        let url = URL(string: "https://newsapi.org/v2/everything?q=\(searchText)&apiKey=f830c611d9a643108f4573e5bc1dcb48")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okBtn)
                    self.present(alert, animated: true,completion: nil)
                }else{
                    if data != nil {
                        do {
                            let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                            DispatchQueue.main.async {
                                if let articles = jsonResponse["articles"] as? [String:Any] {
                                    print(articles)
                                }
                                print(jsonResponse["articles"]!)                              // Kontrol amaçlı.
                            }
                        }catch{
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = self.searchBarField.text!
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = self.searchBarField.text!                                                         // Klavye ile alınan değer kontrolü
        getData()                                                                     // Api ile data bağlantısı sağlanan fonksiyon
    }
//    func getDictVal(dict: [String:Any], path:String)->Any?{
//        let array = path.components(separatedBy: ".")
//        if(array.count == 1){
//            return dict[String(array[0])]
//        }else if(array.count > 1){
//            let p = array[1...array.count-1].joined(separator: ".")
//            let d = dict[String(array[0])] as? [String : Any]
//            if(d!= nil){
//                return getDictVal(dict:d!,path:)
//            }
//        }
//    }
}



