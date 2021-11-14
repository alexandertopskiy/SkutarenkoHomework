import Foundation

// MARK: - ARC - это только про объекты классов!
// Объект жив до тех пор, пока на него есть хотя бы 1 сильная ссылка!
// ARC считает только СИЛЬНЫЕ ССЫЛКИ

func Lesson() {
    var playground = true

    // Учитель держит студента сильной ссылкой (Если есть учитель, то обязательно должен быть и студент)
    // Студент держит учителя слабой ссылкой (Если учителя "удалили", то и студента можно удалить)
    // (с главного на зависимый - strong, с зависимого на главный - weak)
    class Student {
        // weak - это всегда опциональный var!!!
        // если объект уничтожен, то ссылка устанавливается в nil
        // также может быть unowned ссылка, она уже может быть и константой, и неопциональной (но нужно ее проинициализировать)
        weak var teacher : Teacher?
        deinit {
            print("goodbye student")
        }
    }

    class Teacher {
        var student : Student?
        
        var teacherClosure : (() -> ())? // сильная ссылка
        
        lazy var printTeacher : () -> () = { [unowned self] in
            // так как это lazy свойство, оно может быть не инициализоровано в 1 фазе -> можно использовать self прямо в нем
            print(self.student)
        }
        
        deinit {
            print("goodbye teacher")
        }
    }

    var closure : (() -> ())?

    if playground {
        // зона видимости этих объектов ограничена условием if playground
        // как только мы выходим за эту зону, ничто больше не указывает на эти объекты -> они уничтожаются
        let teacher = Teacher() // 1 сильная ссылка на Teacher
        
        teacher.printTeacher()
        
        // замыкание - сильная ссылка, указывает на сильную ссылку teacher (перекрестные сильные ссылки) -> ничего не уничтожится
        teacher.teacherClosure = { [unowned teacher] in
            print(teacher)
        }
        if playground {
            let student = Student() // 1 сильная ссылка на Student
            // две сильные ссылки указывают друг на друга -> по выходу из зоны видимости обе останутся живы
            student.teacher = teacher // все еще 1 сильная ссылка на Teacher
            teacher.student = student // 2 сильных ссылки на Student
            closure = { [weak student] in
                print(student) // все еще 2 сильных ссылки на Student
            }
        } // 1 сильная ссылка на Student, 1 сильная ссылка на Teacher
        print("exit playground")
    } // 0 сильных ссылок на Teacher -> отпускает сильную ссылку на Student -> 0 сильных ссылок на Student -> оба уничтожаются

    print("end.")


    // MARK: - Лист захвата значений у замыканий

    class Test { var name = "a" }

    var x = 10
    var y = 20
    var test = Test() // test.name = "a"

    // здесь мы захватываем ссылки (хоть это и  value type)
    let closure1 = {
        print("closure1:   x:\(x), y: \(y), name: \(test.name)")
    }

    closure1()
    x = 20
    y = 10
    test.name = "b"
    closure1()

    // здесь мы захватываем сами значения в []
    let closure2 = {
        [x,y,test] in
        print("closure2:   x:\(x), y: \(y), name: \(test.name)")
    }

    closure2()
    x = 100
    y = 100
    test = Test() // test.name = "a"
    test.name = "c"
    closure2()

    // лист захвата нужно писать до скобок с входными переменными
    let closure3 = { [x,y,test] () -> () in
        print("closure3:   x:\(x), y: \(y), name: \(test.name)")
    }


    closure3()
    x = 50
    y = 50
    test = Test() // test.name = "a"
    test.name = "d"
    closure3()

    // если добавить объект в коллекцию (массив,словарь), то коллекция держит объект сильной ссылкой


}
