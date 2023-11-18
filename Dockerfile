# Use a imagem base do Rust
FROM rust:1.56 as builder

# Crie um novo projeto vazio
RUN USER=root cargo new --bin time-capsule
WORKDIR /time-capsule

# Copie os arquivos do seu projeto
COPY ./Cargo.toml ./Cargo.toml
COPY ./src ./src

# Compile o projeto
RUN cargo build --release

# Crie a imagem final
FROM debian:buster-slim
COPY --from=builder /time-capsule/target/release/time-capsule /usr/local/bin/time-capsule

# Quando o container iniciar, execute o aplicativo
CMD ["time-capsule"]
