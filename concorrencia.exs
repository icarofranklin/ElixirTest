defmodule Carteiro do
    # Esta função é "loop" de vida do nosso processo
    def trabalhar do
        receive do
            # Padrão 1: Recebeu uma ordem de entrega
            {:entregar, remetente, mensagem} ->
                IO.puts("[Carteiro] Preparando para entregar: '#{mensagem}'")

                # Simulando uma tarefa que demora 1 segundo
                Process.sleep(1000)

                # O carteiro envia uma mensagem de volta para quem pediu a entrega
                send(remetente, {:ok, "Entrega concluída!"})

                # Chama a si mesmo para continuar ouvindo novas mensagens (Recursão de Cauda)
                # ocorre quando a chamada recursiva é a última instrução executada pela função, sem qualquer operação pendente após o retorno da chamada.  Isso significa que o resultado da chamada recursiva é diretamente o resultado da função que a invocou.
                trabalhar()
            
            # Padrão 2: Recebeu uma ordem para encerrar
            :parar ->
                IO.puts("[Carteiro] Expediente encerrado. Indo para casa descansar.")
        end
    end
end 

# EXECUTANDO E TESTANDO NOSSO CARTEIRO

# 1. Pegamos o PID (Process Identifier) do nosso processo principal atual
meu_pid = self()

# 2. Iniciamos o processo do Carteiro em paralelo
# spawn/3 recebe: Módulo, :nome_da_funcao, [lista_de_argumentos]
pid_carteiro = spawn(Carteiro, :trabalhar, [])

IO.puts("[Principal] Carteiro criado com o PID: #{inspect(pid_carteiro)}")

# 3. Enviamos uma mensagem para o carteiro trabalhar
# Passamos nosso próprio PID para ele saber quem responder
send(pid_carteiro, {:entregar, meu_pid, "Bem-vindo ao mundo concorrente do Elixir!"})

IO.puts("[Principal] Mensagem enviada! Aguardando resposta...\n")

# 4. O processo principal agora fica aguardando a resposta do carteiro
receive do
    {:ok, resposta} ->
        IO.puts("[Principal] Recebi a confirmação: #{resposta}")
after
    # Se o carteiro demorar mais de 3 segundos, o processo principal desiste
  3000 -> 
    IO.puts("[Principal] O carteiro demorou demais. Desistindo.")
end

# 5. Mandamos o processo do carteiro parar e encerrar sua vida útil
send(pid_carteiro, :parar)