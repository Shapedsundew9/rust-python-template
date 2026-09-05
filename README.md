# Rust & Python Agentic Engineering Template

> A template and multi-agent orchestration framework for specification-driven systems development in Rust and Python.

---

## 🌟 Overview

This repository is a **starter template** designed for teams and engineers building software systems using AI-assisted, specification-first workflows. It combines a dual-language runtime environment (**Rust** for high-performance, memory-safe core logic; **Python** for rapid tooling, analysis, and data scripts) with a suite of specialized **GitHub Copilot / Antigravity Agent Orchestrators**.

The agent suite is structured into three strictly decoupled, domain-bounded tracks:

1. **Specification & Architecture Track (`Spec:*`)**: Progressively refines human intent into formal domain invariants, user experience journeys, logical interface contracts, and technology realization profiles with explicit human-in-the-loop decision gates.
2. **Implementation & Quality Track (`Code:*`)**: Operates on a strict **Repeat Until Good (RUG)** protocol—decomposing tasks, dispatching implementation workers, and subjecting every change to multi-tiered automated verification.
3. **Scientific Research Track (`Sci:*`)**: Drives hypothesis formulation, rigorous empirical experiment protocols, and dynamical systems diagnostics, translating abstract research designs into standardized experiment implementation specifications.

---

## 🏛️ Architectural Guardrails: Depth & Domain Boundaries

To prevent recursion, runaway execution, and architectural confusion, the multi-agent system enforces two foundational design constraints:

### 1. The 1-Level Subagent Depth Constraint

In modern coding agent platforms (including GitHub Copilot and VS Code agents), subagent delegation is strictly **one level deep**:

$$\text{Operator / User} \longrightarrow \text{Lead Orchestrator} \longrightarrow \text{Leaf Subagent}$$

- Subagents **cannot** invoke further subagents. Nested delegation is disabled to eliminate the risk of unbounded recursion, cyclical execution loops, and runaway context window costs.
- Orchestrators **cannot** call orchestrators from other groups. Because an orchestrator requires root management privileges to decompose tasks and launch workers, running an orchestrator inside another orchestrator causes delegation failure.
- The **Operator / User** acts as the overarching lifecycle coordinator, invoking orchestrators sequentially across track boundaries.

### 2. Strict Domain Encapsulation (Zero Cross-Group Calls)

Every agent belongs to exactly one track (`Spec:*`, `Code:*`, or `Sci:*`) and operates strictly within its domain:

- **`Spec:*` Agents** never write runtime code, execute test suites, or dispatch `Code:*` subagents.
- **`Code:*` Agents** never author abstract requirements documents or dispatch `Spec:*` subagents.
- **`Sci:*` Agents** never implement code harnesses or dispatch `Code:*` subagents.
- **Inter-Track Collaboration** is achieved exclusively via **standardized, typed file artifacts** passed across user-mediated stage gates.

---

## 🤖 Multi-Agent System Architecture

The following diagram illustrates how the three decoupled agent tracks interact with the user and exchange artifacts across track boundaries:

```mermaid
%%{init: {
  'theme': 'base',
  'themeVariables': {
    'darkMode': true,
    'background': '#161922',
    'mainBkg': '#1e2230',
    'nodeBorder': '#434c5e',
    'textColor': '#e2e8f0',
    'fontFamily': 'ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
    'fontSize': '14px',
    'lineColor': '#8892b0',
    'primaryColor': '#422026',
    'primaryTextColor': '#fde8ec',
    'primaryBorderColor': '#e06c75',
    'secondaryColor': '#1b3528',
    'secondaryTextColor': '#e6f7ee',
    'secondaryBorderColor': '#73c991',
    'tertiaryColor': '#1d2c44',
    'tertiaryTextColor': '#e4f0fc',
    'tertiaryBorderColor': '#61afef',
    'clusterBkg': '#13161f',
    'clusterBorder': '#373e51',
    'noteBkgColor': '#2e271a',
    'noteTextColor': '#fdf4db',
    'noteBorderColor': '#e5c07b',
    'edgeLabelBackground': '#1a1d27'
  }
}}%%
flowchart TB
    classDef primary fill:#422026,stroke:#e06c75,stroke-width:1.5px,color:#fde8ec;
    classDef secondary fill:#1b3528,stroke:#73c991,stroke-width:1.5px,color:#e6f7ee;
    classDef tertiary fill:#1d2c44,stroke:#61afef,stroke-width:1.5px,color:#e4f0fc;
    classDef note fill:#2e271a,stroke:#e5c07b,stroke-width:1.5px,color:#fdf4db;

    USER["👤 Operator / User<br/><i>(Root Lifecycle Coordinator & Decision Gatekeeper)</i>"]:::note

    subgraph SPEC_TRACK["Specification & Architecture Track (Spec:*)"]
        SPEC_O["🎯 Spec: Orchestrator<br/><i>(Progressive Refinement)</i>"]:::primary
        SPEC_SUBS["👥 Spec Subagents<br/><i>(PRD, PM, Req, UX, API, Arch, ADR)</i>"]:::secondary
        SPEC_ARTS["📄 Specification Artifacts<br/><i>(docs/requirements/, docs/architecture/)</i>"]:::tertiary
        SPEC_O <-->|"1-level dispatch"| SPEC_SUBS
        SPEC_SUBS -->|"Generates"| SPEC_ARTS
    end

    subgraph CODE_TRACK["Implementation & Quality Track (Code:*)"]
        CODE_O["🎯 Code: RUG Orchestrator<br/><i>(Repeat-Until-Good Manager)</i>"]:::primary
        CODE_SUBS["👥 Code Subagents<br/><i>(SWE, Debug, QA Lite, QA, Security)</i>"]:::secondary
        CODE_PROD["💻 Code, Tests & Run Logs<br/><i>(src/, python/, tests/, docs/implementation/)</i>"]:::tertiary
        CODE_O <-->|"1-level dispatch"| CODE_SUBS
        CODE_SUBS -->|"Implements & Tests"| CODE_PROD
    end

    subgraph SCI_TRACK["Scientific Research Track (Sci:*)"]
        SCI_O["🎯 Sci: Orchestrator<br/><i>(Research State Machine Controller)</i>"]:::primary
        SCI_SUBS["👥 Sci Subagents<br/><i>(Strategist, Hypothesis, Protocol, Diagnostician, Curriculum)</i>"]:::secondary
        SCI_ARTS["🔬 Research Artifacts<br/><i>(Protocols, Implementation Specs, Diagnostic Reports)</i>"]:::tertiary
        SCI_O <-->|"1-level dispatch"| SCI_SUBS
        SCI_SUBS -->|"Generates"| SCI_ARTS
    end

    USER -->|"1. Directs Intent & Approves Tiers"| SPEC_O
    SPEC_ARTS -.->|"Approved Specs Handed to User"| USER
    USER -->|"2. Dispatches Specs for Implementation"| CODE_O
    CODE_PROD -.->|"Code & Run Logs Handed to User"| USER
    CODE_O -.->|"3. Spec Change Proposal (Reverse Escalation)"| USER
    USER -.->|"4. Amends Specs on Blocker"| SPEC_O

    USER -->|"A. Directs Research Campaigns"| SCI_O
    SCI_ARTS -.->|"Experiment Spec Handed to User"| USER
    USER -->|"B. Dispatches Experiment Harness"| CODE_O
    CODE_PROD -.->|"Telemetry & Output Logs"| USER
    USER -->|"C. Feeds Telemetry to Diagnostician"| SCI_O
```

---

## 📐 Specification & Architecture Track (`Spec:*`)

The **Specification Track** governs the transition from ambiguous human requirements to verifiable software contracts. Led by [`Spec: Orchestrator`](.github/agents/spec-orchestrator.agent.md), it enforces:

- **Pure Specification Scope**: Focuses strictly on problem framing, domain modeling, interface schemas, and realization constraints. Never writes executable runtime code.
- **Persistent State Across Sessions**: Maintains a durable specification tracker in `docs/requirements/ROADMAP.md` (instantiated from `docs/templates/spec-roadmap-template.md`), capturing stage completions, gate timestamps, approved requirement ranges, and open forks.
- **In-Domain Quality Audits**: Auditing is performed within the track (`Spec: Product Manager` audits business value and scope discipline; `Spec: Architecture Reviewer` verifies system boundaries, security, and schema rigor). Auditors generate durable reports in `docs/requirements/audits/AUDIT-T{tier}-*.md`.
- **ADR Governance & Central Registry**: Evaluates architectural fork points via [`Spec: ADR Generator`](.github/agents/spec-adr-generator.agent.md), registers them in [`docs/architecture/README.md`](docs/architecture/README.md), and promotes them from `Proposed` to `Accepted` upon user sign-off at Gate 1 or Gate 2.
- **Human Decision Gates & Invalidation Discipline**: Progresses only upon explicit operator sign-off against structured gate verification checklists. If revisions occur, downstream artifacts are invalidated before re-drafting.

### Specification Refinement Workflow

