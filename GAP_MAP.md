# Tese — Gap Map

**Criado**: 2026-05-14
**Defesa target**: fim de julho 2026 (≈ 10-11 semanas)
**Gaps fechados target**: fim de junho 2026 (≈ 6.5 semanas)
**Tese**: *Towards a Local Interpretation of Attention Based Neural Models*

> Documento vivo. Versão 1 cobre **experimentos**. Mapa de capítulos vem em iteração seguinte.

---

## 0. Resumo executivo

A proposta promete três contribuições empíricas (C1/G1, C2/G2, C3/G3) ancoradas em duas publicações: um paper aceito (ICTAI 2025, Qualis A3+) e um preprint (arXiv 2026). O estado real diverge da proposta em três pontos críticos:

1. **G2 (steering) foi abandonado** em março/2026 (LSNC NO-GO), mas o texto da tese (`circuitry.tex` §5.6) ainda apresenta G2 com protocolo congelado e plano de execução ativo.
2. **G3 (diagnósticos) teve as duas hipóteses pré-registradas falsificadas** em abril/2026, com gates pré-declarados intactos. O texto (`circuitry.tex` §5.7) descreve o gate de publicação como requisito para reportar resultados — agora ele falhou.
3. **Submissão a jornal A3+ ainda não aconteceu** (requisito formal do programa). O preprint de stego é o candidato natural, mas não está submetido.

Não é "tese parada". É tese com material substancial e três pontos onde a narrativa precisa ser reconciliada com os dados. As decisões abaixo são em maior parte de **enquadramento** e **escopo**, não de mais experimentos. O caminho crítico para o fim de julho privilegia escrita e submissão — não novas rodadas computacionais — desde que decisões de enquadramento sejam tomadas até fim de maio.

---

## 1. Restrições e prazo

| Item | Status | Bloqueia defesa? |
|---|---|---|
| Paper aceito A3+ (ICTAI 2025) | ✅ feito | Não |
| Paper submetido a jornal A3+ | ❌ pendente | **Sim** (requisito formal) |
| Tese escrita e compilável | ⚠️ parcial | Sim |
| Revisão dos orientadores | ❌ pendente | Sim |
| Banca e defesa marcadas | ❌ pendente | Sim |

Janela: ~6.5 semanas até fim de junho para fechar gaps materiais; ~4 semanas adicionais para revisão final + defesa.

---

## 2. Mapa de contribuições

### C1 / G1 — Emergence (Grokking under distribution shift)

**Prometido (proposta + intro + circuitry §5.4):**
- Caracterizar mudanças representacionais ao redor de transições grokking-like via probes mecanísticos
- Métricas comportamentais (delay-to-generalization, estabilidade pós-transição) **e** mecanísticas (SAE sparsity/reconstruction, estabilidade cross-seed de features, alinhamento cross-layer)
- Falsificabilidade C1: "no systematic association between transition timing and mechanistic changes across seeds"

**Existe:**
- ICTAI paper aceito: `Inducing Grokking with Distribution Shifts` (Qualis A3+ confirmado 2026-04-21). Cobre o lado **comportamental**: datasets sintéticos equidistant/equivariant, MLP + 2-layer Transformer, 10 runs, V100 16GB.
- Capítulo `learning_phenomena.tex` substancial (~250 linhas) — definições, datasets sintéticos, resultados de equidistant e equivariant. **Quase totalmente comportamental.**
- Repo: `brenowca/grokking_explained` (link em `\repourl`).
- Em paralelo: `research/memorized-init-compression/` — implementação completa (~2100 linhas) testando se SGD escapa memorização via weight decay (compression bias). 3 condições, ~10-12 GPU-h, **nunca rodado**.

**Falta para sustentar C1 como prometido:**
- A parte **mecanística** prometida (SAE sparsity/reconstruction em torno da transição, feature stability cross-seed, cross-layer alignment) **não tem evidência empírica**. O capítulo só reporta comportamento.
- Sem rodar nada mecanístico em G1, C1 deveria ser **reduzido a um claim comportamental** (já forte e publicado). O texto de claim/falsificação (`circuitry.tex` §5.5 Table C1) cita feature stability + cross-layer alignment como observáveis primários — isso precisa cair, ou alguma evidência precisa ser produzida.

