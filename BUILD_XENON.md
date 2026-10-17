# Gunman360 — build e validação (v0.2b)

## Estado
O código atual é um bootstrap mínimo com logger e ciclo de vida do runtime. Não é um port jogável e não contém o motor original nem sistemas completos de jogo.

## Teste de compilação no host
Com um compilador C++ comum instalado:

```sh
make host-test
```

Esse teste verifica que os arquivos C++ portáveis compilam e que o bootstrap executa no computador de desenvolvimento. **Não** comprova compatibilidade com Xbox 360.

## Build Xenon
Instale e configure uma toolchain compatível com Xbox 360/Xenon. As opções de compilação, os arquivos de inicialização, as bibliotecas e as opções de linkedição dependem da distribuição usada.

```sh
make show-config
make xenon-elf
```

É possível substituir o compilador e as opções, por exemplo:

```sh
make xenon-elf XENON_CXX=/caminho/para/xenon-g++
```

Isso apenas troca o executável do compilador; não fornece dependências ausentes. Após o build, verifique o formato PowerPC/Xenon do arquivo, o ponto de entrada e as dependências de linkedição. A saída esperada é `build/elf/Xenon.elf`, mas ela não é considerada existente até que o build seja executado com sucesso.

## Etapa XEX (ainda pendente)
Depois de validar o ELF, identifique a versão de `elf2xex` da toolchain instalada e consulte sua sintaxe específica. Só então configure a conversão para `default.xex`. Não se presume uma linha de comando universal.

## Testes de hardware
Registre o ambiente de teste, a versão da toolchain, a saída do compilador e os resultados observados no XeLL/console. O teste de host ou o sucesso de um commit não comprova execução no Xbox 360.

## Próximos módulos
1. Identificar e validar toolchain e dependências.
2. Gerar e inspecionar `Xenon.elf`.
3. Validar inicialização em ambiente compatível.
4. Configurar conversão para `default.xex`.
5. Adicionar camadas de plataforma, recursos, renderização, áudio, entrada e gameplay em etapas testáveis.
