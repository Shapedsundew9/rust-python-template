# Project Guidelines

## Layout

- This is a mixed Rust and Python experimentation workspace.
- Put Rust code in `src/` and Rust integration tests in `tests/`.
- Put reusable Python code in `python/src/tools/`.
- Put Python tests in `python/tests/`.
- Put one-off Python programs in `python/scripts/`.
- Do not mix Python files into the Rust `src/` directory.
- Do not assume Rust/Python FFI unless explicitly requested.

## Python

- Use `.venv/bin/python`; the devcontainer installs `python/` as an editable package.
- Import reusable code as `tools`.
- Do not set or modify `PYTHONPATH`.
- Declare Python package dependencies in `python/pyproject.toml`.

## Services And Secrets

- PostgreSQL and Neo4j are available through Docker Compose but are not started by default.
- Read credentials and tokens from the existing environment variables.
- The environment variables may direct to a remote service. Do not assume a docker or local service is running.
- Never hard-code, print, or commit secret values.
- Relevant variables include `DATABASE_URL`, `NEO4J_URI`,
  `NEO4J_USERNAME`, `NEO4J_PASSWORD`, `NEO4J_DATABASE`,
  `GEMINI_API_KEY`, `ARC_AGI_API`, and `HF_READ_TOKEN`.

## Validation

- Run `cargo fmt --check`, `cargo clippy`, and `cargo test` for Rust changes.
- Run `.venv/bin/python -m unittest discover -s python/tests -v`
  for Python changes.
- Validate only the services and language surfaces affected by an experiment.
- If authentication testing is not needed use `cargo test -- --skip configured_authentication` to avoid waiting for intentional timeouts. Saves about 40s per test run. 

## Diagramming

- Use Mermaid for diagrams in Markdown files.
- Convert any textual diagrams to Mermaid for consistency and maintainability.
- Follow the style in `docs/templates/mermaid-style-guide.md` for Mermaid diagrams.

## 3rd Party Packages

- Minimize the number of 3rd party packages used in the project.
- OSS brings supply chain and security risk. Only use it if there is a significant benefit over implementing the functionality in-house.
- Only use well-known, widely adopted, consistently maintained packages that have a permissive license to reduce maintenance burden.

<<<<<<< HEAD
=======
## Documentation Structure

- `docs/requirements/` — Formal requirements in r9ts Markdown interchange format (one requirement per file). Optional subfolders: `product/`, `architecture/`, `implementation/`, `resource/`, `performance/`.
- `docs/architecture/` — Freeform architecture documentation and ADRs. ADRs use the naming convention `adr-NNNN-[title-slug].md`.
- `docs/design/` — Freeform design documentation.
- `docs/product/` — Freeform product discovery documents, journey maps, feature descriptions.
- `docs/ux/` — Freeform UX research artifacts (JTBD analysis, journey maps, flow specs).
- `docs/code-review/` — Code review reports.
- Existing Markdown documents in `docs/` are freeform sources that the r9ts application processes via LLM and MCP server to generate and decompose structured requirements.

## Requirements Engineering

This repo builds a graph-driven requirements engineering tool. All agents must follow these semantics when authoring or reviewing requirements.

### Three-Tier Abstraction Model

- **Tier 0 — Domain & Functional Invariants**: Tech-agnostic business rules. Never references a specific technology. Describes *what*, never *how*.
- **Tier 1 — Logical Architecture & Contracts**: Component boundaries, interface contracts, QoS constraints. Technology-neutral.
- **Tier 2 — Technology Realization Profiles**: Constraints induced by a selected tech stack. Always `is_derived: true`. Invalidated when the tech stack changes.

### Requirement ID Scheme

Format: `REQ-T{tier}-{domain}-{sequence}` (e.g., `REQ-T0-AUTH-001`).

Domain codes: `AUTH`, `API`, `DATA`, `SEC`, `PERF`, `UI`, `ASYNC`, `MEM`, `NET`, `CFG`. Additional codes can be declared in `r9ts.toml`.

Other entity prefixes: `OBJ-` (MissionObjective), `COMP-` (SystemElement), `IFC-` (InterfaceContract), `VER-` (VerificationActivity), `TECH-` (TechnologyProfile).

### EARS Syntax & NASA Modal Verbs

Requirements use EARS (Easy Approach to Requirements Syntax) patterns:

- **Ubiquitous**: `The <system> SHALL <action>.`
- **Event-driven**: `When <event>, the <system> SHALL <action>.`
- **State-driven**: `While <state>, the <system> SHALL <action>.`
- **Optional**: `Where <feature is enabled>, the <system> SHALL <action>.`
- **Unwanted**: `If <condition>, then the <system> SHALL <action>.`

Binding levels: **SHALL** (mandatory, verifiable), **SHOULD** (goal, non-binding), **MAY** (discretionary, non-binding). **WILL** is a statement of fact, not a requirement — use it in rationale only.

Prohibited terms in SHALL statements: `user-friendly`, `flexible`, `adequate`, `maximize`, `minimize`, `fast`, `easy`, `simple`, `efficient`, `robust`, `seamless`, `intuitive`, `etc.`, `and/or`.

### Requirement Quality Rules

1. **Atomic**: One subject, one predicate. No AND/OR.
2. **Correct tier**: Tier 0 is implementation-free, Tier 1 is technology-neutral, Tier 2 names technology only when traceably induced.
3. **Quantified**: Every metric has explicit bounds.
4. **Unambiguous**: No subjective or vague terms.

### Status Lifecycle

`Draft` → `InReview` → `Approved` → `Baselined` → `Verified`. Any state → `Deprecated`. Approved/Baselined/Verified requirements are immutable; edits create a new Draft successor revision.

### Verification Methods (NASA TADI)

Every SHALL requirement must specify at least one: **Test**, **Analysis**, **Demonstration**, **Inspection**.

### Graph Relationships

Requirements link via typed edges: `REFINES` (child→parent), `DERIVED_FROM` (design-induced), `TRACES_TO` (→MissionObjective), `ALLOCATED_TO` (→SystemElement), `CONFLICTS_WITH` (LLM-detected), `VERIFIED_BY` (→VerificationActivity).

### Markdown Interchange Format

Formal requirements use this format (one per file, placed in `docs/requirements/`):

```yaml
---
id: REQ-T{tier}-{domain}-{seq}
title: "Short descriptive title"
tier: 0 | 1 | 2
binding: shall | should | may
category: functional | performance | interface | security | constraint
priority: critical | high | medium | low
verification_method: [test, analysis, demonstration, inspection]
status: draft
is_derived: false
traces_to: [OBJ-xxx]
refines: [REQ-xxx]
allocated_to: [COMP-xxx]
---
```

Body sections: `## Statement`, `## Rationale`, `## Verification Criteria`.

See `docs/design/requirement-model.md` for the full specification and examples. See `docs/glossary.md` for defined terms including `RequirementRevision`, `MissionObjective`, `SystemElement`, `InterfaceContract`, `TechnologyProfile`, `ChangeSet`, `AuditEvent`, `Baseline`, and `SemanticView`.
>>>>>>> c49e176 (Generalized agents and change their semantic to be consistent with r9ts)
