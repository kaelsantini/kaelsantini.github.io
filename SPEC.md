# Portfólio — Kael Santini

Especificação das decisões do projeto. Fonte do conteúdo: `Resume - Kael Santini.pdf`.

## Objetivo

Uma página pública que apresente Kael Santini como desenvolvedor sênior Ruby on Rails e leve o visitante aos produtos em produção e aos canais de contato.

## Decisões

| Tema | Decisão | Motivo |
|---|---|---|
| Tipo de site | Estático, sem backend e sem banco | Conteúdo muda pouco; não justifica um app Rails |
| Escopo | Uma página só | Sem blog e sem estudos de caso |
| Idiomas | Inglês como padrão, PT-BR como alternativa | O CV é em inglês |
| Contato | Links para `kael.santini@gmail.com`, [GitHub](https://github.com/kaelsantini) e [LinkedIn](https://www.linkedin.com/in/kael-santini-6849ab215/) | Sem formulário, logo sem backend |
| Visual | Continuação tipográfica do CV | O site herda uma identidade que já é sua, em vez de um padrão de template ou de IA |
| Hospedagem | GitHub Pages | Funciona com is-a.dev e não depende do servidor Hetzner |
| Domínio | `kaelsantini.is-a.dev` | Gratuito; nome livre em 2026-10-30, sujeito à aprovação do PR |

### Hospedagens descartadas

- **Cloudflare Pages:** a documentação do is-a.dev recomenda outro provedor no momento, porque o Pages pode exigir que o domínio esteja na zona DNS do próprio usuário. Há relato de erro 1014 (CNAME Cross-User Banned).
- **Hetzner com Caddy:** um registro apontando para o servidor exporia o IP de origem que hoje fica atrás do Cloudflare, e o portfólio cairia junto com os produtos.

## Stack

- HTML semântico e CSS puro, sem framework.
- JavaScript apenas se for indispensável; a página deve funcionar sem ele.
- Build com um script Ruby usando só a biblioteca padrão (`erb`, `yaml`, `fileutils`), sem `Gemfile`.
- Deploy por GitHub Actions a cada push na `main`, usando `actions/upload-pages-artifact` e `actions/deploy-pages`.

## Estrutura do repositório

Repositório público `kaelsantini/kaelsantini.github.io`:

```text
.
├── .github/workflows/deploy.yml
├── content/
│   ├── en.yml          # textos em inglês
│   └── pt-BR.yml       # textos em português
├── templates/
│   └── index.html.erb  # template único para os dois idiomas
├── assets/
│   ├── fonts/          # Oswald e Source Code Pro em woff2
│   └── styles.css
├── build.rb            # gera dist/ a partir de content/ e templates/
├── .gitignore          # dist/ e *.pdf
└── SPEC.md
```

## Rotas

- `/` — inglês.
- `/pt/` — português.

A troca de idioma é um link visível em cada página, sem redirecionamento automático. As duas páginas se referenciam com `hreflang`.

## Seções da página

1. **Hero:** nome, título e resumo curto, com os links de contato.
2. **Produtos:** simplifica.work, Rachide e nafrente.live, em destaque e com link para cada um.
3. **Experiência:** DESYS Finance, EasyLemon e CGS Móveis, com período, descrição e tecnologias.
4. **Experiência anterior:** Ministério da Justiça, CTMGEO, Prefeitura de Cascavel, Wealth Systems e Coach View / Frimesa, em formato compacto.
5. **Stack:** Ruby on Rails, PostgreSQL, Hotwire, Turbo Streams, RSpec, Docker, Git, CI/CD, Bootstrap e empacotamento iOS/Android.
6. **Formação:** UNICESUMAR e UTFPR.
7. **Rodapé:** contatos repetidos.

## Visual

O objetivo é que a página pareça o CV de Kael publicado na web, e não uma landing page. Nenhum sinal isolado prova que um site foi feito por IA; o que denuncia é o conjunto de padrões sem decisão por trás.

### Direção

- **Tipografia:** as fontes do CV, Oswald nos títulos e Source Code Pro no texto, hospedadas no próprio site.
- **Layout:** coluna única alinhada à esquerda, com largura de leitura de documento e a linha grossa sob o nome, como no CV.
- **Cor:** fundo branco, texto quase preto e um único acento, o azul dos títulos do CV. No tema escuro, fundo neutro e o mesmo azul clareado até ter bom contraste.
- **Hierarquia:** vem de tamanho, peso e espaçamento. Itens relacionados ficam próximos e as seções ficam bem separadas.
- **Produtos:** blocos de texto com nome, descrição e link, como no CV, e não uma grade de cards.
- **Texto:** frases concretas sobre o que cada sistema faz. Usar sentence case nos títulos; só o nome fica em caixa alta.

### Fora da página

- Fontes: Inter, Geist, Space Grotesk e Instrument Serif; serif itálico em títulos.
- Cores: gradientes, roxo, ciano sobre escuro, fundo creme ou bege, brilhos e neon.
- Layout: hero centralizado, grade de cards iguais, cards aninhados, faixa de números como "15+ years", fundo com grade decorativa.
- Componentes: pill badge, eyebrow sobre títulos, numeração de seções, ícones em quadrados arredondados, emoji como ícone, borda colorida lateral, glassmorphism, sombras decorativas e cantos muito arredondados.
- Movimento: animações de entrada, cursor piscando, ponto pulsante, marquee e easing elástico.
- Texto: "passionate", "world-class", "supercharge", contrastes de slogan ("Not X. Y.") e excesso de travessões.

### Verificação

Antes de publicar, conferir a página contra a lista acima, nas duas versões de idioma e nos dois temas.

## Requisitos

- Layout responsivo, mobile-first.
- Tema claro e escuro via `prefers-color-scheme`.
- HTML semântico, com foco visível e contraste adequado.
- `title`, `meta description`, Open Graph e URL canônica em cada idioma.
- Sem rastreadores de terceiros.

## Privacidade

- O telefone do CV não aparece no site.
- O PDF do CV não entra no repositório, porque contém o telefone e o repositório é público.
- Não há botão de download do CV nesta versão.

## Publicação

1. Criar o repositório e publicar em `https://kaelsantini.github.io`.
2. Abrir o PR em [is-a-dev/register](https://github.com/is-a-dev/register) com `domains/kaelsantini.json`, usando `kaelsantini.github.io` como CNAME. O PR deve ser escrito por Kael: o is-a.dev pede que pedidos não sejam gerados por IA.
3. Só depois do merge, informar `kaelsantini.is-a.dev` em Settings > Pages > Custom domain e ativar Enforce HTTPS.
4. Atualizar `SITE_URL` no `build.rb` e publicar de novo.

Guia oficial: <https://docs.is-a.dev/guides/github-pages/>

## Referências de visual

- [The visible tells of AI design](https://www.impeccable.style/slop)
- [Scoring Show HN submissions for AI design patterns](https://www.adriankrebs.ch/blog/design-slop/)