```mermaid
%%{init: {
  'theme': 'base',
  'themeVariables': {
    'darkMode': true,
    'background': '#161922',
    'mainBkg': '#1e2230',
    'nodeBorder': '#434c5e',
    'textColor': '#e2e8f0',
    'fontFamily': 'ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
    'fontSize': '14px',
    'lineColor': '#8892b0',
    'primaryColor': '#422026',
    'primaryTextColor': '#fde8ec',
    'primaryBorderColor': '#e06c75',
    'secondaryColor': '#1b3528',
    'secondaryTextColor': '#e6f7ee',
    'secondaryBorderColor': '#73c991',
    'tertiaryColor': '#1d2c44',
    'tertiaryTextColor': '#e4f0fc',
    'tertiaryBorderColor': '#61afef',
    'clusterBkg': '#13161f',
    'clusterBorder': '#373e51',
    'noteBkgColor': '#2e271a',
    'noteTextColor': '#fdf4db',
    'noteBorderColor': '#e5c07b',
    'edgeLabelBackground': '#1a1d27'
  }
}}%%
flowchart TD
    classDef primary fill:#422026,stroke:#e06c75,stroke-width:1.5px,color:#fde8ec;
    classDef secondary fill:#1b3528,stroke:#73c991,stroke-width:1.5px,color:#e6f7ee;
    classDef tertiary fill:#1d2c44,stroke:#61afef,stroke-width:1.5px,color:#e4f0fc;
    classDef note fill:#2e271a,stroke:#e5c07b,stroke-width:1.5px,color:#fdf4db;

    ORCH["🎯 Spec: Orchestrator<br/><i>(Align, Draft, Audit, Gate)</i>"]:::primary
    ROADMAP[("📋 docs/requirements/ROADMAP.md<br/><i>(Persistent State Tracker)</i>")]:::tertiary

    subgraph T0_STAGE["Tier 0: Domain Invariants & Product Goals (Tech-Agnostic)"]
        PRD["Spec: PRD<br/><i>(Sole Drafting Author: prd.md synthesis)</i>"]:::secondary
        PM_AUDIT["Spec: Product Manager<br/><i>(Auditor: Business value, KPI validity & backlog slicing)</i>"]:::secondary
        ARCH_AUDIT["Spec: Architecture Reviewer<br/><i>(Auditor: Invariant testability & boundaries)</i>"]:::secondary
        SPEC0["Spec: Specification<br/><i>(Extractor: Formal REQ-T0 in EARS syntax)</i>"]:::secondary
        GATE0["🔒 Gate 0: Scope & Invariants Sign-Off"]:::note
    end

    subgraph UX_STAGE["UX Track: User Experience & Workflows"]
        UX["🎨 Spec: UX Designer<br/><i>(JTBD, user journeys & interaction flows)</i>"]:::secondary
        AUDIT_UX["Spec: Product Manager<br/><i>(Audit: Flow ergonomics & edge states)</i>"]:::secondary
        GATE_UX["🔒 Gate UX: Interaction Sign-Off"]:::note
    end

    subgraph T1_STAGE["Tier 1: Logical Architecture & Interface Contracts"]
        ARCH["Spec: Architecture Reviewer<br/><i>(Mandatory: Component boundaries & patterns)</i>"]:::secondary
        API["Spec: API Architect<br/><i>(Mandatory: OpenAPI, schemas & resilience contracts)</i>"]:::secondary
        ADR["Spec: ADR Generator<br/><i>(Fork point trade-off matrices)</i>"]:::secondary
        AUDIT_T1["Spec: Architecture Reviewer<br/><i>(Audit: System cohesion & schema rigor)</i>"]:::secondary
        GATE1["🔒 Gate 1: Contract Sign-Off & ADR Promotion"]:::note
    end

    subgraph T2_STAGE["Tier 2: Technology Realization Profiles"]
        SPEC2["Spec: Specification<br/><i>(Mandatory: REQ-T2 realization profiles)</i>"]:::secondary
        AUDIT_T2["Spec: Architecture Reviewer<br/><i>(Audit: Traceability & constraint proof)</i>"]:::secondary
        GATE2["🔒 Gate 2: Implementation Readiness Sign-Off"]:::note
    end

    ORCH -->|"1. Initialize / Resume"| ROADMAP
    ORCH -->|"2. Dispatch drafting"| PRD
    PRD -->|"Draft prd.md"| PM_AUDIT & ARCH_AUDIT
    PM_AUDIT & ARCH_AUDIT -->|"Validated Proposal & Audit Log"| SPEC0
    SPEC0 -->|"Formal Requirements Package"| GATE0
    PM_AUDIT -.->|"Audit Failure: Re-draft"| PRD
    ARCH_AUDIT -.->|"Audit Failure: Re-draft"| PRD

    GATE0 -.->|"Update State"| ROADMAP
    GATE0 -->|"Approved: Slices Issues"| PM_AUDIT
    GATE0 -->|"Operator Prompt"| UX_DECISION{"Has User/CLI Interaction?"}:::primary
    UX_DECISION -->|"Yes"| UX
    UX_DECISION -->|"No (Skip UX)"| T1_STAGE

    UX -->|"Journey Artifacts"| AUDIT_UX
    AUDIT_UX -->|"Verified UX & Audit Log"| GATE_UX
    GATE_UX -.->|"Update State"| ROADMAP
    GATE_UX -->|"Approved"| T1_STAGE

    T1_STAGE --> ARCH & API
    ARCH -.->|"Architectural Fork Detected"| ADR
    ARCH & API & ADR --> AUDIT_T1
    AUDIT_T1 -->|"Verified Contracts & Audit Log"| GATE1
    GATE1 -.->|"Update State & Accept ADRs"| ROADMAP
    AUDIT_T1 -.->|"Audit Failure: Re-draft"| ARCH

    GATE1 -->|"Approved"| T2_STAGE
    T2_STAGE --> SPEC2
    SPEC2 --> AUDIT_T2
    AUDIT_T2 -->|"Verified Realization & Audit Log"| GATE2
    GATE2 -.->|"Release Package"| ROADMAP
    GATE2 -->|"Approved"| FINAL_ARTIFACTS["📦 Approved Requirements Package<br/><i>(docs/requirements/, docs/architecture/)</i>"]:::tertiary

    GATE1 -.->|"Gate 1 Revision / Reject"| T0_STAGE
    GATE2 -.->|"Gate 2 Revision / Reject"| T1_STAGE
```

