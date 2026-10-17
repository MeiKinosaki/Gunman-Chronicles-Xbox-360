# Gunman360 — Gunman Chronicles para Xbox 360

> **Versão de desenvolvimento:** v0.2b  
> **Plataforma-alvo:** Xbox 360 RGH/JTAG (dependente da toolchain e dos testes reais)  
> **Ordem obrigatória do build:** código → `Xenon.elf` → validação → `default.xex`

Gunman360 é um projeto inicial para pesquisar e construir uma base de port/runtime de **Gunman Chronicles** para Xbox 360. O código atual é um bootstrap técnico, ainda **não é um port jogável** e não contém o motor original nem todos os recursos do jogo.

## Estado atual verificado

| Etapa | Estado |
|---|---|
| README principal na `main` | Atualizado |
| Runtime mínimo | Implementado como scaffold |
| Logger mínimo | Implementado |
| Build de teste no computador (host) | Configurado; execução ainda precisa ser verificada |
| GitHub Actions para teste host | Workflow adicionado; resultado de execução pendente |
| Toolchain Xenon real | Pendente de configuração/verificação |
| `Xenon.elf` | Ainda não gerado/verificado |
| Teste no XeLL / console | Pendente |
| Conversão para `default.xex` | Pendente |
| Renderização, áudio e gameplay | Planejados; não implementados |

Um arquivo enviado ao GitHub ou um workflow configurado não equivale a build bem-sucedido. Os resultados da automação devem ser conferidos na aba **Actions**.

## Estrutura atual

```text
Gunman-Chronicles-Xbox-360/
├── .github/
│   └── workflows/
│       └── host-smoke-test.yml
├── src/
│   ├── main.cpp
│   └── core/
│       ├── logger.hpp
│       ├── logger.cpp
│       ├── runtime.hpp
│       └── runtime.cpp
├── BUILD_XENON.md
├── LICENSE
├── Makefile
└── README.md
```

## Funcionalidades que já existem no bootstrap

- **Logger:** emite mensagens básicas de informação, aviso e erro.
- **Runtime:** ciclo mínimo de inicialização, execução de smoke test e encerramento.
- **Build host:** alvo para compilar o código portável com um compilador C++ comum.
- **Build Xenon:** alvo configurável para tentar produzir o ELF quando a toolchain correta estiver instalada.
- **GitHub Actions:** workflow para executar o teste host em push, pull request ou manualmente.

Esses componentes são uma fundação mínima; não implementam os sistemas de jogo nem comprovam compatibilidade com o Xbox 360.

## Teste local do bootstrap

Com um compilador C++ compatível instalado, execute:

```sh
make host-test
```

O teste compila e executa o bootstrap no computador de desenvolvimento. Isso valida apenas a compilação host, não a plataforma Xenon.

Para consultar a configuração de compilação:

```sh
make show-config
```

## Build do Xbox 360: prioridade Xenon.elf

É necessária uma toolchain cruzada compatível com Xbox 360/Xenon. Os nomes dos executáveis, arquivos de inicialização, bibliotecas e opções de linkedição variam conforme a distribuição.

Com a toolchain instalada e configurada:

```sh
make xenon-elf
```

O Makefile usa `xenon-g++` por padrão. Se o compilador estiver em outro caminho, ajuste-o:

```sh
make xenon-elf XENON_CXX=/caminho/para/xenon-g++
```

A substituição do caminho não instala dependências nem garante que as opções de link estejam corretas. Depois de compilar, verifique o formato do ELF, a arquitetura PowerPC/Xenon, o ponto de entrada e as dependências. A saída esperada é `build/elf/Xenon.elf`; ela só pode ser considerada pronta após um build real bem-sucedido.

## Etapa seguinte: default.xex

A conversão para `default.xex` só deve começar após validar o ELF. É necessário identificar a versão da ferramenta `elf2xex` instalada e confirmar sua sintaxe e dependências. Não há ainda um `default.xex` confirmado neste repositório.

Após a conversão, registrar os resultados do teste no ambiente Xbox 360 de destino. Não afirmar que o jogo inicia até isso ter sido observado.

## Arquitetura planejada

Os itens abaixo são metas futuras, não funcionalidades já concluídas:

- **Runtime e plataforma:** inicialização, tratamento de falhas e ciclo principal.
- **Memória e recursos:** gestão de memória, leitura de arquivos e diagnóstico.
- **Vídeo/renderização:** estudo dos formatos e adaptação para a GPU Xenos.
- **Entrada e áudio:** integração com os mecanismos disponíveis na plataforma.
- **Conteúdo:** carregadores e adaptadores para formatos necessários, após investigação técnica.
- **Gameplay:** entidades, câmera, colisão, animação, lógica de NPCs, eventos, HUD e salvamento.
- **Desempenho:** métricas, profiling, testes de regressão e streaming de recursos.

## Roadmap sequencial

1. **v0.2b — bootstrap:** runtime e logger mínimos, Makefile, documentação e workflow host.
2. **Próximo marco:** executar e conferir o workflow de teste host.
3. Confirmar a toolchain Xenon e suas dependências.
4. Produzir e inspecionar `Xenon.elf`.
5. Testar inicialização em ambiente compatível, se suportado.
6. Confirmar o processo `elf2xex` e gerar `default.xex`.
7. Testar o XEX no console-alvo.
8. Só então avançar para os subsistemas do jogo, com testes por etapa.

As versões devem avançar uma por vez (v0.2b → v0.3b → v0.4b...), sem pular números nem marcar etapas como concluídas sem evidências.

## Compatibilidade, origem do código e licenciamento

O executável original de PC e suas dependências não podem ser presumidos compatíveis com Xbox 360. Um port pode exigir reimplementação de partes do runtime, adaptação de APIs e tratamento das diferenças de CPU/GPU. Este repositório não contém o código-fonte original completo do jogo e não promete compatibilidade total.

O arquivo [LICENSE](LICENSE) aplica-se ao material coberto por essa licença neste repositório. Ele não concede automaticamente direitos sobre o jogo original, marcas, executáveis, músicas, texturas, modelos ou outros materiais de terceiros. Distribua apenas código e recursos para os quais você tenha autorização.

## Como relatar falhas

Ao reportar um erro, inclua a versão da toolchain, o ambiente, o comando executado e a saída completa do compilador/linker. Nunca publique tokens, senhas ou outras credenciais.

Consulte [BUILD_XENON.md](BUILD_XENON.md) para instruções de build e validação.

---

**Resumo:** a base inicial do runtime foi adicionada à `main`, junto de um logger, um teste de compilação host e um workflow do GitHub Actions. A execução do workflow, a compilação do `Xenon.elf`, a conversão para `default.xex` e os testes no Xbox 360 continuam pendentes até serem efetivamente executados e verificados.