**Decisões abertas:**
- **(D1.a) C1 fica comportamental?** Sim → editar `circuitry.tex` §5.5 e §5.4 para refletir, evitar overclaim. Custo: ~1 dia de reescrita.
- **(D1.b) Compression Bias entra na tese?** Se rodar o sweep (~10-12 GPU-h, mas requer GPU; GTX 1060 do Helios é insuficiente para o sweep completo conforme memória) e produzir resultado positivo, vira **subseção em `learning_phenomena.tex`** estendendo G1. Se não, fica como future work / appendix.
  - Compute disponível: GTX 1060 6GB local (suficiente para pilots, não sweep). UFRGS cluster status incerto. TPU/vast.ai não acionado.
  - **Recomendação**: rodar pilot local (1 condição, 50 epochs) em ≤2 dias para sanity. Se OK, decidir se vale buscar GPU externa para sweep completo.

---

### C2 / G2 — Steering locality (Neuro-symbolic constraints)

**Prometido (proposta + intro + circuitry §5.4-5.6 + future.tex):**
- Pipeline LoRA+LTN+guided beam search para controle local de geração
- Métricas: constraint satisfaction, perplexity, collateral regression rate
- Avaliação em DFA-compatible (vs Ctrl-G) e syntax-sensitive (vs CCN+)
- Protocolo congelado pós-fevereiro 2026, runs finais março-abril 2026
- Risks R3a/R3b/R3c declarados (latency, predicate error propagation, conflicting constraints)
- Falsificabilidade C2: "constraint gains require unacceptable quality loss or collateral regressions exceed preset bounds"

**Existe:**
- Repo LSNC com infraestrutura completa (src/, tests/, configs/, 6 notebooks).
- Experimentos iniciais rodados: baseline (Ctrl-G), soft constraints (LSNC), hard (LSNC-Hybrid), ablations, stress tests, dashboard.
- **Resultados ruins**: score function comporta como degrau (não diferenciável). Overhead computacional grande. Convicção científica de Breno: baixa ("não acredito em steering semântico via beam search; nem se conecta à narrativa da tese").
- **Decisão registrada 2026-03-30**: LSNC NO-GO (lsnc-no-go-arguments.md). Comunicado aos orientadores.

**Falta:**
- **Nada experimental** se a decisão NO-GO se mantém.
- **Mas o texto da tese ainda assume G2 ativo**: `circuitry.tex` §5.6 ("G2 steering protocol (preliminary evidence track)") descreve protocolo congelado, tabela 5.5 de tarefas-predicados-baselines, §5.7 ("G2 limitations and failure modes") trata como limitações de uma trilha em execução. Idem `future.tex` (Contribuição 3 lista G2 como entregável). `intro.tex` §1.2 H2 e RQ2 são sobre logic-guided steering.

**Decisões abertas:**
- **(D2.a) Manter G2 NO-GO mas converter em "negative evidence" reportada?** Reescrever §5.6 como "evidência preliminar e razões metodológicas para não-completar G2 nesta tese; resultado como negative evidence que motiva R3a–c". Custo: ~3 dias de reescrita; protege a coerência da proposta original sem requerer experimentos novos. **Recomendado**.
- **(D2.b) Remover G2 inteiramente da tese?** Cortar §5.6, §5.7, redefinir Contribuição 3 em `future.tex`, ajustar Tabela 5.4 (claim-to-evidence), reduzir RQ/H2 do `intro.tex`. Custo: ~5 dias; muda o escopo declarado da tese; precisa de aval dos orientadores antes (já é mid-PhD). Mais limpo, mais arriscado por mexer no contrato com o programa.
- **(D2.c) Reviver G2 com método novo?** Não recomendado — Breno explicitamente disse 2026-03-30 que não acredita no método; 6.5 semanas é insuficiente para novo método + experimentos + escrita + revisão.

---

### C3 / G3 — Diagnostics (SAE-based perturbation detection)

