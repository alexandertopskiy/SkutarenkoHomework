import Foundation

// MARK: - Циклы сильных ссылок в замыканиях

class HTMLElement {
    let name: String
    let text: String?
//  Свойство asHTML называется и используется несколько схоже с методом экземпляра. Однако из-за того что asHTML является свойством-замыканием, а не методом экземпляра, то вы можете заменить значение по умолчанию свойства asHTML на пользовательское замыкание, если вы хотите сменить отображение конкретного HTML элемента.
//  Замыкание asHTML является ленивым для того, чтобы ссылаться на self внутри дефолтного замыкания (потому что обращение к ленивому свойству невозможно до тех пор, пока инициализация полностью не закончится и не будет известно, что self уже существует)
//  Self является бесхозной ссылкой и уже не поддерживает сильной связи с экземпляром HTMLElement, которого он захватил.
    lazy var asHTML : () -> String = { [unowned self] in // "захватить self как unowned ссылку, вместо strong"
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name)></\(self.name)>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit { print("HTML Element \(name) deinit") }
}

var h1 : HTMLElement? = HTMLElement(name: "h1", text: "asdas")
print(h1!.asHTML())
h1 = nil // теперь это освободит память от экземпляра, потому что внутри замыкания нет сильной ссылки на self

//var p : HTMLElement? = HTMLElement(name: "p")
//let defaultText = "some default text"
//// это замыкание не вызовет цикла сильных ссылок даже без списка захвата, т.к. оно переопределено и теперь не будет ссылаться на self по умолчанию
//p?.asHTML = {
//    return "<\(p!.name)>\(defaultText)</\(p!.name)>"
//}
//print(p!.asHTML())
//p = nil
