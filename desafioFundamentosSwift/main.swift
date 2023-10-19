import Foundation

// Defina uma constante com o valor "Steve"
let constantName = "Steve"

// Defina uma variável do tipo String opcional com valor inicial "Jobs"
var optionalName: String? = "Jobs"

// Escreva um print fazendo interpolação com a constante e variável,
// definindo um valor padrão ("Wozniak") para a variável opcional
if let unwrappedName = optionalName {
    print("\(constantName) \(unwrappedName)")
} else {
    // Se a variável opcional for nula, use "Wozniak" como valor padrão
    let defaultName = "Wozniak"
    print("\(constantName) \(defaultName)")
}