**Prometido (proposta + intro + circuitry §5.7):**
- Detector com features esparsas (SAE) supera baselines de saída em estabilidade
- Métricas: ROC-AUC, PR-AUC, calibração, lead time
- Avaliação em ViT-B/16 + CLIP, FGSM + PGD + stego
- Hipóteses **pré-registradas** H1 (magnitude invariance) e H2 (adversarial specificity) com thresholds numéricos
- Gate de publicação: H1 ∧ H2 ∧ saúde do SAE ∧ análise de features ∧ análise por camada
- Falsificabilidade C3: "internal signatures do not outperform output-only baselines under transfer settings"

**Existe (estado canônico, 2026-04-24):**
- **Preprint arXiv**: `Interpretable Detection of Steganographic Adversarial Perturbations in Vision Models Using Sparse Autoencoders` (Carvalho et al. 2026). Resultados positivos: 0.90 ROC-AUC clean-vs-stego com 32 features SAE.
- **Repo `interp_adversarial_image`** rodou Fases 0-3 com PLAN.md / DESIGN_CHOICES.md / RESEARCH_LOG.md pré-registrados.
- **Bug crítico descoberto e corrigido**: FGSM aplicava clip [0,1] em espaço normalizado. Pré-fix: AUC plana ~0.88 (artefato OOD). Pós-fix: comportamento honesto. Bug é candidato a **case study metodológico** no paper.
- **Resultados pós-fix (gates pré-registrados)**:
  - **H1 — magnitude invariance: ❌ FALSIFICADA.** |r(ε,AUC)| = 0.92 (gate < 0.3); var(AUC) = 6.7×10⁻³ (gate < 10⁻³); mean(AUC) = 0.76 (gate > 0.95). AUC varre 0.65→0.86 com ε ∈ [0.001, 0.032]. Padrão de magnitude detector clássico.
  - **H2 — adversarial specificity: ❌ FALSIFICADA pelo gate.** gap(FGSM − max_benigno) = 0.12 (gate > 0.3); max_benigno = 0.68 (gate < 0.7 ✅). Existe gap pequeno e estatisticamente significativo, mas abaixo do limiar.
- **Leitura conjunta H1 ∧ H2**: detector responde a mistura de magnitude/OOD (~0.62-0.68 em benignos L2-casados) + estrutura específica de gradiente-FGSM (extra ~0.12). Nem "change detector puro" nem "adversarial detector puro" — intermediário, e abaixo do threshold pré-declarado.
- **Phase 4 (feature analysis)** não rodou — gateada em H1∧H2 passarem.

**Caveats de escopo (modulam força, não revertem conclusão):**
- 1 seed; 1600 amostras/variante; 1 camada (`mlp_11`); 1 arquitetura SAE (linear + L1); 1 detector (logística); 1 ε de treino (0.012).
- Classificador linear probe (backbone IN-1k congelado). Invariâncias do pretraining dominam.

**Falta para C3 publicação-ready segundo o gate atual:** tudo — gate falhou.

**Decisões abertas (escolhas de enquadramento, não experimentos):**
- **(D3.a) Pivot para "paper de resultado negativo + lições metodológicas".** Esta é a saída honesta com os gates pré-registrados. Estrutura natural:
  1. Promessa do método (SAE expõe features adversarial-específicas, replicando o preprint stego).
  2. Pré-registro com H1/H2 e gates.
  3. Bug do clip como pitfall didático (com fix).
  4. Resultados pós-fix: ambos gates falham; sinal residual existe mas é pequeno.
  5. Lições metodológicas para o campo (medir L2 antes de reportar AUC; pre-register thresholds; cross-eval em vez de detectores independentes).
  - **Onde vai**: jornal-target da tese; também serve como conteúdo de C3 no capítulo `circuitry.tex` e `current-results.tex`.
  - **Custo**: ~3-4 semanas de escrita (paper + edits no capítulo).
  - **Mantém C3 como contribuição genuína**: reportar resultado negativo com pré-registro é contribuição metodológica forte. **Recomendado**.

