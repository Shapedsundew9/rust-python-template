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
- Never hard-code, print, or commit secret values.
- Relevant variables include `DATABASE_URL`, `NEO4J_URI`,
  `NEO4J_USERNAME`, `NEO4J_PASSWORD`, `NEO4J_DATABASE`,
  `GEMINI_API_KEY`, `ARC_AGI_API`, and `HF_READ_TOKEN`.

## Validation

- Run `cargo fmt --check`, `cargo clippy`, and `cargo test` for Rust changes.
- Run `.venv/bin/python -m unittest discover -s python/tests -v`
  for Python changes.
- Validate only the services and language surfaces affected by an experiment.

## Diagramming

- Use Mermaid for diagrams in Markdown files.
- Convert any textual diagrams to Mermaid for consistency and maintainability.