### `Spec:*` Subagents Catalog

| Agent Name | Role | Call Nature | Inputs | Primary Deliverables |
| :--- | :--- | :--- | :--- | :--- |
| **`Spec: Orchestrator`** | Master Specification Manager | **Orchestrator** | User goal, roadmap | Decomposed plan, persistent `ROADMAP.md`, stage gates, ADR promotions |
| **`Spec: PRD`** | Sole Tier 0 Drafting Author | **Mandatory (Tier 0 Author)** | User intent, scope | `prd.md` (10-section outline, personas, user stories) |
| **`Spec: Product Manager`** | Value & Scope Auditor, Backlog Slicer | **Mandatory (Tier 0 Auditor)** | Draft PRD, feature scope | Value critique report, audit log (`AUDIT-T0-*`), sized GitHub issues & epics |
| **`Spec: Specification`** | Formal Requirements Author | **Mandatory (T0 & T2)** | PRDs, logical designs | `docs/requirements/` in r9ts format (`REQ-T0-*`, `REQ-T2-*`) |
| **`Spec: UX Designer`** | Experience & Workflow Designer | **Optional (Gate 0 Decision)** | User workflows | JTBD analysis, user journey maps, CLI/Web interaction flows |
| **`Spec: API Architect`** | Interface & Contract Designer | **Mandatory (Tier 1)** | Component boundaries | OpenAPI 3.1/JSON schemas, error taxonomies, resilience SLA budgets (NO runtime code) |
| **`Spec: Architecture Reviewer`** | Architecture & Security Reviewer | **Mandatory (Tier 1 & Audits)** | System designs, NFRs | Component decomposition, security architecture, audit logs (`AUDIT-T1-*`, `AUDIT-T2-*`) |
| **`Spec: ADR Generator`** | Architecture Decision Author | **Optional / Triggered** | Technology trade-offs | `docs/architecture/adr-NNNN-[slug].md` records & `docs/architecture/README.md` registry |

---

## ⚡ Implementation & Quality Track (`Code:*`)

The **Implementation Track** is driven by [`Code: RUG Orchestrator`](.github/agents/code-rug-orchestrator.agent.md) using the **Repeat Until Good (RUG)** protocol:

- **Pure Orchestration**: The lead agent **never** writes code, edits files, or executes commands directly. It delegates 100% of execution to specialized subagents.
- **Independent Validation**: Every work subagent's changes are verified by a separate validation subagent with a fresh context window.
- **Persistent Run & Decision Records**: Every completed implementation session compiles a durable log in `docs/implementation/RUN-YYYYMMDD-[slug].md` capturing technical trade-offs, deviations from spec, and empirical test evidence.
- **Reverse Escalation Protocol (Rolling Back Up)**: If an upstream specification is technically impossible or contradicts domain invariants, the orchestrator halts execution, formulates a Spec Change Proposal (SCP), and yields to a human decision gate rather than looping indefinitely on code retries.
- **Strict In-Domain Workers**: Only code implementation, debugging, refactoring, and code verification subagents are dispatched.

### RUG Execution Loop & Subagent Hierarchy

