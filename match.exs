# No Elixir, o sinal de = não é apenas para "atribuir" um valor. Ele é um operador de Pattern Matching.
nome = "Ícaro Ferreira Franklin"
idade = 23
IO.puts("Nome: #{nome}, Idade: #{idade}")

status = :erro

mensagem = if status == :ok do
  "Tudo certo!"
else
  "Algo deu errado..."
end

IO.puts(mensagem)