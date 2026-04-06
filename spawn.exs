# Criando um processo leve que executa uma função em segundo plano
pid = spawn(fn ->
    IO.puts("Olá de um processo paralelo!")
end)

# O Elixir te devolve um PID (Process Identifier), como #PID<0.109.0>
# O Elixir tem mecanismos chamados Supervisors (Supervisores) que ficam observando esses processos e, se um deles falhar, o Supervisor o reinicia automaticamente. É daí que vem a famosa filosofia da linguagem: "Let it crash" (Deixe quebrar), pois o sistema sabe se curar sozinho.