```mermaid
%%{init: {
  'theme': 'base',
  'themeVariables': {
    'darkMode': true,
    'background': '#161922',
    'mainBkg': '#1e2230',
    'nodeBorder': '#434c5e',
    'textColor': '#e2e8f0',
    'fontFamily': 'ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
    'fontSize': '14px',
    'lineColor': '#8892b0',
    'primaryColor': '#422026',
    'primaryTextColor': '#fde8ec',
    'primaryBorderColor': '#e06c75',
    'secondaryColor': '#1b3528',
    'secondaryTextColor': '#e6f7ee',
    'secondaryBorderColor': '#73c991',
    'tertiaryColor': '#1d2c44',
    'tertiaryTextColor': '#e4f0fc',
    'tertiaryBorderColor': '#61afef',
    'clusterBkg': '#13161f',
    'clusterBorder': '#373e51',
    'noteBkgColor': '#2e271a',
    'noteTextColor': '#fdf4db',
    'noteBorderColor': '#e5c07b',
    'edgeLabelBackground': '#1a1d27'
  }
}}%%
flowchart TD
    classDef primary fill:#422026,stroke:#e06c75,stroke-width:1.5px,color:#fde8ec;
    classDef secondary fill:#1b3528,stroke:#73c991,stroke-width:1.5px,color:#e6f7ee;
    classDef tertiary fill:#1d2c44,stroke:#61afef,stroke-width:1.5px,color:#e4f0fc;
    classDef note fill:#2e271a,stroke:#e5c07b,stroke-width:1.5px,color:#fdf4db;

    REQ["📋 Task Request / Approved Requirements"]:::tertiary
    RUG["🎯 Code: RUG Orchestrator<br/><i>(Pure Coordinator: Never edits or runs tests directly)</i>"]:::primary
    TODO["📝 Todo List Roadmap<br/><i>(manage_todo_list)</i>"]:::note

    subgraph WORKERS["Implementation Workers (In-Domain Subagents)"]
        SWE["💻 Code: SWE<br/><i>(Mandatory Worker: Features, edits, refactoring, tests)</i>"]:::secondary
        DEBUG["🔍 Code: Debug<br/><i>(Optional / Conditional: 4-phase bug diagnosis & reproduction)</i>"]:::secondary
    end

    subgraph VALIDATION["Validation Subagents (Independent Context)"]
        QA_LITE["⚡ Code: QA Lite<br/><i>(Default Task Validator: Fast diff inspection & sanity check)</i>"]:::secondary
        QA_FULL["🧪 Code: QA<br/><i>(Strict Mode / High-Risk: Deep test suite execution & regressions)</i>"]:::secondary
        SEC["🛡️ Code: Security Reviewer<br/><i>(Optional / Triggered: OWASP, Zero Trust, LLM threats)</i>"]:::secondary
    end

    REQ --> RUG
    RUG -->|"1. Decompose & Initialize"| TODO

    RUG -->|"Standard Task Dispatch"| SWE
    RUG -.->|"Defect Diagnosis / Fix"| DEBUG

    SWE & DEBUG -->|"Produces Diff & Self-Report"| MODE_SELECT{"Validation Mode"}:::primary

    MODE_SELECT -->|"Default / Fast Mode"| QA_LITE
    MODE_SELECT -->|"High-Risk Task / Strict Mode"| QA_FULL
    MODE_SELECT -.->|"Security Surface (Optional)"| SEC

    QA_LITE & QA_FULL & SEC --> VERDICT{"Validation Outcome"}:::primary

    VERDICT -->|"FAIL (Code Defect)"| RETRY["🔁 Re-dispatch Worker with Defect Report"]:::primary
    RETRY --> SWE

    VERDICT -->|"FAIL (Spec Defect / Blocker)"| ESCALATE["⚠️ Escalate: Spec Change Proposal (SCP)"]:::note
    ESCALATE --> USER_GATE["🔒 User Decision Gate: Roll back to Spec Track or Authorize Exception"]:::note
    USER_GATE -.->|"Roll Back"| REQ
    USER_GATE -.->|"Exception Approved"| SWE

    VERDICT -->|"PASS"| ADVANCE["✅ Mark Task Complete in Todo"]:::note
    ADVANCE --> MORE_TASKS{"More Tasks in Todo?"}:::primary

    MORE_TASKS -->|"Yes: Next Task"| RUG
    MORE_TASKS -->|"No: All Tasks Done"| FINAL_GATE["🏁 Final Integration Gate<br/><i>(Code: QA full test suite run)</i>"]:::primary
    FINAL_GATE --> LOG["📝 Compile Run & Decision Log<br/><i>(docs/implementation/RUN-*.md)</i>"]:::tertiary
    LOG --> COMPLETE["🎉 Verified Working Solution"]:::tertiary
```

### Validation Modes & Flags

The RUG Orchestrator controls automated verification rigor via mode flags:

- **Default (Balanced)**: Dispatches `Code: QA Lite` for per-task static checks. Tasks modifying core invariants, security/auth, or public schemas escalate to full `Code: QA`. Runs full `Code: QA` at the final integration gate.
- **Fast / Draft Mode (`--fast`, `--draft`)**: Uses `Code: QA Lite` for task-level checks and the final integration gate, maximizing iteration velocity.
- **Strict / Release Mode (`--strict`, `--release`)**: Dispatches full `Code: QA` for **every** individual task and the final gate, executing complete test suites (`cargo test`, Python unittests) and linter passes.

### `Code:*` Subagents Catalog

