import Foundation

enum CheckingResult<Result, Msg> {
    case nice(_ msg: Msg)
    case incorrect(_ result: Result)
}

enum CheckingError: Error {
    case invalid(_ msg: String)
}

func checkTask(_ task: String) throws -> CheckingResult<Double, String> {
    var isValid = task.range(
            of: #"^(\-)?(\d)+(\s)?(\+|\-)(\s)?(\d)+(\s)?=(\s)?(\-)?(\d)+$"#,
            options: .regularExpression
        ) != nil
    var isCorrect = false;
    var result: Double = 0;
    if (isValid) {
        let parts = task.filter({$0 != " "}).components(separatedBy: "=")
        let exp: NSExpression = NSExpression(format: parts[0])
        result = exp.expressionValue(with:nil, context: nil) as! Double
        if (result.isNaN) {
            isValid = false;
        } else {
            isCorrect = result == Double(parts.last!)
        }
    }
    
    if (!isValid) {
        throw CheckingError.invalid("ошибка: невалидный пример")
    }
    if (!isCorrect) {
        return .incorrect(result)
    }
    return .nice("молодец")
}

func getRet(_ tasks: Array<TaskCheck>, withNice: Bool) -> String {
    let ret = tasks.reduce("", { (acc, result) in
        if (!withNice && result.1 != nil) {
            return acc + result.0 + "\n"
        } else if (withNice) {
            return acc + result.0 + (result.1 == nil ? " молодец" : "") + "\n"
        }
        return acc + ""
    })
    return ret
}

typealias TaskCheck = (String, Double?, String)

func checkHomework(_ tasks: Array<String>) -> String {
    let tasksLength = tasks.count
    if (tasksLength == 0) {
        return "нет примеров"
    }
    var incorrectsCount = 0;
    var checkedTasks = [TaskCheck]()
    for task in tasks {
        do {
            let ok = try checkTask(task)
            switch(ok) {
            case CheckingResult.incorrect(let result):
                checkedTasks.append((task, result, "делай заново"));
                incorrectsCount += 1
            case CheckingResult.nice(let msg):
                checkedTasks.append((task, nil, msg));
            }
        } catch CheckingError.invalid(_) {
            return "переделывай"
        } catch {
            exit(-1)
        }
    }
    
    let is75PIncorrects = incorrectsCount * 100 / tasksLength > CRITICAL_INCORRECTS_COUNT
    var ret = "";
    if (is75PIncorrects) {
        ret = getRet(checkedTasks, withNice: false)
        ret += "делай заново"
        return ret
    } else {
        ret = getRet(checkedTasks, withNice: true)
    }
    return ret
}

let niceSolutions = [
    "32 + 16 = 48",
    "32 + 16 = 47",
    "32 + 16 = 47",
    "32 + 16 = 47",
    "32 + 14 = 46",
    "-32 - 14 = 46",
    "32-14=18",
    "-32+14= -18",
    "3948092384092384092384092384092380948230948230948203948092348902343452-13453456=-44653453458",
]

let incorrectSolutions = [
    "1 + 1 = 2",
    "2 + 2 = -42",
    "32 + 16 = 47",
    "32 + 16 = 464",
    "32 + 14 = 463",
    "-32 - 14 = 463",
    "32-14=1",
    "-32+14= -1",
    "3948092384092384092384092384092380948230948230948203948092348902343452-13453456=0",
]

let containsInvalid = ["sdf"]
let zero = [String]()

let CRITICAL_INCORRECTS_COUNT = 75

print("\n<= 75% некорректных решений:")
print(checkHomework(niceSolutions))

print("\n> 75% некорректных решений:")
print(checkHomework(incorrectSolutions))

print("\nесть невалидные описания решений:")
print(checkHomework(containsInvalid))

print("\nрешений не передано:")
print(checkHomework(zero))
