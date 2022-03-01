--17fev22
--login SQL server with AD credential

Comando para rodar o SQL em máquinas externas usando CPF do domínio e consequentemente remover os usuários locais desnecessários:

C:\Windows\System32\runas.exe /netonly /user:tce.govrn\637CPF... "C:\Program Files\Microsoft SQL Server\110\Tools\Binn\ManagementStudio\Ssms.exe"