| Agent Name | Role | Call Nature | Trigger Condition | Primary Deliverables |
| :--- | :--- | :--- | :--- | :--- |
| **`Code: RUG Orchestrator`** | Execution Coordinator | **Orchestrator** | Feature request, task spec | Task decomposition, subagent prompts, iteration loop, run logs |
| **`Code: SWE`** | Senior Software Engineer | **Mandatory Worker** | Standard implementation task | Clean code diffs, unit/integration tests, docstrings, technical decisions |
| **`Code: Debug`** | Defect Diagnostician | **Optional / Conditional** | Bug report, failing tests | Reproduction recipe, root cause analysis, targeted fix |
| **`Code: QA Lite`** | Fast Sanity Validator | **Default Task Auditor** | Routine task completion | Diff sanity verification, acceptance criteria checklist, defect classification |
| **`Code: QA`** | Comprehensive QA Tester | **Strict / Integration Auditor** | High-risk tasks, final integration | Test suite logs (`cargo test`, `unittest`), boundary audit, regression proofs |
| **`Code: Security Reviewer`** | Code Security Specialist | **Optional / Triggered** | Auth, crypto, external boundaries | OWASP Top 10 audit, Zero Trust verification, risk report |

---

## 🔬 Scientific Research Track (`Sci:*`)

The **Scientific Track** coordinates empirical discovery campaigns. Managed by [`Sci: Orchestrator`](.github/agents/sci-orchestrator.agent.md), it enforces a formal research lifecycle state machine:

- **Theoretical & Measurement Purity**: Separates mathematical modeling, empirical experiment protocol design, and dynamical diagnostics from code implementation.
- **Persistent Campaign Continuity**: Tracks theoretical capability progression on a complexity ladder across sessions in `docs/research/CAMPAIGN.md`.
- **Execution Gate & Run Manifest**: The protocol designer outputs both the measurement protocol and the machine-readable `Experiment Implementation Specification`. The operator signs off at **Gate H/P**, executes via the Code Track, and records an `Experiment Run Manifest` (`docs/research/runs/RUN-EXP-*.md`) capturing runtime environment, seed completions, and parameter overrides.
- **Programmatic Telemetry Reduction**: Raw multi-gigabyte telemetry is reduced via scripts to statistical summaries and phase plots before ingestion by the Empirical Diagnostician.
- **Human-Gated Discovery Loop**: All iteration directives (Exploit, Mutate, Ablate, Pivot) pass through **Gate I** for operator approval before new hypotheses or protocols are dispatched.

### Research Lifecycle & Execution Handoff

```mermaid
%%{init: {
  'theme': 'base',
  'themeVariables': {
    'darkMode': true,
    'background': '#161922',
    'mainBkg': '#1e2230',
    'nodeBorder': '#434c5e',
    'textColor': '#e2e8f0',
    'fontFamily': 'ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
    'fontSize': '14px',
    'lineColor': '#8892b0',
    'primaryColor': '#422026',
    'primaryTextColor': '#fde8ec',
    'primaryBorderColor': '#e06c75',
    'secondaryColor': '#1b3528',
    'secondaryTextColor': '#e6f7ee',
    'secondaryBorderColor': '#73c991',
    'tertiaryColor': '#1d2c44',
    'tertiaryTextColor': '#e4f0fc',
    'tertiaryBorderColor': '#61afef',
    'clusterBkg': '#13161f',
    'clusterBorder': '#373e51',
    'noteBkgColor': '#2e271a',
    'noteTextColor': '#fdf4db',
    'noteBorderColor': '#e5c07b',
    'edgeLabelBackground': '#1a1d27'
  }
}}%%
flowchart TD
    classDef primary fill:#422026,stroke:#e06c75,stroke-width:1.5px,color:#fde8ec;
    classDef secondary fill:#1b3528,stroke:#73c991,stroke-width:1.5px,color:#e6f7ee;
    classDef tertiary fill:#1d2c44,stroke:#61afef,stroke-width:1.5px,color:#e4f0fc;
    classDef note fill:#2e271a,stroke:#e5c07b,stroke-width:1.5px,color:#fdf4db;

    subgraph FORMULATION["1. Scientific Formulation (In-Domain Sci Subagents)"]
        STRAT["🔭 Sci: Research Strategist<br/><i>(Paradigm guardian & roadmap)</i>"]:::primary
        HYP["📐 Sci: Hypothesis Formulator<br/><i>(Mathematical hypotheses & invariants)</i>"]:::secondary
        PROTO["📋 Sci: Experiment Protocol Designer<br/><i>(Pre-registered metrics & Eng Spec)</i>"]:::secondary
    end

    subgraph PROTOCOL_GATE["2. Protocol & Budget Decision Gate"]
        GATE_HP["🔒 Gate H/P: Protocol & Budget Sign-Off<br/><i>(Operator verifies compute & sweep limits)</i>"]:::note
    end

    subgraph EXECUTION["3. Execution & Provenance Capture"]
        GATE_EXEC["⚙️ Execution Handoff<br/><i>(Executed via Code Track or runner)</i>"]:::tertiary
        RUN_MANIFEST["📋 Run Manifest & Telemetry<br/><i>(RUN-EXP-*.md & data/telemetry/)</i>"]:::tertiary
        REDUCE["⚡ Telemetry Data Reduction<br/><i>(scripts/reduce_telemetry.py)</i>"]:::secondary
        SUMMARY["📊 Reduced Summary Metrics<br/><i>(summary_reduced.json & plots)</i>"]:::tertiary
    end

    subgraph EVALUATION["4. Empirical Diagnostics & Discovery Loop"]
        DIAG["🔬 Sci: Empirical Diagnostician<br/><i>(Phase portraits, attractors, failure modes)</i>"]:::secondary
        CURR["🧭 Sci: Curriculum Director<br/><i>(Exploit, Mutate, or Ablate directive)</i>"]:::primary
        GATE_I["🔒 Gate I: Iteration Decision Gate<br/><i>(Operator signs off on next move)</i>"]:::note
    end

    STRAT -->|"Strategic Milestone Directive"| HYP
    HYP -->|"Formal Hypothesis Document"| PROTO
    PROTO -->|"Protocol & Implementation Spec"| GATE_HP
    GATE_HP -->|"Approved"| GATE_EXEC
    GATE_EXEC -->|"Emits Raw Logs & Manifest"| RUN_MANIFEST
    RUN_MANIFEST -->|"Input to Script"| REDUCE
    REDUCE -->|"Produces Compact Metrics"| SUMMARY
    SUMMARY & RUN_MANIFEST -->|"Ingested for Analysis"| DIAG
    DIAG -->|"Diagnostic Evaluation Report"| CURR
    CURR -->|"Iteration Directive"| GATE_I

    GATE_I -->|"Mutate Approved"| HYP
    GATE_I -->|"Exploit / Ablate Approved"| PROTO
    GATE_I -.->|"Stall Detected: Pivot Approved"| STRAT
    GATE_I -.->|"Milestone Verified"| MILESTONE_DONE["🏁 Research Milestone Complete"]:::note
```