- **(D3.b) Investigar hipóteses adjacentes antes de declarar game over.** Variantes não testadas: SAE TopK/JumpReLU; detector não-linear; multi-seed com CI; sweep de camadas; ViT-Large.
  - **Custo**: 2-3 semanas de compute na GTX 1060 + análise.
  - **Risco**: se variantes também falharem, gasta-se tempo e o paper continua negativo. Se passarem, abre espaço para C3 positivo — mas requer rerodar e reescrever sob nova narrativa em tempo apertado.
  - **Não recomendado** com 6.5 semanas — alto custo, alto risco, conflita com prazo da defesa.

- **(D3.c) Manter G3 só como "stego paper" (preprint) e descartar o trabalho de Phase 0-3.**
  - O preprint cobre stego (resultado positivo, 0.90 AUC). Adversarial detection (FGSM/PGD) ficaria fora do escopo final de C3.
  - **Custo**: zero experimental; ~2 dias de reescrita do capítulo para limitar G3 ao escopo do preprint.
  - **Perda**: trabalho substancial de pré-registro + descoberta de bug não entra na narrativa.
  - Inferior a D3.a porque desperdiça material já produzido.

---

### Lateral — Compression Bias (`memorized-init-compression`)

**Status atual:**
- Pipeline pronto, ~2100 linhas, 3 condições configuradas, ~10-12 GPU-h estimado para sweep completo.
- Breakthrough conceitual: 2026-03-09 (9 experimentos CPU, modular addition 6.19%→79.84%, sparse parity 100%).
- **Sweep completo nunca rodou**.

**Não está na proposta** como contribuição declarada. Decisão de inclusão é estratégica:

- **(D4.a) Excluir da tese, manter como future work / paralelo pós-defesa.** Recomendado se Compression Bias **não** for incluído como subseção de G1. Mais limpo.
- **(D4.b) Rodar pilot (1 condição, 50-100 épocas) localmente e decidir.** ~1-2 dias. Se resultado é claramente positivo (compression mensurável), incluir como subseção de `learning_phenomena.tex` estendendo G1 mecanístico. Custo adicional: ~1-2 semanas para sweep + análise + escrita; **requer GPU externa** porque GTX 1060 é insuficiente para o sweep completo.
- **(D4.c) Workshop paper paralelo, fora da tese.** Útil para CV, mas concorre por tempo com defesa.

**Recomendação**: rodar pilot em paralelo nas próximas 2 semanas como **decision input**, sem committment de inclusão. Se positivo e rápido, virar D4.b; se não, D4.a.

---

## 3. Requisito formal — submissão a jornal A3+

**Status**: ❌ pendente. Bloqueia defesa.

**Candidato natural**: o paper de stego (atualmente arXiv preprint `carvalho2026interpretable_stego_detection_sae`). Resultados positivos (0.90 AUC), método claro, escopo coerente com G3.

**Candidato alternativo / complementar**: paper de resultado negativo de adversarial detection (D3.a). Mais inovador metodologicamente, mas com risco de revisores reagirem a "paper que falsifica próprio método" — viés contra negatives existe em jornais.

**Caminho recomendado:**
1. **Semana 1-2**: revisar e polir o preprint de stego para submissão a jornal A3+ (Pattern Recognition, Neural Networks, IEEE TPAMI, Neural Computing & Applications dependendo do alvo). Identificar 2-3 alvos com escopo casado.
2. **Semana 3-4**: submeter. Ganhar timestamp formal — submissão (não aceitação) costuma ser suficiente para defesa, mas confirmar com PPGC.
3. **Em paralelo (semana 3-6)**: escrever paper negativo de adversarial detection (D3.a). Submeter depois da defesa.

**Decisão aberta:**
- **(D5.a) Submeter primeiro o stego paper.** Recomendado: pronto, positivo, baixo risco.
- **(D5.b) Submeter primeiro um paper unificado (stego + adversarial negativo).** Risco alto, prazo apertado, escopo grande para revisão única.

---

## 4. Caminho crítico — 6.5 semanas

