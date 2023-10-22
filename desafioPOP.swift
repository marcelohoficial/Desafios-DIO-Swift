import Foundation

// Protocolo que define um dispositivo que pode ser ligado/desligado
protocol DispositivoLigavel {
    var ligado: Bool { get set }
    
    func ligar()
    func desligar()
}

// Struct que representa uma lâmpada
struct Lampada: DispositivoLigavel {
    var ligado: Bool = false
    
    func ligar() {
        ligado = true
        print("Lâmpada ligada.")
    }
    
    func desligar() {
        ligado = false
        print("Lâmpada desligada.")
    }
}

// Struct que representa uma TV
struct Televisao: DispositivoLigavel {
    var ligado: Bool = false
    
    func ligar() {
        ligado = true
        print("TV ligada.")
    }
    
    func desligar() {
        ligado = false
        print("TV desligada.")
    }
}

// Função que liga e desliga dispositivos ligáveis
func operarDispositivo(_ dispositivo: DispositivoLigavel) {
    if dispositivo.ligado {
        dispositivo.desligar()
    } else {
        dispositivo.ligar()
    }
}

// Criação de instâncias
let lâmpada = Lampada()
let televisao = Televisao()

// Exemplo de controle de fluxo
operarDispositivo(lâmpada)
operarDispositivo(televisao)

// Exemplo de uso de coleções
var dispositivos: [DispositivoLigavel] = [lâmpada, televisao]

for dispositivo in dispositivos {
    operarDispositivo(dispositivo)
}

// Verifica o estado dos dispositivos concorrentemente
let group = DispatchGroup()

for dispositivo in dispositivos {
    group.enter()
    
    DispatchQueue.global().async {
        if dispositivo.ligado {
            print("\(type(of: dispositivo)) está ligado.")
        } else {
            print("\(type(of: dispositivo)) está desligado.")
        }
        
        group.leave()
    }
}

group.wait()