### Science-to-Engineering Protocol & Execution Gate

The `Sci: Experiment Protocol Designer` includes an **Experiment Implementation Specification** in every protocol document before presenting it at **Gate H/P**:

1. **CLI Entry Points**: Exact executable commands, script targets, and argument signatures.
2. **Parameter Sweep Configs**: Explicit grid/random search spaces, seed sets, and sweep strategies.
3. **Emission Schemas**: JSON/CSV telemetry fields, logging frequencies, and target directories.
4. **Resource Budgets**: Wall-clock timeouts, memory limits, and process limits.
5. **Success Gates & Reduction**: Minimum metric thresholds and automated telemetry reduction targets before returning logs to the Diagnostician.

### `Sci:*` Subagents Catalog

| Agent Name | Lifecycle Stage | Role | Primary Input | Primary Output |
| :--- | :--- | :--- | :--- | :--- |
| **`Sci: Orchestrator`** | Pipeline Controller | State machine manager | Research goal, directives | Dispatches, campaign state tracking |
| **`Sci: Research Strategist`** | Strategic Direction | Paradigm guardian | Campaign history, roadmap | Strategic Milestone Directives, pivot advice |
| **`Sci: Hypothesis Formulator`** | Theoretical Modeling | Mathematical formalizer | Strategic Directives | Formal Hypothesis Documents (equations, invariants) |
| **`Sci: Experiment Protocol Designer`** | Empirical Design | Measurement architect | Formal Hypotheses | Structured Experiment Protocols (baselines, ablations) |
| **`Sci: Empirical Diagnostician`** | Telemetry Analysis | Experimental analyst | Raw telemetry & state snapshots | Diagnostic Evaluation Reports, failure taxonomy |
| **`Sci: Curriculum Director`** | Discovery Loop Controller | Adaptive search controller | Diagnostic Reports | Iteration Directives (Exploit, Mutate, Ablate) |

---

## 🔄 Inter-Track Artifact Handoff Matrix

Because agents operate under strict domain encapsulation and a 1-level depth limit, cross-track coordination occurs through **asynchronous artifact handoffs mediated by the Operator**:

| Source Track | Originating Artifact | User Handoff Action | Destination Track | Target Orchestrator | Expected Outcome |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **`Spec:*`** | Approved Requirements (`docs/requirements/`) & ADRs (`docs/architecture/`) | Operator triggers implementation | **`Code:*`** | `Code: RUG Orchestrator` | Fully implemented, unit-tested, and verified software |
| **`Sci:*`** | Experiment Protocol & Eng Spec (`docs/research/protocols/EXP-*.md`) | Operator signs off at Gate H/P & triggers testbed execution | **`Code:*`** (or CLI runner) | `Code: RUG Orchestrator` | Executed experiment sweeps, test harness, & raw telemetry |
| **`Code:*`** | Run Manifest (`docs/research/runs/RUN-EXP-*.md`) & Reduced Telemetry (`data/telemetry/`) | Operator passes verified data to research pipeline | **`Sci:*`** | `Sci: Orchestrator` | Empirical diagnostics and adaptive iteration directives |
| **`Code:*`** | Spec Change Proposal (Escalation report on infeasible requirement) | Operator routes architectural roadblock/defect | **`Spec:*`** | `Spec: Orchestrator` | Updated formal requirements (`REQ-T*`) or new ADR (`ADR-NNNN-*`) |
| **`Code:*`** | Run & Decision Log (`docs/implementation/RUN-YYYYMMDD-*.md`) | Operator reviews implementation decisions & test proof | **Operator / Records** | N/A | Durable audit trail of plan vs implementation drift and decisions |
| **`Sci:*`** | Research Campaign State Tracker (`docs/research/CAMPAIGN.md`) | Operator monitors complexity ladder progression | **Operator / Records** | N/A | Cross-session continuity of milestones, hypotheses, and iteration history |

