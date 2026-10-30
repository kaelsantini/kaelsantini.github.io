# Portfolio — Kael Santini

Specification of the project's decisions. Content source: `Resume - Kael Santini.pdf`.

## Goal

A public page that presents Kael Santini as a senior Ruby on Rails developer and takes visitors to the products in production and the contact channels.

## Decisions

| Topic | Decision | Reason |
|---|---|---|
| Site type | Static, no backend and no database | The content rarely changes, so a Rails app is not justified |
| Scope | A single page | No blog and no case studies |
| Languages | English by default, PT-BR as the alternative | The resume is in English |
| Contact | Links to `kael.santini@gmail.com`, [GitHub](https://github.com/kaelsantini) and [LinkedIn](https://www.linkedin.com/in/kael-santini-6849ab215/) | No form, so no backend |
| Visual | Typographic continuation of the resume | The site inherits an identity that is already Kael's, instead of a template or AI default |
| Hosting | GitHub Pages | Works with is-a.dev and does not depend on the Hetzner server |
| Domain | `kaelsantini.is-a.dev` | Free; the name was available on 2026-10-30, subject to PR approval |

### Rejected hosting options

- **Cloudflare Pages:** the is-a.dev docs currently recommend another provider, because Pages may require the domain to be in the user's own DNS zone. There are reports of error 1014 (CNAME Cross-User Banned).
- **Hetzner with Caddy:** a record pointing at the server would expose the origin IP that currently sits behind Cloudflare, and the portfolio would go down together with the products.

## Stack

- Semantic HTML and plain CSS, no framework.
- JavaScript only if indispensable; the page must work without it.
- Build with a Ruby script using only the standard library (`erb`, `yaml`, `fileutils`), no `Gemfile`.
- Deploy through GitHub Actions on every push to `main`, using `actions/upload-pages-artifact` and `actions/deploy-pages`.

## Repository structure

Public repository `kaelsantini/kaelsantini.github.io`:

```text
.
├── .github/workflows/deploy.yml
├── content/
│   ├── en.yml          # English copy
│   └── pt-BR.yml       # Portuguese copy
├── templates/
│   └── index.html.erb  # single template for both languages
├── assets/
│   ├── fonts/          # Oswald and Source Code Pro as woff2
│   └── styles.css
├── build.rb            # generates dist/ from content/ and templates/
├── .gitignore          # dist/ and *.pdf
└── SPEC.md
```

## Routes

- `/` — English.
- `/pt/` — Portuguese.

The language switch is a visible link on each page, with no automatic redirect. Both pages reference each other with `hreflang`.

## Page sections

1. **Hero:** name, title and short summary, with the contact links.
2. **Products:** simplifica.work, Rachide and nafrente.live, featured, each with a link.
3. **Experience:** DESYS Finance, EasyLemon and CGS Móveis, with period, description and technologies.
4. **Earlier experience:** Ministério da Justiça, CTMGEO, Prefeitura de Cascavel, Wealth Systems and Coach View / Frimesa, in compact form.
5. **Stack:** Ruby on Rails, PostgreSQL, Hotwire, Turbo Streams, RSpec, Docker, Git, CI/CD, Bootstrap and iOS/Android packaging.
6. **Education:** UNICESUMAR and UTFPR.
7. **Footer:** contacts repeated.

## Visual

The goal is for the page to look like Kael's resume published on the web, not like a landing page. No single signal proves a site was made by AI; what gives it away is the bundle of patterns with no decision behind them.

### Direction

- **Typography:** the resume's fonts, Oswald for headings and Source Code Pro for text, hosted on the site itself.
- **Layout:** a single left-aligned column at document reading width, with the thick rule under the name, as in the resume.
- **Color:** white background, near-black text and a single accent, the blue from the resume's headings. In the dark theme, a neutral background and the same blue lightened for good contrast.
- **Hierarchy:** comes from size, weight and spacing. Related items stay close and sections stay well apart.
- **Products:** text blocks with name, description and link, as in the resume, not a card grid.
- **Copy:** concrete sentences about what each system does. Use sentence case in headings; only the name is uppercase.

### Kept off the page

- Fonts: Inter, Geist, Space Grotesk and Instrument Serif; italic serif in headings.
- Colors: gradients, purple, cyan on dark, cream or beige backgrounds, glows and neon.
- Layout: centered hero, grid of identical cards, nested cards, stat rows like "15+ years", decorative grid backgrounds.
- Components: pill badges, eyebrows above headings, section numbering, icons in rounded squares, emoji as icons, colored side borders, glassmorphism, decorative shadows and heavily rounded corners.
- Motion: entrance animations, blinking cursors, pulsing dots, marquees and elastic easing.
- Copy: "passionate", "world-class", "supercharge", slogan contrasts ("Not X. Y.") and overuse of em dashes.

### Verification

Before publishing, check the page against the list above, in both languages and both themes.

## Requirements

- Responsive, mobile-first layout.
- Light and dark themes through `prefers-color-scheme`.
- Semantic HTML, with visible focus and adequate contrast.
- `title`, `meta description`, Open Graph and canonical URL in each language.
- No third-party trackers.

## Privacy

- The phone number from the resume does not appear on the site.
- The resume PDF stays out of the repository, because it contains the phone number and the repository is public.
- There is no resume download button in this version.

## Publishing

1. Create the repository and publish at `https://kaelsantini.github.io`.
2. In [Settings > Pages](https://github.com/kaelsantini/kaelsantini.github.io/settings/pages), set **Build and deployment > Source** to **GitHub Actions**.
3. Open the PR at [is-a-dev/register](https://github.com/is-a-dev/register) with `domains/kaelsantini.json`, using `kaelsantini.github.io` as the CNAME. The PR must be written by Kael: is-a.dev asks that requests not be AI-generated.
4. Only after the merge, enter `kaelsantini.is-a.dev` in Settings > Pages > Custom domain and enable Enforce HTTPS.
5. Update `SITE_URL` in `build.rb` and publish again.

Official guide: <https://docs.is-a.dev/guides/github-pages/>

## Updating the site

Edit the copy in `content/`, the layout in `templates/` or the styles in `assets/`. Keep both language files in sync.

Preview locally:

```bash
ruby build.rb
ruby -run -e httpd dist -p 8000  # needs the webrick gem on Ruby 3+
```

If `webrick` is not installed, use `python3 -m http.server 8000 --directory dist`. Then open <http://localhost:8000>.

Publish:

```bash
git status                # confirm that no PDF is listed
git add .
git commit -m "Describe the change"
git push
```

A push to `main` triggers the deploy automatically. Follow it in the [Actions tab](https://github.com/kaelsantini/kaelsantini.github.io/actions); to run it manually, use **Run workflow** on the [Deploy workflow](https://github.com/kaelsantini/kaelsantini.github.io/actions/workflows/deploy.yml). `dist/` is ignored by Git and built in CI.

## Visual references

- [The visible tells of AI design](https://www.impeccable.style/slop)
- [Scoring Show HN submissions for AI design patterns](https://www.adriankrebs.ch/blog/design-slop/)