Ordenação assumindo decisões D2.a (G2 reescrito como negative evidence), D3.a (paper negativo de adversarial), D4.a ou b (compression como pilot), D5.a (stego primeiro):

| Sem | Foco principal | Entregáveis |
|---|---|---|
| 1 (14-21 mai) | Decisões D1-D5 com orientadores | GAP_MAP discutido + alinhamento; pilot Compression Bias rodando |
| 2 (22-28 mai) | Stego paper: revisão final para jornal | Draft jornal v1 + identificação de alvo |
| 3 (29 mai-4 jun) | Submissão do stego paper | Submetido (timestamp); paper negativo: outline + intro |
| 4 (5-11 jun) | Paper negativo de adversarial detection | Draft v1 (método + resultados; bug case study) |
| 5 (12-18 jun) | Reescrita G2 (negative evidence) + G3 (gate falhou) nos capítulos | `circuitry.tex` §5.6-5.7 reconciliados; `current-results.tex` atualizado |
| 6 (19-25 jun) | Reescrita G1 (calibrar C1 comportamental) + Compression decisão | `learning_phenomena.tex` revisado; D4 finalizado |
| 7 (26 jun-2 jul) | Buffer / paper negativo finalização / preparar revisão orientador | Submissão paper negativo (opcional, pode ir pós-defesa) |
| 8-10 (jul) | Revisão orientadores, banca, defesa | Manuscrito final, defesa |

**Restrição compute**: GTX 1060 é suficiente para pilot Compression; insuficiente para sweep completo. Se D4.b ativar, identificar GPU externa (Colab/Kaggle/vast.ai/UFRGS cluster) na semana 1.

---

## 5. Próximos passos imediatos

Decisões a fechar nesta janela inicial (ordem de prioridade):

1. **D2 — G2**: confirmar reescrita como negative evidence (D2.a) vs remoção (D2.b). Requer aval de orientadores antes da reescrita.
2. **D3 — G3**: confirmar pivot para paper negativo (D3.a). Decisão de Breno; afeta a história inteira da tese.
3. **D5 — Jornal**: priorizar stego paper (D5.a) e identificar alvo. Decisão técnica que destrava o requisito formal.
4. **D1 — C1**: aceitar redução para claim comportamental (D1.a) — provavelmente já o caminho natural.
5. **D4 — Compression**: decidir se pilot vale a pena (D4.b) ou cortar (D4.a).

Discussões com orientadores são pré-requisito para D2 e D3 — provavelmente nesta primeira semana de retomada.

---

## 6. Mapa de capítulos

### 6.0 Achado estrutural — escopo da tese > escopo da proposta

O arquivo principal da tese (`infufrgs/ppgc-tese.tex`) define **três partes**:

- **Part I — Understanding**: Introduction, Background, Dynamics of Emergence
- **Part II — Steering**: Neuro-symbolic dissection of circuitry, Neuro-symbolic constrained generation
- **Part III — Generality Across Modalities**: Reasoning in time, Non-verbal (PDE/Physics) models
- Limitations and Future Work + Conclusion

A proposta (`ppgc-prop-tese.tex`) cobre apenas Part I e o início de Part II (Methodology + Current Results). **Part III (Reasoning, Physics) não está na proposta, está marcada para inclusão na tese final, e os arquivos estão vazios.**

Isso configura o maior gap estrutural: a tese, se mantida com o escopo declarado em `ppgc-tese.tex`, precisaria de duas novas linhas de trabalho substantivas (Reasoning como tópico interpretability e PDE/Physics como aplicação não-verbal) **sem evidência empírica encaminhada**. Em 6.5 semanas isso é inviável.

**Decisão estrutural prioritária (D6):**
- **(D6.a) Reduzir escopo da tese a Parts I + II** — alinhar com o que existe de evidência (proposta + experimentos rodados). Remover Part III do `ppgc-tese.tex`; mover Reasoning e Physics para Future Work como direções abertas. **Recomendado**.
- **(D6.b) Manter Part III com tratamento conceitual/review** — sem novos experimentos, escrever Reasoning como capítulo de literatura/posicionamento e Physics como discussão de domínio aplicado. Custo: ~2-3 semanas adicionais de leitura + escrita; risco médio (capítulos sem dados empíricos diluem a tese).
- **(D6.c) Manter Part III com experimentos** — não viável no prazo.

