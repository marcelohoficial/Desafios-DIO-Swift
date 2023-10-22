import Foundation

// Enum para representar o tipo de conta bancária
enum TipoConta {
    case corrente
    case poupanca
}

// Struct que representa uma conta bancária
struct ContaBancaria {
    var numero: Int
    var saldo: Double
    var tipo: TipoConta
}

// Classe que representa um banco
class Banco {
    var contas: [ContaBancaria] = []
    
    // Método para adicionar uma nova conta
    func adicionarConta(numero: Int, saldo: Double, tipo: TipoConta) {
        let novaConta = ContaBancaria(numero: numero, saldo: saldo, tipo: tipo)
        contas.append(novaConta)
    }
    
    // Método que usa uma closure para executar uma operação em todas as contas de um tipo específico
    func processarContasDoTipo(_ tipo: TipoConta, usando closure: (inout ContaBancaria) -> Void) {
        for index in 0..<contas.count {
            if contas[index].tipo == tipo {
                closure(&contas[index])
            }
        }
    }
    
    // Método que usa concorrência para verificar o saldo de várias contas
    func verificarSaldoConcorrente() {
        let group = DispatchGroup()
        
        for conta in contas {
            group.enter()
            
            DispatchQueue.global().async {
                print("Verificando saldo da conta \(conta.numero)...")
                // Simulação de verificação de saldo (pode ser uma operação demorada)
                usleep(2000000) // Aguarda 2 segundos
                print("Saldo da conta \(conta.numero): R$\(conta.saldo)")
                group.leave()
            }
        }
        
        group.wait()
        print("Todas as verificações de saldo concluídas.")
    }
}

// Criação de instâncias
let banco = Banco()

banco.adicionarConta(numero: 1, saldo: 1000.0, tipo: .corrente)
banco.adicionarConta(numero: 2, saldo: 500.0, tipo: .poupanca)
banco.adicionarConta(numero: 3, saldo: 1500.0, tipo: .corrente)

// Exemplo de controle de fluxo
for conta in banco.contas {
    if conta.saldo > 1000 {
        print("Conta \(conta.numero) tem um saldo significativo.")
    } else {
        print("Conta \(conta.numero) tem um saldo baixo.")
    }
}

// Exemplo de uso de closures para atualizar saldos
banco.processarContasDoTipo(.corrente) { (conta) in
    conta.saldo += 100 // Simula um depósito
}
banco.processarContasDoTipo(.poupanca) { (conta) in
    conta.saldo -= 50 // Simula um saque
}

// Verifica saldo concorrentemente
banco.verificarSaldoConcorrente()
