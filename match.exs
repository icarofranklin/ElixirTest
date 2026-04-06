# No Elixir, o sinal de = não é apenas para "atribuir" um valor. Ele é um operador de Pattern Matching.
{:ok, nome} = {:ok, "Ícaro"}
IO.puts(nome)

{:ok, mensagem} = {:ok, "Sistema iniciado com sucesso"}
IO.puts(mensagem) # Imprime: Sistema iniciado com sucesso

{:ok, erro} = {:error, "Falha na conexão"} # Isso vai gerar um erro