D6 precisa ser fechada com orientadores na semana 1, **antes** de qualquer reescrita.

### 6.1 Quadro-resumo dos arquivos `.tex`

Convenção: `vazio` (≤20 linhas, só preamble) · `esqueleto` (estrutura sem conteúdo substantivo) · `rascunho` (conteúdo presente, precisa revisão) · `revisão` (conteúdo bom, precisa só polimento) · `pronto`.

| Chapter (TOC tese) | Arquivo | Linhas | Status | Dep. exp. | Ação principal |
|---|---|---|---|---|---|
| Front matter — Abstract (EN+PT) | `chapters/abstract.tex` | 49 | rascunho | D1, D2, D3 | Reescrever para refletir resultados negativos de G3 e G2 reduzido |
| Cap. 1 — Introduction | `chapters/intro.tex` | 105 | rascunho | D2, D3, D6 | Calibrar C2/H2 (G2 redux) e C3/H3 (G3 negativo). Remover RQ/H sobre Part III se D6.a |
| Cap. 2 — Background | `chapters/background.tex` | 223 | revisão | — | Polir, checar consistência com mudanças do Cap. 4. Conteúdo é forte. |
| Cap. 3 — Dynamics of Emergence | `chapters/learning_phenomena.tex` | 247 | rascunho | D1, D4 | Decidir incluir Compression Bias subseção (D4). Reduzir C1 a claim comportamental (D1). |
| Cap. 4 — Methodology (circuitry) | `chapters/circuitry.tex` | 246 | rascunho com conflito | **D2, D3** | Reescrever §5.6 (G2 → negative evidence) e §5.7 (G3 → reportar gates que falharam). Maior trabalho de reescrita. |
| Cap. 5 — Constrained Generation | `chapters/constrained_generation.tex` | 3 | **vazio** | **D2** | Se D2.a: escrever capítulo curto de negative evidence (~10-15 pp). Se D2.b: remover do TOC. |
| Cap. 6 — Reasoning in time | `chapters/reasoning.tex` | 11 | **vazio** | **D6** | Se D6.a: remover do TOC. Se D6.b: escrever do zero (~10-20 pp review). |
| Cap. 7 — Non-verbal (Physics) | `chapters/physics.tex` | 3 | **vazio** | **D6** | Idem reasoning. |
| Cap. 8 — Limitations & Future Work | (sem arquivo — comentado em `ppgc-tese.tex`) | 0 | inexistente | D1-D6 | Criar arquivo `chapters/future.tex`. Conteúdo derivável das decisões + caveats experimentais. ~5-10 pp. |
| Cap. 9 — Conclusion | `chapters/closing.tex` | 11 | rascunho (forma de proposta) | D1-D6 | Reescrever em forma de tese final, não de proposta. ~3-5 pp. |
| Appendix — Resumo expandido (PT) | `chapters/resumo-expandido.tex` | 52 | rascunho (forma de proposta) | D1-D3 | Atualizar para refletir resultados finais (não promessas). |

**Arquivos não usados em `ppgc-tese.tex`** (decisão de housekeeping):
- `chapters/alignment.tex` (esqueleto, comentado no main): apagar ou usar como subseção de Intro/Background. **Recomendação**: apagar.
- `chapters/instructions.tex` (template de instruções LaTeX): apagar.
- `chapters/prop-tese/`: pasta inteira só para `ppgc-prop-tese.tex` (proposta). Manter intacta — proposta já foi avaliada, é histórica.

### 6.2 Dependências experimento ↔ capítulo

Setas indicam que a decisão exp/formal deve ser fechada antes da reescrita do capítulo.

