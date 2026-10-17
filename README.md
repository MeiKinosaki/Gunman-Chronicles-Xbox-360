# Gunman360 — Gunman Chronicles para Xbox 360

> **Versão de desenvolvimento:** v0.2b  
> **Plataforma-alvo:** Xbox 360 com RGH/JTAG, sujeito à compatibilidade da toolchain e do ambiente de execução  
> **Prioridade de build:** `Xenon.elf` primeiro; validar o ELF; depois investigar/gerar `default.xex`.

Gunman360 é um projeto em estágio inicial para pesquisar e construir uma base de port/runtime de **Gunman Chronicles** para Xbox 360. Esta branch contém apenas um bootstrap mínimo e a configuração inicial de build. **Ainda não é um port jogável** e não inclui o motor original, seus recursos ou uma implementação completa do jogo.

## Estado atual

| Item | Estado verificado |
|---|---|
| Repositório GitHub | Criado |
| Branch de desenvolvimento v0.2b | Criada: `gunman360-v0.2b-xenon-elf-scaffold` |
| Ponto de entrada mínimo em C++ | Adicionado em `src/main.cpp` |
| Makefile configurável | Adicionado |
| Guia de build | Adicionado em `BUILD_XENON.md` |
| Compilação com toolchain Xenon real | **Ainda não verificada** |
| Binário `Xenon.elf` gerado | **Não confirmado** |
| Conversão para `default.xex` | Pendente |
| Teste no XeLL/Xbox 360 RGH | Pendente |
| Engine, renderização e gameplay | Ainda não implementados |

Um commit no GitHub confirma apenas que os arquivos foram gravados no repositório; não comprova que o projeto compilou ou foi testado em hardware.

## Objetivo e ordem de desenvolvimento

1. Preparar uma base de código C/C++ organizada para a plataforma Xenon.
2. Configurar e identificar a toolchain cruzada compatível com Xbox 360.
3. Compilar o bootstrap para gerar `Xenon.elf`.
4. Verificar o formato do ELF, o ponto de entrada, as dependências e os requisitos de linkedição.
5. Testar a inicialização do ELF em um ambiente compatível, como XeLL, se suportado pela configuração usada.
6. Só depois da validação, confirmar a sintaxe e os requisitos da ferramenta `elf2xex` disponível na toolchain e gerar `default.xex`.
7. Testar o XEX no console de destino e registrar os resultados.
8. Desenvolver os subsistemas do jogo em incrementos pequenos, com testes e histórico de versões.

**Não se deve marcar uma etapa como concluída sem evidência reproduzível.** As versões devem avançar sequencialmente — v0.2b, v0.3b, v0.4b e assim por diante — sem saltar versões.

## Estrutura atual

```text
Gunman-Chronicles-Xbox-360/
├── README.md
├── LICENSE
├── BUILD_XENON.md
├── Makefile
└── src/
    └── main.cpp
```

O Makefile cria diretórios de build durante a compilação. Os artefatos gerados não são incluídos no repositório por padrão.

## Requisitos de build

- Um ambiente de desenvolvimento com uma **toolchain cruzada compatível com Xbox 360/Xenon**.
- O compilador C++ configurado no Makefile (por padrão, `xenon-g++`).
- Os arquivos de inicialização, bibliotecas, opções de linkedição e demais dependências exigidos pela versão específica da toolchain.
- Para a etapa posterior de XEX, uma versão compatível de `elf2xex` e a documentação correspondente.

O nome dos executáveis e as opções de compilação/linkedição podem variar entre distribuições. O Makefile é configurável, mas não substitui a instalação nem a validação da toolchain.

### Consultar a configuração

```sh
make show-config
```

### Tentar compilar o ELF

Em um ambiente com a toolchain compatível instalada:

```sh
make xenon-elf
```

Para usar outro caminho de compilador:

```sh
make xenon-elf XENON_CXX=/caminho/para/xenon-g++
```

