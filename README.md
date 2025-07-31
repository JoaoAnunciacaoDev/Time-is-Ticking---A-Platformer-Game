# Time-is-Ticking---A-Platformer-Game
Um jogo de plataforma frenético onde cada moeda coletada são momentos a mais de vida. Corra contra o relógio, salte com precisão e adie o fim inevitável, uma moeda de cada vez.

Este projeto foi desenvolvido como um estudo prático de mecânicas de jogos de plataforma e padrões de arquitetura de software no Godot Engine.

---

## Índice

- [Funcionalidades](#funcionalidades)
- [Conceitos Técnicos Estudados](#conceitos-técnicos-estudados)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)

---

## Funcionalidades

- **Plataforma 2D com Controles Responsivos:** Movimentação fluida e controle aéreo.
- **Itens Coletáveis:** Moedas espalhadas pelo cenário que servem como o principal recurso para reiniciar o tempo.
- **Game Feel Avançado:** Implementação de mecânicas que melhoram a experiência do jogador, como Coyote Time e Jump Buffer.

---

## Conceitos Técnicos Estudados

O principal objetivo deste projeto foi aplicar e aprofundar o conhecimento em padrões de desenvolvimento de jogos. Os seguintes conceitos foram trabalhados:

###  Finite State Machine (Máquina de Estados Finita)
Para gerenciar os estados do jogador (`idle`, `walk`, `jump`, `fall`) de forma organizada e escalável. A FSM evita o uso de condicionais complexas (`if/else`) no script do jogador, separando a lógica de cada estado em sua própria classe. Isso torna o código mais limpo, legível e fácil de manter ou expandir.

### Coyote Time
Uma pequena janela de tempo (alguns milissegundos) após o jogador sair de uma plataforma onde ele ainda pode executar um pulo. Isso previne quedas frustrantes "por um triz" e torna os controles mais justos e agradáveis.

### Jump Buffer
Permite que o comando de pulo seja "lembrado" por um instante se o jogador apertar o botão um pouco *antes* de tocar o chão. Quando o personagem aterrissa, o pulo é executado imediatamente. Isso evita a sensação de "inputs perdidos" e torna as sequências de saltos mais fluidas.

### Sinais Customizados (Custom Signals)
Utilizados para criar uma comunicação desacoplada entre os nós. Por exemplo, quando o jogador coleta uma moeda:
1.  O nó da **Moeda** emite um sinal customizado `collected`.
2.  O nó da **Interface (UI)**, que gerencia o timer, está está conectada a esse sinal.
3.  Ao receber o sinal, a UI reinicia o cronômetro.
Dessa forma, a Moeda não precisa saber da existência do Timer, e vice-versa, tornando o sistema modular.

### Itens Coletáveis com Feedback
Criação de um sistema onde os itens colecionáveis são cenas independentes. Ao serem coletados, eles se removem da árvore de cena e instanciam uma cena de "feedback" (um efeito visual) no mesmo local, que então se autodestrói após sua animação terminar.

---

## Tecnologias Utilizadas

- **Motor de Jogo:** Godot Engine 4.4.1
- **Linguagem:** GDScript
- **Arte:** Assets Rocky Roads por Essssam (https://essssam.itch.io/rocky-roads)

---

## Autor

**[João Victor Anunciação da Silva]**
