# Instacook application using Flutter framework
Esta aplicação para smartphones iOS e Android tem  como objetivo permitir aos utilizadores pesquisarem receitas, criar o seu livro de receitas, seguir outros utilizadores que poderão ser mentores e fazer lista de compras com base nas receitas e porções escolhidas. 

## Implementação

A nivel de implementação, a aplicação tem uma construção de uma aplicação escalável, em que futuramente permite estender a aplicação para varias plataformas e novos módulos, em termos de segurança, todos os dados dos utilizadores se encontram encriptados pelo Firebase e com uma comunicação segura através de comunicação HTTPS entre servidor e cliente.

Toda a aplicação se encontra modular, com utilizações de padrões de desenho (Facades) e respeitando algumas das principais regras no desenvolvimento de software (separação de responsabilidade, entre outros), sendo que todos estes módulos passaram em testes unitários.

## Backend

No que toca ao back-end, é utilizado o Firebase, em que permite o desenvolvimento rápido de um servidor de back-end, possibilita autenticação com opções predefinidas, e um armazenamento em cloud para imagens e vídeos.
Contem limitações como, baixo nível em realizar pesquisas na base de dados, apenas 100 conexões e armazenamento máximo até 1GB.

### [Artigo](https://github.com/RicardoJardim/Instacook/blob/master/SSUI_relatorio_Alex_Leonardo_Ricardo.pdf "Article")