Esse exemplo altera apenas o caminho do compilador; não adiciona bibliotecas ou arquivos de inicialização que estejam faltando. Consulte também [BUILD_XENON.md](BUILD_XENON.md).

### Saída esperada do alvo de build

```text
build/
├── obj/
│   └── main.o
└── elf/
    └── Xenon.elf
```

Essa árvore descreve a **saída esperada**, não arquivos binários já produzidos. Se o build falhar, registre a mensagem completa e ajuste as opções à toolchain instalada antes de declarar o ELF pronto.

## Arquitetura planejada

Estes são objetivos de desenvolvimento, não componentes que já estejam implementados:

- **Runtime e inicialização:** ciclo principal, tratamento de falhas e encerramento controlado.
- **Plataforma Xbox 360:** integração com entrada, vídeo, áudio, armazenamento e APIs disponíveis na toolchain.
- **Memória e recursos:** carregamento controlado de dados, gestão de memória e diagnóstico de erros.
- **Renderização:** investigação do formato dos dados e criação de uma camada de renderização compatível com a GPU Xenos.
- **Conteúdo do jogo:** carregadores e adaptadores para os formatos de recursos necessários, após verificação técnica e jurídica.
- **Gameplay:** entidades, câmera, colisão, animação, lógica de NPCs, eventos, HUD e sistema de salvamento, a serem implementados e testados gradualmente.
- **Ferramentas de diagnóstico:** logs, verificações de integridade, métricas de desempenho e testes reproduzíveis.

A prioridade imediata é a toolchain e a inicialização ELF. Os sistemas de jogo não devem ser apresentados como funcionais antes de haver código e testes correspondentes.

## Compatibilidade e limites técnicos

O executável original de PC e suas dependências não podem ser presumidos compatíveis com o Xbox 360. Um port real pode exigir a reimplementação de partes do runtime, adaptação de APIs, tratamento de diferenças de CPU/GPU e conversão ou carregamento adequado dos recursos.

Este repositório não contém o código-fonte original completo do jogo. Não se presume acesso a esse código nem se promete compatibilidade total. A viabilidade de cada subsistema deve ser confirmada por pesquisa técnica, protótipos e testes.

## Uso de recursos e licenciamento

O arquivo [LICENSE](LICENSE) deste repositório indica Apache License 2.0 para o material coberto por essa licença. Isso **não concede automaticamente direitos** sobre o jogo original, marcas, executáveis, músicas, texturas, modelos ou outros recursos de terceiros. Use apenas código e recursos que você tenha autorização para distribuir e utilizar; mantenha avisos de licença e atribuições exigidos por seus respectivos titulares.

## Checklist de progresso

- [x] Criar branch de desenvolvimento para o scaffold v0.2b.
- [x] Adicionar ponto de entrada C++ mínimo.
- [x] Adicionar Makefile configurável para o alvo ELF.
- [x] Documentar os critérios de validação do build.
- [ ] Confirmar a toolchain e suas dependências reais.
- [ ] Compilar `Xenon.elf`.
- [ ] Inspecionar formato, entry point e dependências do ELF.
- [ ] Testar inicialização em ambiente compatível.
- [ ] Confirmar o comando correto para `elf2xex`.
- [ ] Gerar `default.xex` após validar o ELF.
- [ ] Testar o XEX no console-alvo.
- [ ] Começar os subsistemas do runtime com testes automatizados.

## Contribuição e relato de erros

Ao relatar uma falha, inclua o sistema utilizado, a origem/versão da toolchain, o comando executado e a saída completa do compilador/linker. Não inclua chaves, tokens ou credenciais. Alterações de arquitetura devem registrar o que foi implementado, como foi testado e o que continua pendente.

---

**Resumo:** Gunman360 está na fase de bootstrap. O próximo marco verificável é produzir e validar `Xenon.elf`; `default.xex` e a execução do jogo continuam pendentes.