```
D1 (C1 → comportamental)            → Cap. 3, Cap. 1, Abstract
D2 (G2 → negative evidence vs cut)  → Cap. 5, Cap. 4 §5.6, Cap. 1, Abstract
D3 (G3 → paper negativo)            → Cap. 4 §5.7, Cap. 1, Abstract, current-results-equivalent
D4 (Compression in/out)             → Cap. 3 (subseção opcional)
D5 (Stego paper → jornal)           → não afeta capítulos diretamente; bloqueia defesa
D6 (Part III scope)                 → Cap. 6, Cap. 7, TOC inteiro do ppgc-tese.tex
```

**Bottleneck**: D2, D3, D6 são reescritas substanciais. Devem ser fechadas com orientadores na **semana 1** para liberar 4 semanas de escrita.

### 6.3 Caminho crítico revisado (capítulos + experimentos)

Versão do §4 ampliada para incluir trabalho de capítulos.

| Sem | Foco principal | Entregáveis capítulo |
|---|---|---|
| 1 (14-21 mai) | Fechar D1-D6 com orientadores | GAP_MAP discutido; pilot Compression rodando |
| 2 (22-28 mai) | Stego paper para jornal + housekeeping `.tex` | Stego paper draft v1; deletar arquivos não usados; criar `future.tex` esqueleto |
| 3 (29 mai-4 jun) | Submeter stego paper + reescrever **Cap. 4 §5.6 (G2)** e **§5.7 (G3)** | Stego submetido; Cap. 4 reconciliado com realidade |
| 4 (5-11 jun) | Paper negativo adversarial + reescrever **Cap. 1 (Intro)** e **Abstract** | Paper negativo draft v1; Intro/Abstract calibrados |
| 5 (12-18 jun) | Cap. 5 (Constrained Gen — D2.a) ou cortar (D2.b) + **Cap. 3** (D1, D4) | Cap. 3 polido; Cap. 5 decidido |
| 6 (19-25 jun) | Cap. 8 (Future Work) + Cap. 9 (Conclusion) + Resumo expandido | Capítulos finais escritos |
| 7 (26 jun-2 jul) | Cap. 2 (Background) polimento + revisão global de consistência | Tese compilável end-to-end |
| 8-10 (jul) | Revisão orientadores → ajustes finais → banca → defesa | Manuscrito final, defesa |

### 6.4 Esforço estimado (escrita)

Ordem de grandeza, assumindo decisões recomendadas (D2.a, D3.a, D4.b/pilot, D6.a):

| Capítulo | Escrita nova | Reescrita | Polimento | Total |
|---|---|---|---|---|
| Abstract | — | meio dia | meio dia | 1 dia |
| Cap. 1 Intro | — | 2 dias | 1 dia | 3 dias |
| Cap. 2 Background | — | — | 2 dias | 2 dias |
| Cap. 3 Dynamics | (subseção Compression, se D4.b) 3 dias | 2 dias | 1 dia | 3-6 dias |
| Cap. 4 Methodology | — | **5 dias** | 2 dias | 7 dias |
| Cap. 5 Constrained Gen | (se D2.a) 4 dias | — | 1 dia | 0-5 dias |
| Cap. 6,7 Part III | — | — | — | 0 dias (se D6.a) |
| Cap. 8 Future Work | 3 dias | — | 1 dia | 4 dias |
| Cap. 9 Conclusion | 2 dias | — | 1 dia | 3 dias |
| Resumo expandido | — | 1 dia | meio dia | 1.5 dias |
| **Total** | | | | **~25-32 dias úteis** |

25-32 dias úteis = ~5-6.5 semanas concentradas. Cabe na janela se D2/D3/D6 forem fechadas com orientadores nas duas primeiras semanas.

### 6.5 Próxima iteração deste documento

- Revisar GAP_MAP com Breno e refinar decisões.
- Após discussão com orientadores: marcar D1-D6 como **fechadas** com a decisão tomada.
- Atualizar o quadro 6.1 conforme decisões mudam o escopo (ex: se D6.a, remover linhas de Cap. 6 e 7).
- Adicionar referência cruzada para o capítulo de Methodology quando reescrito.

---

*Versão 1.1 — experimentos + mapa de capítulos. Próxima iteração: pós-discussão com orientadores e revisão de Breno.*