---

## 🎨 Diagramming Style Guide

All architectural and workflow diagrams in documentation must use Mermaid and adhere to the project's **Gentle RGB Dark Theme**:

- `:::primary` (Rosewood Red `#422026` / `#e06c75`): Core domain, invariants, decision gates, entry points, orchestrators.
- `:::secondary` (Forest Sage Green `#1b3528` / `#73c991`): Application services, coordinators, worker subagents, active pipelines.
- `:::tertiary` (Royal Slate Blue `#1d2c44` / `#61afef`): Storage, databases, adapters, external boundaries, specifications and artifacts.
- `:::note` (Muted Amber `#2e271a` / `#e5c07b`): Security constraints, verification guards, stage sign-off gates, callouts.

See [`docs/templates/mermaid-style-guide.md`](docs/templates/mermaid-style-guide.md) and [`docs/templates/diagram-template.md`](docs/templates/diagram-template.md) for full style definitions, class declarations, and copy-pasteable boilerplates.

---

## 📁 Project Structure & Layout

This template enforces a strict separation between Rust high-performance core logic and Python tooling:

```text
.
├── .agents/agents/            # Agent definition copies for runtime discovery
├── .github/agents/            # GitHub Copilot agent track definitions (spec-*, code-*, sci-*)
├── data/                      # Experiment runtime data
│   └── telemetry/             # Raw experiment telemetry and reduced summaries
├── docs/                      # Architecture, ADRs, requirements & templates
│   ├── architecture/          # ADRs (adr-*.md) and ADR registry (README.md)
│   ├── implementation/        # Implementation Run & Decision Logs (RUN-YYYYMMDD-*)
│   ├── requirements/          # Formal r9ts requirements & audits
│   │   ├── product/           # REQ-T0-* domain invariants
│   │   ├── architecture/      # REQ-T1-* logical architecture contracts
│   │   ├── system/            # REQ-T2-* technology realization profiles
│   │   ├── audits/            # AUDIT-T*-* tier audit reports
│   │   └── ROADMAP.md         # Persistent specification state tracker
│   ├── research/              # Scientific research campaign artifacts
│   │   ├── hypotheses/        # Formal hypotheses (HYP-YYYY-NNN.md)
│   │   ├── protocols/         # Experiment protocols & specs (EXP-YYYY-NNNa.md)
│   │   ├── runs/              # Execution manifests & run logs (RUN-EXP-*.md)
│   │   ├── diagnostics/       # Diagnostic evaluation reports (DIAG-*.md)
│   │   └── CAMPAIGN.md        # Persistent campaign state tracker
│   └── templates/             # Templates for ADRs, requirements, roadmaps, and runs
├── python/                    # Python workspace
│   ├── pyproject.toml         # Python dependency definitions
│   ├── src/tools/             # Reusable Python tools (imported as `tools`)
│   └── tests/                 # Python unit and integration tests
├── src/                       # Rust primary workspace (main.rs, core libraries)
├── tests/                     # Rust integration tests
├── Cargo.toml                 # Rust workspace package configuration
├── GEMINI.md                  # Project rules & developer guidelines
└── README.md                  # Project documentation & agent orchestration guide
```

### Dual-Language Rules

- **Rust**: Put production code in `src/` and integration tests in `tests/`. Do not mix Python into `src/`.
- **Python**: Use `.venv/bin/python`. Declare dependencies in `python/pyproject.toml`. Reusable Python packages reside in `python/src/tools/` and are imported as `tools`. Do not modify `PYTHONPATH`.

---

## 🧪 Validation & Quality Assurance

Always run validation checks on affected surfaces before committing changes:

### Rust Validation

```bash
cargo fmt --check
cargo clippy
cargo test
```

### Python Validation

```bash
.venv/bin/python -m unittest discover -s python/tests -v
```

### Markdown & Diagram Validation

```bash
# Automatically fix formatting issues
markdownlint-cli2 --fix "**/*.md"

# Verify clean markdown compliance
markdownlint-cli2 "**/*.md"
```

---

## 📄 License

Distributed under the [MIT License](LICENSE).
